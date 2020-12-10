From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Dec 2020 15:15:39 +0100
Subject: [LTP] [PATCH v2 01/10] lib: Introduce TST_EXP_* macros
In-Reply-To: <20201210141548.10982-1-chrubis@suse.cz>
References: <20201210141548.10982-1-chrubis@suse.cz>
Message-ID: <20201210141548.10982-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to simplify common return value checks.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt  |  54 +++++++++++++
 include/tst_test.h               |  28 +------
 include/tst_test_macros.h        | 130 +++++++++++++++++++++++++++++++
 lib/newlib_tests/.gitignore      |   3 +
 lib/newlib_tests/test_macros01.c |  40 ++++++++++
 lib/newlib_tests/test_macros02.c |  42 ++++++++++
 lib/newlib_tests/test_macros03.c |  40 ++++++++++
 lib/tst_test.c                   |   1 +
 8 files changed, 311 insertions(+), 27 deletions(-)
 create mode 100644 include/tst_test_macros.h
 create mode 100644 lib/newlib_tests/test_macros01.c
 create mode 100644 lib/newlib_tests/test_macros02.c
 create mode 100644 lib/newlib_tests/test_macros03.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 149c0854a..99fb34628 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -451,6 +451,60 @@ Printf-like function to report error and exit the test, it can be used with ttyp
 The 'ttype' can be combined bitwise with 'TERRNO' or 'TTERRNO' to print
 'errno', 'TST_ERR' respectively.
 
+There are also 'TST_EXP_*()' macros that can simplify syscall unit tests to a
+single line, use them whenever possible. These macros take a function call as
+the first parameter and a printf-like format string and parameters as well.
+These test macros then expand to a code that runs the call, checks the return
+value and errno and reports the test result.
+
+[source,c]
+-------------------------------------------------------------------------------
+static void test(void)
+{
+	...
+	TST_EXP_PASS(stat(fname, &statbuf), "stat(%s, ...)", fname);
+
+	if (!TST_PASS)
+		return;
+	...
+}
+-------------------------------------------------------------------------------
+
+The 'TST_EXP_PASS()' can be used for calls that return -1 on failure and 0 on
+success. It will check for the return value and reports failure if the return
+value is not equal to 0. The call also sets the 'TST_PASS' variable to 1 if
+the call succeeeded.
+
+[source,c]
+-------------------------------------------------------------------------------
+static void test(void)
+{
+	...
+	TST_EXP_FD(open(fname, O_RDONLY), "open(%s, O_RDONLY)", fname);
+
+	SAFE_CLOSE(TST_RET);
+	...
+}
+-------------------------------------------------------------------------------
+
+The 'TST_EXP_FD()' is the same as 'TST_EXP_PASS()' the only difference is that
+the return value is expected to be a file descriptor so the call passes if
+positive integer is returned.
+
+[source,c]
+-------------------------------------------------------------------------------
+static void test(void)
+{
+	...
+	TST_EXP_FAIL(stat(fname, &statbuf), ENOENT, "stat(%s, ...)", fname);
+	...
+}
+-------------------------------------------------------------------------------
+
+The 'TST_EXP_FAIL()' is similar to 'TST_EXP_PASS()' but it fails the test if
+the call haven't failed with -1 and 'errno' wasn't set to the expected one
+passed as the second argument.
+
 [source,c]
 -------------------------------------------------------------------------------
 const char *tst_strsig(int sig);
diff --git a/include/tst_test.h b/include/tst_test.h
index cf08f3c78..c87251870 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -18,6 +18,7 @@
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
+#include "tst_test_macros.h"
 #include "tst_checkpoint.h"
 #include "tst_device.h"
 #include "tst_mkfs.h"
@@ -272,33 +273,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
  */
 void tst_reinit(void);
 
