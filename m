From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Jul 2016 16:21:13 +0800
Subject: [LTP] [PATCH v2 2/3] lib/cloner.c: Add tst_clone.h for new API
In-Reply-To: <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160719135349.GE6409@rei.lan>
 <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1469002874-18630-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make sure the functions from lib/cloner.c can be used by new API.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/tst_clone.h | 39 +++++++++++++++++++++++++++++++++++++++
 include/tst_test.h  |  1 +
 lib/cloner.c        |  1 +
 3 files changed, 41 insertions(+)
 create mode 100644 include/tst_clone.h

diff --git a/include/tst_clone.h b/include/tst_clone.h
new file mode 100644
index 0000000..a6c5a5b
--- /dev/null
+++ b/include/tst_clone.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
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
+ *
+ */
+
+#ifndef TST_CLONE_H__
+#define TST_CLONE_H__
+
+/* Functions from lib/cloner.c */
+int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
+		size_t stack_size, void *stack);
+int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
+		size_t stack_size, void *stack, ...);
+int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
+		void *arg, size_t stacksize);
+int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
+		void *arg);
+
+#define clone(...) (use_the_ltp_clone_functions, do_not_use_clone)
+
+#endif	/* TST_CLONE_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 7d0cff8..c89e51f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -32,6 +32,7 @@
 #include "tst_process_state.h"
 #include "tst_atomic.h"
 #include "tst_kvercmp.h"
+#include "tst_clone.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/cloner.c b/lib/cloner.c
index 63f223d..2947817 100644
--- a/lib/cloner.c
+++ b/lib/cloner.c
@@ -30,6 +30,7 @@
 #include <stdarg.h>
 #include "test.h"
 #include "config.h"
+#include "tst_clone.h"
 
 #undef clone			/* we want to use clone() */
 
-- 
1.8.3.1



