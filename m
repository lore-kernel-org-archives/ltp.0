From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 19 Jun 2017 13:00:31 +0800
Subject: [LTP] [PATCH 2/2] syscalls/lseek0[2-5]: cleanup && convert to new
	API
In-Reply-To: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1497848431-30404-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1497848431-30404-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) merge lseek03,04,05 into lseek02
2) add combinations of invalid parameters

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                           |   3 -
 runtest/stress.part3                      |   3 -
 runtest/syscalls                          |   3 -
 testcases/kernel/syscalls/.gitignore      |   3 -
 testcases/kernel/syscalls/lseek/lseek02.c | 246 ++++++++++--------------------
 testcases/kernel/syscalls/lseek/lseek03.c | 123 ---------------
 testcases/kernel/syscalls/lseek/lseek04.c | 222 ---------------------------
 testcases/kernel/syscalls/lseek/lseek05.c | 219 --------------------------
 8 files changed, 78 insertions(+), 744 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek03.c
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek04.c
 delete mode 100644 testcases/kernel/syscalls/lseek/lseek05.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 7904117..2826514 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -407,9 +407,6 @@ llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
-lseek03 lseek03
-lseek04 lseek04
-lseek05 lseek05
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 42c2b0e..67548dc 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -333,9 +333,6 @@ llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
-lseek03 lseek03
-lseek04 lseek04
-lseek05 lseek05
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/runtest/syscalls b/runtest/syscalls
index fcef347..169bfcd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -549,9 +549,6 @@ llseek03 llseek03
 
 lseek01 lseek01
 lseek02 lseek02
-lseek03 lseek03
-lseek04 lseek04
-lseek05 lseek05
 lseek07 lseek07
 lseek08 lseek08
 lseek09 lseek09
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 5b8e5b4..9ea4ed8 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -500,9 +500,6 @@
 /llseek/llseek03
 /lseek/lseek01
 /lseek/lseek02
-/lseek/lseek03
-/lseek/lseek04
-/lseek/lseek05
 /lseek/lseek07
 /lseek/lseek08
 /lseek/lseek09
diff --git a/testcases/kernel/syscalls/lseek/lseek02.c b/testcases/kernel/syscalls/lseek/lseek02.c
index 0efc691..0d6ca1d 100644
--- a/testcases/kernel/syscalls/lseek/lseek02.c
+++ b/testcases/kernel/syscalls/lseek/lseek02.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * 06/2017 modified by Xiao Yang <yangx.jy@cn.fujitsu.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -17,189 +18,98 @@
  * other software, or any other product whatsoever.
  *
  * You should have received a copy of the GNU General Public License along
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
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * DESCRIPTION
+ * 1) lseek(2) fails and sets errno to EBADF when fd is invalid.
+ * 2) lseek(2) fails ans sets errno to EINVAL when whence is invalid.
+ * 3) lseek(2) fails and sets errno to ESPIPE when fd is associated
+ *    with a pipe or FIFO.
  */
