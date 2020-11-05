From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Thu,  5 Nov 2020 10:50:45 +0200
Subject: [LTP] [PATCH v2] Convert dup02 to new API and clean up
Message-ID: <20201105085045.31247-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/kernel/syscalls/dup/dup02.c | 209 ++++++--------------------
 1 file changed, 44 insertions(+), 165 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index c0919ef09..c67acda43 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -1,179 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2020 SUSE LLC
  *
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
+ * 03/30/1992 AUTHOR: Richard Logan CO-PILOT: William Roske
  *
  */
-/* $Id: dup02.c,v 1.6 2009/10/13 14:00:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: dup02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Negative test for dup(2) with bad fd.
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 2
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 06/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1-?.) dup(2) returns -1 with errno set to EBADF...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *	Standard tst_res formatted output
- *$
- *    DURATION
- * 	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
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
- *	  Loop through the test cases
- * 	   Execute system call
- *	   Check return code, if system call failed (return=-1)
- *		if doing functional check
- *		   check if errno set correctly, report results
- *	  Otherwise, Issue a FAIL message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "dup02";
-int TST_TOTAL = 2;
-
-int Fds[] = { -1, 1500 };
-
-int main(int ac, char **av)
+/*\
+ * [DESCRIPTION]
+ * Negative test for dup(2) with bad fds.
+ *
+ * [ALGORITHM]
+ * Call dup(2) with invalid argument and make sure it returns -1 with errno set
+ * to EBADF.
+\*/
+
+#include "tst_test.h"
+
+static struct tcase {
+	int fd;
+	int expected_errno;
+} tcases[] = {
+	{-1, EBADF},
+	{1500, EBADF},
+};
+
+static void run(unsigned int n)
 {
-	int lc;
-	int nfds = sizeof(Fds) / sizeof(int);
-	int ind;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	struct tcase *tc = &tcases[n];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	TEST(dup(tc->fd));
 
-		tst_count = 0;
-
-		for (ind = 0; ind < nfds; ind++) {
-
-			TEST(dup(Fds[ind]));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == EBADF)
-					tst_resm(TPASS,
-						 "dup failed as expected "
-						 "with EBADF");
-				else
-					tst_resm(TFAIL | TTERRNO,
-						 "dup failed unexpectedly");
-			} else {
-				tst_resm(TFAIL, "dup succeeded unexpectedly");
+	if (TST_RET < -1) {
+		tst_res(TFAIL | TERRNO, "Invalid dup() return value %ld",
+			TST_RET);
+		return;
+	}
 
-				SAFE_CLOSE(cleanup, TEST_RETURN);
-			}
+	if (TST_RET == -1) {
+		if (tc->expected_errno == TST_ERR) {
+			tst_res(TPASS | TERRNO, "dup(%d) failed as expected",
+				tc->fd);
+		} else {
+			tst_res(TFAIL | TERRNO, "dup(%d) failed unexpectedly",
+				tc->fd);
 		}
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	tst_res(TFAIL, "dup(%d) Succeeded unexpectedly", tc->fd);
+	SAFE_CLOSE(TST_RET);
 }
 
-void setup(void)
-{
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-}
-
-void cleanup(void)
-{
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};
-- 
2.26.2

