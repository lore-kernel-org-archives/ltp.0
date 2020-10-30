From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Fri, 30 Oct 2020 16:53:50 +0200
Subject: [LTP] [PATCH] Convert dup01 to new API and clean up
In-Reply-To: <20201030145350.23829-1-radoslav.kolev@suse.com>
References: <20201030145350.23829-1-radoslav.kolev@suse.com>
Message-ID: <20201030145350.23829-2-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/kernel/syscalls/dup/dup01.c | 202 ++++----------------------
 1 file changed, 30 insertions(+), 172 deletions(-)

diff --git a/testcases/kernel/syscalls/dup/dup01.c b/testcases/kernel/syscalls/dup/dup01.c
index 5c82ebefc..c3abfb14e 100644
--- a/testcases/kernel/syscalls/dup/dup01.c
+++ b/testcases/kernel/syscalls/dup/dup01.c
@@ -1,187 +1,45 @@
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
- *
+ * Copyright (c) 2020 SUSE LLC
+ * 
+ * 03/30/1992 AUTHOR: William Roske CO-PILOT: Dave Fenner
+ * 30/10/2020 Convert to new api Radoslav Kolev <radoslav.kolev@suse.com>
  */
-/* $Id: dup01.c,v 1.6 2009/10/13 14:00:46 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: dup01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for dup(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: William Roske
- *
- *    CO-PILOT		: Dave Fenner
- *
- *    DATE STARTED	: 03/30/92
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
- *	This is a Phase I test for the dup(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	dup(2).
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
 
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
-void setup();
-void cleanup();
+static int fd;
+static int dup_fd;
 
-char *TCID = "dup01";
-int TST_TOTAL = 1;
-
-char filename[255];
-int fd;
-
-int main(int ac, char **av)
+static void verify_dup(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call dup(2)
-		 */
-		TEST(dup(fd));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "dup(%s) Failed, errno=%d : %s",
-				 filename, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "dup(%s) returned %ld",
-				 filename, TEST_RETURN);
-
-			/* close the new file so loops do not open too many files */
-			SAFE_CLOSE(cleanup, TEST_RETURN);
-		}
-
+	TEST(dup_fd = dup(fd));
+
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TERRNO, "dup(%d) Failed, %s",
+			fd);
+	} else {
+		tst_res(TPASS, "dup(%d) returned %ld",
+			fd, TST_RET);
+		SAFE_CLOSE(dup_fd);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-	fd = -1;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(filename, "dupfile");
-	if ((fd = open(filename, O_RDWR | O_CREAT, 0700)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = SAFE_OPEN("dupfile", O_RDWR | O_CREAT, 0700);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	if (fd != -1)
-		if (close(fd) == -1)
-			tst_resm(TWARN | TERRNO, "closing %s failed", filename);
-
-	tst_rmdir();
-
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.test_all = verify_dup,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.26.2

