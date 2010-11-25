Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLefh-0003Kr-AO
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 16:27:45 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3B32E945D8
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Nov 2010 17:27:36 +0100 (CET)
Date: Thu, 25 Nov 2010 17:40:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125164008.GC2853@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix lchown tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Folowing patch fixes/cleanups lchown tests.

lchown01 changes:

* make a better use of ltp test interface
* make error messages consistent
* various coding style issues

lchown02 changes:

* all test setups are now done in setup functions
* eliminated need for external script for preparing tempfile
* make a better use of ltp test interface
* make error messages consistent
* various coding style issues
* fix lchown02 invocation in runtest files

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--fdj2RfSjLxBAspz7
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_lchown_tests.patch"

diff --git a/runtest/ltplite b/runtest/ltplite
index 516ba7c..0b0368c 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -373,7 +373,7 @@ kill11 ulimit -c 1024;kill11
 kill12 kill12
 
 lchown01 lchown01
-lchown02 prep_create_link; lchown02
+lchown02 lchown02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index c2903f5..55d4fe5 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -306,7 +306,7 @@ kill11 ulimit -c 1024;kill11
 kill12 kill12
 
 lchown01 lchown01
-lchown02 prep_create_link; lchown02
+lchown02 lchown02
 
 link01 symlink01 -T link01
 link02 link02
diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..e0d1e10 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -462,8 +462,8 @@ kill12 kill12
 
 lchown01 lchown01
 lchown01_16 lchown01_16
-lchown02 prep_create_link; lchown02
-lchown02_16 prep_create_link; lchown02_16
+lchown02  lchown02
+lchown02_16 lchown02_16
 
 libevent01 export LTPROOT; $LTPROOT/testcases/bin/libevent/run_libevent.sh
 
diff --git a/testcases/kernel/syscalls/lchown/Makefile b/testcases/kernel/syscalls/lchown/Makefile
index 829746d..fba133f 100644
--- a/testcases/kernel/syscalls/lchown/Makefile
+++ b/testcases/kernel/syscalls/lchown/Makefile
@@ -20,12 +20,10 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+CFLAGS+=-W -Wall
+
 SRCS			:= $(wildcard $(abs_srcdir)/lchown*.c)
 
 include $(abs_srcdir)/../utils/compat_16.mk
 
-INSTALL_TARGETS		:= prep_create_link
-
-MAKE_TARGETS		+= create_link
-
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/lchown/create_link.c b/testcases/kernel/syscalls/lchown/create_link.c
deleted file mode 100644
index 0cb53ec..0000000
--- a/testcases/kernel/syscalls/lchown/create_link.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-/*
- * Description: This is a setuid to root program invoked by a non-root
- *		process to change the user id/group id bits on the test
- *		directory/file created in the setup function.
- *		It sets uid to another non-root user and creates a
- *		symlink of testfile/directory.
- *
- *		This function exit with 0 or 1 depending upon the
- *		success/failure each system call.
- */
-
-#include <libgen.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <pwd.h>
-#include <grp.h>
-#include <errno.h>
-#include <string.h>
-
-#define LTPUSER		"bin"
-#define LTPGRP		"bin"
-#define SFILE1		"sfile_1"
-
-int main(int argc, char **argv)
-{
-	int rc = 1;		/* Failed until proven passed ;). */
-	struct passwd *ltpuser;	/* password struct for nobody */
-	struct group *ltpgroup;	/* group struct for nobody */
-	uid_t user_uid;		/* user id of nobody */
-	gid_t group_gid;	/* group id of nobody */
-	char *path_name;	/* name of test directory/file */
-
-	path_name = argv[1];
-
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s filename\n", basename(*argv));
-		exit (1);
-	} else if ((ltpuser = getpwnam(LTPUSER)) == NULL)
-		/*
-		 * Get the user id and group id of "ltpuser" user from password
-		 * and group files.
-		 */
-		fprintf(stderr, "change_owner: %s not found in /etc/passwd",
-			LTPUSER);
-	else if ((ltpgroup = getgrnam(LTPGRP)) == NULL)
-		fprintf(stderr, "change_owner: %s not found in /etc/group",
-			LTPGRP);
-	else {
-
-		user_uid = ltpuser->pw_uid;
-		group_gid = ltpgroup->gr_gid;
-
-		/*
-		 * Change the ownership of test directory/file specified by
-		 * pathname to that of LTPUSER user_uid and group_gid.
-		 */
-		if (chown(path_name, user_uid, group_gid) < 0)
-			fprintf(stderr, "change_owner: chown() of %s failed, "
-				"error %d\n", path_name, errno);
-		else if (setuid(user_uid) < 0)
-			fprintf(stderr, "change_owner: setuid() to %s fails, error=%d",
-				LTPUSER, errno);
-		else if (symlink(path_name, SFILE1) < 0)
-			fprintf(stderr, "change_owner: symlink() of %s Failed, "
-				"errno=%d : %s", path_name, errno, strerror(errno));
-		else
-			rc = 0;
-
-	}
-
-	return rc;
-
-}
diff --git a/testcases/kernel/syscalls/lchown/lchown01.c b/testcases/kernel/syscalls/lchown/lchown01.c
index 8e83a8f..b4a8ec3 100644
--- a/testcases/kernel/syscalls/lchown/lchown01.c
+++ b/testcases/kernel/syscalls/lchown/lchown01.c
@@ -62,6 +62,7 @@
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
+ *	11/2010 Code cleanup by Cyril Hrubis chrubis@suse.cz
  *
  * RESTRICTIONS:
  *  This test should be run by 'super-user' (root) only.
