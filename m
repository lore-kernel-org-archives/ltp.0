Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Wwno0-0005VH-Az
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 07:27:44 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wwnnx-0007mu-Eb
	for ltp-list@lists.sourceforge.net; Tue, 17 Jun 2014 07:27:44 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5H7RXZn027532
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Jun 2014 15:27:33 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 17 Jun 2014 15:26:30 +0800
Message-ID: <1402989991-19613-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1398079016-9193-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/2] renameat/renameat01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Add renameat.h to encapsulate renameat syscall.
Delete some useless comments.
Use some SAFE_* macros.
Move the test body from main() to renameat_verify().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 configure.ac                                    |   2 +
 include/lapi/fcntl.h                            |   4 +
 include/lapi/renameat.h                         |  36 +++
 m4/ltp-renameat.m4                              |  25 ++
 testcases/kernel/syscalls/renameat/renameat01.c | 312 ++++++++++--------------
 5 files changed, 195 insertions(+), 184 deletions(-)
 create mode 100644 include/lapi/renameat.h
 create mode 100644 m4/ltp-renameat.m4

diff --git a/configure.ac b/configure.ac
index 804a924..70bd1be 100644
--- a/configure.ac
+++ b/configure.ac
@@ -185,4 +185,6 @@ LTP_CHECK_TIRPC
 LTP_CHECK_TEE
 LTP_CHECK_SPLICE
 LTP_CHECK_VMSPLICE
+LTP_CHECK_RENAMEAT
+
 AC_OUTPUT
diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index cd75fc7..200f574 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -51,6 +51,10 @@
 # define AT_SYMLINK_NOFOLLOW 0x100
 #endif
 
+#ifndef AT_REMOVEDIR
+# define AT_REMOVEDIR 0x200
+#endif
+
 #ifndef O_NOATIME
 # define O_NOATIME 01000000
 #endif
diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
new file mode 100644
index 0000000..b0ec5bc
--- /dev/null
+++ b/include/lapi/renameat.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (c) International Business Machines  Corp., 2007
+ * Copyright (c) 2014 Fujitsu Ltd.
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Library General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef RENAMEAT_H
+#define RENAMEAT_H
+
+#include <sys/types.h>
+#include "config.h"
+#include "linux_syscall_numbers.h"
+
+#if !defined(HAVE_RENAMEAT)
+int renameat(int olddirfd, const char *oldpath, int newdirfd,
+			const char *newpath)
+{
+	return ltp_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
+					newpath);
+}
+#endif
+
+#endif /* RENAMEAT_H */
diff --git a/m4/ltp-renameat.m4 b/m4/ltp-renameat.m4
new file mode 100644
index 0000000..f40c58e
--- /dev/null
+++ b/m4/ltp-renameat.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2014
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program;  if not, write to the Free Software Foundation,
+dnl Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+dnl
+
+dnl
+dnl LTP_CHECK_RENAMEAT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_RENAMEAT],[
+AC_CHECK_FUNCS(renameat,,)
+])
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index a1aecc0..8632950 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -1,46 +1,30 @@
-/******************************************************************************
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
  *
- *   Copyright (c) International Business Machines  Corp., 2006
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
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- *
- * NAME
- *      renameat01.c
- *
- * DESCRIPTION
- *	This test case will verify basic function of renameat
- *	added by kernel 2.6.16 or up.
- *
- * USAGE:  <for command-line>
- * renameat01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-p]
- * where:
- *      -c n : Run n copies simultaneously.
- *      -e   : Turn on errno logging.
- *      -i n : Execute test n times.
- *      -I x : Execute test for x seconds.
- *      -p   : Pause for SIGUSR1 before starting
- *      -P x : Pause for x seconds between iterations.
- *      -t   : Turn on syscall timing.
- *
- * Author
- *	Yi Yang <yyangcdl@cn.ibm.com>
- *
- * History
- *      08/24/2006      Created first by Yi Yang <yyangcdl@cn.ibm.com>
- *
- *****************************************************************************/
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+/*
+ * Description:
+ *   Verify that,
+ *   1) renameat(2) returns -1 and sets errno to EBADF if olddirfd
+ *      or newdirfd is not a valid file descriptor.
+ *   2) renameat(2) returns -1 and sets errno to ENOTDIR if oldpath
+ *      is relative and olddirfd is a file descriptor referring to
+ *      a file other than a directory, or similar for newpath and
+ *      newdirfd.
+ */
 
 #define _GNU_SOURCE
 
@@ -53,189 +37,149 @@
 #include <errno.h>
 #include <string.h>
 #include <signal.h>
