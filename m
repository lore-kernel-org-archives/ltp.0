From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Fri, 23 Mar 2018 19:34:52 +0800
Subject: [LTP] [PATCH 5/5] syscalls/mkdir05,
	08: Cleanup && Convert to new API
In-Reply-To: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1521804892-5783-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <1521804892-5783-5-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Take use of some safe macros
2) Remove duplicate tests mkdir08

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mkdir/mkdir05.c | 147 ++++++----------------
 testcases/kernel/syscalls/mkdir/mkdir08.c | 196 ------------------------------
 2 files changed, 38 insertions(+), 305 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/mkdir/mkdir08.c

diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index 3d25c43..d5ae930 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -1,6 +1,5 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2001
- *  07/2001 Ported by Wayne Boyer
+/* Copyright (c) International Business Machines  Corp., 2001
+ * 07/2001 Ported by Wayne Boyer
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -13,137 +12,67 @@
  * the GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * DESCRIPTION
- *	This test will verify the mkdir(2) syscall basic functionality
+/* DESCRIPTION
+ * This test will verify the mkdir(2) creates a new directory successfully and
+ * it is owned by the effective group ID of the process.
  */
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <pwd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
+#include "tst_test.h"
 
 #define PERMS		0777
+#define TESTDIR		"testdir"
 
-char *TCID = "mkdir05";
-int TST_TOTAL = 1;
-
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-
-char tstdir1[100];
-
-int main(int ac, char **av)
+static void verify_mkdir(void)
 {
-	int lc;
 	struct stat buf;
 
-	/*
-	 * parse standard options
-	 */
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	/*
-	 * perform global setup for test
-	 */
-	setup();
-
-	/*
-	 * check looping state if -i option given
-	 */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * TEST mkdir() base functionality
-		 */
-
-		/* Initialize the test directory name */
-		sprintf(tstdir1, "tstdir1.%d", getpid());
-
-		/* Call mkdir(2) using the TEST macro */
-		TEST(mkdir(tstdir1, PERMS));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "mkdir(%s, %#o) Failed",
-				 tstdir1, PERMS);
-			continue;
-		}
-
-		SAFE_STAT(cleanup, tstdir1, &buf);
-		/* check the owner */
-		if (buf.st_uid != geteuid()) {
-			tst_resm(TFAIL, "mkdir() FAILED to set owner ID"
-				 " as process's effective ID");
-			continue;
-		}
-		/* check the group ID */
-		if (buf.st_gid != getegid()) {
-			tst_resm(TFAIL, "mkdir() failed to set group ID"
-				 " as the process's group ID");
-			continue;
-		}
-		tst_resm(TPASS, "mkdir() functionality is correct");
-
-		/* clean up things in case we are looping */
-		SAFE_RMDIR(cleanup, tstdir1);
-
+	TEST(mkdir(TESTDIR, PERMS));
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "mkdir() Failed");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-/*
- * setup() - performs all ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
+	SAFE_STAT(TESTDIR, &buf);
 
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	if (buf.st_uid != geteuid()) {
+		tst_res(TFAIL, "mkdir() FAILED to set owner ID "
+			"as process's effective ID");
+		return;
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (buf.st_gid != getegid()) {
+		tst_res(TFAIL, "mkdir() failed to set group ID "
+			"as the process's group ID");
+		return;
+	}
 
-	TEST_PAUSE;
+	tst_res(TPASS, "mkdir() functionality is correct");
 
-	/* Create a temporary directory and make it current. */
-	tst_tmpdir();
+	SAFE_RMDIR(TESTDIR);
 }
 
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *             completion or premature exit.
- */
-void cleanup(void)
+void setup(void)
 {
+	struct passwd *pw;
+	static uid_t nobody_uid;
 
-	/*
-	 * Remove the temporary directory.
-	 */
-	tst_rmdir();
-
-	/*
-	 * Exit with return code appropriate for results.
-	 */
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = pw->pw_uid;
 
+	SAFE_SETUID(nobody_uid);
 }
+
+static struct tst_test test = {
+	.test_all = verify_mkdir,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/mkdir/mkdir08.c b/testcases/kernel/syscalls/mkdir/mkdir08.c
deleted file mode 100644
index ead218a..0000000
--- a/testcases/kernel/syscalls/mkdir/mkdir08.c
+++ /dev/null
@@ -1,196 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
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
- */
-/* $Id: mkdir08.c,v 1.6 2009/11/02 13:57:17 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: mkdir08
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for mkdir(2)
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
- * 	1.) mkdir(2) returns...(See Description)
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
- *	This is a Phase I test for the mkdir(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	mkdir(2).
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
-
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "mkdir08";
-int TST_TOTAL = 1;
-
-char fname[255];
-
-int main(int ac, char **av)
-{
-	int lc;
-
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
-	tst_parse_opts(ac, av, NULL, NULL);
-
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
-	setup();
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call mkdir(2)
-		 */
-		TEST(mkdir(fname, 0777));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "mkdir(%s) Failed, errno=%d : %s",
-				 fname, TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS, "mkdir(%s) returned %ld", fname,
-				 TEST_RETURN);
-			SAFE_RMDIR(cleanup, fname);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "./dir_%d", getpid());
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



