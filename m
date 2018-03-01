From: Yang Xu <xuyang.jy@cn.fujitsu.com>
Date: Thu, 1 Mar 2018 21:48:59 +0800
Subject: [LTP] [PATCH 2/2] syscalls/setuid: Cleanup && Convert to new API
In-Reply-To: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <1519912139-18839-2-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: yang xu <xuyang.jy@cn.fujitsu.com>

1) Merge setuid02 into setuid01
2) Use new compat_tst_16.h
3) Take use of some safe macros

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   2 -
 testcases/kernel/syscalls/.gitignore        |   2 -
 testcases/kernel/syscalls/setuid/Makefile   |   7 +-
 testcases/kernel/syscalls/setuid/setuid01.c | 110 +++++----------
 testcases/kernel/syscalls/setuid/setuid02.c | 200 ----------------------------
 testcases/kernel/syscalls/setuid/setuid03.c |  89 ++++---------
 testcases/kernel/syscalls/setuid/setuid04.c | 200 +++++++++-------------------
 9 files changed, 124 insertions(+), 488 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/setuid/setuid02.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 5418495..919b745 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -815,7 +815,6 @@ settimeofday01 settimeofday01
 settimeofday02 settimeofday02
 
 setuid01 setuid01
-setuid02 setuid02
 setuid03 setuid03
 setuid04 setuid04
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 242b696..4497275 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -705,7 +705,6 @@ settimeofday01 settimeofday01
 settimeofday02 settimeofday02
 
 setuid01 setuid01
-setuid02 setuid02
 setuid03 setuid03
 setuid04 setuid04
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 97fc643..bd6f914 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1169,8 +1169,6 @@ settimeofday02 settimeofday02
 
 setuid01 setuid01
 setuid01_16 setuid01_16
-setuid02 setuid02
-setuid02_16 setuid02_16
 setuid03 setuid03
 setuid03_16 setuid03_16
 setuid04 setuid04
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 12a136e..721b500 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -947,8 +947,6 @@
 /settimeofday/settimeofday02
 /setuid/setuid01
 /setuid/setuid01_16
-/setuid/setuid02
-/setuid/setuid02_16
 /setuid/setuid03
 /setuid/setuid03_16
 /setuid/setuid04
diff --git a/testcases/kernel/syscalls/setuid/Makefile b/testcases/kernel/syscalls/setuid/Makefile
index f3ab657..4aaa6c6 100644
--- a/testcases/kernel/syscalls/setuid/Makefile
+++ b/testcases/kernel/syscalls/setuid/Makefile
@@ -12,12 +12,15 @@
 #  the GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#  along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
+
+#for compat_16.mk uses the compat_16_tst.h
+COMPAT_16_TST_H		:= 1
+
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/setuid/setuid01.c b/testcases/kernel/syscalls/setuid/setuid01.c
index c6061b8..4eb8414 100644
--- a/testcases/kernel/syscalls/setuid/setuid01.c
+++ b/testcases/kernel/syscalls/setuid/setuid01.c
@@ -1,95 +1,47 @@
 /*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * AUTHOR		: William Roske
- * CO-PILOT		: Dave Fenner
+/* DESCRIPTION
+ *	This test will verify that setuid(2) syscall basic functionality.
+ *	setuid(2) returns a value of 0 and uid has been set successfully
+ *	as a normal or super user.
  */
 
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
+#include <unistd.h>
 #include <sys/types.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-#include "test.h"