-/* $Id: lseek02.c,v 1.5 2009/10/26 14:55:48 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: lseek02
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Negative test for lseek(2)
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 04/25/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) lseek(2) returns...(See Description)
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
- *	This is a Phase I test for the lseek(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	lseek(2).
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
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
+#include <sys/types.h>
 #include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "lseek02";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
-
-int Whence[] = { SEEK_SET, SEEK_CUR, SEEK_END, -1 };
-
-int main(int ac, char **av)
+#include <stdio.h>
+#include "tst_test.h"
+
+static char fname[255], pname[255];
+static int bad_fd = -1;
+static int fd, pfd;
+static int pfds[2];
+
+static struct tcase {
+	int *fd;
+	int whence;
+	int exp_err;
+} tcases[] = {
+	{&bad_fd, SEEK_SET, EBADF},
+	{&bad_fd, SEEK_CUR, EBADF},
+	{&bad_fd, SEEK_END, EBADF},
+	{&fd, 5, EINVAL},
+	{&fd, -1, EINVAL},
+	{&fd, 7, EINVAL},
+	{&pfd, SEEK_SET, ESPIPE},
+	{&pfd, SEEK_CUR, ESPIPE},
+	{&pfd, SEEK_END, ESPIPE},
+	{&pfds[0], SEEK_SET, ESPIPE},
+	{&pfds[0], SEEK_CUR, ESPIPE},
+	{&pfds[0], SEEK_END, ESPIPE},
+};
+
+static void verify_lseek(unsigned int n)
 {
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
-		 *  Call lseek(2)
-		 */
-		TEST(lseek(-1, (long)1, SEEK_SET));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == EBADF)
-
-				tst_resm(TPASS,
-					 "lseek(-1, 1, SEEK_SET) Failed, errno=%d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			else
-				tst_resm(TFAIL,
-					 "lseek(-1, 1, SEEK_SET) Failed, errno=%d : %s, expected %d(EBADF)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EBADF);
-		} else {
-
-			tst_resm(TFAIL, "lseek(-1, 1, SEEK_SET) returned %ld",
-				 TEST_RETURN);
-		}
+	struct tcase *tc = &tcases[n];
 
+	TEST(lseek(*tc->fd, (off_t) 1, tc->whence));
+	if (TEST_RETURN != (off_t) -1) {
+		tst_res(TFAIL, "lseek(%d, 1, %d) succeeded unexpectedly",
+			*tc->fd, tc->whence);
+			return;
 	}
 
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == tc->exp_err) {
+		tst_res(TPASS | TTERRNO, "lseek(%d, 1, %d) failed as expected",
+			*tc->fd, tc->whence);
+	} else {
+		tst_res(TFAIL | TTERRNO, "lseek(%d, 1, %d) failed "
+			"unexpectedly, expected %s", *tc->fd, tc->whence,
+			tst_strerrno(tc->exp_err));
+	}
 }
 
