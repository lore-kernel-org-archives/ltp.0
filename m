From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 19 Aug 2016 17:19:34 +0800
Subject: [LTP] [PATCH 2/2] syscalls/access02: add behaviour check for F_OK
In-Reply-To: <1471598374-26908-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20160804165028.GD3367@rei.lan>
 <1471598374-26908-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <1471598374-26908-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add F_OK check of access04 to access02, and remove access04.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 runtest/ltplite                             |   1 -
 runtest/stress.part3                        |   1 -
 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/.gitignore        |   1 -
 testcases/kernel/syscalls/access/access02.c |  32 +++++--
 testcases/kernel/syscalls/access/access04.c | 129 ----------------------------
 6 files changed, 27 insertions(+), 138 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/access/access04.c

diff --git a/runtest/ltplite b/runtest/ltplite
index 00898f2..2f8fbaf 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -64,7 +64,6 @@ accept01 accept01
 access01 access01
 access02 access02
 access03 access03
-access04 access04
 access05 access05
 access06 access06
 
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 7c74ea0..537e450 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -6,7 +6,6 @@ accept01 accept01
 access01 access01
 access02 access02
 access03 access03
-access04 access04
 access05 access05
 access06 access06
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 9ccf851..53d6f32 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -7,7 +7,6 @@ accept4_01 accept4_01
 access01 access01
 access02 access02
 access03 access03
-access04 access04
 access05 access05
 access06 access06
 
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 10bd62a..a13dbb3 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -4,7 +4,6 @@
 /access/access01
 /access/access02
 /access/access03
-/access/access04
 /access/access05
 /access/access06
 /acct/acct01
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 7161a05..e327a91 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -19,17 +19,17 @@
 
 /*
  * Test Description:
- *  Verify that access() succeeds to check the read/write/execute permissions
- *  on a file if the mode argument passed was R_OK/W_OK/X_OK.
+ *  Verify that access() succeeds to check the existence or read/write/execute
+ *  permissions on a file if the mode argument passed was F_OK/R_OK/W_OK/X_OK.
  *
  *  Also verify that, access() succeeds to test the accessibility of the file
  *  referred to by symbolic link if the pathname points to a symbolic link.
  *
- *  As well as verify that, these test files can be read/written/executed
- *  indeed as root and nobody respectively.
+ *  As well as verify that, these test files can be got status or
+ *  read/written/executed indeed as root and nobody respectively.
  *
  *	07/2001 Ported by Wayne Boyera
- *	06/2016 modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ *	06/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
 #include <sys/types.h>
@@ -40,9 +40,11 @@
 #include <stdlib.h>
 #include "tst_test.h"
 
+#define FNAME_F	"file_f"
 #define FNAME_R	"file_r"
 #define FNAME_W	"file_w"
 #define FNAME_X	"file_x"
+#define SNAME_F	"symlink_f"
 #define SNAME_R	"symlink_r"
 #define SNAME_W	"symlink_w"
 #define SNAME_X	"symlink_x"
@@ -55,9 +57,11 @@ static struct tcase {
 	char *name;
 	const char *targetname;
 } tcases[] = {
+	{FNAME_F, F_OK, "F_OK", FNAME_F},
 	{FNAME_R, R_OK, "R_OK", FNAME_R},
 	{FNAME_W, W_OK, "W_OK", FNAME_W},
 	{FNAME_X, X_OK, "X_OK", FNAME_X},
+	{SNAME_F, F_OK, "F_OK", FNAME_F},
 	{SNAME_R, R_OK, "R_OK", FNAME_R},
 	{SNAME_W, W_OK, "W_OK", FNAME_W},
 	{SNAME_X, X_OK, "X_OK", FNAME_X}
@@ -65,6 +69,7 @@ static struct tcase {
 
 static void access_test(struct tcase *tc, const char *user)
 {
+	struct stat stat_buf;
 	char command[64];
 
 	TEST(access(tc->pathname, tc->mode));
@@ -76,6 +81,21 @@ static void access_test(struct tcase *tc, const char *user)
 	}
 
 	switch (tc->mode) {
+	case F_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * exists, attempt to get its status, if successful,
+		 * access() behaviour is correct.
+		 */
+		TEST(stat(tc->targetname, &stat_buf));
+
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO, "stat(%s) as %s failed",
+				tc->targetname, user);
+			return;
+		}
+
+		break;
 	case R_OK:
 		/*
 		 * The specified file(or pointed to by symbolic link)
@@ -163,10 +183,12 @@ static void setup(void)
 
 	uid = pw->pw_uid;
 
+	SAFE_TOUCH(FNAME_F, 0000, NULL);
 	SAFE_TOUCH(FNAME_R, 0444, NULL);
 	SAFE_TOUCH(FNAME_W, 0222, NULL);
 	SAFE_TOUCH(FNAME_X, 0555, NULL);
 
+	SAFE_SYMLINK(FNAME_F, SNAME_F);
 	SAFE_SYMLINK(FNAME_R, SNAME_R);
 	SAFE_SYMLINK(FNAME_W, SNAME_W);
 	SAFE_SYMLINK(FNAME_X, SNAME_X);
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
deleted file mode 100644
index 49e7057..0000000
--- a/testcases/kernel/syscalls/access/access04.c
+++ /dev/null
@@ -1,129 +0,0 @@
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
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Description:
- *  Verify that access() succeeds to check the existance of a file if
- *  search access is permitted on the pathname of the specified file.
- *
- *  07/2001 Ported by Wayne Boyer
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <pwd.h>
-
-#include "test.h"
-
-#define TESTDIR		"testdir"
-#define TESTFILE	"testdir/testfile"
-#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
-#define FILE_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
-
-char *TCID = "access04";
-int TST_TOTAL = 1;
-
-static const char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
-
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
-{
-	struct stat stat_buf;
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(access(TESTFILE, F_OK));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "access(%s, F_OK) failed",
-				 TESTFILE);
-			continue;
-		}
-
-		if (stat(TESTFILE, &stat_buf) < 0) {
-			tst_resm(TFAIL | TERRNO, "stat(%s) failed",
-				 TESTFILE);
-		} else {
-			tst_resm(TPASS, "functionality of "
-				 "access(%s, F_OK) ok", TESTFILE);
-		}
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	int fd;
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	tst_require_root();
-
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TINFO | TERRNO, NULL, "setuid failed");
-
-	TEST_PAUSE;
-	tst_tmpdir();
-
-	if (mkdir(TESTDIR, DIR_MODE) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
-			 TESTDIR, DIR_MODE);
-
-	if (chmod(TESTDIR, DIR_MODE) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, %#o) failed",
-			 TESTDIR, DIR_MODE);
-
-	fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TESTFILE, FILE_MODE);
-
-	if (close(fd) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", TESTFILE);
-
-	if (chmod(TESTFILE, 0) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "chmod(%s, 0) failed", TESTFILE);
-}
-
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-- 
1.8.4.2



