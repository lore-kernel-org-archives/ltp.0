From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Fri, 13 Nov 2020 10:40:30 +0200
Subject: [LTP] [PATCH v2] Convert dup03 to new API and clean up
Message-ID: <20201113084030.19317-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/kernel/syscalls/dup/dup03.c | 229 ++++++--------------------
 1 file changed, 47 insertions(+), 182 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index e41c9e445..950c390a1 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -1,212 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * Copyright (c) 2020 SUSE LLC
  *
  */
-/* $Id: dup03.c,v 1.5 2009/10/13 14:00:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: dup03
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Negative test for dup(2) (too many fds)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *
- *    DATE STARTED	: 06/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) dup(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
+/*\
+ * [DESCRIPTION]
+ * Negative test for dup(2) (too many fds).
  *
- *    RESOURCES
- * 	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- * 	None
- *
- *    INTERCASE DEPENDENCIES
- * 	None
- *
- *    DETAILED DESCRIPTION
- *
- * 	Setup:
- * 	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *	 Loop if the proper options are given.
- * 	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * [ALGORITHM]
+ * Open the maximum allowed number of file descriptors and then try to call
+ * dup() once more and verify it fails with EMFILE.
+\*/
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <stdlib.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+int *fd;
+int nfds;
 
-char *TCID = "dup03";
-int TST_TOTAL = 1;
-
-char filename[255];
-int *fd = NULL;
-int nfds = 0;
-
-int main(int ac, char **av)
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	TEST(dup(fd[0]));
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		TEST(dup(fd[0]));
-
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EMFILE)
-				tst_resm(TPASS,
-					 "dup failed as expected with "
-					 "EMFILE");
-			else
-				tst_resm(TFAIL | TTERRNO,
-					 "dup failed unexpectedly");
-		} else {
-			tst_resm(TFAIL, "dup succeeded unexpectedly");
-
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
+	if (TST_RET < -1) {
+		tst_res(TFAIL, "Invalid dup() return value %ld", TST_RET);
+		return;
+	}
 
+	if (TST_RET == -1) {
+		if (TST_ERR == EMFILE)
+			tst_res(TPASS | TERRNO, "dup() failed as expected");
+		else
+			tst_res(TFAIL | TERRNO, "dup() failed unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TFAIL, "dup() succeeded unexpectedly");
+	SAFE_CLOSE(TST_RET);
 }
 
-void setup(void)
+static void setup(void)
 {
 	long maxfds;
 
 	maxfds = sysconf(_SC_OPEN_MAX);
-	/*
-	 * Read the errors section if you're so inclined to determine
-	 * why == -1 matters for errno.
-	 */
-	if (maxfds < 1)
-		tst_brkm((maxfds == -1 ? TBROK | TERRNO : TBROK), NULL,
-			 "sysconf(_SC_OPEN_MAX) failed");
+	if (maxfds == -1)
+		tst_brk(TBROK, "sysconf(_SC_OPEN_MAX) failed");
 
-	fd = malloc(maxfds * sizeof(int));
+	fd = SAFE_MALLOC(maxfds * sizeof(int));
 	if (fd == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
-	fd[0] = -1;
+		tst_brk(TBROK | TERRNO, "malloc failed");
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	fd[0] = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
 
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(filename, "dupfile");
-	for (nfds = 1; nfds <= maxfds; nfds++)
-		if ((fd[nfds - 1] =
-		     open(filename, O_RDWR | O_CREAT, 0700)) == -1) {
-			if (errno == EMFILE)
-				break;
-			else
-				tst_brkm(TBROK | TBROK, cleanup, "open failed");
-			nfds--;
-		}
-
-	if (nfds == 0)
-		tst_brkm(TBROK, cleanup, "unable to open@least one file");
-	if (nfds > maxfds)
-		tst_brkm(TBROK, cleanup,
-			 "unable to open enough files to use all file descriptors, "
-			 "tried %ld", maxfds);
+	for (nfds = 1; nfds < maxfds; nfds++) {
+		fd[nfds] = SAFE_DUP(fd[0]);
+		if (fd[nfds] >= maxfds - 1)
+			break;
+	}
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int i;
 
-	for (i = 0; i <= nfds; i++)
-		close(fd[i]);
-
-	tst_rmdir();
+	for (i = 0; i < nfds; i++)
+		SAFE_CLOSE(fd[i]);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.26.2

