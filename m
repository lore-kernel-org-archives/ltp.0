From: Xie Ziyao <ziyaoxie@outlook.com>
Date: Tue, 31 Aug 2021 11:51:02 +0800
Subject: [LTP] [PATCH v2] epoll_creat01: Replace TST_PASS with TST_RET
Message-ID: <OSZP286MB0871620CFE5F9AB0D6F33BD9CCCC9@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In TST_EXP_FD(), the value of TST_RET is the returned fd, not TST_PASS.

Fixes: 081f940b2df00 ("epoll_create: Add test for epoll_create01")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Xie Ziyao <ziyaoxie@outlook.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/epoll_create/epoll_create01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
index 54fd0810d..3ef5b5cac 100644
--- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
@@ -28,7 +28,7 @@ static void run(unsigned int n)

 	if (!TST_PASS)
 		return;
-	SAFE_CLOSE(TST_PASS);
+	SAFE_CLOSE(TST_RET);
 }

 static struct tst_test test = {
--
2.25.1

