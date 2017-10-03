From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:48 +0200
Subject: [LTP] [COMMITTED] [PATCH 01/13] Make use of SAFE_CREAT()
Message-ID: <20171003154100.807-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/vma/vma03.c                |  5 ++---
 testcases/kernel/syscalls/chroot/chroot03.c     |  4 +---
 testcases/kernel/syscalls/creat/creat01.c       |  5 +----
 testcases/kernel/syscalls/fork/fork09.c         |  5 +----
 testcases/kernel/syscalls/fork/fork10.c         |  7 ++-----
 testcases/kernel/syscalls/getxattr/getxattr01.c |  6 ++----
 testcases/kernel/syscalls/getxattr/getxattr02.c |  5 ++---
 testcases/kernel/syscalls/getxattr/getxattr03.c |  5 ++---
 testcases/kernel/syscalls/open/open07.c         |  8 ++------
 testcases/kernel/syscalls/open/open08.c         |  4 +---
 testcases/kernel/syscalls/open/open11.c         |  6 ++----
 testcases/kernel/syscalls/sendfile/sendfile08.c |  5 ++---
 testcases/kernel/syscalls/setxattr/setxattr01.c | 10 +++-------
 testcases/kernel/syscalls/setxattr/setxattr02.c |  9 ++-------
 testcases/kernel/syscalls/setxattr/setxattr03.c | 15 ++++-----------
 15 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index edad9f403..1db16eab1 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -49,6 +49,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "tst_kernel.h"
 
 char *TCID = "vma03";
@@ -131,9 +132,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	fd = creat(TESTFILE, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "creat %s", TESTFILE);
+	fd = SAFE_CREAT(NULL, TESTFILE, 0644);
 	close(fd);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
index de247b61c..b904e4ac9 100644
--- a/testcases/kernel/syscalls/chroot/chroot03.c
+++ b/testcases/kernel/syscalls/chroot/chroot03.c
@@ -143,9 +143,7 @@ static void setup(void)
 	 * ENOTDIR if the argument is not a directory.
 	 */
 	(void)sprintf(fname, "tfile_%d", getpid());
-	fd = creat(fname, 0777);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "Failed to creat a temp file");
+	fd = SAFE_CREAT(cleanup, fname, 0777);
 
 #if !defined(UCLINUX)
 	bad_addr = mmap(0, 1, PROT_NONE,
diff --git a/testcases/kernel/syscalls/creat/creat01.c b/testcases/kernel/syscalls/creat/creat01.c
index 6b70be292..5d0ffc6a7 100644
--- a/testcases/kernel/syscalls/creat/creat01.c
+++ b/testcases/kernel/syscalls/creat/creat01.c
@@ -53,10 +53,7 @@ static void verify_creat(unsigned int i)
 	struct stat buf;
 	char c;
 
-	fd = creat(filename, tcases[i].mode);
-
-	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "creat() failed");
+	fd = SAFE_CREAT(filename, tcases[i].mode);
 
 	SAFE_STAT(filename, &buf);
 
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index dedc8a41c..32bad89b3 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -84,10 +84,7 @@ int main(int ac, char **av)
 
 		/* establish first free file */
 		sprintf(filname, "fork09.%d", mypid);
-		first = creat(filname, 0660);
-		if (first == -1)
-			tst_brkm(TBROK, cleanup, "Cannot open first file %s, "
-				 "errno = %d", filname, errno);
+		first = SAFE_CREAT(cleanup, filname, 0660);
 		close(first);
 
 		tst_resm(TINFO, "first file descriptor is %d ", first);
diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 381ce6716..13db0555d 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -45,6 +45,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "fork10";
 int TST_TOTAL = 1;
@@ -72,11 +73,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		fildes = creat(fnamebuf, 0600);
-		if (fildes < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "Parent: cannot open %s for " "write",
-				 fnamebuf);
+		fildes = SAFE_CREAT(cleanup, fnamebuf, 0600);
 		write(fildes, "ABCDEFGHIJKLMNOPQRSTUVWXYZ\n", 27);
 		close(fildes);
 
diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c b/testcases/kernel/syscalls/getxattr/getxattr01.c
index 8c09aa8a9..be410a536 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr01.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
@@ -48,6 +48,7 @@
 # include <sys/xattr.h>
 #endif
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getxattr01";
 
@@ -142,10 +143,7 @@ static void setup(void)
 
 	/* Create test file and setup initial xattr */
 	snprintf(filename, BUFSIZ, "getxattr01testfile");
-	fd = creat(filename, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 filename);
+	fd = SAFE_CREAT(cleanup, filename, 0644);
 	close(fd);
 	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
 		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
index df75fb360..dca6b13be 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr02.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
@@ -54,6 +54,7 @@
 # include <sys/xattr.h>
 #endif
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getxattr02";
 