@@ -83,65 +84,57 @@
 #define TESTFILE	"testfile"
 #define SFILE		"slink_file"
 
-char *TCID = "lchown01";	/* Test program identifier.    */
-int TST_TOTAL = 5;		/* Total number of test conditions */
-extern int Tst_count;		/* Test Case counter for tst_* routines */
+char *TCID = "lchown01";
+int TST_TOTAL = 5;
+extern int Tst_count;
 
-struct test_case_t {		/* test case struct. to test different conditions */
+struct test_case_t {
 	char *desc;
 	uid_t user_id;
 	gid_t group_id;
-} Test_cases[] = {
-	{
-	"Change Owner/Group ids", 700, 701}, {
-	"Change Owner id only", 702, -1}, {
-	"Change Owner id only", 703, 701}, {
-	"Change Group id only", -1, 704}, {
-	"Change Group id only", 703, 705}, {
-	NULL, 0, 0}
 };
 
-void setup();			/* setup function for the test */
-void cleanup();			/* cleanup function for the test */
+static struct test_case_t test_cases[] = {
+	{"Change Owner/Group ids", 700, 701},
+	{"Change Owner id only",   702,  -1},
+	{"Change Owner/Group ids", 703, 701},
+	{"Change Group id only",    -1, 704},
+	{"Change Group/Group ids", 703, 705},
+	{NULL,                       0,   0}
+};
+
+void setup(void);
+void cleanup(void);
 
-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
-	struct stat stat_buf;	/* stat(2) struct contents */
-	int lc;			/* loop counter */
-	char *msg;		/* message returned from parse_opts */
-	int ind;		/* counter variable for chmod(2) tests */
-	uid_t User_id;		/* user id of the user set for testfile */
-	gid_t Group_id;		/* group id of the user set for testfile */
-	char *test_desc;	/* test specific message */
+	struct stat stat_buf;
+	int lc, i;
+	char *msg;
 
-	/* Parse standard options given to run the test. */
-	msg = parse_opts(ac, av, (option_t *) NULL, NULL);
-	if (msg != (char *)NULL) {
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
+	msg = parse_opts(argc, argv, NULL, NULL);
+	
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 
-	/* Perform global setup for test */
 	setup();
 
-	/* Check looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		/* Reset Tst_count in case we are looping. */
 		Tst_count = 0;
 
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			test_desc = Test_cases[ind].desc;
-			User_id = Test_cases[ind].user_id;
-			Group_id = Test_cases[ind].group_id;
+		for (i = 0; test_cases[i].desc != NULL; i++) {
+			uid_t user_id = test_cases[i].user_id;
+			gid_t group_id = test_cases[i].group_id;
+			char *test_desc = test_cases[i].desc;
 
 			/*
 			 * Call lchwon(2) with different user id and
 			 * group id (numeric values) to set it on
 			 * symlink of testfile.
 			 */
-			TEST(lchown(SFILE, User_id, Group_id));
+			TEST(lchown(SFILE, user_id, group_id));
 
-			/* check return code of lchown(2) */
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL,
 					 "lchown() Fails to %s, errno=%d",
@@ -162,23 +155,19 @@ int main(int ac, char **av)
 						 "%s failed, errno:%d",
 						 SFILE, TEST_ERRNO);
 				}
-				if (User_id == -1) {
-					User_id = Test_cases[ind - 1].user_id;
-				}
-				if (Group_id == -1) {
-					Group_id = Test_cases[ind - 1].group_id;
-				}
 
-				/*
-				 * Check for expected Ownership ids
-				 * set on testfile.
-				 */
-				if ((stat_buf.st_uid != User_id) ||
-				    (stat_buf.st_gid != Group_id)) {
+				if (user_id == (uid_t)-1)
+					user_id = test_cases[i - 1].user_id;
+
+				if (group_id == (gid_t)-1)
+					group_id = test_cases[i - 1].group_id;
+
+				if ((stat_buf.st_uid != user_id) ||
+				    (stat_buf.st_gid != group_id)) {
 					tst_resm(TFAIL,
 						 "%s: Incorrect ownership set, "
 						 "Expected %d %d", SFILE,
-						 User_id, Group_id);
+						 user_id, group_id);
 				} else {
 					tst_resm(TPASS, "lchown() succeeds to "
 						 "%s of %s", test_desc, SFILE);
@@ -187,13 +176,12 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "call succeeded");
 			}
 		}
