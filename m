From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Jul 2019 20:03:14 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/2] syscalls/accept02: Fix
 TST_GET_UNUSED_PORT() usage
Message-ID: <20190730180315.6958-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The value returned from TST_GET_UNUSED_PORT() is in network byte order
already so we must not use htons() when passing the value in the
sockaddr structure.

Also when printing the value we have to do the inverse conversion.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/accept/accept02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 662ae4346..3db0f33bc 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -92,7 +92,7 @@ static void run(void)
 {
 	pthread_t server_thr, client_thr;
 
-	server_addr.sin_port = htons(server_port);
+	server_addr.sin_port = server_port;
 	client_addr.sin_port = htons(0);
 
 	SAFE_PTHREAD_CREATE(&server_thr, NULL, server_thread, NULL);
@@ -121,7 +121,7 @@ static void setup(void)
 	addr_len = sizeof(struct sockaddr_in);
 
 	server_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
-	tst_res(TINFO, "Starting listener on port: %d", server_port);
+	tst_res(TINFO, "Starting listener on port: %d", ntohs(server_port));
 }
 
 static void cleanup(void)
-- 
2.21.0

