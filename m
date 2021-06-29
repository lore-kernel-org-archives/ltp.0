From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Jun 2021 19:14:09 +0800
Subject: [LTP] [PATCH v2] lib/newlib_tests/test_macros*.c: Include more test
 macros
In-Reply-To: <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
References: <CAEemH2dL=bZdP_X+YkZuOFK2dCV8RTq5CyZYPTrKh+_2yjHK5g@mail.gmail.com>
Message-ID: <1624965249-7087-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) test TST_EXP_FD_SILENT macro in test_macros01.c
2) test TST_EXP_FAIL2 macro in test_macros02.c
3) test TST_EXP_PASS_SILENT macro in test_macros03.c
4) add test_macros04.c to test TST_EXP_PID and TST_EXP_PID_SILENT macros

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1->v2:
1.add more info for silent macro
2.replace scall string with function name
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros01.c | 26 +++++++++++---
 lib/newlib_tests/test_macros02.c | 21 +++++++++---
 lib/newlib_tests/test_macros03.c | 17 +++++++---
 lib/newlib_tests/test_macros04.c | 58 ++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 13 deletions(-)
 create mode 100644 lib/newlib_tests/test_macros04.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index b95ead2c2..83a240223 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -41,5 +41,6 @@ tst_bool_expr
 test_macros01
 test_macros02
 test_macros03
+test_macros04
 tst_fuzzy_sync01
 tst_fuzzy_sync02
diff --git a/lib/newlib_tests/test_macros01.c b/lib/newlib_tests/test_macros01.c
index 9a920f8e4..c04c94363 100644
--- a/lib/newlib_tests/test_macros01.c
+++ b/lib/newlib_tests/test_macros01.c
@@ -4,7 +4,7 @@
  */
 
 /*
- * Test macros.
+ * Test TST_EXP_FD and TST_EXP_FD_SILENT macro.
  */
 
 #include "tst_test.h"
@@ -25,14 +25,32 @@ static int inval_val(void)
 	return -42;
 }
 
+static int zero_val(void)
+{
+	return 0;
+}
+
 static void do_test(void)
 {
-	TST_EXP_FD(fail_fd(), "TEST DESCRIPTION");
+	tst_res(TINFO, "Testing TST_EXP_FD macro");
+	TST_EXP_FD(fail_fd(), "fail_fd()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FD(pass_fd(), "pass_fd()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD(pass_fd(), "%s", "TEST DESCRIPTION PARAM");
+	TST_EXP_FD(inval_val(), "inval_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FD(zero_val(), "zero_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_FD_SILENT macro");
+	TST_EXP_FD_SILENT(fail_fd(), "fail_fd()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FD(inval_val());
+	TST_EXP_FD_SILENT(pass_fd(), "%s", "pass_fd()");
+	tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(pass_fd, ...)", TST_PASS);
+	TST_EXP_FD_SILENT(inval_val(), "inval_val()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FD_SILENT(zero_val(), "zero_val()");
+	tst_res(TINFO, "TST_PASS = %i from TST_EXP_FD_SILENT(zero_val, ...)", TST_PASS);
 }
 
 static struct tst_test test = {
diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
index f0a692ab6..647f73682 100644
--- a/lib/newlib_tests/test_macros02.c
+++ b/lib/newlib_tests/test_macros02.c
@@ -4,7 +4,7 @@
  */
 
 /*
- * Test macros.
+ * Test TST_EXP_FAIL and TST_EXP_FAIL2 macro.
  */
 
 #include "tst_test.h"
@@ -27,13 +27,24 @@ static int inval_ret_fn(void)
 
 static void do_test(void)
 {
-	TST_EXP_FAIL(fail_fn(), EINVAL);
+	tst_res(TINFO, "Testing TST_EXP_FAIL macro");
+	TST_EXP_FAIL(fail_fn(), EINVAL, "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(fail_fn(), ENOTTY);
+	TST_EXP_FAIL(fail_fn(), ENOTTY, "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(pass_fn(), ENOTTY);
+	TST_EXP_FAIL(pass_fn(), ENOTTY, "pass_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "TEST DESCRIPTION");
+	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_FAIL2 macro");
+	TST_EXP_FAIL2(fail_fn(), EINVAL, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL2(fail_fn(), ENOTTY, "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL2(pass_fn(), ENOTTY, "pass_fn");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL2(inval_ret_fn(), ENOTTY, "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 }
 
diff --git a/lib/newlib_tests/test_macros03.c b/lib/newlib_tests/test_macros03.c
index 414370980..19a0ad6fd 100644
--- a/lib/newlib_tests/test_macros03.c
+++ b/lib/newlib_tests/test_macros03.c
@@ -4,7 +4,7 @@
  */
 
 /*
- * Test macros.
+ * Test TST_EXP_PASS and TST_EXP_PASS_SILENT macro.
  */
 
 #include "tst_test.h"
@@ -27,11 +27,20 @@ static int inval_ret_fn(void)
 
 static void do_test(void)
 {
-	TST_EXP_PASS(fail_fn());
+	tst_res(TINFO, "Testing TST_EXP_PASS macro");
+	TST_EXP_PASS(fail_fn(), "fail_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PASS(pass_fn(), "TEST DESCRIPTION");
+	TST_EXP_PASS(pass_fn(), "pass_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_PASS(inval_ret_fn());
+	TST_EXP_PASS(inval_ret_fn(), "inval_ret_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_PASS_SILENT macro");
+	TST_EXP_PASS_SILENT(fail_fn(), "fail_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PASS_SILENT(pass_fn(), "pass_fn()");
+	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PASS_SILENT(pass_fn, ...)", TST_PASS);
+	TST_EXP_PASS_SILENT(inval_ret_fn(), "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 }
 
diff --git a/lib/newlib_tests/test_macros04.c b/lib/newlib_tests/test_macros04.c
new file mode 100644
index 000000000..e0111807f
--- /dev/null
+++ b/lib/newlib_tests/test_macros04.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*
+ * Test TST_EXP_PID and TST_EXP_PID_SILENT macro.
+ */
+
+#include "tst_test.h"
+
+static int fail_pid(void)
+{
+	errno = EINVAL;
+	return -1;
+}
+
+static int pass_pid(void)
+{
+	return 42;
+}
+
+static int inval_val(void)
+{
+	return -42;
+}
+
+static int zero_val(void)
+{
+	return 0;
+}
+
+static void do_test(void)
+{
+	tst_res(TINFO, "Testing TST_EXP_PID macro");
+	TST_EXP_PID(fail_pid(), "fail_pid()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PID(pass_pid(), "pass_pid()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PID(inval_val(), "inval_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PID(zero_val(), "zero_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_PID_SILENT macro");
+	TST_EXP_PID_SILENT(fail_pid(), "fail_pid()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PID_SILENT(pass_pid(), "%s", "pass_pid()");
+	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PID_SILENT(pass_pid, ...)", TST_PASS);
+	TST_EXP_PID_SILENT(inval_val(), "inval_val()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PID_SILENT(zero_val(), "zero_val()");
+	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PID_SILENT(zero_val, ...)", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.23.0

