From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 Apr 2020 14:21:47 +0800
Subject: [LTP] [PATCH 2/3] lib: Add TST_ASSERT_FILE_INT and
 TST_ASSERT_FILE_STR
In-Reply-To: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1587450108-31100-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1587450108-31100-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
 include/tst_assert.h | 28 ++++++++++++++++++++++++++--
 lib/tst_assert.c     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index 04e80777c..913fff1b5 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -16,7 +16,20 @@
  * values in sysfs, procfs, etc.
  */
 void tst_assert_int(const char *file, const int lineno,
-                    const char *path, int val);
+		    const char *path, int val);
+
+#define TST_ASSERT_FILE_INT(path, buf, val) \
+	tst_assert_file_int(__FILE__, __LINE__, path, buf, val)
+
+/*
+ * Asserts that integer value stored in the buf field of file pointed by path
+ * equals to the value passed to this function. This is mostly useful for
+ * asserting correct field values in sysfs, procfs, etc.
+ */
+
+void tst_assert_file_int(const char *file, const int lineno,
+			 const char *path, const char *buf, int val);
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
+#define TST_ASSERT_FILE_STR(path, buf, val) \
+	tst_assert_file_str(__FILE__, __LINE__, path, buf, val)
+
+/*
+ * Asserts that a string value stored in the buf field of file pointed by path
+ * equals to the value passed to this function. This is mostly useful for
+ * asserting correct field values in sysfs, procfs, etc.
+ */
+void tst_assert_file_str(const char *file, const int lineno,
+			 const char *path, const char *buf, const char *val);
 
 #endif /* TST_ASSERT_H__ */
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index 8ef3cd72e..65ee76473 100644
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
 
+void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *buf, int val)
+{
+	int sys_val;
+	char fmt[1024];
+
+	sprintf(fmt, "%s: %%d", buf);
+	SAFE_FILE_LINES_SCANF(path, fmt, &sys_val);
+
+	if (val == sys_val) {
+		tst_res_(file, lineno, TPASS, "%s %s = %d", path, buf, sys_val);
+		return;
+	}
+
+	tst_res_(file, lineno, TFAIL, "%s %s != %d got %d", path, buf, val, sys_val);
+}
+
 void tst_assert_str(const char *file, const int lineno, const char *path, const char *val)
 {
 	char sys_val[1024];
@@ -34,3 +51,19 @@ void tst_assert_str(const char *file, const int lineno, const char *path, const
 
 	tst_res_(file, lineno, TFAIL, "%s != '%s' got '%s'", path, val, sys_val);
 }
+
+void tst_assert_file_str(const char *file, const int lineno, const char *path, const char *buf, const char *val)
+{
+	char sys_val[1024];
+	char fmt[2048];
+
+	sprintf(fmt, "%s: %%1024s", buf);
+	SAFE_FILE_LINES_SCANF(path, fmt, sys_val);
+
+	if (!strcmp(val, sys_val)) {
+		tst_res_(file, lineno, TPASS, "%s %s = '%s'", path, buf, sys_val);
+		return;
+	}
+
+	tst_res_(file, lineno, TFAIL, "%s %s != '%s' got '%s'", path, buf, val, sys_val);
+}
-- 
2.23.0