@@ -126,9 +127,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Test for xattr support */
-	fd = creat("testfile", 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
+	fd = SAFE_CREAT(cleanup, "testfile", 0644);
 	close(fd);
 	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
 		if (errno == ENOTSUP)
diff --git a/testcases/kernel/syscalls/getxattr/getxattr03.c b/testcases/kernel/syscalls/getxattr/getxattr03.c
index 06c993415..b6ea14287 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr03.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr03.c
@@ -42,6 +42,7 @@
 # include <sys/xattr.h>
 #endif
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getxattr03";
 
@@ -88,9 +89,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Test for xattr support and set attr value */
-	fd = creat(TESTFILE, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", TESTFILE);
+	fd = SAFE_CREAT(cleanup, TESTFILE, 0644);
 	close(fd);
 
 	if (setxattr(TESTFILE, XATTR_TEST_KEY, XATTR_TEST_VALUE,
diff --git a/testcases/kernel/syscalls/open/open07.c b/testcases/kernel/syscalls/open/open07.c
index b941f4b81..f36db00cb 100644
--- a/testcases/kernel/syscalls/open/open07.c
+++ b/testcases/kernel/syscalls/open/open07.c
@@ -163,9 +163,7 @@ static void setupfunc_test1(void)
 
 	sprintf(file1, "open03.1.%d", getpid());
 	sprintf(file2, "open03.2.%d", getpid());
-	fd1 = creat(file1, 00700);
-	if (fd1 < 0)
-		tst_brkm(TBROK, cleanup, "creat(2) failed: errno: %d", errno);
+	fd1 = SAFE_CREAT(cleanup, file1, 00700);
 
 	SAFE_SYMLINK(cleanup, file1, file2);
 
@@ -192,9 +190,7 @@ static void setupfunc_test3(void)
 	sprintf(file1, "open03.5.%d", getpid());
 	sprintf(file2, "open03.6.%d", getpid());
 	sprintf(file3, "open03.7.%d", getpid());
-	fd2 = creat(file1, 00700);
-	if (fd2 < 0)
-		tst_brkm(TBROK, cleanup, "creat(2) failed: errno: %d", errno);
+	fd2 = SAFE_CREAT(cleanup, file1, 00700);
 
 	SAFE_SYMLINK(cleanup, file1, file2);
 
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 6d1f37de0..d55d8e6bd 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -148,9 +148,7 @@ static void setup(void)
 
 	sprintf(filename, "open3.%d", getpid());
 
-	fildes = creat(filename, 0600);
-	if (fildes == -1)
-		tst_brkm(TBROK, cleanup, "Can't creat %s", filename);
+	fildes = SAFE_CREAT(cleanup, filename, 0600);
 
 	close(fildes);
 
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 6a3b0b8b1..c9239c6b4 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -74,6 +74,7 @@
 #include <string.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "open11";
 
@@ -382,10 +383,7 @@ static void setup(void)
 	}
 	close(fd);
 
-	fd = creat(T_REG_EMPTY, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed",
-			 T_REG_EMPTY);
+	fd = SAFE_CREAT(cleanup, T_REG_EMPTY, 0644);
 	close(fd);
 
 	ret = link(T_REG, T_LINK_REG);
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index 21b25868d..3212ca7cc 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -34,6 +34,7 @@
 #include <string.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define TEST_MSG_IN "world"
 #define TEST_MSG_OUT "hello"
@@ -101,9 +102,7 @@ static void setup(void)
 
 	tst_tmpdir();
 
-	in_fd = creat(in_file, 0700);
-	if (in_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", in_file);
+	in_fd = SAFE_CREAT(cleanup, in_file, 0700);
 
 	ret = write(in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
 	if (ret == -1)
diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 478f99408..359991e3f 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -58,6 +58,7 @@
 # include <sys/xattr.h>
 #endif
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setxattr01";
 
@@ -184,9 +185,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Test for xattr support */
-	fd = creat("testfile", 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
+	fd = SAFE_CREAT(cleanup, "testfile", 0644);
 	close(fd);
 	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
 		if (errno == ENOTSUP)
@@ -195,10 +194,7 @@ static void setup(void)
 
 	/* Create test file */
 	snprintf(filename, BUFSIZ, "setxattr01testfile");
-	fd = creat(filename, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 filename);
+	fd = SAFE_CREAT(cleanup, filename, 0644);
 	close(fd);
 
 	/* Prepare test cases */
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index b16ddce94..6d39236a3 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -187,9 +187,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Test for xattr support */
-	fd = creat("testfile", 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
+	fd = SAFE_CREAT(cleanup, "testfile", 0644);
 	close(fd);
 	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
 		if (errno == ENOTSUP)
@@ -198,10 +196,7 @@ static void setup(void)
 	unlink("testfile");
 
 	/* Create test files */
-	fd = creat(FILENAME, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 FILENAME);
+	fd = SAFE_CREAT(cleanup, FILENAME, 0644);
 	close(fd);
 
 	SAFE_MKDIR(cleanup, DIRNAME, 0644);
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index c09211eeb..a2f6cbf36 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -50,6 +50,7 @@
 #include <linux/fs.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "setxattr03";
 
@@ -167,9 +168,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Test for xattr support */
-	fd = creat("testfile", 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
+	fd = SAFE_CREAT(cleanup, "testfile", 0644);
 	close(fd);
 	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
 		if (errno == ENOTSUP)
@@ -178,18 +177,12 @@ static void setup(void)
 	unlink("testfile");
 
 	/* Create test files and set file immutable or append-only */
-	immu_fd = creat(IMMU_FILE, 0644);
-	if (immu_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 IMMU_FILE);
+	immu_fd = SAFE_CREAT(cleanup, IMMU_FILE, 0644);
 	if (set_immutable_on(immu_fd))
 		tst_brkm(TBROK | TERRNO, cleanup, "Set %s immutable failed",
 			 IMMU_FILE);
 
-	append_fd = creat(APPEND_FILE, 0644);
-	if (append_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
-			 APPEND_FILE);
+	append_fd = SAFE_CREAT(cleanup, APPEND_FILE, 0644);
 	if (set_append_on(append_fd))
 		tst_brkm(TBROK | TERRNO, cleanup, "Set %s append-only failed",
 			 APPEND_FILE);
-- 
2.13.5