-	}			/* End for TEST_LOOPING */
+	}
 
-	/* Call cleanup() to undo setup done for the test. */
 	cleanup();
 
-	 /*NOTREACHED*/ return 0;
-}				/* End main */
+	return 0;
+}
 
 /*
  * setup() - performs all ONE TIME setup for this test.
@@ -201,41 +189,29 @@ int main(int ac, char **av)
  *	     Create a test file under temporary directory and close it
  *	     Create a symlink of testfile under temporary directory.
  */
-void setup()
+void setup(void)
 {
 	int fd;
 
 	/* capture signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Check that the test process id is super/root  */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, NULL, "Must be super/root for this test!");
-		tst_exit();
-	}
-
-	/* Pause if that option was specified */
+	
+	tst_require_root(tst_exit);
+	
 	TEST_PAUSE;
-
-	/* make a temp directory and cd to it */
 	tst_tmpdir();
 
 	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) Failed, errno=%d : %s",
-			 TESTFILE, FILE_MODE, errno, strerror(errno));
-	}
-	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup, "open(2) %s mode %o failed",
+		         TESTFILE, FILE_MODE);
 	}
+	
+	if (close(fd) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "close(2) %s", TESTFILE);
 
-	/* Create a symlink for testfile created */
 	if (symlink(TESTFILE, SFILE) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "symlink() of %s Failed, errno=%d : %s",
-			 TESTFILE, errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup, "symlink(2) %s to %s failed",
+		         TESTFILE, SFILE);
 	}
 }
 
@@ -244,16 +220,10 @@ void setup()
  *	       completion or premature exit.
  *	       Remove the test directory and testfile created in the setup.
  */
-void cleanup()
+void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-	/* Remove tmp dir and all files in it */
 	tst_rmdir();
-
-	/* exit with return code appropriate for results */
 	tst_exit();
 }
