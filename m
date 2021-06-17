From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 17 Jun 2021 18:55:54 +0800
Subject: [LTP] [PATCH 1/3 v2] lib: tst_process_state: Use SPDX and format
 alignment
In-Reply-To: <20210617105556.130869-1-xieziyao@huawei.com>
References: <20210617105556.130869-1-xieziyao@huawei.com>
Message-ID: <20210617105556.130869-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use SPDX and format alignment.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
v1->v2:
1. Move changes in license and whitespaces to a separate patch.

 include/tst_process_state.h | 23 +++++++++--------------
 lib/tst_process_state.c     | 31 +++++++------------------------
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index c32aa58e6..32eaf46d9 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -2,13 +2,10 @@
  * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
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
@@ -29,8 +26,7 @@
 #ifdef TST_TEST_H__

 #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
-	tst_process_state_wait(__FILE__, __LINE__, NULL, \
-	                       (pid), (state), (msec_timeout))
+	tst_process_state_wait(__FILE__, __LINE__, NULL, (pid), (state), (msec_timeout))
 #else
 /*
  * The same as above but does not use tst_brkm() interface.
@@ -41,13 +37,12 @@
  */
 int tst_process_state_wait2(pid_t pid, const char state);

-# define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
-	 tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), \
-	                        (pid), (state), 0)
+#define TST_PROCESS_STATE_WAIT(cleanup_fn, pid, state) \
+	tst_process_state_wait(__FILE__, __LINE__, (cleanup_fn), (pid), (state), 0)
 #endif

 int tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void), pid_t pid,
-			    const char state, unsigned int msec_timeout);
+			   void (*cleanup_fn)(void), pid_t pid,
+			   const char state, unsigned int msec_timeout);

 #endif /* TST_PROCESS_STATE__ */
diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
index 11790c947..2f42895b7 100644
--- a/lib/tst_process_state.c
+++ b/lib/tst_process_state.c
@@ -1,24 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
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
  */

 #include <stdio.h>
@@ -29,8 +11,8 @@
 #include "tst_process_state.h"

 int tst_process_state_wait(const char *file, const int lineno,
-                            void (*cleanup_fn)(void), pid_t pid,
-			    const char state, unsigned int msec_timeout)
+			   void (*cleanup_fn)(void), pid_t pid,
+			   const char state, unsigned int msec_timeout)
 {
 	char proc_path[128], cur_state;
 	unsigned int msecs = 0;
@@ -39,7 +21,7 @@ int tst_process_state_wait(const char *file, const int lineno,

 	for (;;) {
 		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
-		                "%*i %*s %c", &cur_state);
+				"%*i %*s %c", &cur_state);

 		if (state == cur_state)
 			break;
@@ -64,16 +46,17 @@ int tst_process_state_wait2(pid_t pid, const char state)

 	for (;;) {
 		FILE *f = fopen(proc_path, "r");
+
 		if (!f) {
 			fprintf(stderr, "Failed to open '%s': %s\n",
-			        proc_path, strerror(errno));
+				proc_path, strerror(errno));
 			return 1;
 		}

 		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
 			fclose(f);
 			fprintf(stderr, "Failed to read '%s': %s\n",
-			        proc_path, strerror(errno));
+				proc_path, strerror(errno));
 			return 1;
 		}
 		fclose(f);
--
2.17.1

