From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Fri, 27 Aug 2021 11:57:15 +0000
Subject: [LTP] [PATCH] epoll_creat01: Replace TST_PASS with TST_RET
Message-ID: <OSZP286MB087168E8DE5E0E49C9F90E27CCC89@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In TST_EXP_FD(), the value of TST_RET is the returned fd, not TST_PASS.

Fixes: 081f940b2df00 ("epoll_create: Add test for epoll_create01")
Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
---
 testcases/kernel/syscalls/epoll_create/epoll_create01.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
index 54fd0810d..29ac3763e 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -26,9 +26,8 @@ static void run(unsigned int n)
 {
 	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);

-	if (!TST_PASS)
-		return;
-	SAFE_CLOSE(TST_PASS);
+	if (TST_RET)
+		SAFE_CLOSE(TST_RET);
 }

 static struct tst_test test = {
--
2.25.1