diff --git a/testcases/kernel/syscalls/lchown/lchown02.c b/testcases/kernel/syscalls/lchown/lchown02.c
index 4f519ab..a858f85 100644
--- a/testcases/kernel/syscalls/lchown/lchown02.c
+++ b/testcases/kernel/syscalls/lchown/lchown02.c
@@ -72,6 +72,7 @@
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
+ *      11/2010 Rewritten by Cyril Hrubis chrubis@suse.cz
  *
  * RESTRICTIONS:
  *
@@ -93,6 +94,7 @@
 #include "test.h"
 #include "usctest.h"
 
+#define TEST_USER       "nobody"
 #define MODE_RWX	S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
 #define DIR_TEMP	"testdir_1"
@@ -100,105 +102,87 @@
 #define SFILE1		"sfile_1"
 #define TEST_FILE2	"testdir_1/tfile_2"
 #define SFILE2		"testdir_1/sfile_2"
-#define TEST_FILE3	"t_file/tfile_3"
-#define SFILE3		"t_file/sfile_3"
+#define TFILE3          "t_file"
+#define SFILE3		"t_file/sfile"
 
-int no_setup();
-int setup1();			/* setup function to test lchown for EPERM */
-int setup2();			/* setup function to test lchown for EACCES */
-int setup3();			/* setup function to test lchown for ENOTDIR */
-int longpath_setup();		/* setup function to test chown for ENAMETOOLONG */
+char *TCID = "lchown02";
+int TST_TOTAL = 7;
+extern int Tst_count;
 
-char Longpathname[PATH_MAX + 2];
-char High_address_node[64];
-char EXEC_DIR[PATH_MAX];
-char main_test_dir[PATH_MAX + 2];
+static void setup_eperm(int pos);
+static void setup_eacces(int pos);
+static void setup_enotdir(int pos);
+static void setup_longpath(int pos);
+static void setup_efault(int pos);
+static void setup_highaddress(int pos);
 
