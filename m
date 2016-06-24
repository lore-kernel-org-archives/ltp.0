From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Fri, 24 Jun 2016 16:08:03 +0800
Subject: [LTP] [PATCH] syscalls/access02: reconstruct and convert to new API
Message-ID: <1466755683-30036-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
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
 testcases/kernel/syscalls/access/access02.c | 396 ++++++++++------------------
 1 file changed, 141 insertions(+), 255 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access02.c b/testcases/kernel/syscalls/access/access02.c
index 56241d0..361b2e5 100644
--- a/testcases/kernel/syscalls/access/access02.c
+++ b/testcases/kernel/syscalls/access/access02.c
@@ -25,302 +25,188 @@
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
+#define FNAME_R	"accessfile_r"
+#define FNAME_W	"accessfile_w"
+#define FNAME_X	"accessfile_x"
+#define SYMLINK	"symlink"
+#define MODE_R	0444
+#define MODE_W	0222
+#define MODE_X	0555
+
+static uid_t uid;
+static int fds[3];
+
+static struct tcase {
+	const char *pathname;
+	int mode;
+	char *name;
+	int is_symlink;
+	const char *targetname;
+} tcases[] = {
+	{FNAME_R, R_OK, "R_OK", 0, ""},
+	{FNAME_W, W_OK, "W_OK", 0, ""},
+	{FNAME_X, X_OK, "X_OK", 0, ""},
+	{SYMLINK, R_OK, "R_OK", 1, FNAME_R},
+	{SYMLINK, W_OK, "W_OK", 1, FNAME_W},
+	{SYMLINK, X_OK, "X_OK", 1, FNAME_X}
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
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		for (i = 0; i < TST_TOTAL; i++) {
-			file_name = test_cases[i].pathname;
-			access_mode = test_cases[i].a_mode;
-
-			/*
-			 * Call access(2) to check the test file
-			 * for specified access mode permissions.
-			 */
-			TEST(access(file_name, access_mode));
+	char c, command[64];
+	const char *filename;
+
+	if (tc->is_symlink == 1) {
+		SAFE_SYMLINK(tc->targetname, tc->pathname);
+		filename = tc->targetname;
+	} else {
+		filename = tc->pathname;
+	}
 
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL | TTERRNO,
-					 "access(%s, %#o) failed",
-					 file_name, access_mode);
-				continue;
-			}
+	TEST(access(tc->pathname, tc->mode));
 
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
+	switch (tc->mode) {
+	case R_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has read access, attempt to read data from the file,
+		 * if successful, access() behaviour is correct.
+		 */
+		TEST(read(fds[0], &c, 1));
 
-static void setup(void)
-{
-	int i;
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO, "read %s as %s failed",
+				filename, user);
+			return;
+		}
 
-	tst_require_root();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+		break;
+	case W_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has write access, attempt to write data to the file,
+		 * if successful, access() behaviour is correct.
+		 */
+		TEST(write(fds[1], "A", 1));
 
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TINFO | TERRNO, NULL, "setuid failed");
+		if (TEST_RETURN == -1) {
+			tst_res(TFAIL | TTERRNO, "write %s as %s failed",
+				filename, user);
+			return;
+		}
 
-	TEST_PAUSE;
-	tst_tmpdir();
+		break;
+	case X_OK:
+		/*
+		 * The specified file(or pointed to by symbolic link)
+		 * has execute access, attempt to execute the executable
+		 * file, if successful, access() behaviour is correct.
+		 */
+		sprintf(command, "./%s", filename);
 
-	for (i = 0; i < TST_TOTAL; i++)
-		test_cases[i].setupfunc();
-}
+		TEST(system(command));
 
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
+		if (TEST_RETURN != 0) {
+			tst_res(TFAIL | TTERRNO, "execute %s as %s failed",
+				filename, user);
+			return;
+		}
 
-	fd1 = open(TEST_FILE1, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd1 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE1, FILE_MODE);
+		break;
+	default:
+		break;
 	}
 
-	/* write some data into testfile */
-	if (write(fd1, write_buf, strlen(write_buf)) != strlen(write_buf)) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "write(%s) failed in setup1", TEST_FILE1);
-	}
+	tst_res(TPASS, "access(%s, %s) as %s behaviour is correct.",
+		tc->pathname, tc->name, user);
 
-	return 0;
+	if (tc->is_symlink == 1)
+		SAFE_UNLINK(tc->pathname);
 }
 
-/*
- * setup2() - Setup function to test the functionality of access() for
- *	      the access mode argument W_OK.
- *
- *   Creat/open a testfile for writing under temporary directory.
- *   This function returns 0.
- */
-static int setup2(void)
+static void verify_access(unsigned int n)
 {
-	fd2 = open(TEST_FILE2, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd1 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE2, FILE_MODE);
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
-
-	return 0;
 }
 
-/*
- * setup3() - Setup function to test the functionality of access() for
- *	      the access mode argument X_OK.
- *
- *   Creat/open a testfile and provide execute permissions to it.
- *   This function returns 0.
- */
-static int setup3(void)
+static void setup(void)
 {
-	int fd3;
+	struct passwd *pw;
 #ifdef UCLINUX
 	char exechead[] = "#!/bin/sh\n";
 #endif
 
-	fd3 = open(TEST_FILE3, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd3 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEST_FILE3, FILE_MODE);
-	}
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
+	pw = SAFE_GETPWNAM("nobody");
 
-	return 0;
-}
+	uid = pw->pw_uid;
 
-/*
- * setup4() - Setup function to test the functionality of access() for
- *	      symbolic link file.
- *
- *   Creat/open a temporary file and close it.
- *   Creat a symbolic link of temporary file.
- *   This function returns 0.
- */
-static int setup4(void)
-{
-	fd4 = open(TEMP_FILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd4 == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TEMP_FILE, FILE_MODE);
-	}
-
-	/* Creat a symbolic link for temporary file */
-	if (symlink(TEMP_FILE, SYM_FILE) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "symlink(%s, %s) failed", TEMP_FILE, SYM_FILE);
-	}
-
-	return 0;
-}
-
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
+	fds[0] = SAFE_OPEN(FNAME_R, O_RDWR | O_CREAT, 0777);
+	fds[1] = SAFE_OPEN(FNAME_W, O_RDWR | O_CREAT, MODE_W);
+	fds[2] = SAFE_OPEN(FNAME_X, O_RDWR | O_CREAT, 0777);
 
-	rval = 0;
+	SAFE_WRITE(1, fds[0], "A", 1);
+#ifdef UCLINUX
+	SAFE_WRITE(1, fds[2], exechead, sizeof(exechead));
+#endif
 
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
+	SAFE_CLOSE(fds[2]);
+	fds[2] = 0;
 
-	return rval;
+	SAFE_CHMOD(FNAME_R, MODE_R);
+	SAFE_CHMOD(FNAME_X, MODE_X);
 }
 
 static void cleanup(void)
 {
-	if (close(fd1) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEST_FILE1);
-	if (close(fd2) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEST_FILE2);
-	if (close(fd4) == -1)
-		tst_brkm(TFAIL | TERRNO, NULL, "close(%s) failed", TEMP_FILE);
-
-	tst_rmdir();
+	if (fds[0] > 0 && close(fds[0]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fds[1] > 0 && close(fds[1]))
+		tst_res(TWARN | TERRNO, "failed to close file");
+	if (fds[2] > 0 && close(fds[2]))
+		tst_res(TWARN | TERRNO, "failed to close file");
 }
+
+static struct tst_test test = {
+	.tid = "access02",
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_access,
+};
-- 
1.8.4.2



