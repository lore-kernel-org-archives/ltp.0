From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 20 Jan 2016 17:02:41 +0300
Subject: [LTP] [PATCH] kernel/syscalls/open14: openat03: add new test-cases
Message-ID: <1453298561-7741-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* create multiple directories and related temporary files;

* create multiple directories and link files into them. Check
  that files permissions correspond to the ones specified with
  open()/openat().

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/open/open14.c     |  159 ++++++++++++++++++++++++--
 testcases/kernel/syscalls/openat/openat03.c |  160 ++++++++++++++++++++++++---
 2 files changed, 292 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index 839c898..0984bfd 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -21,6 +21,7 @@
 #define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
 
@@ -32,7 +33,7 @@
 #endif
 
 char *TCID = "open14";
-int TST_TOTAL = 1;
+int TST_TOTAL = 3;
 static char *test_dir;
 static ssize_t size;
 static const ssize_t blocks_num = 4;
@@ -79,28 +80,38 @@ static int dir_not_empty(void)
 	return ret;
 }
 
-void test01(void)
+static void create_file(char *dir_name, int *fd, int mode)
 {
-	int fd, i;
-
-	char path[PATH_MAX], tmp[PATH_MAX];
-
-	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
-
-	TEST(open(test_dir, O_TMPFILE | O_WRONLY | O_SYNC));
-	fd = TEST_RETURN;
-	if (fd == -1) {
+	TEST(open(dir_name, O_TMPFILE | O_RDWR, mode));
+	*fd = TEST_RETURN;
+	if (*fd == -1) {
 		if (TEST_ERRNO == EISDIR) {
 			tst_brkm(TCONF, cleanup,
 				"O_TMPFILE not supported");
 		}
-		tst_resm(TFAIL | TERRNO, "open() failed");
+		tst_brkm(TFAIL | TERRNO, cleanup, "open() failed");
 		return;
 	}
+}
+
+static void write_file(int fd)
+{
+	int i;
 
-	tst_resm(TINFO, "writing data to the file");
 	for (i = 0; i < blocks_num; ++i)
 		SAFE_WRITE(cleanup, 0, fd, buf, size);
+}
+
+void test01(void)
+{
+	int fd;
+	char path[PATH_MAX], tmp[PATH_MAX];
+
+	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
+	create_file(test_dir, &fd, 0600);
+
+	tst_resm(TINFO, "writing data to the file");
+	write_file(fd);
 
 	SAFE_FSTAT(cleanup, fd, &st);
 	tst_resm(TINFO, "file size is '%zu'", st.st_size);
@@ -135,6 +146,126 @@ void test01(void)
 	tst_resm(TPASS, "test succeeded");
 }
 
+static void read_file(int fd)
+{
+	int i;
+	char tmp[size];
+
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+
+	for (i = 0; i < blocks_num; ++i) {
+		SAFE_READ(cleanup, 0, fd, tmp, size);
+		if (strncmp(buf, tmp, size))
+			tst_brkm(TBROK, cleanup, "got unexepected data");
+	}
+}
+
+static void test02(void)
+{
+	const int files_num = 100;
+	int i, fd[files_num];
+	char path[PATH_MAX];
+
+	tst_resm(TINFO, "create files in multiple directories");
+	for (i = 0; i < files_num; ++i) {
+		snprintf(path, PATH_MAX, "tst02_%d", i);
+		SAFE_MKDIR(cleanup, path, 0700);
+		SAFE_CHDIR(cleanup, path);
+		SAFE_GETCWD(cleanup, path, PATH_MAX);
+		create_file(path, fd + i, 0600);
+		write_file(fd[i]);
+	}
+
+	tst_resm(TINFO, "removing test directories");
+	for (i = files_num - 1; i >= 0; --i) {
+		SAFE_CHDIR(cleanup, "../");
+		snprintf(path, PATH_MAX, "tst02_%d", i);
+		SAFE_RMDIR(cleanup, path);
+	}
+
+	tst_resm(TINFO, "writing/reading temporary files");
+	for (i = 0; i < files_num; ++i) {
+		write_file(fd[i]);
+		read_file(fd[i]);
+	}
+
+	tst_resm(TINFO, "closing temporary files");
+	for (i = 0; i < files_num; ++i)
+		SAFE_CLOSE(cleanup, fd[i]);
+
+	tst_resm(TPASS, "test succeeded");
+}
+
+static void link_tmp_file(int fd)
+{
+	char path1[PATH_MAX], path2[PATH_MAX];
+
+	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
+	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
+
+	if (linkat(AT_FDCWD, path1, AT_FDCWD, path2, AT_SYMLINK_FOLLOW))
+		tst_brkm(TBROK | TERRNO, cleanup, "linkat() failed");
+}
+
+static const int tst_perm[] = { 0, 07777, 001, 0755, 0644, 0440 };
+
+static void test03(void)
+{
+	const int files_num = 100;
+	int i, fd[files_num];
+	char path[PATH_MAX];
+	struct stat st;
+	unsigned int j;
+	mode_t mask = umask(0);
+
+	umask(mask);
+
+	tst_resm(TINFO, "create multiple directories, link files into them");
+	tst_resm(TINFO, "and check file permissions");
+	for (i = 0, j = 0; i < files_num; ++i) {
+
+		snprintf(path, PATH_MAX, "tst03_%d", i);
+		SAFE_MKDIR(cleanup, path, 0700);
+		SAFE_CHDIR(cleanup, path);
+		SAFE_GETCWD(cleanup, path, PATH_MAX);
+
+		create_file(path, fd + i, tst_perm[j]);
+		write_file(fd[i]);
+		read_file(fd[i]);
+
+		link_tmp_file(fd[i]);
+
+		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
+
+		SAFE_LSTAT(cleanup, path, &st);
+
+		mode_t exp_mode = tst_perm[j] & ~mask;
+
+		if ((st.st_mode & ~S_IFMT) != exp_mode) {
+			tst_brkm(TFAIL, cleanup,
+				"file mode read %o, but expected %o",
+				st.st_mode & ~S_IFMT, exp_mode);
+		}
+
+		if (++j >= ARRAY_SIZE(tst_perm))
+			j = 0;
+	}
+
+	tst_resm(TINFO, "remove files, directories");
+	for (i = files_num - 1; i >= 0; --i) {
+		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
+		SAFE_UNLINK(cleanup, path);
+		SAFE_CLOSE(cleanup, fd[i]);
+
+		SAFE_CHDIR(cleanup, "..");
+
+		snprintf(path, PATH_MAX, "tst03_%d", i);
+		SAFE_RMDIR(cleanup, path);
+	}
+
+	tst_resm(TPASS, "test passed");
+}
+
 int main(int ac, char *av[])
 {
 	int lc;
@@ -146,6 +277,8 @@ int main(int ac, char *av[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		test01();
+		test02();
+		test03();
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index d81989e..ec1aef7 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -21,19 +21,19 @@
 #define _GNU_SOURCE
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 #include <fcntl.h>
 #include <errno.h>
 
 #include "test.h"
 #include "safe_macros.h"
-#include "openat.h"
 
 #ifndef O_TMPFILE
 #define O_TMPFILE	(020000000 | O_DIRECTORY)
 #endif
 
 char *TCID = "openat03";
-int TST_TOTAL = 1;
+int TST_TOTAL = 3;
 static char *test_dir;
 static ssize_t size;
 static const ssize_t blocks_num = 4;
@@ -80,28 +80,38 @@ static int dir_not_empty(void)
 	return ret;
 }
 
-void test01(void)
+static void create_file(char *dir_name, int *fd, int mode)
 {
-	int fd, i;
-
-	char path[PATH_MAX], tmp[PATH_MAX];
-
-	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
-
-	TEST(openat(AT_FDCWD, test_dir, O_TMPFILE | O_WRONLY | O_SYNC));
-	fd = TEST_RETURN;
-	if (fd == -1) {
+	TEST(openat(AT_FDCWD, dir_name, O_TMPFILE | O_RDWR, mode));
+	*fd = TEST_RETURN;
+	if (*fd == -1) {
 		if (TEST_ERRNO == EISDIR) {
 			tst_brkm(TCONF, cleanup,
 				"O_TMPFILE not supported");
 		}
-		tst_resm(TFAIL | TERRNO, "openat() failed");
+		tst_brkm(TFAIL | TERRNO, cleanup, "open() failed");
 		return;
 	}
+}
+
+static void write_file(int fd)
+{
+	int i;
 
-	tst_resm(TINFO, "writing data to the file");
 	for (i = 0; i < blocks_num; ++i)
 		SAFE_WRITE(cleanup, 0, fd, buf, size);
+}
+
+void test01(void)
+{
+	int fd;
+	char path[PATH_MAX], tmp[PATH_MAX];
+
+	tst_resm(TINFO, "creating a file with O_TMPFILE flag");
+	create_file(test_dir, &fd, 0600);
+
+	tst_resm(TINFO, "writing data to the file");
+	write_file(fd);
 
 	SAFE_FSTAT(cleanup, fd, &st);
 	tst_resm(TINFO, "file size is '%zu'", st.st_size);
@@ -136,6 +146,126 @@ void test01(void)
 	tst_resm(TPASS, "test succeeded");
 }
 
+static void read_file(int fd)
+{
+	int i;
+	char tmp[size];
+
+	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
+
+	for (i = 0; i < blocks_num; ++i) {
+		SAFE_READ(cleanup, 0, fd, tmp, size);
+		if (strncmp(buf, tmp, size))
+			tst_brkm(TBROK, cleanup, "got unexepected data");
+	}
+}
+
+static void test02(void)
+{
+	const int files_num = 100;
+	int i, fd[files_num];
+	char path[PATH_MAX];
+
+	tst_resm(TINFO, "create files in multiple directories");
+	for (i = 0; i < files_num; ++i) {
+		snprintf(path, PATH_MAX, "tst02_%d", i);
+		SAFE_MKDIR(cleanup, path, 0700);
+		SAFE_CHDIR(cleanup, path);
+		SAFE_GETCWD(cleanup, path, PATH_MAX);
+		create_file(path, fd + i, 0600);
+		write_file(fd[i]);
+	}
+
+	tst_resm(TINFO, "removing test directories");
+	for (i = files_num - 1; i >= 0; --i) {
+		SAFE_CHDIR(cleanup, "../");
+		snprintf(path, PATH_MAX, "tst02_%d", i);
+		SAFE_RMDIR(cleanup, path);
+	}
+
+	tst_resm(TINFO, "writing/reading temporary files");
+	for (i = 0; i < files_num; ++i) {
+		write_file(fd[i]);
+		read_file(fd[i]);
+	}
+
+	tst_resm(TINFO, "closing temporary files");
+	for (i = 0; i < files_num; ++i)
+		SAFE_CLOSE(cleanup, fd[i]);
+
+	tst_resm(TPASS, "test succeeded");
+}
+
+static void link_tmp_file(int fd)
+{
+	char path1[PATH_MAX], path2[PATH_MAX];
+
+	snprintf(path1, PATH_MAX,  "/proc/self/fd/%d", fd);
+	snprintf(path2, PATH_MAX,  "tmpfile_%d", fd);
+
+	if (linkat(AT_FDCWD, path1, AT_FDCWD, path2, AT_SYMLINK_FOLLOW))
+		tst_brkm(TBROK | TERRNO, cleanup, "linkat() failed");
+}
+
+static const int tst_perm[] = { 0, 07777, 001, 0755, 0644, 0440 };
+
+static void test03(void)
+{
+	const int files_num = 100;
+	int i, fd[files_num];
+	char path[PATH_MAX];
+	struct stat st;
+	unsigned int j;
+	mode_t mask = umask(0);
+
+	umask(mask);
+
+	tst_resm(TINFO, "create multiple directories, link files into them");
+	tst_resm(TINFO, "and check file permissions");
+	for (i = 0, j = 0; i < files_num; ++i) {
+
+		snprintf(path, PATH_MAX, "tst03_%d", i);
+		SAFE_MKDIR(cleanup, path, 0700);
+		SAFE_CHDIR(cleanup, path);
+		SAFE_GETCWD(cleanup, path, PATH_MAX);
+
+		create_file(path, fd + i, tst_perm[j]);
+		write_file(fd[i]);
+		read_file(fd[i]);
+
+		link_tmp_file(fd[i]);
+
+		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
+
+		SAFE_LSTAT(cleanup, path, &st);
+
+		mode_t exp_mode = tst_perm[j] & ~mask;
+
+		if ((st.st_mode & ~S_IFMT) != exp_mode) {
+			tst_brkm(TFAIL, cleanup,
+				"file mode read %o, but expected %o",
+				st.st_mode & ~S_IFMT, exp_mode);
+		}
+
+		if (++j >= ARRAY_SIZE(tst_perm))
+			j = 0;
+	}
+
+	tst_resm(TINFO, "remove files, directories");
+	for (i = files_num - 1; i >= 0; --i) {
+		snprintf(path, PATH_MAX, "tmpfile_%d", fd[i]);
+		SAFE_UNLINK(cleanup, path);
+		SAFE_CLOSE(cleanup, fd[i]);
+
+		SAFE_CHDIR(cleanup, "..");
+
+		snprintf(path, PATH_MAX, "tst03_%d", i);
+		SAFE_RMDIR(cleanup, path);
+	}
+
+	tst_resm(TPASS, "test passed");
+}
+
 int main(int ac, char *av[])
 {
 	int lc;
@@ -147,6 +277,8 @@ int main(int ac, char *av[])
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
 		tst_count = 0;
 		test01();
+		test02();
+		test03();
 	}
 
 	cleanup();
-- 
1.7.1