-struct test_case_t {		/* test case struct. to hold ref. test cond's */
+static char path[PATH_MAX + 2];
+
+struct test_case_t {
 	char *pathname;
 	char *desc;
 	int exp_errno;
-	int (*setupfunc) ();
-} Test_cases[] = {
-	{
-	SFILE1, "Process is not owner/root", EPERM, setup1}, {
-	SFILE2, "No Search permissions to process", EACCES, setup2}, {
-	High_address_node, "Address beyond address space", EFAULT, no_setup},
-	{
-	(char *)-1, "Negative address", EFAULT, no_setup}, {
-	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
-	"", "Pathname is empty", ENOENT, no_setup}, {
-	SFILE3, "Path contains regular file", ENOTDIR, setup3}, {
-	NULL, NULL, 0, no_setup}
+	void (*setup)(int pos);
 };
 
-char *TCID = "lchown02";	/* Test program identifier.    */
-int TST_TOTAL = 7;		/* Total number of test cases. */
-extern int Tst_count;		/* Test Case counter for tst_* routines */
-int exp_enos[] = { EPERM, EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0 };
+static struct test_case_t test_cases[] = {
+	{SFILE1, "Process is not owner/root",    EPERM,   setup_eperm},
+	{SFILE2, "Search permission denied",     EACCES,  setup_eacces},
+	{NULL,   "Address beyond address space", EFAULT,  setup_highaddress},
+	{NULL,   "Unaccessible address space",   EFAULT,  setup_efault},
+	{path,   "Pathname too long",            ENAMETOOLONG, setup_longpath},
+	{SFILE3, "Path contains regular file",   ENOTDIR, setup_enotdir},
+	{"",     "Pathname is empty",            ENOENT,  NULL},
+	{NULL,   NULL,                           0,       NULL}
+};
 
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
+static struct passwd *ltpuser;
 
-char *bad_addr = 0;
+static int exp_enos[] =
+	{EPERM, EACCES, EFAULT, ENAMETOOLONG, ENOENT, ENOTDIR, 0};
 
-void setup();			/* Main setup function for the tests */
-void cleanup();			/* cleanup function for the test */
+void setup(void);
+void cleanup(void);
 
-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
-	int lc;			/* loop counter */
-	char *msg;		/* message returned from parse_opts */
-	char *file_name;	/* ptr. for file name whose mode is modified */
-	char *test_desc;	/* test specific error message */
-	int ind;		/* counter to test different test conditions */
-	uid_t User_id;		/* Effective user id of a test process */
-	gid_t Group_id;		/* Effective group id of a test process */
+	int lc;
+	char *msg;
+	uid_t user_id;
+	gid_t group_id;
+	int i;
 
 	/* Parse standard options given to run the test. */
-	msg = parse_opts(ac, av, (option_t *) NULL, NULL);
-	if (msg != (char *)NULL) {
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-		tst_exit();
-	}
+	msg = parse_opts(argc, argv, NULL, NULL);
+	
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 
-	/*
-	 * Invoke setup function to call individual test setup functions
-	 * to simulate test conditions.
-	 */
 	setup();
-
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-	/* Set uid/gid values to that of test process */
-	User_id = geteuid();
-	Group_id = getegid();
+	user_id = geteuid();
+	group_id = getegid();
 
-	/* Check looping state if -i option given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* Reset Tst_count in case we are looping. */
 		Tst_count = 0;
 
-		for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-			file_name = Test_cases[ind].pathname;
-			test_desc = Test_cases[ind].desc;
-
-			if (file_name == High_address_node) {
-				file_name = get_high_address();
-			}
+		for (i = 0; test_cases[i].desc != NULL; i++) {
+			char *file_name = test_cases[i].pathname;
+			char *test_desc = test_cases[i].desc;
 
 			/*
 			 * Call lchown(2) to test different test conditions.
 			 * verify that it fails with -1 return value and
 			 * sets appropriate errno.
 			 */
-			TEST(lchown(file_name, User_id, Group_id));
+			TEST(lchown(file_name, user_id, group_id));
 
 			/* Check return code from lchown(2) */
 			if (TEST_RETURN == -1) {
 				TEST_ERROR_LOG(TEST_ERRNO);
-				if (TEST_ERRNO == Test_cases[ind].exp_errno) {
+				if (TEST_ERRNO == test_cases[i].exp_errno) {
 					tst_resm(TPASS,
 						 "lchown() fails, %s, errno:%d",
 						 test_desc, TEST_ERRNO);
@@ -206,267 +190,233 @@ int main(int ac, char **av)
 					tst_resm(TFAIL, "lchown() fails, %s, "
 						 "errno:%d, expected errno:%d",
 						 test_desc, TEST_ERRNO,
-						 Test_cases[ind].exp_errno);
+						 test_cases[i].exp_errno);
 				}
 			} else {
 				tst_resm(TFAIL, "lchown() returned %ld, "
 					 "expected -1, errno:%d", TEST_RETURN,
-					 Test_cases[ind].exp_errno);
+					 test_cases[i].exp_errno);
 			}
-		}		/* End of TEST CASE LOOPING. */
-	}			/* End for TEST_LOOPING */
+		}
+	}
 
-	/*
-	 * Invoke cleanup() to delete the test directory/file(s) created
-	 * in the setup().
-	 */
 	cleanup();
 
-	 /*NOTREACHED*/ return 0;
-}				/* End main */
+	return 0;
+}
 
 /*
- * setup(void) - performs all ONE TIME setup for this test.
+ * setup() - performs all ONE TIME setup for this test.
+ *	
  *	Exit the test program on receipt of unexpected signals.
  *	Create a temporary directory and change directory to it.
- *	Invoke individual test setup functions according to the order
- *	set in struct. definition.
+ *	Invoke individual test setup functions.
  */
-void setup()
+void setup(void)
 {
-	int ind;		/* counter for setup functions */
+	int i;
 
 	/* Capture unexpected signals */
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	/* Get the current directory of the test executable */
-	if (getcwd(EXEC_DIR, sizeof(EXEC_DIR)) == NULL) {
-		tst_brkm(TBROK, cleanup,
-			 "getcwd(3) fails to get working directory of process");
-	}
-
-	/* Switch to nobody user for correct error code collection */
-	if (geteuid() != 0) {
-		tst_brkm(TBROK, tst_exit, "Test must be run as root");
-	}
-	ltpuser = getpwnam(nobody_uid);
-	if (setgid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setgid failed to "
-			 "to set the effective gid to %d", ltpuser->pw_uid);
-		perror("setgid");
-	}
-
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_resm(TINFO, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-		perror("setuid");
-	}
+	tst_require_root(tst_exit);
 
