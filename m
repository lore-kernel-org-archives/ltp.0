Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VY9s5-0004VI-Pu
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:49 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VY9s2-0000ah-43
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:49 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9L7PeKx015458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:40 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7PddW000914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:39 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7Pd28006604
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:39 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Oct 2013 11:25:15 +0400
Message-Id: <1382340317-8510-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/3] syscalls/setreuid: 16-bit fixes and minor cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setreuid/setreuid01.c |  172 +++------------------
 testcases/kernel/syscalls/setreuid/setreuid02.c |  157 +++++--------------
 testcases/kernel/syscalls/setreuid/setreuid03.c |  182 +++++++---------------
 testcases/kernel/syscalls/setreuid/setreuid04.c |  141 +++++-------------
 testcases/kernel/syscalls/setreuid/setreuid05.c |  186 +++++++----------------
 testcases/kernel/syscalls/setreuid/setreuid06.c |  104 ++++---------
 testcases/kernel/syscalls/setreuid/setreuid07.c |  124 ++++++----------
 testcases/kernel/syscalls/utils/compat_16.h     |    5 +
 8 files changed, 296 insertions(+), 775 deletions(-)

diff --git a/testcases/kernel/syscalls/setreuid/setreuid01.c b/testcases/kernel/syscalls/setreuid/setreuid01.c
index 1f54337..45d38cb 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid01.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid01.c
@@ -29,127 +29,41 @@
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
+ * Author: William Roske
+ * Co-pilot: Dave Fenner
+ */
+
+/*
+ * Testcase to test the basic functionality of setreuid(2) system call.
  */
-/* $Id: setreuid01.c,v 1.6 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: setreuid01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for setreuid(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 5
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
- *	1.) setreuid(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- *	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *
- *    DURATION
- *	Terminates - with frequency and infinite modes.
- *
- *    SIGNALS
- *	Uses SIGUSR1 to pause before test if option set.
- *	(See the parse_opts(3) man page).
- *
- *    RESOURCES
- *	None
- *
- *    ENVIRONMENTAL NEEDS
- *      No run-time environmental needs.
- *
- *    SPECIAL PROCEDURAL REQUIREMENTS
- *	None
- *
- *    INTERCASE DEPENDENCIES
- *	None
- *
- *    DETAILED DESCRIPTION
- *	This is a Phase I test for the setreuid(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	setreuid(2).
- *
- *	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- *	Test:
- *	 Loop if the proper options are given.
- *	  Execute system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given
- *
- *
- *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
 
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
-
 #include <sys/types.h>
 
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
-void setup();
-void cleanup();
+static void setup();
+static void cleanup();
 
-char *TCID = "setreuid01";
+TCID_DEFINE(setreuid01);
 int TST_TOTAL = 5;
 
-int exp_enos[] = { 0, 0 };
-
-int ruid, euid;			/* real and effective user ids */
+static uid_t ruid, euid;	/* real and effective user ids */
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
 
-    /***************************************************************
-     * parse standard options
-     ***************************************************************/
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-    /***************************************************************
-     * perform global setup for test
-     ***************************************************************/
 	setup();
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
-    /***************************************************************
-     * check looping state if -c option given
-     ***************************************************************/
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
@@ -159,21 +73,19 @@ int main(int ac, char **av)
 		 *  Don't change either real or effective uid
 		 */
 		ruid = getuid();	/* get real uid */
+		UID16_CHECK(ruid, setreuid, cleanup);
+
 		euid = geteuid();	/* get effective uid */
+		UID16_CHECK(euid, setreuid, cleanup);
 
