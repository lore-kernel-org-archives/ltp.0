From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 20 Jul 2016 18:44:39 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/access02: reconstruct and convert to
	new API
In-Reply-To: <20160719114953.GC6409@rei.lan>
References: <20160719114953.GC6409@rei.lan>
Message-ID: <1469011479-808-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* take use of some SAFE Marcos
* add read/execute check for the file referred to by symbolic link
* add test as root and nobody respectively

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/access/Makefile   |   4 +
 testcases/kernel/syscalls/access/access02.c | 381 +++++++++-------------------
 2 files changed, 121 insertions(+), 264 deletions(-)

diff --git a/testcases/kernel/syscalls/access/Makefile b/testcases/kernel/syscalls/access/Makefile
index bd617d8..3954429 100644
--- a/testcases/kernel/syscalls/access/Makefile
+++ b/testcases/kernel/syscalls/access/Makefile
@@ -18,6 +18,10 @@
 
 top_srcdir		?= ../../../..
 
+ifeq ($(UCLINUX),1)
+FILTER_OUT_MAKE_TARGETS += access02
+endif
+
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 56241d0..366916a 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -25,302 +25,155 @@
  *  Also verify that, access() succeeds to test the accessibility of the file
  *  referred to by symbolic link if the pathname points to a symbolic link.
  *
- *	07/2001 Ported by Wayne Boyer
+ *  As well as verify that, these test files can be read/written/executed
+ *  indeed as root and nobody respectively.
+ *
+ *	07/2001 Ported by Wayne Boyera
+ *	06/2016 modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
 #include <pwd.h>
-
-#include "test.h"
-
-#define TEMP_FILE	"temp_file"
-#define SYM_FILE	"sym_file"
-#define TEST_FILE1	"test_file1"
-#define TEST_FILE2	"test_file2"
-#define TEST_FILE3	"test_file3"
-#define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
-#define EXE_MODE	0777
-
-char *TCID = "access02";
-int TST_TOTAL = 4;
-
-static int fd1, fd2, fd4;
-static const char nobody_uid[] = "nobody";
-static struct passwd *ltpuser;
-
-static int setup1(void);
-static int setup2(void);
-static int setup3(void);
-static int setup4(void);
-
-static struct test_case_t {
-	char *pathname;
-	mode_t a_mode;
-	int (*setupfunc) (void);
-} test_cases[] = {
-	{TEST_FILE1, R_OK, setup1},
-	{TEST_FILE2, W_OK, setup2},
-	{TEST_FILE3, X_OK, setup3},
-	{SYM_FILE, W_OK, setup4},
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define FNAME_R	"file_r"
+#define FNAME_W	"file_w"
+#define FNAME_X	"file_x"
+#define SNAME_R	"symlink_r"
+#define SNAME_W	"symlink_w"
+#define SNAME_X	"symlink_x"
+
+static uid_t uid;
+
+static struct tcase {
+	const char *pathname;
+	int mode;
+	char *name;
+	const char *targetname;
+} tcases[] = {
+	{FNAME_R, R_OK, "R_OK", FNAME_R},
+	{FNAME_W, W_OK, "W_OK", FNAME_W},
+	{FNAME_X, X_OK, "X_OK", FNAME_X},
+	{SNAME_R, R_OK, "R_OK", FNAME_R},
+	{SNAME_W, W_OK, "W_OK", FNAME_W},
+	{SNAME_X, X_OK, "X_OK", FNAME_X}
 };
 
-static void setup(void);
-static void cleanup(void);
-static int access_verify(int);
-
-int main(int ac, char **av)
+static void access_test(struct tcase *tc, const char *user)
 {
-	int lc;
-	int i;
-	mode_t access_mode;
-	char *file_name;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
+	char command[64];
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++) {
-			file_name = test_cases[i].pathname;
-			access_mode = test_cases[i].a_mode;
+	TEST(access(tc->pathname, tc->mode));
 
-			/*
-			 * Call access(2) to check the test file
-			 * for specified access mode permissions.
-			 */
-			TEST(access(file_name, access_mode));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "access(%s, %#o) failed",
-					 file_name, access_mode);
-				continue;
-			}
-
-			access_verify(i);
-		}
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL | TTERRNO, "access(%s, %s) as %s failed",
+			tc->pathname, tc->name, user);
+		return;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	int i;
-
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TINFO | TERRNO, NULL, "setuid failed");
+	switch (tc->mode) {
+	case R_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has read access, attempt to open the file with O_RDONLY,
+		 * if we get a valid fd, access() behaviour is correct.
+		 */
+		TEST(open(tc->targetname, O_RDONLY));
 
-	TEST_PAUSE;
-	tst_tmpdir();
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO,
+				"open %s with O_RDONLY as %s failed",
+				tc->targetname, user);
+			return;
+		}
 
-	for (i = 0; i < TST_TOTAL; i++)
-		test_cases[i].setupfunc();
-}
+		break;
+	case W_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has write access, attempt to open the file with O_WRONLY,
+		 * if we get a valid fd, access() behaviour is correct.
+		 */
+		TEST(open(tc->targetname, O_WRONLY));
 
-/*
- * setup1() - Setup function to test the functionality of access() for
- *	      the access mode argument R_OK.
- *
- *   Creat/open a testfile and write some data into it.
- *   This function returns 0.
- */
-static int setup1(void)
-{
-	char write_buf[] = "abc";
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO,
+				"open %s with O_WRONLY as %s failed",
+				tc->targetname, user);
+			return;
+		}
 
-	fd1 = open(TEST_FILE1, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd1 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE1, FILE_MODE);
-	}
+		break;
+	case X_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has execute access, attempt to execute the executable
+		 * file, if successful, access() behaviour is correct.
+		 */
+		sprintf(command, "./%s", tc->targetname);
 
