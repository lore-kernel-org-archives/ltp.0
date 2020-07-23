From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jul 2020 21:52:15 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/futex_wait03: Fix synchronization
Message-ID: <20200723195215.6351-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I was reviewing changes in the test I noticed that the
synchronization was never working as the getppid() returns the test
library pid and not the thread that we should wait for.

So this fixes the test by passing the correct pid casted to a void* as
a parameter to the threaded function.

It seems that in practice this cannot be triggered easily, but the
test without this fix fails easily when you insert bussy loop
such as "for (volatile int i = 0; i < 1000000000; i++);" between
the SAFE_PTHRED() and the futex_wait() call.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/futex/futex_wait03.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/futex/futex_wait03.c b/testcases/kernel/syscalls/futex/futex_wait03.c
index e6e94055b..3e3a7ce23 100644
--- a/testcases/kernel/syscalls/futex/futex_wait03.c
+++ b/testcases/kernel/syscalls/futex/futex_wait03.c
@@ -26,12 +26,12 @@ static struct test_variants {
 #endif
 };
 
-static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
+static void *threaded(void *arg)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	long ret;
+	long ret, pid = (long)arg;
 
-	TST_PROCESS_STATE_WAIT(getppid(), 'S', 0);
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
 
 	ret = futex_wake(tv->fntype, &futex, 1, FUTEX_PRIVATE_FLAG);
 	if (ret != 1)
@@ -43,10 +43,10 @@ static void *threaded(void *arg LTP_ATTRIBUTE_UNUSED)
 static void run(void)
 {
 	struct test_variants *tv = &variants[tst_variant];
-	long res;
+	long res, pid = getpid();
 	pthread_t t;
 
-	SAFE_PTHREAD_CREATE(&t, NULL, threaded, NULL);
+	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void*)pid);
 
 	res = futex_wait(tv->fntype, &futex, futex, NULL, FUTEX_PRIVATE_FLAG);
 	if (res) {
-- 
2.26.2