-/***************************************************************
- * setup() - performs all ONE TIME setup for this test.
- ***************************************************************/
-void setup(void)
+static void setup(void)
 {
+	sprintf(fname, "tfile_%d", getpid());
+	sprintf(pname, "tpipe_%d", getpid());
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0777);
+	SAFE_MKFIFO(pname, 0777);
+	pfd = SAFE_OPEN(pname, O_RDWR, 0777);
+	SAFE_PIPE(pfds);
 }
 
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
+static void cleanup(void)
 {
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+
+	if (pfd > 0)
+		SAFE_CLOSE(pfd);
 
-	tst_rmdir();
+	if (pfds[0] > 0)
+		SAFE_CLOSE(pfds[0]);
 
+	if (pfds[1] > 0)
+		SAFE_CLOSE(pfds[1]);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_lseek,
+	.needs_tmpdir = 1,
+};
diff --git a/testcases/kernel/syscalls/lseek/lseek03.c b/testcases/kernel/syscalls/lseek/lseek03.c
deleted file mode 100644
index 02b94fb..0000000
--- a/testcases/kernel/syscalls/lseek/lseek03.c
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- * Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>
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
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-
-static void setup(void);
-static void cleanup(void);
-
-static char fname[255];
-static int fd;
-static int whences[] = { 5, -1, 7 };
-
-char *TCID = "lseek03";
-int TST_TOTAL = ARRAY_SIZE(whences);
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		int i;
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			/* Call lseek(2) */
-			TEST(lseek(fd, (off_t) 1, whences[i]));
-
-			if (TEST_RETURN == -1) {
-				if (TEST_ERRNO == EINVAL) {
-					tst_resm(TPASS,
-						 "lseek(%s, 1, %d) Failed, errno=%d : %s",
-						 fname, whences[i],
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO));
-				} else {
-					tst_resm(TFAIL,
-						 "lseek(%s, 1, %d) Failed, errno=%d %s, expected %d(EINVAL)",
-						 fname, whences[i],
-						 TEST_ERRNO,
-						 strerror(TEST_ERRNO),
-						 EINVAL);
-				}
-			} else {
-				tst_resm(TFAIL, "lseek(%s, 1, %d) returned %ld",
-					 fname, whences[i], TEST_RETURN);
-			}
-		}
-
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-
-	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
-			 fname, errno, strerror(errno));
-	}
-}
-
-void cleanup(void)
-{
-	if (close(fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s", fname, errno,
-			 strerror(errno));
-	}
-
-	tst_rmdir();
-}
diff --git a/testcases/kernel/syscalls/lseek/lseek04.c b/testcases/kernel/syscalls/lseek/lseek04.c
deleted file mode 100644
index 9d431f0..0000000
--- a/testcases/kernel/syscalls/lseek/lseek04.c
+++ /dev/null
@@ -1,222 +0,0 @@
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
-/* $Id: lseek04.c,v 1.5 2009/10/26 14:55:48 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: lseek04
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Negative test for lseek(2) of a fifo
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 04/25/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) lseek(2) returns...(See Description)
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
- *	This is a Phase I test for the lseek(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	lseek(2).
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
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "lseek04";
-int TST_TOTAL = 1;
-
-char Fname[255];
-int Fd;
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
-		 *  Call lseek(2)
-		 */
-		TEST(lseek(Fd, (long)1, SEEK_SET));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == ESPIPE)
-				tst_resm(TPASS,
-					 "lseek(fifofd, 1, SEEK_SET) Failed, errno=%d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			else
-				tst_resm(TFAIL,
-					 "lseek(fifofd, 1, SEEK_SET) Failed, errno=%d %s, expected %d(ESPIPE)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EINVAL);
-		} else {
-
-			tst_resm(TFAIL,
-				 "lseek(fifofd, 1, SEEK_SET) returned %ld",
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
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(Fname, "tfile_%d", getpid());
-	if (mkfifo(Fname, 0700) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "mkfifo(%s, 0700) Failed, errno=%d : %s",
-			 Fname, errno, strerror(errno));
-	}
-
-	if ((Fd = open(Fname, O_RDWR, 0777)) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR, 0777) Failed, errno=%d : %s",
-			 Fname, errno, strerror(errno));
-	}
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	/* close the file we have open */
-	if (close(Fd) == -1) {
-		tst_resm(TWARN, "close(%s) Failed, errno=%d : %s", Fname, errno,
-			 strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/lseek/lseek05.c b/testcases/kernel/syscalls/lseek/lseek05.c
deleted file mode 100644
index 1eee03d..0000000
--- a/testcases/kernel/syscalls/lseek/lseek05.c
+++ /dev/null
@@ -1,219 +0,0 @@
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
-/* $Id: lseek05.c,v 1.5 2009/10/26 14:55:48 subrata_modak Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: lseek05
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Negative test for lseek(2) of a pipe
- *
- *    PARENT DOCUMENT	: usctpl01
- *
- *    TEST CASE TOTAL	: 1
- *
- *    WALL CLOCK TIME	: 1
- *
- *    CPU TYPES		: ALL
- *
- *    AUTHOR		: Richard Logan
- *
- *    CO-PILOT		: William Roske
- *
- *    DATE STARTED	: 04/25/94
- *
- *    INITIAL RELEASE	: UNICOS 7.0
- *
- *    TEST CASES
- *
- * 	1.) lseek(2) returns...(See Description)
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
- *	This is a Phase I test for the lseek(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	lseek(2).
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
-#include <sys/types.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "lseek05";
-int TST_TOTAL = 1;
-
-int Fd;
-
-/***********************************************************************
- * Main
- ***********************************************************************/
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
-		 *  Call lseek(2)
-		 */
-		TEST(lseek(Fd, (long)1, SEEK_SET));
-
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			if (TEST_ERRNO == ESPIPE)
-				tst_resm(TPASS,
-					 "lseek(pipefd, 1, SEEK_SET) Failed, errno=%d : %s",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			else
-				tst_resm(TFAIL,
-					 "lseek(pipefd, 1, SEEK_SET) Failed, errno=%d %s, expected %d(ESPIPE)",
-					 TEST_ERRNO,
-					 strerror(TEST_ERRNO), EINVAL);
-		} else {
-
-			tst_resm(TFAIL,
-				 "lseek(pipefd, 1, SEEK_SET) returned %ld",
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
-	int fds[2];
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	if (pipe(fds) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "pipe(&fds) Failed, errno=%d : %s", errno,
-			 strerror(errno));
-	}
-	Fd = fds[0];
-
-}
-
-/***************************************************************
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- ***************************************************************/
-void cleanup(void)
-{
-
-	/* close the file we have open */
-	if (close(Fd) == -1) {
-		tst_resm(TWARN, "close(%d) Failed, errno=%d : %s", Fd, errno,
-			 strerror(errno));
-	}
-
-	tst_rmdir();
-
-}
-- 
1.8.3.1



