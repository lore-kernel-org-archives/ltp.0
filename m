From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Aug 2018 16:45:44 +0800
Subject: [LTP] [PATCH v2 1/4] lib/tst_path_has_mnt_flags.c: Factor out
	tst_path_has_mnt_flags() for new API
In-Reply-To: <20180815114220.GA26923@rei>
References: <20180815114220.GA26923@rei>
Message-ID: <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can use existed tst_path_has_mnt_flags() to check whether a path is
on a filesystem that is mounted with specified flags, so ensure that the
function can also be used by new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/old/test.h               | 13 +------------
 include/tst_path_has_mnt_flags.h | 22 ++++++++++++++++++++++
 include/tst_test.h               |  1 +
 3 files changed, 24 insertions(+), 12 deletions(-)
 create mode 100644 include/tst_path_has_mnt_flags.h

diff --git a/include/old/test.h b/include/old/test.h
index 5eef304..25d7152 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -64,6 +64,7 @@
 #include "old_tmpdir.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
+#include "tst_path_has_mnt_flags.h"
 
 /*
  * Ensure that NUMSIGS is defined.
@@ -236,18 +237,6 @@ unsigned short tst_get_unused_port(void (cleanup_fn)(void),
 const char *tst_strsig(int sig);
 const char *tst_strerrno(int err);
 
-/* lib/tst_path_has_mnt_flags.c
- *
- * Check whether a path is on a filesystem that is mounted with
- * specified flags
- * @path: path to file, if path is NULL tst_tmpdir is used.
- * @flags: NULL or NULL terminated array of mount flags
- *
- * Return: 0..n - number of flags matched
- */
-int tst_path_has_mnt_flags(void (cleanup_fn)(void),
-		const char *path, const char *flags[]);
-
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/include/tst_path_has_mnt_flags.h b/include/tst_path_has_mnt_flags.h
new file mode 100644
index 0000000..1b16f1b
--- /dev/null
+++ b/include/tst_path_has_mnt_flags.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ */
+
+#ifndef TST_PATH_HAS_MNT_FLAGS_H__
+#define TST_PATH_HAS_MNT_FLAGS_H__
+
+/* lib/tst_path_has_mnt_flags.c
+ *
+ * Check whether a path is on a filesystem that is mounted with
+ * specified flags
+ * @path: path to file, if path is NULL tst_tmpdir is used.
+ * @flags: NULL or NULL terminated array of mount flags
+ *
+ * Return: 0..n - number of flags matched
+ */
+int tst_path_has_mnt_flags(void (*cleanup_fn)(void),
+		const char *path, const char *flags[]);
+
+#endif	/* TST_PATH_HAS_MNT_FLAGS_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 98dacf3..f7d109a 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -41,6 +41,7 @@
 #include "tst_kernel.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
+#include "tst_path_has_mnt_flags.h"
 
 /*
  * Reports testcase result.
-- 
1.8.3.1



