Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VY9s7-0004ZE-4s
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VY9s4-0000ax-Te
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:51 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9L7PfO6030238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:42 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7Pfo2000949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:41 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7PeqN000851
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:40 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Oct 2013 11:25:16 +0400
Message-Id: <1382340317-8510-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/3] syscalls/setregid{01, 03,
	04}: 16-bit fixes and minor cleanup
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
 testcases/kernel/syscalls/setregid/setregid01.c |  146 +++---------------
 testcases/kernel/syscalls/setregid/setregid03.c |  184 ++++++++---------------
 testcases/kernel/syscalls/setregid/setregid04.c |  142 +++++-------------
 testcases/kernel/syscalls/utils/compat_16.h     |    4 +
 4 files changed, 124 insertions(+), 352 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index a24177d..dae17bf 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -29,104 +29,30 @@
  *
  * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
  *
+ * Author: William Roske
+ * Co-pilot: Dave Fenner
+ */
+
+/*
+ * Testcase to test the basic functionality of setregid(2) systemm call.
  */
-/* $Id: setregid01.c,v 1.6 2009/11/02 13:57:18 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: setregid01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for setregid(2)
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
- *    DATE STARTED	: 05/13/92
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) setregid(2) returns...(See Description)
- *
- *    INPUT SPECIFICATIONS
- * 	The standard options for system call tests are accepted.
- *	(See the parse_opts(3) man page).
- *
- *    OUTPUT SPECIFICATIONS
- *
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
- *	This is a Phase I test for the setregid(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	setregid(2).
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
+static void setup(void);
+static void cleanup(void);
 
-char *TCID = "setregid01";
+TCID_DEFINE(setregid01);
 int TST_TOTAL = 5;
 
-int exp_enos[] = { 0, 0 };
-
-int gid, egid;			/* current real and effective group id */
+static gid_t gid, egid;	/* current real and effective group id */
 
 int main(int ac, char **av)
 {
@@ -138,9 +64,6 @@ int main(int ac, char **av)
 
 	setup();
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
@@ -150,12 +73,13 @@ int main(int ac, char **av)
 		 *  Dont change either real or effective gid
 		 */
 		gid = getgid();
+		GID16_CHECK(gid, setregid, cleanup);
+
 		egid = getegid();
+		GID16_CHECK(egid, setregid, cleanup);
 
-		/* Call setregid(2) */
-		TEST(setregid(-1, -1));
+		TEST(SETREGID(cleanup, -1, -1));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
@@ -163,7 +87,6 @@ int main(int ac, char **av)
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setregid -  Dont change either real or effective gid returned %ld",
 					 TEST_RETURN);
@@ -175,10 +98,8 @@ int main(int ac, char **av)
 		 *  change effective to effective gid
 		 */
 
-		/* Call setregid(2) */
-		TEST(setregid(-1, egid));
+		TEST(SETREGID(cleanup, -1, egid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
@@ -186,7 +107,6 @@ int main(int ac, char **av)
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setregid -  change effective to effective gid returned %ld",
 					 TEST_RETURN);
@@ -198,10 +118,8 @@ int main(int ac, char **av)
 		 *  change real to real gid
 		 */
 
-		/* Call setregid(2) */
-		TEST(setregid(gid, -1));
+		TEST(SETREGID(cleanup, gid, -1));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
@@ -209,7 +127,6 @@ int main(int ac, char **av)
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setregid -  change real to real gid returned %ld",
 					 TEST_RETURN);
@@ -221,10 +138,8 @@ int main(int ac, char **av)
 		 *  change effective to real gid
 		 */
 