-//TODO Clean?
-#define TEST(SCALL) \
-	do { \
-		errno = 0; \
-		TST_RET = SCALL; \
-		TST_ERR = errno; \
-	} while (0)
-
-#define TEST_VOID(SCALL) \
-	do { \
-		errno = 0; \
-		SCALL; \
-		TST_ERR = errno; \
-	} while (0)
-
-extern long TST_RET;
-extern int TST_ERR;
-
-extern void *TST_RET_PTR;
-
-#define TESTPTR(SCALL) \
-	do { \
-		errno = 0; \
-		TST_RET_PTR = (void*)SCALL; \
-		TST_ERR = errno; \
-	} while (0)
-
 /*
  * Functions to convert ERRNO to its name and SIGNAL to its name.
  */
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
new file mode 100644
index 000000000..3016d95c2
--- /dev/null
+++ b/include/tst_test_macros.h
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015-2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_TEST_MACROS_H__
+#define TST_TEST_MACROS_H__
+
+#define TEST(SCALL) \
+	do { \
+		errno = 0; \
+		TST_RET = SCALL; \
+		TST_ERR = errno; \
+	} while (0)
+
+#define TEST_VOID(SCALL) \
+	do { \
+		errno = 0; \
+		SCALL; \
+		TST_ERR = errno; \
+	} while (0)
+
+extern long TST_RET;
+extern int TST_ERR;
+extern int TST_PASS;
+
+extern void *TST_RET_PTR;
+
+#define TESTPTR(SCALL) \
+	do { \
+		errno = 0; \
+		TST_RET_PTR = (void*)SCALL; \
+		TST_ERR = errno; \
+	} while (0)
+
+
+#define TST_2_(_1, _2, ...) _2
+
+#define TST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__
+
+#define TST_MSG_(RES, FMT, SCALL, ...) \
+	tst_res_(__FILE__, __LINE__, RES, \
+		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__))
+
+#define TST_MSGP_(RES, FMT, PAR, SCALL, ...) \
+	tst_res_(__FILE__, __LINE__, RES, \
+		TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, SCALL) FMT, __VA_ARGS__), PAR)
+
+#define TST_EXP_FD(SCALL, ...)                                                 \
+	do {                                                                   \
+		TEST(SCALL);                                                   \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET == -1) {                                           \
+			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
+			         #SCALL, ##__VA_ARGS__);                       \
+			break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_RET < 0) {                                             \
+			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
+			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_MSGP_(TPASS, " returned fd %ld", TST_RET,                  \
+		         #SCALL, ##__VA_ARGS__);                               \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
+#define TST_EXP_PASS(SCALL, ...)                                               \
+	do {                                                                   \
+		TEST(SCALL);                                                   \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET == -1) {                                           \
+			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
+			         #SCALL, ##__VA_ARGS__);                       \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_RET != 0) {                                            \
+			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
+			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);             \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
+
+#define TST_EXP_FAIL(SCALL, ERRNO, ...)                                        \
+	do {                                                                   \
+		TEST(SCALL);                                                   \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET == 0) {                                            \
+			TST_MSG_(TFAIL | TTERRNO, " succeeded",                \
+			         #SCALL, ##__VA_ARGS__);                       \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_RET != -1) {                                           \
+			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
+			          TST_RET, #SCALL, ##__VA_ARGS__);             \
+			break;                                                 \
+		}                                                              \
+		                                                               \
+		if (ERRNO) {                                                   \
+			if (TST_ERR == ERRNO) {                                \
+				TST_MSG_(TPASS | TERRNO, "",                   \
+				         #SCALL, ##__VA_ARGS__);               \
+				TST_PASS = 1;                                  \
+			} else {                                               \
+				TST_MSGP_(TFAIL | TERRNO, " expected %s",      \
+				          tst_strerrno(ERRNO),                 \
+				          #SCALL, ##__VA_ARGS__);              \
+			}                                                      \
+		}                                                              \
+	} while (0)
+
+#endif	/* TST_TEST_MACROS_H__ */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6fc549cf2..6c2612259 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -37,3 +37,6 @@ test_kconfig02
 variant
 test_guarded_buf
 tst_bool_expr
+test_macros01
+test_macros02
+test_macros03
diff --git a/lib/newlib_tests/test_macros01.c b/lib/newlib_tests/test_macros01.c
new file mode 100644
index 000000000..9a920f8e4
--- /dev/null
+++ b/lib/newlib_tests/test_macros01.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test macros.
+ */
+
+#include "tst_test.h"
+
+static int fail_fd(void)
+{
+	errno = EINVAL;
+	return -1;
+}
+
+static int pass_fd(void)
+{
+	return 42;
+}
+
+static int inval_val(void)
+{
+	return -42;
+}
+
+static void do_test(void)
+{
+	TST_EXP_FD(fail_fd(), "TEST DESCRIPTION");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FD(pass_fd(), "%s", "TEST DESCRIPTION PARAM");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FD(inval_val());
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/newlib_tests/test_macros02.c b/lib/newlib_tests/test_macros02.c
new file mode 100644
index 000000000..f0a692ab6
--- /dev/null
+++ b/lib/newlib_tests/test_macros02.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test macros.
+ */
+
+#include "tst_test.h"
+
+static int fail_fn(void)
+{
+	errno = EINVAL;
+	return -1;
+}
+
+static int pass_fn(void)
+{
+	return 0;
+}
+
+static int inval_ret_fn(void)
+{
+	return 42;
+}
+
+static void do_test(void)
+{
+	TST_EXP_FAIL(fail_fn(), EINVAL);
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL(fail_fn(), ENOTTY);
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL(pass_fn(), ENOTTY);
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL(inval_ret_fn(), ENOTTY, "TEST DESCRIPTION");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/newlib_tests/test_macros03.c b/lib/newlib_tests/test_macros03.c
new file mode 100644
index 000000000..414370980
--- /dev/null
+++ b/lib/newlib_tests/test_macros03.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*
+ * Test macros.
+ */
+
+#include "tst_test.h"
+
+static int fail_fn(void)
+{
+	errno = EINVAL;
+	return -1;
+}
+
+static int pass_fn(void)
+{
+	return 0;
+}
+
+static int inval_ret_fn(void)
+{
+	return 42;
+}
+
+static void do_test(void)
+{
+	TST_EXP_PASS(fail_fn());
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PASS(pass_fn(), "TEST DESCRIPTION");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_PASS(inval_ret_fn());
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9c0a95b95..0714f0a0e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -75,6 +75,7 @@ const char *tst_ipc_path = ipc_path;
 static char shm_path[1024];
 
 int TST_ERR;
+int TST_PASS;
 long TST_RET;
 
 static void do_cleanup(void);
-- 
2.26.2

