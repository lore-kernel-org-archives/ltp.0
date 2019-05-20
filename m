From: Christian Amann <camann@suse.com>
Date: Mon, 20 May 2019 07:50:37 +0200
Subject: [LTP] [PATCH v1 1/2] syscalls/fstat{01,02}: rewrote testcases
Message-ID: <20190520055038.11499-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Merged the two tests:
	fstat01 is a subset of fstat02 and is therefore not needed
	anymore.
Rewrote testcase:
	Cleaned up, ported to new library and added variants to test
	for libc aswell as the raw syscall.

Signed-off-by: Christian Amann <camann@suse.com>
---
 runtest/syscalls                           |   2 -
 testcases/kernel/syscalls/fstat/.gitignore |   2 -
 testcases/kernel/syscalls/fstat/fstat.h    |  34 ++++++
 testcases/kernel/syscalls/fstat/fstat01.c  | 175 -----------------------------
 testcases/kernel/syscalls/fstat/fstat02.c  | 141 +++++++----------------
 5 files changed, 76 insertions(+), 278 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fstat/fstat.h
 delete mode 100644 testcases/kernel/syscalls/fstat/fstat01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2b8ca719b..5c2f4cec6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -334,8 +334,6 @@ fpathconf01 fpathconf01
 fremovexattr01 fremovexattr01
 fremovexattr02 fremovexattr02
 
-fstat01 fstat01
-fstat01_64 fstat01_64
 fstat02 fstat02
 fstat02_64 fstat02_64
 fstat03 fstat03
diff --git a/testcases/kernel/syscalls/fstat/.gitignore b/testcases/kernel/syscalls/fstat/.gitignore
index cf5205d44..1c66bdf10 100644
--- a/testcases/kernel/syscalls/fstat/.gitignore
+++ b/testcases/kernel/syscalls/fstat/.gitignore
@@ -1,5 +1,3 @@
-/fstat01
-/fstat01_64
 /fstat02
 /fstat02_64
 /fstat03
diff --git a/testcases/kernel/syscalls/fstat/fstat.h b/testcases/kernel/syscalls/fstat/fstat.h
new file mode 100644
index 000000000..226428071
--- /dev/null
+++ b/testcases/kernel/syscalls/fstat/fstat.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) SUSE LLC, 2019
+ * Author: Christian Amann <camann@suse.com>
+ */
+
+#ifndef __FSTAT_H__
+#define __FSTAT_H__
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include "lapi/syscalls.h"
+
+#define TEST_VARIANTS	2
+#define TESTFILE	"test_file"
+
+static void syscall_info(void)
+{
+	if (tst_variant == 0) {
+		tst_res(TINFO, "Testing libc fstat()");
+		return;
+	}
+	tst_res(TINFO, "Testing syscall fstat()");
+}
+
+static int tst_fstat(int fd, struct stat *statbuf)
+{
+	if (tst_variant == 0)
+		return fstat(fd, statbuf);
+	return tst_syscall(__NR_fstat, fd, statbuf);
+}
+
+#endif /* __FSTAT_H__ */
diff --git a/testcases/kernel/syscalls/fstat/fstat01.c b/testcases/kernel/syscalls/fstat/fstat01.c
deleted file mode 100644
index a5940c627..000000000
--- a/testcases/kernel/syscalls/fstat/fstat01.c
+++ /dev/null
@@ -1,175 +0,0 @@
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
-/* $Id: fstat01.c,v 1.6 2009/08/28 12:51:34 vapier Exp $ */
-/**********************************************************
- *
- *    OS Test - Silicon Graphics, Inc.
- *
- *    TEST IDENTIFIER	: fstat01
- *
- *    EXECUTED BY	: anyone
- *
- *    TEST TITLE	: Basic test for fstat(2)
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
- *	1.) fstat(2) returns...(See Description)
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
- *	This is a Phase I test for the fstat(2) system call.  It is intended
- *	to provide a limited exposure of the system call, for now.  It
- *	should/will be extended when full functional tests are written for
- *	fstat(2).
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
-
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-#include "test.h"
-#include "safe_macros.h"
-
-void setup();
-void cleanup();
-
-char *TCID = "fstat01";
-int TST_TOTAL = 1;
-
-char fname[255];
-int fd;
-struct stat statter;
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
-
-		tst_count = 0;
-
-		TEST(fstat(fd, &statter));
-
-		if (TEST_RETURN == -1)
-			tst_resm(TFAIL | TTERRNO, "fstat failed");
-		else
-			tst_resm(TPASS, "fstat returned %ld", TEST_RETURN);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	sprintf(fname, "tfile_%d", getpid());
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
-}
-
-void cleanup(void)
-{
-	if (close(fd) == -1)
-		tst_resm(TWARN | TERRNO, "close(%s) failed", fname);
-
-	tst_rmdir();
-
-}
diff --git a/testcases/kernel/syscalls/fstat/fstat02.c b/testcases/kernel/syscalls/fstat/fstat02.c
index 21ef16617..2b95586a4 100644
--- a/testcases/kernel/syscalls/fstat/fstat02.c
+++ b/testcases/kernel/syscalls/fstat/fstat02.c
@@ -1,152 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  *  07/2001 Ported by Wayne Boyer
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *  05/2019 Ported to new library: Christian Amann <camann@suse.com>
  */
 /*
- * fstat() should return value 0 on success and the stat structure elements
- * should be filled with specified 'file' information.
+ * Tests if fstat() returns correctly and reports correct file information
+ * using the stat structure.
  */