-	/* Pause if that option was specified */
 	TEST_PAUSE;
+	
+	/* change uid and gid to nobody */
+	ltpuser = getpwnam(TEST_USER);
 
-	/* remember current dir, because create_link has been copied here */
-	if (getcwd(main_test_dir, sizeof(main_test_dir)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to get the current working directory.");
+	if (ltpuser == NULL) {
+		tst_brkm(TBROK, cleanup, "test need user %s to run",
+		         TEST_USER);
 	}
 
-	/* Make a temp dir and cd to it */
-	tst_tmpdir();
-
-	/* fix permissions on the tmpdir */
-	if (chmod(".", 0711) != 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod() failed");
+	if (setgid(ltpuser->pw_uid) == -1) {
+		tst_resm(TBROK | TERRNO,
+		         "setgid(2) failed set the effective gid to %d",
+			 ltpuser->pw_uid);
 	}
 
-	bad_addr = mmap(0, 1, PROT_NONE,
-			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, 0, 0);
-	if (bad_addr == MAP_FAILED) {
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
+	if (seteuid(ltpuser->pw_uid) == -1) {
+		tst_resm(TBROK | TERRNO,
+		         "seteuid(2) failed to set the effective uid to %d",
+			 ltpuser->pw_uid);
 	}
-	Test_cases[3].pathname = bad_addr;
+	
+	tst_tmpdir();
 
 	/* call individual setup functions */
-	for (ind = 0; Test_cases[ind].desc != NULL; ind++) {
-		Test_cases[ind].setupfunc();
+	for (i = 0; test_cases[i].desc != NULL; i++) {
+		if (test_cases[i].setup != NULL)
+			test_cases[i].setup(i);
 	}
 }
 
 /*
- * no_setup() - Some test conditions for mknod(2) do not any setup.
- *              Hence, this function just returns 0.
- *  This function simply returns 0.
- */
-int no_setup()
-{
-	return 0;
-}
-
-/*
- * setup1() - setup function for a test condition for which chown(2)
- *	      returns -1 and sets errno to EPERM.
+ * setup_eperm() - setup function for a test condition for which lchown(2)
+ *	           returns -1 and sets errno to EPERM.
  *
- *  Create a testfile under temporary directory and invoke setuid to root
- *  program to change the ownership of testfile to that of "ltpuser2" user,
- *  create a symlink file of it with ownership as ltpuser2.
+ * Create test file and symlink with uid 0.
  */
-int setup1()
+void setup_eperm(int pos LTP_ATTRIBUTE_UNUSED)
 {
-	int fd;			/* file handler for testfile */
-	char Path_name[PATH_MAX];	/* Buffer to hold command string */
-	char Path2_name[PATH_MAX];	/* Buffer for just the path name */
-	char Cmd_buffer[BUFSIZ];	/* Buffer to hold command string */
+	int fd;
 
-	/* Creat a testfile and close it */
+	/* create a testfile */
 	if ((fd = open(TEST_FILE1, O_RDWR | O_CREAT, 0666)) == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed", TEST_FILE1);
+			 "open(2) %s failed", TEST_FILE1);
 	}
+
 	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup, "close(%s) Failed", TEST_FILE1);
+		tst_brkm(TBROK | TERRNO, cleanup, "close(2) %s failed",
+		         TEST_FILE1);
 	}
-
-	/* Get the current working directory of the process */
-	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "failed to get the current working directory.");
+	
+	/* become root once more */
+	if (seteuid(0) == -1) {
+		tst_resm(TBROK | TERRNO,
+		         "seteuid(2) failed to set the effective uid to 0");
 	}
 
-	/* Provide permissions for temporary directory */
-	if (chmod(Path_name, 0777) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, 0777) failed", Path_name);
+	/* create symling to testfile */
+	if (symlink(TEST_FILE1, SFILE1) < 0) {
+		tst_brkm(TBROK, cleanup, "symlink(2) %s to %s failed",
+			 TEST_FILE1, SFILE1);
 	}
 
-	strcpy(Path2_name, Path_name);
-
-	/* Get the path of test file created under temporary directory */
-	strcat(Path_name, "/" TEST_FILE1);
-
-	/* Get the command name to be executed as setuid to root */
-	strcat((char *)Cmd_buffer, main_test_dir);
-	strcat((char *)Cmd_buffer, (const char *)"/create_link ");
-	strcat((char *)Cmd_buffer, Path_name);
-
-	if (system((const char *)Cmd_buffer) != 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Fail to modify %s ownership(s)!", TEST_FILE1);
+	/* back to the user nobody */
+	if (seteuid(ltpuser->pw_uid) == -1) {
+		tst_resm(TBROK | TERRNO,
+		         "seteuid(2) failed to set the effective uid to %d",
+			 ltpuser->pw_uid);
 	}
-	return 0;
 }
 
 /*
- * setup2() - setup function for a test condition for which chown(2)
- *	      returns -1 and sets errno to EACCES.
+ * setup_eaccess() - setup function for a test condition for which lchown(2)
+ *	             returns -1 and sets errno to EACCES.
+ *
  *  Create a test directory under temporary directory and create a test file
  *  under this directory with mode "0666" permissions.
  *  Modify the mode permissions on test directory such that process will not
  *  have search permissions on test directory.
- *
- *  The function returns 0.
  */
-int setup2()
+void setup_eacces(int pos LTP_ATTRIBUTE_UNUSED)
 {
-	int fd;			/* file handle for testfile */
+	int fd;
 
-	/* Creat a test directory */
+	/* create a test directory */
 	if (mkdir(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", DIR_TEMP);
+		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(2) %s failed",
+		         DIR_TEMP);
 	}
 
-	/* Creat a file under above test directory */
+	/* create a file under test directory */
 	if ((fd = open(TEST_FILE2, O_RDWR | O_CREAT, 0666)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup,
+		         "open(2) %s failed", TEST_FILE2);
 	}
-	/* Close the test file created above */
+	
 	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(%s) Failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "close(2) %s failed", TEST_FILE2);
 	}
 