-#include "compat_16.h"
-
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "setuid01";
-int TST_TOTAL = 1;
-
-static uid_t uid;
-
-int main(int ac, char **av)
+static void verify_setuid(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	uid_t uid;
 
-	setup();
+	/* Set the effective user ID to the current real uid */
+	uid = getuid();
+	UID16_CHECK(uid, setuid);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* Set the effective user ID to the current real uid */
-		uid = getuid();
-		UID16_CHECK(uid, setuid, cleanup);
-
-		TEST(SETUID(cleanup, uid));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setuid -  Set the effective user ID to the current real uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setuid -  Set the effective user ID to the current real uid returned %ld",
-					 TEST_RETURN);
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
+	TEST(SETUID(uid));
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "setuid(%d) failed", uid);
+	else
+		tst_res(TPASS, "setuid(%d) successfully", uid);
 }
 
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_setuid,
+};
diff --git a/testcases/kernel/syscalls/setuid/setuid02.c b/testcases/kernel/syscalls/setuid/setuid02.c
deleted file mode 100644
index c515a1b..0000000
--- a/testcases/kernel/syscalls/setuid/setuid02.c
+++ /dev/null
@@ -1,200 +0,0 @@
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
-/* $Id: setuid02.c,v 1.6 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: setuid02
- *
- *    EXECUTED BY	: root
- *
- *    TEST TITLE	: Basic test for setuid(2) as root
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
- *    DATE STARTED	: 05/14/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) setuid(2) returns...(See Description)
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
- *	This is a Phase I test for the setuid(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	setuid(2).
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
-#include <sys/types.h>
-
-#include "test.h"
-#include "compat_16.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "setuid02";
-int TST_TOTAL = 1;
-
-uid_t uid;			/* current user id */
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
-	uid = getuid();
-	UID16_CHECK(uid, setuid, cleanup);
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * TEST CASE:
-		 *  Set the effective user ID to the current real uid
-		 */
-
-		/* Call setuid(2) */
-		TEST(SETUID(cleanup, uid));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL,
-				 "setuid -  Set the effective user ID to the current real uid failed, errno=%d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-		} else {
-			tst_resm(TPASS,
-				 "setuid -  Set the effective user ID to the current real uid returned %ld",
-				 TEST_RETURN);
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
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/* make a temp dir and cd to it */
-	tst_tmpdir();
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
diff --git a/testcases/kernel/syscalls/setuid/setuid03.c b/testcases/kernel/syscalls/setuid/setuid03.c
index 7453388..c8ae64a 100644
--- a/testcases/kernel/syscalls/setuid/setuid03.c
+++ b/testcases/kernel/syscalls/setuid/setuid03.c
@@ -1,6 +1,5 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *  Ported by Wayne Boyer
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -13,87 +12,55 @@
  * the GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * Test to check the error and trivial conditions in setuid
+/* DESCRIPTION
+ * This test will switch to nobody user for correct error code collection.
+ * Verify setuid returns errno EPERM when it switches to root_user.
  */
 
 #include <errno.h>
 #include <pwd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <unistd.h>
-
-#include "test.h"
-#include "compat_16.h"
+#include <sys/types.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
 #define ROOT_USER	0
 
-char *TCID = "setuid03";
-int TST_TOTAL = 1;
-
-static char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void verify_setuid(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(SETUID(cleanup, ROOT_USER));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
-
-		if (TEST_ERRNO == EPERM) {
-			tst_resm(TPASS, "setuid returned errno EPERM");
-		} else {
-			tst_resm(TFAIL, "setuid returned unexpected errno - %d",
-				 TEST_ERRNO);
-		}
+	TEST(SETUID(ROOT_USER));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL | TTERRNO, "setuid() succeeded unexpectedly");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == EPERM)
+		tst_res(TPASS, "setuid() returned errno EPERM");
+	else
+		tst_res(TFAIL | TTERRNO, "setuid() returned unexpected errno");
 }
 
 static void setup(void)
 {
-	tst_require_root();
+	struct passwd *pw;
+	uid_t uid;
 
-	/* Switch to nobody user for correct error code collection */
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
-			nobody_uid);
+	pw = SAFE_GETPWNAM("nobody");
+	uid = pw->pw_uid;
 
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
+	if (SETUID(uid) == -1) {
+		tst_brk(TBROK,
+			"setuid() failed to set the effective uid to %d", uid);
 	}
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
 	umask(0);
-
-	TEST_PAUSE;
 }
 
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.setup = setup,
+	.needs_root = 1,
+	.test_all =  verify_setuid,
+};
diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index 3459e66..2f2244f 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -1,170 +1,90 @@
-/******************************************************************************
- * Copyright (c) Kerlabs 2008.                                                *
- * Copyright (c) International Business Machines  Corp., 2008                 *
- *  Created by Renaud Lottiaux                                                *
- *                                                                            *
- * This program is free software;  you can redistribute it and/or modify      *
- * it under the terms of the GNU General Public License as published by       *
- * the Free Software Foundation; either version 2 of the License, or          *
- * (at your option) any later version.                                        *
- *                                                                            *
- * This program is distributed in the hope that it will be useful,            *
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of            *
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  *
- * the GNU General Public License for more details.                           *
- *                                                                            *
- * You should have received a copy of the GNU General Public License          *
- * along with this program;  if not, write to the Free Software Foundation,   *
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           *
- *****************************************************************************/
+/*
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, see <http://www.gnu.org/licenses/>.
+ */
 
 /*
- * Check if setuid behaves correctly with file permissions. The test creates a
- * file as ROOT with permissions 0644, does a setuid and then tries to open the
- * file with RDWR permissions. The same test is done in a fork to check if new
- * UIDs are correctly passed to the son.
+ * DESCRIPTION
+ *	Check if setuid behaves correctly with file permissions. The test
+ *	creates a file as ROOT with permissions 0644, does a setuid and then
+ *	tries to open the file with RDWR permissions. The same test is done
+ *	in a fork to check if new UIDs are correctly passed to the son.
  */
 
 #include <errno.h>
 #include <pwd.h>