-	/* write some data into testfile */
-	if (write(fd1, write_buf, strlen(write_buf)) != strlen(write_buf)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "write(%s) failed in setup1", TEST_FILE1);
-	}
+		TEST(system(command));
 
-	return 0;
-}
+		if (TEST_RETURN != 0) {
+			tst_res(TFAIL | TTERRNO, "execute %s as %s failed",
+				tc->targetname, user);
+			return;
+		}
 
-/*
- * setup2() - Setup function to test the functionality of access() for
- *	      the access mode argument W_OK.
- *
- *   Creat/open a testfile for writing under temporary directory.
- *   This function returns 0.
- */
-static int setup2(void)
-{
-	fd2 = open(TEST_FILE2, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd1 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE2, FILE_MODE);
+		break;
+	default:
+		break;
 	}
 
-	return 0;
+	tst_res(TPASS, "access(%s, %s) as %s behaviour is correct.",
+		tc->pathname, tc->name, user);
 }
 
-/*
- * setup3() - Setup function to test the functionality of access() for
- *	      the access mode argument X_OK.
- *
- *   Creat/open a testfile and provide execute permissions to it.
- *   This function returns 0.
- */
-static int setup3(void)
+static void verify_access(unsigned int n)
 {
-	int fd3;
-#ifdef UCLINUX
-	char exechead[] = "#!/bin/sh\n";
-#endif
-
-	fd3 = open(TEST_FILE3, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd3 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE3, FILE_MODE);
+	struct tcase *tc = &tcases[n];
+	pid_t pid;
+
+	/* test as root */
+	access_test(tc, "root");
+
+	/* test as nobody */
+	pid = SAFE_FORK();
+	if (pid) {
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		SAFE_SETUID(uid);
+		access_test(tc, "nobody");
 	}
-#ifdef UCLINUX
-	if (write(fd3, exechead, sizeof(exechead)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "write(%s) failed",
-			 TEST_FILE3);
-	}
-#endif
-
-	/* Close the test file created above */
-	if (close(fd3) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed",
-			 TEST_FILE3);
-	}
-
-	/* Set execute permission bits on the test file. */
-	if (chmod(TEST_FILE3, EXE_MODE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "chmod(%s, %#o) failed",
-			 TEST_FILE3, EXE_MODE);
-	}
-
-	return 0;
 }
 
-/*
- * setup4() - Setup function to test the functionality of access() for
- *	      symbolic link file.
- *
- *   Creat/open a temporary file and close it.
- *   Creat a symbolic link of temporary file.
- *   This function returns 0.
- */
-static int setup4(void)
+static void setup(void)
 {
-	fd4 = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd4 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEMP_FILE, FILE_MODE);
-	}
+	struct passwd *pw;
 
-	/* Creat a symbolic link for temporary file */
-	if (symlink(TEMP_FILE, SYM_FILE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "symlink(%s, %s) failed", TEMP_FILE, SYM_FILE);
-	}
+	pw = SAFE_GETPWNAM("nobody");
 
-	return 0;
-}
+	uid = pw->pw_uid;
 
-/*
- * access_verify(i) -
- *
- *	This function verify the accessibility of the
- *	the testfile with the one verified by access().
- */
-static int access_verify(int i)
-{
-	char write_buf[] = "abc";
-	char read_buf[BUFSIZ];
-	int rval;
+	SAFE_TOUCH(FNAME_R, 0444, NULL);
+	SAFE_TOUCH(FNAME_W, 0222, NULL);
+	SAFE_TOUCH(FNAME_X, 0555, NULL);
 
-	rval = 0;
-
-	switch (i) {
-	case 0:
-		/*
-		 * The specified file has read access.
-		 * Attempt to read some data from the testfile
-		 * and if successful, access() behaviour is
-		 * correct.
-		 */
-		rval = read(fd1, &read_buf, sizeof(read_buf));
-		if (rval == -1)
-			tst_resm(TFAIL | TERRNO, "read(%s) failed", TEST_FILE1);
-		break;
-	case 1:
-		/*
-		 * The specified file has write access.
-		 * Attempt to write some data to the testfile
-		 * and if successful, access() behaviour is correct.
-		 */
-		rval = write(fd2, write_buf, strlen(write_buf));
-		if (rval == -1)
-			tst_resm(TFAIL | TERRNO, "write(%s) failed",
-				 TEST_FILE2);
-		break;
-	case 2:
-		/*
-		 * The specified file has execute access.
-		 * Attempt to execute the specified executable
-		 * file, if successful, access() behaviour is correct.
-		 */
-		rval = system("./" TEST_FILE3);
-		if (rval != 0)
-			tst_resm(TFAIL, "Fail to execute the %s", TEST_FILE3);
-		break;
-	case 3:
-		/*
-		 * The file pointed to by symbolic link has
-		 * write access.
-		 * Attempt to write some data to this temporary file
-		 * pointed to by symlink. if successful, access() bahaviour
-		 * is correct.
-		 */
-		rval = write(fd4, write_buf, strlen(write_buf));
-		if (rval == -1)
-			tst_resm(TFAIL | TERRNO, "write(%s) failed", TEMP_FILE);
-		break;
-	default:
-		break;
-	}
-
-	return rval;
+	SAFE_SYMLINK(FNAME_R, SNAME_R);
+	SAFE_SYMLINK(FNAME_W, SNAME_W);
+	SAFE_SYMLINK(FNAME_X, SNAME_X);
 }
 
-static void cleanup(void)
-{
-	if (close(fd1) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEST_FILE1);
-	if (close(fd2) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEST_FILE2);
-	if (close(fd4) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEMP_FILE);
-
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.tid = "access02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test = verify_access,
+};
-- 
1.8.4.2



