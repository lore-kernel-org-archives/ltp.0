From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 24 May 2016 10:55:54 +0800
Subject: [LTP] [PATCH 1/3] syscalls/pipe01: Remove unnecessary function
Message-ID: <1464058556-7675-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/pipe/pipe01.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 197918b..f0db2fa 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -60,17 +60,7 @@ static void verify_pipe(void)
 	tst_res(TPASS, "pipe() functionality is correct");
 }
 
-static void cleanup(void)
-{
-	if (fds[0] > 0 && close(fds[0]))
-		tst_res(TWARN | TERRNO, "Failed to close file");
-
-	if (fds[1] > 0 && close(fds[1]))
-		tst_res(TWARN | TERRNO, "Failed to close file");
-}
-
 static struct tst_test test = {
 	.tid = "pipe01",
-	.cleanup = cleanup,
 	.test_all = verify_pipe,
 };
-- 
1.8.3.1



