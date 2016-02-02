From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  2 Feb 2016 19:08:12 +0300
Subject: [LTP] [PATCH v2] syscalls/fchmodat: fix test,
	don't use test current directory
Message-ID: <1454429292-4804-1-git-send-email-alexey.kodanev@oracle.com>
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
v2: move setup_every_copy() to setup()

 testcases/kernel/syscalls/fchmodat/fchmodat01.c |   80 ++++++++---------------
 1 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index 19e9ad5..4a72c6f 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -43,6 +43,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "linux_syscall_numbers.h"
 
 #define TEST_CASES 6
@@ -55,11 +56,10 @@ void setup_every_copy();
 
 char *TCID = "fchmodat01";
 int TST_TOTAL = TEST_CASES;
-char pathname[256] = "";
-char testfile[256] = "";
-char testfile2[256] = "";
-char testfile3[256] = "";
-int dirfd, fd, ret;
+char pathname[256];
+char testfile[256];
+char testfile2[256];
+char testfile3[256];
 int fds[TEST_CASES];
 char *filenames[TEST_CASES];
 int expected_errno[TEST_CASES] = { 0, 0, ENOTDIR, EBADF, 0, 0 };
@@ -86,8 +86,6 @@ int main(int ac, char **av)
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		setup_every_copy();
-
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
@@ -103,7 +101,6 @@ int main(int ac, char **av)
 					 TEST_ERRNO, strerror(TEST_ERRNO));
 			}
 		}
-
 	}
 
 	cleanup();
@@ -112,66 +109,45 @@ int main(int ac, char **av)
 
 void setup_every_copy(void)
 {
+}
+
+void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	tst_tmpdir();
+
 	/* Initialize test dir and file names */
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
+	char *abs_path = tst_get_tmpdir();
+	int p = getpid();
 
-	dirfd = open(pathname, O_DIRECTORY);
-	if (dirfd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	sprintf(pathname, "fchmodattestdir%d", p);
+	sprintf(testfile, "fchmodattest%d.txt", p);
+	sprintf(testfile2, "%s/fchmodattest%d.txt", abs_path, p);
+	sprintf(testfile3, "fchmodattestdir%d/fchmodattest%d.txt", p, p);
 
-	fd = open(testfile, O_CREAT | O_RDWR, 0600);
-	if (fd < 0) {
-		perror("open: ");
-		exit(-1);
-	}
+	free(abs_path);
 
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
+	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
+	fds[1] = fds[4] = fds[0];
 
-	fds[0] = fds[1] = fds[4] = dirfd;
-	fds[2] = fd;
+	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
+	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+
+	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 	fds[3] = 100;
 	fds[5] = AT_FDCWD;
 
 	filenames[0] = filenames[2] = filenames[3] = filenames[4] = testfile;
 	filenames[1] = testfile2;
 	filenames[5] = testfile3;
-}
-
-void setup(void)
-{
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
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