-	/* Creat a symlink of testfile */
+	/* create a symlink of testfile */
 	if (symlink(TEST_FILE2, SFILE2) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "symlink() of %s Failed, errno=%d : %s",
-			 TEST_FILE2, errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup, "symlink(2) %s to %s failed",
+			 TEST_FILE2, SFILE2);
 	}
 
-	/* Modify mode permissions on test directory */
+	/* modify mode permissions on test directory */
 	if (chmod(DIR_TEMP, FILE_MODE) < 0) {
-		tst_brkm(TBROK, cleanup, "chmod(2) of %s failed", DIR_TEMP);
+		tst_brkm(TBROK | TERRNO, cleanup, "chmod(2) %s failed",
+		         DIR_TEMP);
 	}
-	return 0;
 }
 
 /*
- * setup3() - setup function for a test condition for which chown(2)
- *	     returns -1 and sets errno to ENOTDIR.
+ * setup_efault() -- setup for a test condition where lchown(2) returns -1 and
+ *                   sets errno to EFAULT.
+ *
+ * Create "bad address" by explicitly mmaping anonymous page that may not be
+ * accesed (see PROT_NONE).
+ */
+static void setup_efault(int pos)
+{
+	char *bad_addr = 0;
+	
+	bad_addr = mmap(NULL, 1, PROT_NONE,
+			MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, -1, 0);
+
+	if (bad_addr == MAP_FAILED)
+		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
+
+	test_cases[pos].pathname = bad_addr;
+}
+
+/*
+ * setup_efault() -- setup for a test condition where lchown(2) returns -1 and
+ *                   sets errno to EFAULT.
+ *
+ * Use ltp function get_high_address() to compute high address.
+ */
+static void setup_highaddress(int pos)
+{
+	test_cases[pos].pathname = get_high_address();
+}
+
+/*
+ * setup_enotdir() - setup function for a test condition for which chown(2)
+ *	             returns -1 and sets errno to ENOTDIR.
  *
- *  Create a test file under temporary directory so that test tries to
- *  change mode of a testfile "tfile_3" under "t_file" which happens to be
- *  another regular file.
+ * Create a regular file "t_file" to call lchown(2) on "t_file/sfile" later.
  */
