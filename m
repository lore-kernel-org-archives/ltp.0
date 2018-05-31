From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 31 May 2018 10:45:24 +0800
Subject: [LTP] [PATCH] pty/pty02.c: Fix compiler error
Message-ID: <1527734724-348-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed because of undefined EXTPROC on old distros(e.g. RHEL5/6).

Based on the fix patch[1] and added EXTPROC, tcgetattr() still could not detect
invalid EXTPROC on old distros.  So we wanted to skip the case if EXTPROC was not
defined on current distros.

[1] http://lists.linux.it/pipermail/ltp/2018-May/008253.html

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/pty/pty02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
index fd3d26b..548f8d1 100644
--- a/testcases/kernel/pty/pty02.c
+++ b/testcases/kernel/pty/pty02.c
@@ -29,6 +29,8 @@
 
 #include "tst_test.h"
 
+#ifdef EXTPROC
+
 static void do_test(void)
 {
 	struct termios io = { .c_lflag = EXTPROC | ICANON };
@@ -60,3 +62,7 @@ static void do_test(void)
 static struct tst_test test = {
 	.test_all = do_test,
 };
+
+#else
+	TST_TEST_TCONF("EXTPROC is not defined");
+#endif
-- 
1.8.3.1