-		/* Call setreuid(2) */
-		TEST(setreuid(-1, -1));
+		TEST(SETREUID(cleanup, -1, -1));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
 				 "setreuid -  Don't change either real or effective uid failed, errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
 				/* No Verification test, yet... */
 				tst_resm(TPASS,
@@ -187,21 +99,15 @@ int main(int ac, char **av)
 		 *  change effective to effective uid
 		 */
 
-		/* Call setreuid(2) */
-		TEST(setreuid(-1, euid));
+		TEST(SETREUID(cleanup, -1, euid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
 				 "setreuid -  change effective to effective uid failed, errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setreuid -  change effective to effective uid returned %ld",
 					 TEST_RETURN);
@@ -213,21 +119,15 @@ int main(int ac, char **av)
 		 *  change real to real uid
 		 */
 
-		/* Call setreuid(2) */
-		TEST(setreuid(ruid, -1));
+		TEST(SETREUID(cleanup, ruid, -1));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
 				 "setreuid -  change real to real uid failed, errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setreuid -  change real to real uid returned %ld",
 					 TEST_RETURN);
@@ -239,21 +139,15 @@ int main(int ac, char **av)
 		 *  change effective to real uid
 		 */
 
-		/* Call setreuid(2) */
-		TEST(setreuid(-1, ruid));
+		TEST(SETREUID(cleanup, -1, ruid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
 				 "setreuid -  change effective to real uid failed, errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setreuid -  change effective to real uid returned %ld",
 					 TEST_RETURN);
@@ -265,21 +159,15 @@ int main(int ac, char **av)
 		 *  try to change real to current real
 		 */
 
-		/* Call setreuid(2) */
-		TEST(setreuid(ruid, ruid));
+		TEST(SETREUID(cleanup, ruid, ruid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
 				 "setreuid -  try to change real to current real failed, errno=%d : %s",
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
-	    /***************************************************************
-	     * only perform functional verification if flag set (-f not given)
-	     ***************************************************************/
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setreuid -  try to change real to current real returned %ld",
 					 TEST_RETURN);
@@ -288,41 +176,23 @@ int main(int ac, char **av)
 
 	}
 
-    /***************************************************************
-     * cleanup and exit
-     ***************************************************************/
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup()
+static void setup(void)
 {
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
-	/* make a temp dir and cd to it */
 	tst_tmpdir();
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup()
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid02.c b/testcases/kernel/syscalls/setreuid/setreuid02.c
index 5fdd918..050df17 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid02.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid02.c
@@ -1,87 +1,47 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported by John George
  */
 
 /*
- * NAME
- *	setreuid02.c
- *
- * DESCRIPTION
- *	Test setreuid() when executed by root.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test set execute the system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise,
- *		Verify the Functionality of system call
- *		if successful,
- *			Issue Functionality-Pass message.
- *		Otherwise,
- *			Issue Functionality-Fail message.
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given.
- *
- * USAGE:  <for command-line>
- *	setreuid02 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	This test must be ran as root.
- *	nobody, bin, and daemon must be valid users.
+ * Test setreuid() when executed by root.
  */
 
+#include <errno.h>
 #include <pwd.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <errno.h>
+#include "compat_16.h"
 
-char *TCID = "setreuid02";
-uid_t nobody_pw_uid, root_pw_uid, daemon_pw_uid, bin_pw_uid;
-uid_t neg_one = -1;
-int exp_enos[] = { 0 };
+TCID_DEFINE(setreuid02);
 
-struct passwd nobody, daemonpw, root, bin;
+static uid_t neg_one = -1;
+static struct passwd nobody, daemonpw, root, bin;
 
 /*
  * The following structure contains all test data.  Each structure in the array
  * is used for a separate test.  The tests are executed in the for loop below.
  */
 
-struct test_data_t {
+static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
 	struct passwd *exp_real_usr;
@@ -90,20 +50,20 @@ struct test_data_t {
 } test_data[] = {
 	{
 	&neg_one, &neg_one, &root, &root, "After setreuid(-1, -1),"}, {
-	&nobody_pw_uid, &neg_one, &nobody, &root, "After setreuid(nobody, -1)"},
+	&nobody.pw_uid, &neg_one, &nobody, &root, "After setreuid(nobody, -1)"},
 	{
-	&root_pw_uid, &neg_one, &root, &root, "After setreuid(root,-1),"}, {
-	&neg_one, &daemon_pw_uid, &root, &daemonpw,
+	&root.pw_uid, &neg_one, &root, &root, "After setreuid(root,-1),"}, {
+	&neg_one, &daemonpw.pw_uid, &root, &daemonpw,
 		    "After setreuid(-1, daemon)"}, {
-	&neg_one, &root_pw_uid, &root, &root, "After setreuid(-1,root),"}, {
-	&bin_pw_uid, &neg_one, &bin, &root, "After setreuid(bin, -1)"}, {
-&root_pw_uid, &neg_one, &root, &root, "After setreuid(-1, root)"},};
+	&neg_one, &root.pw_uid, &root, &root, "After setreuid(-1,root),"}, {
+	&bin.pw_uid, &neg_one, &bin, &root, "After setreuid(bin, -1)"}, {
+&root.pw_uid, &neg_one, &root, &root, "After setreuid(-1, root)"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void uid_verify(struct passwd *ru, struct passwd *eu, char *when);
+static void setup(void);
+static void cleanup(void);
+static void uid_verify(struct passwd *ru, struct passwd *eu, char *when);
 
 int main(int ac, char **av)
 {
@@ -120,12 +80,11 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective user id */
-			TEST(setreuid(*test_data[i].real_uid,
+			TEST(SETREUID(cleanup, *test_data[i].real_uid,
 				      *test_data[i].eff_uid));
 
 			if (TEST_RETURN == -1) {
@@ -134,10 +93,6 @@ int main(int ac, char **av)
 					 *test_data[i].real_uid,
 					 *test_data[i].eff_uid);
 			} else {
-				/*
-				 * Perform functional verification if test
-				 * executed without (-f) option.
-				 */
 				if (STD_FUNCTIONAL_TEST) {
 					uid_verify(test_data[i].exp_real_usr,
 						   test_data[i].exp_eff_usr,
@@ -150,71 +105,45 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	if (getpwnam("nobody") == NULL) {
+	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-		tst_exit();
-	}
 
-	if (getpwnam("daemon") == NULL) {
+	if (getpwnam("daemon") == NULL)
 		tst_brkm(TBROK, NULL, "daemon must be a valid user.");
-		tst_exit();
-	}
 
-	/* Check that the test process id is root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
-
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
+	if (getpwnam("bin") == NULL)
+		tst_brkm(TBROK, NULL, "bin must be a valid user.");
 
 	root = *(getpwnam("root"));
-	root_pw_uid = root.pw_uid;
+	UID16_CHECK(root.pw_uid, setreuid, cleanup);
 
 	nobody = *(getpwnam("nobody"));
-	nobody_pw_uid = nobody.pw_uid;
+	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
 
 	daemonpw = *(getpwnam("daemon"));
-	daemon_pw_uid = daemonpw.pw_uid;
+	UID16_CHECK(daemonpw.pw_uid, setreuid, cleanup);
 
 	bin = *(getpwnam("bin"));
-	bin_pw_uid = bin.pw_uid;
+	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 }
 
-void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
+static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 {
 	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
 		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index 5dcb1f6..24e52d5 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -1,94 +1,52 @@
 /*
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * Ported by John George
  */
 
 /*
- * NAME
- *	setreuid03.c
- *
- * DESCRIPTION
- *	Test setreuid() when executed by an unpriviledged user.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test set execute the system call
- *	  Check that we received the expected result.
- *	  If setreuid failed as expected
- *		check that the correct errno value was set.
- *	  otherwise
- *		Issue Pass message.
- *	  Verify that the uid and euid values are still correct.
- *	Cleanup:
- *	  Print errno log and/or timing stats if option given.
- *
- * USAGE:  <for command-line>
- *	setreuid03 [-c n] [-f] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	This test must be run by nobody.
+ * Test setreuid() when executed by an unpriviledged user.
  */
 
+#include <errno.h>
 #include <pwd.h>
 #include <stdlib.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <errno.h>
+#include "compat_16.h"
 
 #define FAILED  1
 
-char *TCID = "setreuid03";
+TCID_DEFINE(setreuid03);
 
-int fail = -1;
-int pass = 0;
-uid_t neg_one = -1;
-int exp_enos[] = { EPERM, 0 };
+static int fail = -1;
+static int pass;
+static uid_t neg_one = -1;
 
-uid_t root_pw_uid, nobody_pw_uid, bin_pw_uid;
-char user1name[] = "nobody";
-char user2name[] = "bin";
-char rootname[] = "root";
-
-struct passwd nobody, bin, root;
+static struct passwd nobody, bin, root;
 
 /*
  * The following structure contains all test data.  Each structure in the array
  * is used for a separate test.  The tests are executed in the for loop below.
  */
 
-struct test_data_t {
+static struct test_data_t {
 	uid_t *real_uid;
 	uid_t *eff_uid;
 	int *exp_ret;
@@ -97,40 +55,40 @@ struct test_data_t {
 	char *test_msg;
 } test_data[] = {
 	{
-	&nobody_pw_uid, &nobody_pw_uid, &pass, &nobody, &nobody,
+	&nobody.pw_uid, &nobody.pw_uid, &pass, &nobody, &nobody,
 		    "After setreuid(nobody, nobody),"}, {
-	&neg_one, &nobody_pw_uid, &pass, &nobody, &nobody,
+	&neg_one, &nobody.pw_uid, &pass, &nobody, &nobody,
 		    "After setreuid(-1, nobody),"}, {
-	&nobody_pw_uid, &neg_one, &pass, &nobody, &nobody,
+	&nobody.pw_uid, &neg_one, &pass, &nobody, &nobody,
 		    "After setreuid(nobody, -1),"}, {
 	&neg_one, &neg_one, &pass, &nobody, &nobody, "After setreuid(-1, -1),"},
 	{
-	&neg_one, &root_pw_uid, &fail, &nobody, &nobody,
+	&neg_one, &root.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(-1, root),"}, {
-	&root_pw_uid, &neg_one, &fail, &nobody, &nobody,
+	&root.pw_uid, &neg_one, &fail, &nobody, &nobody,
 		    "After setreuid(root, -1),"}, {
-	&root_pw_uid, &root_pw_uid, &fail, &nobody, &nobody,
+	&root.pw_uid, &root.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(root, root),"}, {
-	&root_pw_uid, &nobody_pw_uid, &fail, &nobody, &nobody,
+	&root.pw_uid, &nobody.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(root, nobody),"}, {
-	&root_pw_uid, &bin_pw_uid, &fail, &nobody, &nobody,
+	&root.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(root, nobody),"}, {
-	&bin_pw_uid, &root_pw_uid, &fail, &nobody, &nobody,
+	&bin.pw_uid, &root.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(bin, root),"}, {
-	&bin_pw_uid, &neg_one, &fail, &nobody, &nobody,
+	&bin.pw_uid, &neg_one, &fail, &nobody, &nobody,
 		    "After setreuid(bin, -1),"}, {
-	&bin_pw_uid, &bin_pw_uid, &fail, &nobody, &nobody,
+	&bin.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(bin, bin,),"}, {
-	&bin_pw_uid, &nobody_pw_uid, &fail, &nobody, &nobody,
+	&bin.pw_uid, &nobody.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(bin, nobody),"}, {
-&nobody_pw_uid, &bin_pw_uid, &fail, &nobody, &nobody,
+	&nobody.pw_uid, &bin.pw_uid, &fail, &nobody, &nobody,
 		    "After setreuid(nobody, bin),"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void uid_verify(struct passwd *, struct passwd *, char *);
+static void setup(void);
+static void cleanup(void);
+static void uid_verify(struct passwd *, struct passwd *, char *);
 
 int main(int ac, char **av)
 {
@@ -147,13 +105,12 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
 			/* Set the real or effective user id */
-			TEST(setreuid(*test_data[i].real_uid,
+			TEST(SETREUID(cleanup, *test_data[i].real_uid,
 				      *test_data[i].eff_uid));
 
 			if (TEST_RETURN == *test_data[i].exp_ret) {
@@ -187,86 +144,57 @@ int main(int ac, char **av)
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
 			}
-			/*
-			 * Perform functional verification if test
-			 * executed without (-f) option.
-			 */
 			if (STD_FUNCTIONAL_TEST) {
 				uid_verify(test_data[i].exp_real_usr,
 					   test_data[i].exp_eff_usr,
 					   test_data[i].test_msg);
+			} else {
+				tst_resm(TINFO, "Call succeeded.");
 			}
 		}
 	}
 
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	if (getpwnam("nobody") == NULL) {
+	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-		tst_exit();
-	}
 
-	if (getpwnam("bin") == NULL) {
+	if (getpwnam("bin") == NULL)
 		tst_brkm(TBROK, NULL, "bin must be a valid user.");
-		tst_exit();
-	}
-
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
 
 	root = *(getpwnam("root"));
-	root_pw_uid = root.pw_uid;
+	UID16_CHECK(root.pw_uid, setreuid, cleanup);
 
 	nobody = *(getpwnam("nobody"));
-	nobody_pw_uid = nobody.pw_uid;
+	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
 
 	bin = *(getpwnam("bin"));
-	bin_pw_uid = bin.pw_uid;
+	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
 
-	/* Check that the test process id is nobody */
-	if (geteuid() != nobody.pw_uid) {
-/*		tst_brkm(TBROK, NULL, "Must be nobody for this test!");
-		tst_exit();*/
-		setuid(nobody.pw_uid);
-	}
+	if (setuid(nobody.pw_uid) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "setuid() to nobody failed");
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 }
 
-void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
+static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 {
 	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TINFO, "ERROR: %s real uid = %d; effective uid = %d",
+		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid04.c b/testcases/kernel/syscalls/setreuid/setreuid04.c
index 0396f05..d949a4b 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid04.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid04.c
@@ -1,83 +1,45 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported by John George
  */
 
 /*
- * NAME
- *	setreuid04.c
- *
- * DESCRIPTION
- *	Test that root can change the real and effective uid to an
- *	unpriviledged user.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test set execute the system call
- *	  Check that we received the expected result.
- *	  Verify that the uid and euid values are still correct.
- *	Cleanup:
- *	  Print errno log and/or timing stats if option given.
- *
- * USAGE:  <for command-line>
- *	 setreuid04 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	This test must be run by root.
- *	nobody must be a valid user.
- *	This test cannot be run with the i/I option.
+ * Test that root can change the real and effective uid to an
+ * unpriviledged user.
  */
 
 #include <errno.h>
 #include <stdlib.h>
 #include <pwd.h>
+#include <sys/wait.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <sys/wait.h>
+#include "compat_16.h"
 
-char *TCID = "setreuid04";
+TCID_DEFINE(setreuid04);
 
-uid_t neg_one = -1;
+static uid_t neg_one = -1;
 
 /* flag to tell parent if child passed or failed. */
-int flag = 0;
+static int flag;
 
-uid_t root_pw_uid, nobody_pw_uid;
-char user1name[] = "nobody";
-char rootname[] = "root";
-
-struct passwd nobody, root;
+static struct passwd nobody, root;
 
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -93,15 +55,15 @@ struct test_data_t {
 } test_data[] = {
 	{
 	&neg_one, &neg_one, &root, &root, "After setreuid(-1, nobody),"}, {
-&nobody_pw_uid, &nobody_pw_uid, &nobody, &nobody,
+&nobody.pw_uid, &nobody.pw_uid, &nobody, &nobody,
 		    "After setreuid(-1, -1),"},};
 
 /*int TST_TOTAL = sizeof(test_data)/sizeof(test_data[0]);*/
 int TST_TOTAL = 2;
 
-void setup(void);
-void cleanup(void);
-void uid_verify(struct passwd *, struct passwd *, char *);
+static void setup(void);
+static void cleanup(void);
+static void uid_verify(struct passwd *, struct passwd *, char *);
 
 int main(int ac, char **av)
 {
@@ -115,10 +77,11 @@ int main(int ac, char **av)
 
 	setup();
 
+	flag = 0;
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid, status;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
@@ -128,7 +91,7 @@ int main(int ac, char **av)
 			for (i = 0; i < TST_TOTAL; i++) {
 
 				/* Set the real or effective user id */
-				TEST(setreuid(*test_data[i].real_uid,
+				TEST(SETREUID(cleanup, *test_data[i].real_uid,
 					      *test_data[i].eff_uid));
 
 				if (TEST_RETURN != -1) {
@@ -144,10 +107,6 @@ int main(int ac, char **av)
 					flag = -1;
 				}
 
-				/*
-				 * Perform functional verification if test
-				 * executed without (-f) option.
-				 */
 				if (STD_FUNCTIONAL_TEST) {
 					uid_verify(test_data[i].exp_real_usr,
 						   test_data[i].exp_eff_usr,
@@ -167,62 +126,36 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	if (getpwnam("nobody") == NULL) {
+	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-		tst_exit();
-	}
-
-	/* Check that the test process id is root */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be root for this test!");
-		tst_exit();
-	}
 
 	root = *(getpwnam("root"));
-	root_pw_uid = root.pw_uid;
+	UID16_CHECK(root.pw_uid, setreuid, cleanup);
 
 	nobody = *(getpwnam("nobody"));
-	nobody_pw_uid = nobody.pw_uid;
+	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -i option.
-	 * You want to make sure you do this before you create your temporary
-	 * directory.
-	 */
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 }
 
-void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
+static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 {
 	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TINFO, "ERROR: %s real uid = %d; effective uid = %d",
+		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid05.c b/testcases/kernel/syscalls/setreuid/setreuid05.c
index fe8bd89..c46fcd9 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid05.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid05.c
@@ -1,91 +1,47 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported by John George
  */
 
 /*
- * NAME
- *	setreuid05.c
- *
- * DESCRIPTION
- *	Test the setreuid() feature, verifying the role of the saved-set-uid
- *	and setreuid's effect on it.
- *
- * ALGORITHM
- *
-*      Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test set execute the system call
- *	  Check that we received the expected result.
- *	  If setreuid failed as expected
- *		check that the correct errno value was set.
- *	otherwise
- *		Issue Pass message.
- *	  Verify that the uid and euid values are still correct.
- *	Cleanup:
- *	  Print errno log and/or timing stats if option given.
- *
- * USAGE:  <for command-line>
- *	setreuid05 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *	This test must be run by root.
- *	nobody must be a valid user.
+ * Test the setreuid() feature, verifying the role of the saved-set-uid
+ * and setreuid's effect on it.
  */
 
 #include <errno.h>
 #include <pwd.h>
 #include <stdlib.h>
+#include <sys/wait.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <sys/wait.h>
+#include "compat_16.h"
 
-char *TCID = "setreuid05";
+TCID_DEFINE(setreuid05);
 
 /* flag to tell parent if child passed or failed. */
 int flag = 0;
 
-int fail = -1;
-int pass = 0;
-uid_t neg_one = -1;
-int exp_enos[] = { EPERM, 0 };
-
-uid_t root_pw_uid, nobody_pw_uid, daemon_pw_uid, bin_pw_uid;
-char user1name[] = "nobody";
-char user2name[] = "daemon";
-char rootname[] = "root";
-char binname[] = "bin";
+static int fail = -1;
+static int pass;
+static uid_t neg_one = -1;
 
-struct passwd nobody, daemonpw, root, bin;
+static struct passwd nobody, daemonpw, root, bin;
 
 struct test_data_t {
 	uid_t *real_uid;
@@ -96,39 +52,39 @@ struct test_data_t {
 	char *test_msg;
 } test_data[] = {
 	{
-	&nobody_pw_uid, &root_pw_uid, &pass, &nobody, &root, "Initially"}, {
-	&neg_one, &nobody_pw_uid, &pass, &nobody, &nobody,
+	&nobody.pw_uid, &root.pw_uid, &pass, &nobody, &root, "Initially"}, {
+	&neg_one, &nobody.pw_uid, &pass, &nobody, &nobody,
 		    "After setreuid(-1, nobody),"}, {
-	&neg_one, &root_pw_uid, &pass, &nobody, &root,
+	&neg_one, &root.pw_uid, &pass, &nobody, &root,
 		    "After setreuid(-1, root),"}, {
-	&daemon_pw_uid, &neg_one, &pass, &daemonpw, &root,
+	&daemonpw.pw_uid, &neg_one, &pass, &daemonpw, &root,
 		    "After setreuid(daemon, -1),"}, {
-	&neg_one, &bin_pw_uid, &pass, &daemonpw, &bin,
+	&neg_one, &bin.pw_uid, &pass, &daemonpw, &bin,
 		    "After setreuid(-1, bin),"}, {
-	&neg_one, &root_pw_uid, &fail, &daemonpw, &bin,
+	&neg_one, &root.pw_uid, &fail, &daemonpw, &bin,
 		    "After setreuid(-1, root),"}, {
-	&neg_one, &nobody_pw_uid, &fail, &daemonpw, &bin,
+	&neg_one, &nobody.pw_uid, &fail, &daemonpw, &bin,
 		    "After setreuid(-1, nobody),"}, {
-	&neg_one, &daemon_pw_uid, &pass, &daemonpw, &daemonpw,
+	&neg_one, &daemonpw.pw_uid, &pass, &daemonpw, &daemonpw,
 		    "After setreuid(-1, daemon),"}, {
-	&neg_one, &bin_pw_uid, &pass, &daemonpw, &bin,
+	&neg_one, &bin.pw_uid, &pass, &daemonpw, &bin,
 		    "After setreuid(-1, bin),"}, {
-	&bin_pw_uid, &daemon_pw_uid, &pass, &bin, &daemonpw,
+	&bin.pw_uid, &daemonpw.pw_uid, &pass, &bin, &daemonpw,
 		    "After setreuid(bin, daemon),"}, {
-	&neg_one, &bin_pw_uid, &pass, &bin, &bin, "After setreuid(-1, bin),"},
+	&neg_one, &bin.pw_uid, &pass, &bin, &bin, "After setreuid(-1, bin),"},
 	{
-	&neg_one, &daemon_pw_uid, &pass, &bin, &daemonpw,
+	&neg_one, &daemonpw.pw_uid, &pass, &bin, &daemonpw,
 		    "After setreuid(-1, daemon),"}, {
-	&daemon_pw_uid, &neg_one, &pass, &daemonpw, &daemonpw,
+	&daemonpw.pw_uid, &neg_one, &pass, &daemonpw, &daemonpw,
 		    "After setreuid(daemon, -1),"}, {
-&neg_one, &bin_pw_uid, &fail, &daemonpw, &daemonpw,
+	&neg_one, &bin.pw_uid, &fail, &daemonpw, &daemonpw,
 		    "After setreuid(-1, bin),"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void uid_verify(struct passwd *, struct passwd *, char *);
+static void setup(void);
+static void cleanup(void);
+static void uid_verify(struct passwd *, struct passwd *, char *);
 
 int main(int argc, char **argv)
 {
@@ -142,10 +98,11 @@ int main(int argc, char **argv)
 
 	setup();
 
+	pass = 0;
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i, pid, status;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
@@ -153,7 +110,7 @@ int main(int argc, char **argv)
 		} else if (pid == 0) {	/* child */
 			for (i = 0; i < TST_TOTAL; i++) {
 				/* Set the real or effective user id */
-				TEST(setreuid(*test_data[i].real_uid,
+				TEST(SETREUID(cleanup, *test_data[i].real_uid,
 					      *test_data[i].eff_uid));
 
 				if (TEST_RETURN == *test_data[i].exp_ret) {
@@ -193,14 +150,12 @@ int main(int argc, char **argv)
 				if (TEST_RETURN == -1) {
 					TEST_ERROR_LOG(TEST_ERRNO);
 				}
-				/*
-				 * Perform functional verification if test
-				 * executed without (-f) option.
-				 */
 				if (STD_FUNCTIONAL_TEST) {
 					uid_verify(test_data[i].exp_real_usr,
 						   test_data[i].exp_eff_usr,
 						   test_data[i].test_msg);
+				} else {
+					tst_resm(TINFO, "Call succeeded.");
 				}
 			}
 			exit(flag);
@@ -214,73 +169,48 @@ int main(int argc, char **argv)
 	}
 	cleanup();
 	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	if (getpwnam("nobody") == NULL) {
+	if (getpwnam("nobody") == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
-		tst_exit();
-	}
 
-	if (getpwnam("daemon") == NULL) {
+	if (getpwnam("daemon") == NULL)
 		tst_brkm(TBROK, NULL, "daemon must be a valid user.");
-		tst_exit();
-	}
-
-	if (getuid() != 0) {
-		tst_resm(TBROK, "Must be run as root");
-		tst_exit();
-	}
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
+	if (getpwnam("bin") == NULL)
+		tst_brkm(TBROK, NULL, "bin must be a valid user.");
 
 	nobody = *(getpwnam("nobody"));
-	nobody_pw_uid = nobody.pw_uid;
+	UID16_CHECK(nobody.pw_uid, setreuid, cleanup);
 
 	daemonpw = *(getpwnam("daemon"));
-	daemon_pw_uid = daemonpw.pw_uid;
+	UID16_CHECK(daemonpw.pw_uid, setreuid, cleanup);
 
 	root = *(getpwnam("root"));
-	root_pw_uid = root.pw_uid;
+	UID16_CHECK(root.pw_uid, setreuid, cleanup);
 
 	bin = *(getpwnam("bin"));
-	bin_pw_uid = bin.pw_uid;
+	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
 }
 
-void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
+static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
 {
 	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
-		tst_resm(TINFO, "ERROR: %s real uid = %d; effective uid = %d",
+		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
 			 when, getuid(), geteuid());
 		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
 			 ru->pw_uid, eu->pw_uid);
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index f03ab86..823d10b 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -1,44 +1,25 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Ported by John George
  */
 
 /*
- * NAME
- *	setreuid06.c
- *
- * DESCRIPTION
- *	Test that EPERM is set when setreuid is given an invalid user id.
- *
- * USAGE:  <for command-line>
- *	setreuid06 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- *
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- *      Must be ran as non-root user - nobody recommended.
+ * Test that EPERM is set when setreuid is given an invalid user id.
  */
 
 #include <wait.h>
@@ -50,20 +31,20 @@
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 #define INVAL_USER		 (USHRT_MAX-2)
 
-char *TCID = "setreuid06";
+TCID_DEFINE(setreuid06);
 int TST_TOTAL = 1;
-int exp_enos[] = { EPERM, 0 };
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+static struct passwd *ltpuser;
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int argc, char **argv)
 {
@@ -75,16 +56,12 @@ int main(int argc, char **argv)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 	}
 
-	/*
-	 * perform global setup for the test
-	 */
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(setreuid(-1, INVAL_USER));
+		TEST(SETREUID(cleanup, -1, INVAL_USER));
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "%s did not fail as expected", TCID);
 		} else if (TEST_ERRNO == EPERM) {
@@ -100,49 +77,28 @@ int main(int argc, char **argv)
 	}
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
+	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
 	umask(0);
 
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Test must be run as root");
-	}
-	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
+	ltpuser = getpwnam("nobody");
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
+
+	if (setuid(ltpuser->pw_uid) == -1)
+		tst_brkm(TBROK | TERRNO, NULL, "setuid failed to "
 			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all the ONE TIME cleanup for this test at completion
- *	or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing status if that option was specified
-	 * print errno log if that option was specified
-	 */
 	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index e64700c..b2bb6fc 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -1,71 +1,55 @@
-/******************************************************************************/
-/* Copyright (c) Kerlabs 2008.                                                */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
 /*
- * NAME
- *	setreuid07.c
+ * Copyright (c) Kerlabs 2008.
+ * Copyright (c) International Business Machines  Corp., 2008
  *
- * DESCRIPTION
- *	Check if setreuid behaves correctly with file permissions.
- *      The test creates a file as ROOT with permissions 0644, does a setreuid
- *      and then tries to open the file with RDWR permissions.
- *      The same test is done in a fork to check if new UIDs are correctly
- *      passed to the son.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * USAGE:  <for command-line>
- *  setreuid07 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *             -i n : Execute test n times.
- *             -I x : Execute test for x seconds.
- *             -P x : Pause for x seconds between iterations.
- *             -t   : Turn on syscall timing.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- * HISTORY
- *	07/2001 Created by Renaud Lottiaux
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
- * RESTRICTIONS
- *	Must be run as root.
+ * Created by Renaud Lottiaux
  */
+
+/*
+ * Check if setreuid behaves correctly with file permissions.
+ * The test creates a file as ROOT with permissions 0644, does a setreuid
+ * and then tries to open the file with RDWR permissions.
+ * The same test is done in a fork to check if new UIDs are correctly
+ * passed to the son.
+ */
+
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <pwd.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <pwd.h>
+#include "compat_16.h"
 
-char *TCID = "setreuid07";
+TCID_DEFINE(setreuid07);
 int TST_TOTAL = 1;
-char nobody_uid[] = "nobody";
-char testfile[256] = "";
-struct passwd *ltpuser;
 
-int exp_enos[] = { EACCES, 0 };
+static char testfile[256] = "";
+static struct passwd *ltpuser;
 
-int fd = -1;
+static int fd = -1;
 
-void setup(void);
-void cleanup(void);
-void do_master_child();
+static void setup(void);
+static void cleanup(void);
+static void do_master_child(void);
 
 int main(int ac, char **av)
 {
@@ -74,10 +58,9 @@ int main(int ac, char **av)
 	int status;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	setup();
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 
-	TEST_EXP_ENOS(exp_enos);
+	setup();
 
 	pid = FORK_OR_VFORK();
 	if (pid < 0)
@@ -95,10 +78,7 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-/*
- * do_master_child()
- */
-void do_master_child()
+static void do_master_child(void)
 {
 	int lc;
 	int pid;
@@ -107,11 +87,10 @@ void do_master_child()
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int tst_fd;
 
-		/* Reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if (setreuid(0, ltpuser->pw_uid) == -1) {
-			perror("setfsuid failed");
+		if (SETREUID(NULL, 0, ltpuser->pw_uid) == -1) {
+			perror("setreuid failed");
 			exit(1);
 		}
 
@@ -175,8 +154,8 @@ void do_master_child()
 		 *         the file with RDWR permissions.
 		 */
 		tst_count++;
-		if (setreuid(0, 0) == -1) {
-			perror("setfsuid failed");
+		if (SETREUID(NULL, 0, 0) == -1) {
+			perror("setreuid failed");
 			exit(1);
 		}
 
@@ -193,14 +172,13 @@ void do_master_child()
 	exit(0);
 }
 
-/*
- * setup() - performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
 	tst_require_root(NULL);
 
-	ltpuser = getpwnam(nobody_uid);
+	ltpuser = getpwnam("nobody");
+	if (ltpuser == NULL)
+		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
 
 	tst_tmpdir();
 
@@ -209,27 +187,19 @@ void setup(void)
 	/* Create test file */
 	fd = open(testfile, O_CREAT | O_RDWR, 0644);
 	if (fd < 0)
-		tst_brkm(TBROK, cleanup, "cannot creat test file");
+		tst_brkm(TBROK | TERRNO,
+			cleanup, "cannot create test file");
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *	       or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
 	close(fd);
 
-	/*
-	 * print timing status if that option was specified
-	 * print errno log if that option was specified
-	 */
 	TEST_CLEANUP;
 
 	tst_rmdir();
-
 }
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index fa1217d..b1da7d7 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -116,4 +116,9 @@ int SETFSGID(void (cleanup)(void), GID_T gid)
 {
 	LTP_CREATE_SYSCALL(setfsgid, cleanup, gid);
 }
+
+int SETREUID(void (cleanup)(void), UID_T ruid, UID_T euid)
+{
+	LTP_CREATE_SYSCALL(setreuid, cleanup, ruid, euid);
+}
 #endif /* __LTP_COMPAT_16_H__ */
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
