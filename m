From: j.nixdorf@avm.de <j.nixdorf@avm.de>
Date: Wed, 25 Nov 2020 14:06:32 +0100
Subject: [LTP] [PATCH] netstress: explicitly set a thread stack size
Message-ID: <OFCE604BCE.4F62924B-ONC125862B.004801C0-C125862B.0048027B@avm.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Musl libc uses a relatively small thread stack size (128k [1]). This
gets used up on 2 local buffers sized max_msg_len (64k by default),
which causes a segfault due to a stack overflow in the error reporting
path.

Set the stack size to 128kB + 2*max_msg_len instead, which is enough for
both buffers with an additional allowance for the remaining stack usage
by netstress and called libc or ltp helper functions.

[1]: https://wiki.musl-libc.org/functional-differences-from-glibc.html#Thread_stack_size

Signed-off-by: Johannes Nixdorf <j.nixdorf@avm.de>
---
 testcases/network/netstress/netstress.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index e79e64220..bcd3cd049 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -480,7 +480,7 @@ static void client_init(void)
 	clock_gettime(CLOCK_MONOTONIC_RAW, &tv_client_start);
 	intptr_t i;
 	for (i = 0; i < clients_num; ++i)
-		SAFE_PTHREAD_CREATE(&thread_ids[i], 0, client_fn, (void *)i);
+		SAFE_PTHREAD_CREATE(&thread_ids[i], &attr, client_fn, (void *)i);
 }
 
 static void client_run(void)
@@ -747,8 +747,6 @@ static void server_run(void)
 	struct sockaddr_in6 addr6;
 	socklen_t addr_size = sizeof(addr6);
 
-	pthread_attr_init(&attr);
-
 	/*
 	 * detaching threads allow to reclaim thread's resources
 	 * once a thread finishes its work.
@@ -980,6 +978,14 @@ static void setup(void)
 	break;
 	}
 
+	errno = pthread_attr_init(&attr);
+	if (errno != 0)
+		tst_brk(TBROK | TERRNO, "pthread_attr_init failed");
+
+	errno = pthread_attr_setstacksize(&attr, 128*1024 + 2*max_msg_len);
+	if (errno != 0)
+		tst_brk(TBROK | TERRNO, "pthread_attr_setstacksize failed");
+
 	net.init();
 }
 
-- 
2.17.1