+
 #include "test.h"
 #include "usctest.h"
-#include "linux_syscall_numbers.h"
-
-#define TEST_CASES 5
-#ifndef AT_FDCWD
-#define AT_FDCWD -100
-#endif
-#ifndef AT_REMOVEDIR
-#define AT_REMOVEDIR 0x200
-#endif
-
-void setup();
-void cleanup();
-void setup_every_copy();
+#include "safe_macros.h"
+#include "lapi/fcntl.h"
+#include "lapi/renameat.h"
+
+#define TESTDIR "testdir"
+#define NEW_TESTDIR "new_testdir"
+#define TESTFILE "testfile"
+#define NEW_TESTFILE "new_testfile"
+#define TESTFILE2 "testfile2"
+#define NEW_TESTFILE2 "new_testfile2"
+#define TESTFILE3 "testdir/testfile"
+#define TESTFILE4 "testfile4"
+
+#define DIRMODE (S_IRWXU | S_IRWXG | S_IRWXO)
+#define FILEMODE (S_IRWXU | S_IRWXG | S_IRWXO)
+
+static int curfd = AT_FDCWD;
+static int olddirfd;
+static int newdirfd;
+static int badfd = 100;
+static int filefd;
+static char absoldpath[256];
+static char absnewpath[256];
+
+static struct test_case_t {
+	int *oldfdptr;
+	const char *oldpath;
+	int *newfdptr;
+	const char *newpath;
+	int exp_errno;
+} test_cases[] = {
+	{ &curfd, TESTFILE, &curfd, NEW_TESTFILE, 0 },
+	{ &olddirfd, TESTFILE, &newdirfd, NEW_TESTFILE, 0 },
+	{ &olddirfd, absoldpath, &newdirfd, absnewpath, 0 },
+	{ &badfd, TESTFILE, &badfd, NEW_TESTFILE, EBADF },
+	{ &filefd, TESTFILE, &filefd, NEW_TESTFILE, ENOTDIR },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void renameat_verify(const struct test_case_t *);
 
 char *TCID = "renameat01";
-int TST_TOTAL = TEST_CASES;
-char pathname[256];
-char dpathname[256];
-char testfile[256];
-char dtestfile[256];
-char testfile2[256];
-char dtestfile2[256];
-char testfile3[256];
-char dtestfile3[256];
-int olddirfd, newdirfd, fd, ret;
-int oldfds[TEST_CASES], newfds[TEST_CASES];
-char *oldfilenames[TEST_CASES], *newfilenames[TEST_CASES];
-int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0 };
-
-int myrenameat(int olddirfd, const char *oldfilename, int newdirfd,
-	       const char *newfilename)
-{
-	return ltp_syscall(__NR_renameat, olddirfd, oldfilename, newdirfd,
-		       newfilename);
-}
+int TST_TOTAL = ARRAY_SIZE(test_cases);
+static int exp_enos[] = { EBADF, ENOTDIR, 0 };
 
 int main(int ac, char **av)
 {
-	int lc;
+	int i, lc;
 	const char *msg;
-	int i;
-
-	/* Disable test if the version of the kernel is less than 2.6.16 */
-	if ((tst_kvercmp(2, 6, 16)) < 0) {
-		tst_brkm(TCONF, NULL,
-			 "This test can only run on kernels that are 2.6.16 and higher");
-	}
 
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
 	setup();
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		setup_every_copy();
+	TEST_EXP_ENOS(exp_enos);
 
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		/*
-		 * Call renameat
-		 */
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(myrenameat
-			     (oldfds[i], oldfilenames[i], newfds[i],
-			      newfilenames[i]));
-
-			/* check return code */
-			if (TEST_ERRNO == expected_errno[i]) {
-
-				tst_resm(TPASS | TTERRNO,
-					 "renameat failed as expected");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "renameat failed unexpectedly");
-			}
-		}
-
+		for (i = 0; i < TST_TOTAL; i++)
+			renameat_verify(&test_cases[i]);
 	}
 
 	cleanup();
 	tst_exit();
 }
 
