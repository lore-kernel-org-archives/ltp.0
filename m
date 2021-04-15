From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 15 Apr 2021 14:35:17 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/chown: rewrite chown/chown01.c with
 the new api
In-Reply-To: <20210415063518.174631-1-xieziyao@huawei.com>
References: <20210415063518.174631-1-xieziyao@huawei.com>
Message-ID: <20210415063518.174631-2-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For this:
  testcases/kernel/syscalls/chown/chown01.c

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---

v1->v2:
1. Use TST_EXP_PASS(CHOWN(fname, uid, gid), "chown(%s,%d,%d)", ...)
instead of TEST() and return value checks;
2. Use the FILENAME constant for the name of the temporary file.

 testcases/kernel/syscalls/chown/chown01.c | 187 ++++------------------
 1 file changed, 32 insertions(+), 155 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
index 2e42153d6..c4898c53a 100644
--- a/testcases/kernel/syscalls/chown/chown01.c
+++ b/testcases/kernel/syscalls/chown/chown01.c
@@ -1,179 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
+ * AUTHOR: William Roske
+ * CO-PILOT: Dave Fenner
  */
-/* $Id: chown01.c,v 1.6 2009/08/28 11:59:17 vapier Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: chown01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for chown(2)
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
- * 	1.) chown(2) returns...(See Description)
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
- *	This is a Phase I test for the chown(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	chown(2).
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
+
+/*\
+ * [Description]
  *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
+ * This is a Phase I test for the chown(2) system call. It is intended
+ * to provide a limited exposure of the system call, for now. It
+ * should/will be extended when full functional tests are written for
+ * chown(2).
  *
+ * [Algorithm]
  *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
+ * - Execute system call
+ * - Check return code, if system call failed (return=-1)
+ * -   Log the errno and Issue a FAIL message
+ * - Otherwise, Issue a PASS message
+ */

+#include <stdio.h>
 #include <sys/types.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"

-TCID_DEFINE(chown01);
-int TST_TOTAL = 1;
+#include "tst_test.h"
+#include "compat_tst_16.h"

-char fname[255];
-int uid, gid;
+#define FILENAME "chown01_testfile"

-static void setup(void);
-static void cleanup(void);
+int uid, gid;

-int main(int ac, char **av)
+static void run(void)
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
-		TEST(CHOWN(cleanup, fname, uid, gid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "chown(%s, %d,%d) failed",
-				 fname, uid, gid);
-		} else {
-			tst_resm(TPASS, "chown(%s, %d,%d) returned %ld",
-				 fname, uid, gid, TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TST_EXP_PASS(CHOWN(FILENAME, uid, gid), "chown(%s,%d,%d)",
+		     FILENAME, uid, gid);
 }

 static void setup(void)
 {
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	UID16_CHECK((uid = geteuid()), "chown", cleanup)
-	GID16_CHECK((gid = getegid()), "chown", cleanup)
-
-	sprintf(fname, "t_%d", getpid());
-
-	SAFE_FILE_PRINTF(cleanup, fname, "davef");
+	UID16_CHECK((uid = geteuid()), "chown");
+	GID16_CHECK((gid = getegid()), "chown");
+	SAFE_FILE_PRINTF(FILENAME, "davef");
 }

-static void cleanup(void)
-{
-	tst_rmdir();
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.test_all = run,
+};

-}
--
2.17.1

