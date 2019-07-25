From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 25 Jul 2019 13:01:54 +0800
Subject: [LTP] [PATCH v6 2/3] syscalls/copy_file_range01: add cross-device
 test
In-Reply-To: <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1564030915-3211-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Amir has relaxed cross-device constraint since commit[1], I think we can test it in
copy_file_range01.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dae222a5

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 .../copy_file_range/copy_file_range01.c       | 58 ++++++++++++++-----
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
index a5bd5e7f7..ec55e5da1 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
@@ -24,7 +24,16 @@
 
 static int page_size;
 static int errcount, numcopies;
-static int fd_in, fd_out;
+static int fd_in, fd_out, cross_sup;
+
+static struct tcase {
+	char    *path;
+	int     flags;
+	char    *message;
+} tcases[] = {
+	{FILE_DEST_PATH,  0, "non cross-device"},
+	{FILE_MNTED_PATH, 1, "cross-device"},
+};
 
 static int check_file_content(const char *fname1, const char *fname2,
 	loff_t *off1, loff_t *off2, size_t len)
@@ -90,7 +99,7 @@ static int check_file_offset(const char *m, int fd, loff_t len,
 	return ret;
 }
 
-static void test_one(size_t len, loff_t *off_in, loff_t *off_out)
+static void test_one(size_t len, loff_t *off_in, loff_t *off_out, char *path)
 {
 	int ret;
 	size_t to_copy = len;
@@ -131,7 +140,7 @@ static void test_one(size_t len, loff_t *off_in, loff_t *off_out)
 		to_copy -= TST_RET;
 	} while (to_copy > 0);
 
-	ret = check_file_content(FILE_SRC_PATH, FILE_DEST_PATH,
+	ret = check_file_content(FILE_SRC_PATH, path,
 		off_in, off_out, len);
 	if (ret) {
 		tst_res(TFAIL, "file contents do not match");
@@ -149,10 +158,10 @@ static void test_one(size_t len, loff_t *off_in, loff_t *off_out)
 	}
 }
 
-static void open_files(void)
+static void open_files(char *path)
 {
 	fd_in  = SAFE_OPEN(FILE_SRC_PATH, O_RDONLY);
-	fd_out = SAFE_OPEN(FILE_DEST_PATH, O_CREAT | O_WRONLY | O_TRUNC, 0644);
+	fd_out = SAFE_OPEN(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
 }
 
 static void close_files(void)
@@ -163,9 +172,16 @@ static void close_files(void)
 		SAFE_CLOSE(fd_in);
 }
 
-static void copy_file_range_verify(void)
+static void copy_file_range_verify(unsigned int n)
 {
 	int i, j, k;
+	struct tcase *tc = &tcases[n];
+
+	if (tc->flags && !cross_sup) {
+		tst_res(TCONF,
+			"copy_file_range doesn't support cross-device, skip it");
+		return;
+	}
 
 	errcount = numcopies = 0;
 	size_t len_arr[]	= {11, page_size-1, page_size, page_size+1};
@@ -182,33 +198,41 @@ static void copy_file_range_verify(void)
 	for (i = 0; i < (int)ARRAY_SIZE(len_arr); i++)
 		for (j = 0; j < num_offsets; j++)
 			for (k = 0; k < num_offsets; k++) {
-				open_files();
-				test_one(len_arr[i], off_arr[j], off_arr[k]);
+				open_files(tc->path);
+				test_one(len_arr[i], off_arr[j], off_arr[k], tc->path);
 				close_files();
 				numcopies++;
 			}
 
 	if (errcount == 0)
 		tst_res(TPASS,
-			"copy_file_range completed all %d copy jobs successfully!",
-			numcopies);
+			"%s copy_file_range completed all %d copy jobs successfully!",
+			tc->message, numcopies);
 	else
-		tst_res(TFAIL, "copy_file_range failed %d of %d copy jobs.",
-				errcount, numcopies);
+		tst_res(TFAIL, "%s copy_file_range failed %d of %d copy jobs.",
+			tc->message, errcount, numcopies);
 }
 
 static void setup(void)
 {
-	int i, fd;
+	int i, fd, fd_test;
 
 	syscall_info();
 
 	page_size = getpagesize();
-
+	cross_sup = 1;
 	fd = SAFE_OPEN(FILE_SRC_PATH, O_RDWR | O_CREAT, 0664);
 	/* Writing page_size * 4 of data into test file */
 	for (i = 0; i < (int)(page_size * 4); i++)
 		SAFE_WRITE(1, fd, CONTENT, CONTSIZE);
+
+	fd_test = SAFE_OPEN(FILE_MNTED_PATH, O_RDWR | O_CREAT, 0664);
+	TEST(sys_copy_file_range(fd, 0, fd_test, 0, CONTSIZE, 0));
+	if (TST_ERR == EXDEV)
+		cross_sup = 0;
+
+	SAFE_CLOSE(fd_test);
+	remove(FILE_MNTED_PATH);
 	SAFE_CLOSE(fd);
 }
 
@@ -220,7 +244,11 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
 	.needs_tmpdir = 1,
-	.test_all = copy_file_range_verify,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.test = copy_file_range_verify,
 	.test_variants = TEST_VARIANTS,
 };
-- 
2.18.1