-int setup3()
+void setup_enotdir(int pos LTP_ATTRIBUTE_UNUSED)
 {
 	int fd;
 
-	/* Creat a testfile under temporary directory */
-	if ((fd = open("t_file", O_RDWR | O_CREAT, MODE_RWX)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(2) on t_file failed, errno=%d : %s",
-			 errno, strerror(errno));
+	/* create a testfile under temporary directory */
+	if ((fd = open(TFILE3, O_RDWR | O_CREAT, MODE_RWX)) == -1) {
+		tst_brkm(TBROK | TERRNO, cleanup, "open(2) %s failed",
+		         TFILE3);
 	}
-	/* close the test file */
+
 	if (close(fd) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "close(t_file) Failed, errno=%d : %s",
-			 errno, strerror(errno));
+		tst_brkm(TBROK | TERRNO, cleanup, "close(2) %s failed",
+		         TFILE3);
 	}
-	return 0;
 }
 
 /*
  * longpath_setup() - setup to create a node with a name length exceeding
- *                    the MAX. length of PATH_MAX.
- *   This function retruns 0.
+ *                    the length of PATH_MAX.
  */
-int longpath_setup()
+void setup_longpath(int pos)
 {
-	int ind;		/* counter variable */
-
-	for (ind = 0; ind <= (PATH_MAX + 1); ind++) {
-		Longpathname[ind] = 'a';
-	}
-	return 0;
+	memset(test_cases[pos].pathname, 'a', PATH_MAX + 1);
+	test_cases[pos].pathname[PATH_MAX + 1] = '\0';
 }
 
 /*
  * cleanup() - Performs all ONE TIME cleanup for this test at
  *             completion or premature exit.
- *	Print test timing stats and errno log if test executed with options.
- *      Restore the mode permissions on test directory.
+ *
  *	Remove temporary directory and sub-directories/files under it
  *	created during setup().
  *	Exit the test program with normal exit code.
  */
-void cleanup()
+void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
-
-	/* Restore mode permissions on test directory created in setup2() */
-	if (chmod(DIR_TEMP, MODE_RWX) < 0) {
-		tst_brkm(TBROK, NULL, "chmod(2) of %s failed", DIR_TEMP);
+	
+	/* become root again */
+	if (seteuid(0) == -1) {
+		tst_resm(TINFO | TERRNO,
+		         "seteuid(0) failed to set the effective uid to 0");
 	}
 
-	/* Remove files and temporary directory created */
 	tst_rmdir();
-
-	/* exit with return code appropriate for results */
 	tst_exit();
 }
diff --git a/testcases/kernel/syscalls/lchown/prep_create_link b/testcases/kernel/syscalls/lchown/prep_create_link
deleted file mode 100755
index ef3f767..0000000
--- a/testcases/kernel/syscalls/lchown/prep_create_link
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/bin/sh
-
-set -e
-
-TMP=${TMP:-/tmp}
-
-if ! PROGDIR=$(dirname "$0") ; then
-
-    if [ -x "$LTPROOT/testcases/bin/create_link" ] ; then
-        PROGDIR=$LTPROOT/testcases/bin
-    else
-        echo "${0%##*/} : ERROR : Couldn't determine directory for \`$0'"
-        exit 1
-    fi
-
-fi
-
-cp "$PROGDIR/create_link" "$TMP"
-chown root:root "$TMP/create_link"
-chmod 04755 "$TMP/create_link"

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--fdj2RfSjLxBAspz7--