-void setup_every_copy(void)
+static void setup(void)
 {
-	/* Initialize test dir and file names */
-	sprintf(pathname, "renameattestdir%d", getpid());
-	sprintf(dpathname, "drenameattestdir%d", getpid());
-	sprintf(testfile, "renameattestfile%d.txt", getpid());
-	sprintf(dtestfile, "drenameattestfile%d.txt", getpid());
-	sprintf(testfile2, "renameattestdir%d/renameattestfile%d.txt", getpid(),
-		getpid());
-	sprintf(dtestfile2, "drenameattestdir%d/drenameattestfile%d.txt",
-		getpid(), getpid());
-	sprintf(testfile3, "/tmp/renameattestfile%d.txt", getpid());
-	sprintf(dtestfile3, "/tmp/drenameattestfile%d.txt", getpid());
-
-	ret = mkdir(pathname, 0700);
-	if (ret < 0) {
-		perror("mkdir: ");
-		exit(-1);
-	}
+	char *tmpdir;
 
-	ret = mkdir(dpathname, 0700);
-	if (ret < 0) {
-		perror("mkdir: ");
-		exit(-1);
-	}
-
-	olddirfd = open(pathname, O_DIRECTORY);
-	if (olddirfd < 0) {
-		perror("open: ");
-		exit(-1);
+	if ((tst_kvercmp(2, 6, 16)) < 0) {
+		tst_brkm(TCONF, NULL,
+			"This test can only run on kernels that are "
+			"2.6.16 and higher");
 	}
 
-	newdirfd = open(dpathname, O_DIRECTORY);
-	if (newdirfd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	fd = open(testfile, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	tst_tmpdir();
 
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	TEST_PAUSE;
 
-	fd = open(testfile3, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	SAFE_TOUCH(cleanup, TESTFILE, FILEMODE, NULL);
 
-	oldfds[0] = oldfds[1] = olddirfd;
-	oldfds[2] = fd;
-	oldfds[3] = 100;
-	oldfds[4] = AT_FDCWD;
+	SAFE_TOUCH(cleanup, TESTFILE2, FILEMODE, NULL);
+	tmpdir = tst_get_tmpdir();
+	sprintf(absoldpath, "%s/%s", tmpdir, TESTFILE2);
+	sprintf(absnewpath, "%s/%s", tmpdir, NEW_TESTFILE2);
+	free(tmpdir);
 
-	newfds[0] = newfds[1] = newdirfd;
-	newfds[2] = fd;
-	newfds[3] = 100;
-	newfds[4] = AT_FDCWD;
+	SAFE_MKDIR(cleanup, TESTDIR, DIRMODE);
+	SAFE_TOUCH(cleanup, TESTFILE3, FILEMODE, NULL);
+	SAFE_MKDIR(cleanup, NEW_TESTDIR, DIRMODE);
 
-	oldfilenames[0] = oldfilenames[2] = oldfilenames[3] = oldfilenames[4] =
-	    testfile;
-	oldfilenames[1] = testfile3;
+	olddirfd = SAFE_OPEN(cleanup, TESTDIR, O_DIRECTORY);
+	newdirfd = SAFE_OPEN(cleanup, NEW_TESTDIR, O_DIRECTORY);
 
-	newfilenames[0] = newfilenames[2] = newfilenames[3] = newfilenames[4] =
-	    dtestfile;
-	newfilenames[1] = dtestfile3;
+	filefd = SAFE_OPEN(cleanup, TESTFILE4,
+				O_RDWR | O_CREAT, FILEMODE);
 }
 
-void setup(void)
+static void renameat_verify(const struct test_case_t *tc)
 {
+	TEST(renameat(*(tc->oldfdptr), tc->oldpath,
+			*(tc->newfdptr), tc->newpath));
+
+	if (TEST_ERRNO == tc->exp_errno) {
+		tst_resm(TPASS | TTERRNO,
+		"renameat() returned the expected value");
+	} else {
+		tst_resm(TFAIL | TTERRNO,
+			"renameat() got unexpected return value; expected: "
+			"%d - %s", tc->exp_errno,
+			strerror(tc->exp_errno));
+	}
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
+	if (TEST_ERRNO == 0 && renameat(*(tc->newfdptr), tc->newpath,
+		*(tc->oldfdptr), tc->oldpath) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup, "renameat(%d, %s, "
+			"%d, %s) failed.", *(tc->newfdptr), tc->newpath,
+			*(tc->oldfdptr), tc->oldpath);
+	}
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	/* Remove them */
-	unlink(testfile2);
-	unlink(dtestfile2);
-	unlink(testfile3);
-	unlink(dtestfile3);
-	unlink(testfile);
-	unlink(dtestfile);
-	rmdir(pathname);
-	rmdir(dpathname);
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
+
+	if (olddirfd && close(olddirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close olddirfd failed");
+
+	if (newdirfd && close(newdirfd) < 0)
+		tst_resm(TWARN | TERRNO, "close newdirfd failed");
+
+	if (filefd && close(filefd) < 0)
+		tst_resm(TWARN | TERRNO, "close filefd failed");
+
+	tst_rmdir();
 }
-- 
1.9.3


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