-		/* Call setregid(2) */
-		TEST(setregid(-1, gid));
+		TEST(SETREGID(cleanup, -1, gid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL,
@@ -232,7 +147,6 @@ int main(int ac, char **av)
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS,
 					 "setregid -  change effective to real gid returned %ld",
 					 TEST_RETURN);
@@ -244,16 +158,13 @@ int main(int ac, char **av)
 		 *  try to change real to current real
 		 */
 
-		/* Call setregid(2) */
-		TEST(setregid(gid, gid));
+		TEST(SETREGID(cleanup, gid, gid));
 
-		/* check return code */
 		if (TEST_RETURN == -1) {
 			TEST_ERROR_LOG(TEST_ERRNO);
 			tst_resm(TFAIL | TTERRNO, "setregid failed");
 		} else {
 			if (STD_FUNCTIONAL_TEST) {
-				/* No Verification test, yet... */
 				tst_resm(TPASS, "setregid return %ld",
 					 TEST_RETURN);
 			}
@@ -263,34 +174,19 @@ int main(int ac, char **av)
 
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
-
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
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index b9a5311..932371b 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -1,65 +1,25 @@
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
- * 	setregid03.c
- *
- * DESCRIPTION
- * 	Test setregid() when executed by a non-root user.
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
- *	setregid03 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
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
- * 	This test must be ran as root.
- *	users, sys and bin must be valid groups.
+ * Test setregid() when executed by a non-root user.
  */
 
 #include <errno.h>
@@ -67,21 +27,19 @@
 #include <stdlib.h>
 #include <pwd.h>
 #include <string.h>
-#include "test.h"
-#include "usctest.h"
 #include <sys/wait.h>
 
-char *TCID = "setregid03";
-int fail = -1;
-int pass = 0;
-gid_t neg_one = -1;
-int exp_enos[] = { 0 };
+#include "test.h"
+#include "usctest.h"
+#include "compat_16.h"
 
-gid_t users_gr_gid, root_gr_gid, sys_gr_gid, bin_gr_gid;
-uid_t nobody_pw_uid;
+TCID_DEFINE(setregid03);
+static int fail = -1;
+static int pass;
+static gid_t neg_one = -1;
 
 /* flag to tell parent if child passed or failed. */
-int flag = 0;
+static int flag;
 
 struct group users, sys, root, bin;
 struct passwd nobody;
@@ -99,33 +57,33 @@ struct test_data_t {
 	char *test_msg;
 } test_data[] = {
 	{
-	&sys_gr_gid, &bin_gr_gid, &pass, &sys, &bin,
+	&sys.gr_gid, &bin.gr_gid, &pass, &sys, &bin,
 		    "After setregid(sys, bin),"}, {
-	&neg_one, &sys_gr_gid, &pass, &sys, &sys, "After setregid(-1, sys)"},
+	&neg_one, &sys.gr_gid, &pass, &sys, &sys, "After setregid(-1, sys)"},
 	{
-	&neg_one, &bin_gr_gid, &pass, &sys, &bin, "After setregid(-1, bin),"},
+	&neg_one, &bin.gr_gid, &pass, &sys, &bin, "After setregid(-1, bin),"},
 	{
-	&bin_gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
+	&bin.gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
 	{
 	&neg_one, &neg_one, &pass, &bin, &bin, "After setregid(-1, -1),"}, {
-	&neg_one, &bin_gr_gid, &pass, &bin, &bin, "After setregid(-1, bin),"},
+	&neg_one, &bin.gr_gid, &pass, &bin, &bin, "After setregid(-1, bin),"},
 	{
-	&bin_gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
+	&bin.gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
 	{
-	&bin_gr_gid, &bin_gr_gid, &pass, &bin, &bin,
+	&bin.gr_gid, &bin.gr_gid, &pass, &bin, &bin,
 		    "After setregid(bin, bin),"}, {
-	&sys_gr_gid, &neg_one, &fail, &bin, &bin, "After setregid(sys, -1)"},
+	&sys.gr_gid, &neg_one, &fail, &bin, &bin, "After setregid(sys, -1)"},
 	{
-	&neg_one, &sys_gr_gid, &fail, &bin, &bin, "After setregid(-1, sys)"},
+	&neg_one, &sys.gr_gid, &fail, &bin, &bin, "After setregid(-1, sys)"},
 	{
-&sys_gr_gid, &sys_gr_gid, &fail, &bin, &bin,
+	&sys.gr_gid, &sys.gr_gid, &fail, &bin, &bin,
 		    "After setregid(sys, sys)"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void gid_verify(struct group *ru, struct group *eu, char *when);
+static void setup(void);
+static void cleanup(void);
+static void gid_verify(struct group *ru, struct group *eu, char *when);
 
 int main(int ac, char **av)
 {
@@ -141,15 +99,16 @@ int main(int ac, char **av)
 		pid_t pid;
 		int status, i;
 
-		/* reset tst_count in case we are looping */
+		pass = 0;
+		flag = 0;
+
 		tst_count = 0;
 
 		/* set the appropriate ownership values */
-		if (setregid(sys_gr_gid, bin_gr_gid) == -1) {
+		if (SETREGID(cleanup, sys.gr_gid, bin.gr_gid) == -1)
 			tst_brkm(TBROK, NULL, "Initial setregid failed");
-		}
 
-		if (seteuid(nobody_pw_uid) == -1) {
+		if (seteuid(nobody.pw_uid) == -1) {
 			tst_brkm(TBROK, NULL, "Initial seteuid failed");
 		}
 		if ((pid = FORK_OR_VFORK()) == -1) {
@@ -158,7 +117,7 @@ int main(int ac, char **av)
 			for (i = 0; i < TST_TOTAL; i++) {
 				gid_t test_ret;
 				/* Set the real or effective group id */
-				TEST(setregid(*test_data[i].real_gid,
+				TEST(SETREGID(NULL, *test_data[i].real_gid,
 					      *test_data[i].eff_gid));
 				test_ret = TEST_RETURN;
 
@@ -202,10 +161,6 @@ int main(int ac, char **av)
 					TEST_ERROR_LOG(TEST_ERRNO);
 				}
 
-				/*
-				 * Perform functional verification if test
-				 * executed without (-f) option.
-				 */
 				if (STD_FUNCTIONAL_TEST) {
 					gid_verify(test_data[i].exp_real_usr,
 						   test_data[i].exp_eff_usr,
@@ -225,65 +180,50 @@ int main(int ac, char **av)
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
+	struct group *junk;
+
 	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
+	if (getpwnam("nobody") == NULL)
+		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
 	nobody = *(getpwnam("nobody"));
-	nobody_pw_uid = nobody.pw_uid;
-
-	root = *(getgrnam("root"));
-	root_gr_gid = root.gr_gid;
-
-	users = *(getgrnam("users"));
-	users_gr_gid = users.gr_gid;
 
-	sys = *(getgrnam("sys"));
-	sys_gr_gid = sys.gr_gid;
+#define GET_GID(group) do { \
+	junk = getgrnam(#group); \
+	if (junk == NULL) { \
+		tst_brkm(TBROK, NULL, "%s must be a valid group", #group); \
+	} \
+	GID16_CHECK(junk->gr_gid, setregid, NULL); \
+	group = *(junk); \
+} while (0)
 
-	bin = *(getgrnam("bin"));
-	bin_gr_gid = bin.gr_gid;
+	GET_GID(users);
+	GET_GID(sys);
+	GET_GID(bin);
 
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
 
-void gid_verify(struct group *rg, struct group *eg, char *when)
+static void gid_verify(struct group *rg, struct group *eg, char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
-		tst_resm(TINFO, "ERROR: %s real gid = %d; effective gid = %d",
+		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
 		tst_resm(TINFO, "Expected: real gid = %d; effective gid = %d",
 			 rg->gr_gid, eg->gr_gid);
 		flag = -1;
+	} else {
+		tst_resm(TPASS, "real or effective gid was modified as expected");
 	}
 }
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index ee1348c..7b343e2 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -1,81 +1,42 @@
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
- * 	setregid04.c
- *
- * DESCRIPTION
- * 	Test setregid() when executed by root.
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
- *	setregid04 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
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
- * 	This test must be ran as root.
+ * Test setregid() when executed by root.
  */
 
+#include <errno.h>
 #include <pwd.h>
 #include <grp.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <errno.h>
+#include "compat_16.h"
+
+TCID_DEFINE(setregid04);
 
-char *TCID = "setregid04";
-gid_t users_gr_gid, root_gr_gid, daemon_gr_gid, bin_gr_gid;
-gid_t neg_one = -1;
-int exp_enos[] = { 0 };
+static gid_t neg_one = -1;
 
-/* Avoid clashing with daemon in unistd.h. */
-struct group users_gr, daemon_gr, root_gr, bin_gr;
+static struct group users_gr, daemon_gr, root_gr, bin_gr;
 
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -90,31 +51,31 @@ struct test_data_t {
 	const char *test_msg;
 } test_data[] = {
 	{
-	&root_gr_gid, &root_gr_gid, &root_gr, &root_gr,
+	&root_gr.gr_gid, &root_gr.gr_gid, &root_gr, &root_gr,
 		    "After setregid(root, root),"}, {
-	&users_gr_gid, &neg_one, &users_gr, &root_gr,
+	&users_gr.gr_gid, &neg_one, &users_gr, &root_gr,
 		    "After setregid(users, -1)"}, {
-	&root_gr_gid, &neg_one, &root_gr, &root_gr,
+	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
 		    "After setregid(root,-1),"}, {
 	&neg_one, &neg_one, &root_gr, &root_gr,
 		    "After setregid(-1, -1),"}, {
-	&neg_one, &root_gr_gid, &root_gr, &root_gr,
+	&neg_one, &root_gr.gr_gid, &root_gr, &root_gr,
 		    "After setregid(-1, root)"}, {
-	&root_gr_gid, &neg_one, &root_gr, &root_gr,
+	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
 		    "After setregid(root, -1),"}, {
-	&daemon_gr_gid, &users_gr_gid, &daemon_gr, &users_gr,
+	&daemon_gr.gr_gid, &users_gr.gr_gid, &daemon_gr, &users_gr,
 		    "After setregid(daemon, users)"}, {
 	&neg_one, &neg_one, &daemon_gr, &users_gr,
 		    "After setregid(-1, -1)"}, {
-	&neg_one, &users_gr_gid, &daemon_gr, &users_gr,
+	&neg_one, &users_gr.gr_gid, &daemon_gr, &users_gr,
 		    "After setregid(-1, users)"}
 };
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void gid_verify(struct group *ru, struct group *eu, const char *when);
+static void setup(void);
+static void cleanup(void);
+static void gid_verify(struct group *ru, struct group *eu, const char *when);
 
 int main(int ac, char **av)
 {
@@ -129,12 +90,11 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective group id */
-			TEST(setregid(*test_data[i].real_gid,
+			TEST(SETREGID(cleanup, *test_data[i].real_gid,
 				      *test_data[i].eff_gid));
 
 			if (TEST_RETURN == -1) {
@@ -143,10 +103,6 @@ int main(int ac, char **av)
 					 *test_data[i].real_gid,
 					 *test_data[i].eff_gid);
 			} else {
-				/*
-				 * Perform functional verification if test
-				 * executed without (-f) option.
-				 */
 				if (STD_FUNCTIONAL_TEST) {
 					gid_verify(test_data[i].exp_real_usr,
 						   test_data[i].exp_eff_usr,
@@ -160,58 +116,34 @@ int main(int ac, char **av)
 
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
 #define SAFE_GETGROUP(GROUPNAME)	\
-	if ((junk = getgrnam(#GROUPNAME)) == NULL) { \
+	if (getgrnam(#GROUPNAME) == NULL) { \
 		tst_brkm(TBROK, NULL, "Couldn't find the `" #GROUPNAME "' group"); \
 	} \
-	memcpy((void*) &GROUPNAME ## _gr, (const void*) junk, sizeof(struct group)); \
-	GROUPNAME ## _gr_gid = GROUPNAME ## _gr.gr_gid
+	GROUPNAME ## _gr = *(getgrnam(#GROUPNAME));
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
-	struct group *junk;
-
 	tst_require_root(NULL);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
 	SAFE_GETGROUP(root);
 	SAFE_GETGROUP(users);
 	SAFE_GETGROUP(daemon);
 	SAFE_GETGROUP(bin);
 
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
 
-void gid_verify(struct group *rg, struct group *eg, const char *when)
+static void gid_verify(struct group *rg, struct group *eg, const char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
 		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index b1da7d7..47f9912 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -121,4 +121,8 @@ int SETREUID(void (cleanup)(void), UID_T ruid, UID_T euid)
 {
 	LTP_CREATE_SYSCALL(setreuid, cleanup, ruid, euid);
 }
+int SETREGID(void (cleanup)(void), GID_T rgid, GID_T egid)
+{
+	LTP_CREATE_SYSCALL(setregid, cleanup, rgid, egid);
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