+#include <unistd.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
 #include <fcntl.h>
-#include <unistd.h>
+#include "tst_test.h"
+#include "compat_tst_16.h"
 
-#include "test.h"
-#include "safe_macros.h"
-#include "compat_16.h"
+#define  FILENAME  "setuid04_testfile"
 
-char *TCID = "setuid04";
-int TST_TOTAL = 1;
+static void dosetuid(void);
 
-static char nobody_uid[] = "nobody";
-static char testfile[] = "setuid04_testfile";
-static struct passwd *ltpuser;
-
-static int fd = -1;
-
-static void setup(void);
-static void cleanup(void);
-static void do_master_child(void);
-
-int main(int ac, char **av)
+static void verify_setuid(void)
 {
 	pid_t pid;
-	int status;
-
-	tst_parse_opts(ac, av, NULL, NULL);
 
-	setup();
-
-	pid = FORK_OR_VFORK();
-	if (pid < 0)
-		tst_brkm(TBROK, cleanup, "Fork failed");
-
-	if (pid == 0) {
-		do_master_child();
-	} else {
-		waitpid(pid, &status, 0);
-		if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-			tst_resm(WEXITSTATUS(status),
-				 "son process exits with error");
-	}
-
-	cleanup();
-	tst_exit();
+	pid = SAFE_FORK();
+	if (!pid)
+		dosetuid();
+	else
+		dosetuid();
 }
 
-static void do_master_child(void)
+static void dosetuid(void)
 {
-	int lc;
-	int pid;
-	int status;
+	int tst_fd;
 
-	if (SETUID(NULL, ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK, NULL,
-			 "setuid failed to set the effective uid to %d",
-			 ltpuser->pw_uid);
+	TEST(tst_fd = open(FILENAME, O_RDWR));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "open() succeeded unexpectedly");
+		close(tst_fd);
+		return;
 	}
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int tst_fd;
-
-		tst_count = 0;
-
-		TEST(tst_fd = open(testfile, O_RDWR));
-
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			close(tst_fd);
-		}
-
-		if (TEST_ERRNO == EACCES) {
-			tst_resm(TPASS, "open returned errno EACCES");
-		} else {
-			tst_resm(TFAIL, "open returned unexpected errno - %d",
-				 TEST_ERRNO);
-			continue;
-		}
-
-		pid = FORK_OR_VFORK();
-		if (pid < 0)
-			tst_brkm(TBROK, NULL, "Fork failed");
-
-		if (pid == 0) {
-			int tst_fd2;
-
-			/* Test to open the file in son process */
-			TEST(tst_fd2 = open(testfile, O_RDWR));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				close(tst_fd2);
-			}
-
-			if (TEST_ERRNO == EACCES) {
-				tst_resm(TPASS, "open returned errno EACCES");
-			} else {
-				tst_resm(TFAIL,
-					 "open returned unexpected errno - %d",
-					 TEST_ERRNO);
-			}
-			tst_exit();
-		} else {
-			/* Wait for son completion */
-			waitpid(pid, &status, 0);
-			if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0))
-				exit(WEXITSTATUS(status));
-		}
-	}
-	tst_exit();
+	if (TEST_ERRNO == EACCES)
+		tst_res(TPASS, "open() returned errno EACCES");
+	else
+		tst_res(TFAIL | TTERRNO, "open() returned unexpected errno");
 }
 
 static void setup(void)
 {
-	tst_require_root();
+	struct passwd *pw;
+	uid_t uid;
 
-	ltpuser = getpwnam(nobody_uid);
-
-	if (ltpuser == NULL)
-		tst_brkm(TBROK, cleanup, "getpwnam failed for user id %s",
-			nobody_uid);
-
-	UID16_CHECK(ltpuser->pw_uid, setuid, cleanup);
-
-	tst_tmpdir();
+	pw = SAFE_GETPWNAM("nobody");
+	uid = pw->pw_uid;
 
+	UID16_CHECK(uid, setuid);
 	/* Create test file */
-	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	SAFE_TOUCH(FILENAME, 0644, NULL);
 
-	TEST_PAUSE;
+	if (SETUID(uid) == -1) {
+		tst_brk(TBROK,
+			"setuid() failed to set the effective uid to %d", uid);
+	}
 }
 
-static void cleanup(void)
-{
-	close(fd);
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.needs_root = 1,
+	.test_all = verify_setuid,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
-- 
1.8.3.1



