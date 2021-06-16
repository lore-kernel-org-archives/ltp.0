From: Xie Ziyao <xieziyao@huawei.com>
Date: Wed, 16 Jun 2021 17:36:04 +0800
Subject: [LTP] [PATCH 1/3] lib: tst_process_state: Add
 tst_process_release_wait()
In-Reply-To: <20210616093606.214856-1-xieziyao@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
Message-ID: <20210616093606.214856-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The tst_process_release_wait() returns a value indicating if the
process is released with checking whether "/proc/%i" exists.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 include/tst_process_state.h | 41 +++++++++++++++++------------
 lib/tst_process_state.c     | 52 +++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index c32aa58e6..8cc1a57fc 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -1,20 +1,21 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

- /*
-
-   These functions helps you wait till a process with given pid changes state.
-   This is for example useful when you need to wait in parent until child
-   blocks.
-
-  */
+/*
+ * These functions helps you wait till a process with given pid changes state.
+ * This is for example useful when you need to wait in parent until child blocks.
+ */

 #ifndef TST_PROCESS_STATE__
 #define TST_PROCESS_STATE__

 #include <unistd.h>

+#ifdef TST_TEST_H__
+
 /*
  * Waits for process state change.
  *
@@ -26,11 +27,16 @@
  * Z - zombie process
  * T - process is traced
  */
-#ifdef TST_TEST_H__
-
 #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
 	tst_process_state_wait(__FILE__, __LINE__, NULL, \
-	                       (pid), (state), (msec_timeout))
+			       (pid), (state), (msec_timeout))
+
+/*
+ * Waits for process is released.
+ */
+#define TST_PROCESS_RELEASE_WAIT(pid, msec_timeout) \
+	tst_process_release_wait((pid), (msec_timeout))
+
 #else
 /*
  * The same as above but does not use tst_brkm() interface.
@@ -41,13 +47,16 @@
  */
 int tst_process_state_wait2(pid_t pid, const char state);

-# define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
-	 tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), \
-	                        (pid), (state), 0)
+#define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
+	tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), \
+			       (pid), (state), 0)
+
 #endif

 int tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void), pid_t pid,
-			    const char state, unsigned int msec_timeout);
+			   void (*cleanup_fn)(void), pid_t pid,
+			   const char state, unsigned int msec_timeout);
+
+int tst_process_release_wait(pid_t pid, unsigned int msec_timeout);

 #endif /* TST_PROCESS_STATE__ */
diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 11790c947..849379e4a 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -1,24 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
 /*
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
  */

 #include <stdio.h>
@@ -28,9 +12,8 @@
 #include "test.h"
 #include "tst_process_state.h"

-int tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void), pid_t pid,
-			    const char state, unsigned int msec_timeout)
+int tst_process_state_wait(const char *file, const int lineno, void (*cleanup_fn)(void),
+			   pid_t pid, const char state, unsigned int msec_timeout)
 {
 	char proc_path[128], cur_state;
 	unsigned int msecs = 0;
@@ -39,7 +22,7 @@ int tst_process_state_wait(const char *file, const int lineno,

 	for (;;) {
 		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
-		                "%*i %*s %c", &cur_state);
+				"%*i %*s %c", &cur_state);

 		if (state == cur_state)
 			break;
@@ -84,3 +67,26 @@ int tst_process_state_wait2(pid_t pid, const char state)
 		usleep(10000);
 	}
 }
+
+int tst_process_release_wait(pid_t pid, unsigned int msec_timeout)
+{
+	char proc_path[128];
+	unsigned int msecs = 0;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%i", pid);
+
+	for (;;) {
+		if (access(proc_path, F_OK))
+			break;
+
+		usleep(1000);
+		msecs += 1;
+
+		if (msec_timeout && msecs >= msec_timeout) {
+			errno = ETIMEDOUT;
+			return 0;
+		}
+	}
+
+	return 1;
+}
--
2.17.1