-#include <stdio.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <sys/stat.h>
+
 #include <errno.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "fstat.h"
 
-#include "test.h"
-#include "safe_macros.h"
-
-#define FILE_MODE	0644
-#define TESTFILE	"testfile"
 #define FILE_SIZE       1024
-#define BUF_SIZE	256
-#define MASK		0777
+#define FILE_MODE	0644
 
-char *TCID = "fstat02";
-int TST_TOTAL = 1;
 static uid_t user_id;
 static gid_t group_id;
 static int fildes;
 
-static void setup(void);
-static void cleanup(void);
-
-static void verify(void)
+static void run(void)
 {
+	int fail;
 	struct stat stat_buf;
-	int fail = 0;
 
-	TEST(fstat(fildes, &stat_buf));
+	TEST(tst_fstat(fildes, &stat_buf));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "fstat(%s) failed", TESTFILE);
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fstat() failed");
 		return;
 	}
 
+	fail = 0;
 	if (stat_buf.st_uid != user_id) {
-		tst_resm(TINFO, "stat_buf.st_uid = %i expected %i",
-		         stat_buf.st_uid, user_id);
+		tst_res(TFAIL, "stat_buf.st_uid = %i expected %i",
+			stat_buf.st_uid, user_id);
 		fail++;
 	}
 
 	if (stat_buf.st_gid != group_id) {
-		tst_resm(TINFO, "stat_buf.st_gid = %i expected %i",
-		         stat_buf.st_gid, group_id);
+		tst_res(TFAIL, "stat_buf.st_gid = %i expected %i",
+			stat_buf.st_gid, group_id);
 		fail++;
 	}
 
 	if (stat_buf.st_size != FILE_SIZE) {
-		tst_resm(TINFO, "stat_buf.st_size = %li expected %i",
-		         (long)stat_buf.st_size, FILE_SIZE);
+		tst_res(TFAIL, "stat_buf.st_size = %li expected %i",
+			(long)stat_buf.st_size, FILE_SIZE);
 		fail++;
 	}
 
-        if ((stat_buf.st_mode & MASK) != FILE_MODE) {
-		tst_resm(TINFO, "stat_buf.st_mode = %o expected %o",
-		         (stat_buf.st_mode & MASK), FILE_MODE);
+	if ((stat_buf.st_mode & 0777) != FILE_MODE) {
+		tst_res(TFAIL, "stat_buf.st_mode = %o expected %o",
+			(stat_buf.st_mode & 0777), FILE_MODE);
 		fail++;
 	}
 
 	if (fail) {
-		tst_resm(TFAIL, "functionality of fstat incorrect");
+		tst_res(TFAIL, "fstat() reported wrong values.");
 		return;
 	}
 
-	tst_resm(TPASS, "functionality of fstat correct");
-}
-
-int main(int ac, char **av)
-{
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++)
-		verify();
-
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "fstat() reported correct values.");
 }
 
 static void setup(void)
 {
-	struct passwd *ltpuser;
-	char tst_buff[BUF_SIZE];
-	int wbytes;
-	int write_len = 0;
+	syscall_info();
 
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	ltpuser = SAFE_GETPWNAM(NULL, "nobody");
-	SAFE_SETUID(NULL, ltpuser->pw_uid);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	umask(022);
-
-	fildes = SAFE_OPEN(tst_rmdir, TESTFILE, O_WRONLY | O_CREAT, FILE_MODE);
-
-	/* Fill the test buffer with the known data */
-	memset(tst_buff, 'a', BUF_SIZE - 1);
+	user_id  = getuid();
+	group_id = getgid();
 
-	/* Write to the file 1k data from the buffer */
-	while (write_len < FILE_SIZE) {
-		if ((wbytes = write(fildes, tst_buff, sizeof(tst_buff))) <= 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
-		else
-			write_len += wbytes;
-	}
+	fildes = SAFE_OPEN(TESTFILE, O_WRONLY | O_CREAT, FILE_MODE);
 
-	user_id = getuid();
-	group_id = getgid();
+	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
+		tst_brk(TBROK, "Could not fill Testfile!");
 }
 
 static void cleanup(void)
 {
-	if (close(fildes) == -1)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.test_variants = TEST_VARIANTS,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.16.4

