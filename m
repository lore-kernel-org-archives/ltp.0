From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 30 Apr 2020 17:58:23 +0800
Subject: [LTP] [PATCH v2 2/3] lib: Add TST_ASSERT_FILE_INT and
 TST_ASSERT_FILE_STR
In-Reply-To: <1588240704-14747-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200429120609.GA668@yuki.lan>
 <1588240704-14747-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1588240704-14747-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These functions are similar to TST_ASSERT_INT/STR, but they
are designed to get field value of proc or sys file. ie
NoNewPrivs field in the /proc/[pid]/status.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt |  8 ++++++++
 include/tst_assert.h            | 28 ++++++++++++++++++++++++++--
 lib/newlib_tests/.gitignore     |  1 +
 lib/newlib_tests/test_assert.c  | 19 +++++++++++++++++++
 lib/tst_assert.c                | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 2 deletions(-)
 create mode 100644 lib/newlib_tests/test_assert.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 3e33fd4c1..bda9bcfd5 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2045,6 +2045,14 @@ terminated array of strings such as:
 },
 -------------------------------------------------------------------------------
 
+2.2.36 Assert sys or proc file value
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Using TST_ASSERT_INT/STR(path, val) to assert that integer value or string stored in
+the prefix field of file pointed by path equals to the value passed to this function.
+
+Also having a similar api pair TST_ASSERT_FILE_INT/STR(path, prefix, val) to assert
+the field value of file.
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/tst_assert.h b/include/tst_assert.h
index 04e80777c..9969a8169 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -16,7 +16,20 @@
  * values in sysfs, procfs, etc.
  */
 void tst_assert_int(const char *file, const int lineno,
-                    const char *path, int val);
+		    const char *path, int val);
+
+#define TST_ASSERT_FILE_INT(path, prefix, val) \
+	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
+
+/*
+ * Asserts that integer value stored in the prefix field of file pointed by path
+ * equals to the value passed to this function. This is mostly useful for
+ * asserting correct field values in sysfs, procfs, etc.
+ */
+
+void tst_assert_file_int(const char *file, const int lineno,
+			 const char *path, const char *prefix, int val);
+
 
 #define TST_ASSERT_STR(path, val) \
 	tst_assert_str(__FILE__, __LINE__, path, val)
@@ -27,6 +40,17 @@ void tst_assert_int(const char *file, const int lineno,
  * values in sysfs, procfs, etc.
  */
 void tst_assert_str(const char *file, const int lineno,
-                    const char *path, const char *val);
+		    const char *path, const char *val);
+
+#define TST_ASSERT_FILE_STR(path, prefix, val) \
+	tst_assert_file_str(__FILE__, __LINE__, path, prefix, val)
+
+/*
+ * Asserts that a string value stored in the prefix field of file pointed by path
+ * equals to the value passed to this function. This is mostly useful for
+ * asserting correct field values in sysfs, procfs, etc.
+ */
+void tst_assert_file_str(const char *file, const int lineno,
+			 const char *path, const char *prefix, const char *val);
 
 #endif /* TST_ASSERT_H__ */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index dd9899927..fee8795b6 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -25,6 +25,7 @@ test18
 test19
 test20
 tst_expiration_timer
+test_assert
 test_timer
 test_exec
 test_exec_child
diff --git a/lib/newlib_tests/test_assert.c b/lib/newlib_tests/test_assert.c
new file mode 100644
index 000000000..092303893
--- /dev/null
+++ b/lib/newlib_tests/test_assert.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+#include <stdio.h>
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	TST_ASSERT_INT("/proc/self/oom_score", 0);
+	TST_ASSERT_STR("/proc/self/comm", "test_assert");
+	TST_ASSERT_FILE_INT("/proc/self/io", "read_bytes:", 0);
+	TST_ASSERT_FILE_STR("/proc/self/status1", "State", "unexpected");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index f05aea222..8418fb72d 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -4,6 +4,7 @@
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
+#include <stdio.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_assert.h"
 #include "tst_test.h"
@@ -22,6 +23,22 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
+void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
+{
+	int sys_val;
+	char fmt[1024];
+
+	sprintf(fmt, "%s%%d", prefix);
+	file_lines_scanf(file, lineno, NULL, 1, path, fmt, &sys_val);
+
+	if (val == sys_val) {
+		tst_res_(file, lineno, TPASS, "%s %s = %d", path, prefix, sys_val);
+		return;
+	}
+
+	tst_res_(file, lineno, TFAIL, "%s %s != %d got %d", path, prefix, val, sys_val);
+}
+
 void tst_assert_str(const char *file, const int lineno, const char *path, const char *val)
 {
 	char sys_val[1024];
@@ -34,3 +51,19 @@ void tst_assert_str(const char *file, const int lineno, const char *path, const
 
 	tst_res_(file, lineno, TFAIL, "%s != '%s' got '%s'", path, val, sys_val);
 }
+
+void tst_assert_file_str(const char *file, const int lineno, const char *path, const char *prefix, const char *val)
+{
+	char sys_val[1024];
+	char fmt[2048];
+
+	sprintf(fmt, "%s: %%1024s", prefix);
+	file_lines_scanf(file, lineno, NULL, 1, path, fmt, sys_val);
+
+	if (!strcmp(val, sys_val)) {
+		tst_res_(file, lineno, TPASS, "%s %s = '%s'", path, prefix, sys_val);
+		return;
+	}
+
+	tst_res_(file, lineno, TFAIL, "%s %s != '%s' got '%s'", path, prefix, val, sys_val);
+}
-- 
2.23.0



