From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 9 Feb 2018 15:56:48 +0800
Subject: [LTP] [PATCH 1/4] lib/get_high_address.c: Add
	tst_get_high_address.h for new API
Message-ID: <1518163011-23322-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make sure get_high_address() can be used by new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/old/test.h             |  4 +---
 include/tst_get_high_address.h | 31 +++++++++++++++++++++++++++++++
 include/tst_test.h             |  1 +
 lib/get_high_address.c         |  1 +
 4 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 include/tst_get_high_address.h

diff --git a/include/old/test.h b/include/old/test.h
index 137ebb1..21f7db9 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -63,6 +63,7 @@
 #include "old_device.h"
 #include "old_tmpdir.h"
 #include "tst_minmax.h"
+#include "tst_get_high_address.h"
 
 /*
  * Ensure that NUMSIGS is defined.
@@ -203,9 +204,6 @@ extern int tst_count;
 /* lib/tst_sig.c */
 void tst_sig(int fork_flag, void (*handler)(), void (*cleanup)());
 
-/* lib/get_high_address.c */
-char *get_high_address(void);
-
 /* lib/self_exec.c */
 void maybe_run_child(void (*child)(), const char *fmt, ...);
 int self_exec(const char *argv0, const char *fmt, ...);
diff --git a/include/tst_get_high_address.h b/include/tst_get_high_address.h
new file mode 100644
index 0000000..84e0257
--- /dev/null
+++ b/include/tst_get_high_address.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.  Patent licenses, if
+ * any, provided herein do not apply to combinations of this program with
+ * other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program.
+ */
+
+#ifndef TST_GET_HIGH_ADDRESS_H__
+#define TST_GET_HIGH_ADDRESS_H__
+
+/* Functions from lib/get_high_address.c */
+
+char *get_high_address(void);
+
+#endif	/* TST_GET_HIGH_ADDRESS_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index eaf7a1f..c539d38 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -40,6 +40,7 @@
 #include "tst_clone.h"
 #include "tst_kernel.h"
 #include "tst_minmax.h"
+#include "tst_get_high_address.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/get_high_address.c b/lib/get_high_address.c
index eed9cf1..0e1e225 100644
--- a/lib/get_high_address.c
+++ b/lib/get_high_address.c
@@ -33,6 +33,7 @@
  */
 
 #include <unistd.h>
+#include "tst_get_high_address.h"
 
 char *get_high_address(void)
 {
-- 
1.8.3.1



