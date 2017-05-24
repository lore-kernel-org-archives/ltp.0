From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 24 May 2017 17:29:55 +0800
Subject: [LTP] [PATCH] syscalls/fanotify07.c: Fix compilation without
	fanotify
Message-ID: <1495618195-4139-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed becasue main function is defined in new API.
We should use TST_TEST_TCONF instead of main function to skip
this case in new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fanotify/fanotify07.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index 5cb5bbb..79ff455 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -240,10 +240,5 @@ static struct tst_test test = {
 };
 
 #else
-
-int main(void)
-{
-	tst_brk(TCONF, "system doesn't have required fanotify support");
-}
-
+	TST_TEST_TCONF("system doesn't have required fanotify support");
 #endif
-- 
1.8.3.1



