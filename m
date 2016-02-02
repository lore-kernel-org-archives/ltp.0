From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2016 13:14:34 +0300
Subject: [LTP] [PATCH] syscalls/fchmodat: fix test,
	don't use test current directory
Message-ID: <1454408074-3149-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* use tmp directory for the test files,
* remove hard-coded tmp directory path,
* test fails with more than one iteration - cleanup after
  each iteration,
* make use of safe macros.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/fchmodat/fchmodat01.c |   83 +++++++++-------------
 1 files changed, 34 insertions(+), 49 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 19e9ad5..e9753e1 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -43,6 +43,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
 #define TEST_CASES 6
@@ -55,12 +56,11 @@ void setup_every_copy();
 
 char *TCID = "fchmodat01";
 int TST_TOTAL = TEST_CASES;
-char pathname[256] = "";
-char testfile[256] = "";
-char testfile2[256] = "";
-char testfile3[256] = "";
-int dirfd, fd, ret;
-int fds[TEST_CASES];
+char pathname[256];
+char testfile[256];
+char testfile2[256];
+char testfile3[256];
+int fds[TEST_CASES], tst_fds[4];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
 
@@ -73,6 +73,7 @@ int main(int ac, char **av)
 {
 	int lc;
 	int i;
+	size_t k;
 
 	/* Disable test if the version of the kernel is less than 2.6.16 */
 	if ((tst_kvercmp(2, 6, 16)) < 0) {
@@ -104,6 +105,12 @@ int main(int ac, char **av)
 			}
 		}
 
+		for (k = 0; k < ARRAY_SIZE(tst_fds); ++k)
+			SAFE_CLOSE(cleanup, tst_fds[k]);
+
+		SAFE_UNLINK(cleanup, testfile);
+		SAFE_UNLINK(cleanup, testfile3);
+		SAFE_RMDIR(cleanup, pathname);
 	}
 
 	cleanup();
@@ -112,45 +119,15 @@ int main(int ac, char **av)
 
 void setup_every_copy(void)
 {
-	/* Initialize test dir and file names */
-	sprintf(pathname, "fchmodattestdir%d", getpid());
-	sprintf(testfile, "fchmodattestfile%d.txt", getpid());
-	sprintf(testfile2, "/tmp/fchmodattestfile%d.txt", getpid());
-	sprintf(testfile3, "fchmodattestdir%d/fchmodattestfile%d.txt", getpid(),
-		getpid());
-
-	ret = mkdir(pathname, 0700);
-	if (ret < 0) {
-		perror("mkdir: ");
-		exit(-1);
-	}
-
-	dirfd = open(pathname, O_DIRECTORY);
-	if (dirfd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
-
-	fd = open(testfile, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
-
-	fd = open(testfile2, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	SAFE_MKDIR(cleanup, pathname, 0700);
 
-	fd = open(testfile3, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	tst_fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
+	tst_fds[1] = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
+	tst_fds[2] = SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	tst_fds[3] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
-	fds[0] = fds[1] = fds[4] = dirfd;
-	fds[2] = fd;
+	fds[0] = fds[1] = fds[4] = tst_fds[0];
+	fds[2] = tst_fds[3];
 	fds[3] = 100;
 	fds[5] = AT_FDCWD;
 
@@ -161,17 +138,25 @@ void setup_every_copy(void)
 
 void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+	tst_tmpdir();
+
+	/* Initialize test dir and file names */
+	char *abs_path = tst_get_tmpdir();
+	int p = getpid();
+
+	sprintf(pathname, "fchmodattestdir%d", p);
+	sprintf(testfile, "fchmodattest%d.txt", p);
+	sprintf(testfile2, "%s/fchmodattest%d.txt", abs_path, p);
+	sprintf(testfile3, "fchmodattestdir%d/fchmodattest%d.txt", p, p);
+
+	free(abs_path);
+
 	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
-	close(fd);
-	unlink(testfile);
-	unlink(testfile2);
-	unlink(testfile3);
-	rmdir(pathname);
+	tst_rmdir();
 }
-- 
1.7.1

