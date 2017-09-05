From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:11 +0200
Subject: [LTP] [RFC] [PATCH 08/15] syscalls/fallocate04: Convert to the new
	library
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 169 ++++++++++------------
 1 file changed, 77 insertions(+), 92 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index a6729161c..4916c8b47 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -30,13 +30,9 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 #include "lapi/fallocate.h"
 
-char *TCID = "fallocate04";
-int TST_TOTAL = 5;
-
 static int fd;
 static const char fname[] = "fallocate04.txt";
 static size_t block_size;
@@ -44,28 +40,18 @@ static size_t buf_size;
 
 #define NUM_OF_BLOCKS	3
 
-static int verbose;
-static const option_t options[] = {
-	{"v", &verbose, NULL},
-	{NULL, NULL, NULL}
-};
-
-static void help(void)
-{
-	printf("  -v      Verbose\n");
-}
+static char *verbose;
 
 static void cleanup(void)
 {
-	close(fd);
-	tst_rmdir();
+	SAFE_CLOSE(fd);
 }
 
 static void get_blocksize(void)
 {
 	struct stat file_stat;
 
-	SAFE_FSTAT(cleanup, fd, &file_stat);
+	SAFE_FSTAT(fd, &file_stat);
 
 	block_size = file_stat.st_blksize;
 	buf_size = NUM_OF_BLOCKS * block_size;
@@ -77,7 +63,7 @@ static size_t get_allocsize(void)
 
 	fsync(fd);
 
-	SAFE_FSTAT(cleanup, fd, &file_stat);
+	SAFE_FSTAT(fd, &file_stat);
 
 	return file_stat.st_blocks * 512;
 }
@@ -93,9 +79,7 @@ static void fill_tst_buf(char buf[])
 
 static void setup(void)
 {
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
+	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
 	get_blocksize();
 }
@@ -104,86 +88,86 @@ static void check_file_data(const char exp_buf[], size_t size)
 {
 	char rbuf[size];
 
-	tst_resm(TINFO, "reading the file, compare with expected buffer");
+	tst_res(TINFO, "reading the file, compare with expected buffer");
 
-	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
-	SAFE_READ(cleanup, 1, fd, rbuf, size);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_READ(1, fd, rbuf, size);
 
 	if (memcmp(exp_buf, rbuf, size)) {
 		if (verbose) {
-			tst_resm_hexd(TINFO, exp_buf, size, "expected:");
-			tst_resm_hexd(TINFO, rbuf, size, "but read:");
+			tst_res_hexd(TINFO, exp_buf, size, "expected:");
+			tst_res_hexd(TINFO, rbuf, size, "but read:");
 		}
-		tst_brkm(TFAIL, cleanup, "not expected file data");
+		tst_brk(TFAIL, "not expected file data");
 	}
 }
 
 static void test01(void)
 {
-	tst_resm(TINFO, "allocate '%zu' bytes", buf_size);
+	tst_res(TINFO, "allocate '%zu' bytes", buf_size);
 
 	if (fallocate(fd, 0, 0, buf_size) == -1) {
 		if (errno == ENOSYS || errno == EOPNOTSUPP)
-			tst_brkm(TCONF, cleanup, "fallocate() not supported");
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
+			tst_brk(TCONF, "fallocate() not supported");
+		tst_brk(TFAIL | TERRNO, "fallocate() failed");
 	}
 
 	char buf[buf_size];
 
 	fill_tst_buf(buf);
 
-	SAFE_WRITE(cleanup, 1, fd, buf, buf_size);
+	SAFE_WRITE(1, fd, buf, buf_size);
 
-	tst_resm(TPASS, "test-case succeeded");
+	tst_res(TPASS, "test-case succeeded");
 }
 
 static void test02(void)
 {
 	size_t alloc_size0 = get_allocsize();
 
-	tst_resm(TINFO, "read allocated file size '%zu'", alloc_size0);
-	tst_resm(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
+	tst_res(TINFO, "read allocated file size '%zu'", alloc_size0);
+	tst_res(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
 
 	if (tst_kvercmp(2, 6, 38) < 0) {
-		tst_brkm(TCONF, cleanup,
-			 "FALLOC_FL_PUNCH_HOLE needs Linux 2.6.38 or newer");
+		tst_brk(TCONF,
+			"FALLOC_FL_PUNCH_HOLE needs Linux 2.6.38 or newer");
 	}
 
 	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 	    block_size, block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brkm(TCONF, cleanup,
-			         "FALLOC_FL_PUNCH_HOLE not supported");
+			tst_brk(TCONF,
+			        "FALLOC_FL_PUNCH_HOLE not supported");
 		}
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate() failed");
+		tst_brk(TFAIL | TERRNO, "fallocate() failed");
 	}
 
-	tst_resm(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
+	tst_res(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
 	off_t ret = lseek(fd, 0, SEEK_HOLE);
 
 	if (ret != (ssize_t)block_size) {
 		/* exclude error when kernel doesn't have SEEK_HOLE support */
 		if (errno != EINVAL) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
+			tst_brk(TFAIL | TERRNO,
 				 "fallocate() or lseek() failed");
 		}
 		if (tst_kvercmp(3, 1, 0) < 0) {
-			tst_resm(TINFO, "lseek() doesn't support SEEK_HOLE, "
+			tst_res(TINFO, "lseek() doesn't support SEEK_HOLE, "
 				 "this is expected for < 3.1 kernels");
 		} else {
-			tst_brkm(TBROK | TERRNO, cleanup,
+			tst_brk(TBROK | TERRNO,
 				 "lseek() doesn't support SEEK_HOLE");
 		}
 	} else {
-		tst_resm(TINFO, "found a hole at '%ld' offset", ret);
+		tst_res(TINFO, "found a hole@'%ld' offset", ret);
 	}
 
 	size_t alloc_size1 = get_allocsize();
 
-	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
 	if ((alloc_size0 - block_size) != alloc_size1)
-		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+		tst_brk(TFAIL, "not expected allocated size");
 
 	char exp_buf[buf_size];
 
@@ -192,29 +176,29 @@ static void test02(void)
 
 	check_file_data(exp_buf, buf_size);
 
-	tst_resm(TPASS, "test-case succeeded");
+	tst_res(TPASS, "test-case succeeded");
 }
 
 static void test03(void)
 {
-	tst_resm(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
+	tst_res(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
 
 	if (tst_kvercmp(3, 15, 0) < 0) {
-		tst_brkm(TCONF, cleanup,
-			 "FALLOC_FL_ZERO_RANGE needs Linux 3.15 or newer");
+		tst_brk(TCONF,
+			"FALLOC_FL_ZERO_RANGE needs Linux 3.15 or newer");
 	}
 
 	size_t alloc_size0 = get_allocsize();
 
-	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+	tst_res(TINFO, "read current allocated file size '%zu'", alloc_size0);
 
 	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size - 1,
 	    block_size + 2) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brkm(TCONF, cleanup,
-			         "FALLOC_FL_ZERO_RANGE not supported");
+			tst_brk(TCONF,
+			        "FALLOC_FL_ZERO_RANGE not supported");
 		}
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+		tst_brk(TFAIL | TERRNO, "fallocate failed");
 	}
 
 	/* The file hole in the specified range must be allocated and
@@ -222,10 +206,10 @@ static void test03(void)
 	 */
 	size_t alloc_size1 = get_allocsize();
 
-	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
 	if ((alloc_size0 + block_size) != alloc_size1)
-		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+		tst_brk(TFAIL, "not expected allocated size");
 
 	char exp_buf[buf_size];
 
@@ -234,32 +218,32 @@ static void test03(void)
 
 	check_file_data(exp_buf, buf_size);
 
-	tst_resm(TPASS, "test-case succeeded");
+	tst_res(TPASS, "test-case succeeded");
 }
 
 static void test04(void)
 {
-	tst_resm(TINFO, "collapsing file space with FALLOC_FL_COLLAPSE_RANGE");
+	tst_res(TINFO, "collapsing file space with FALLOC_FL_COLLAPSE_RANGE");
 
 	size_t alloc_size0 = get_allocsize();
 
-	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+	tst_res(TINFO, "read current allocated file size '%zu'", alloc_size0);
 
 	if (fallocate(fd, FALLOC_FL_COLLAPSE_RANGE, block_size,
 	    block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brkm(TCONF, cleanup,
-			         "FALLOC_FL_COLLAPSE_RANGE not supported");
+			tst_brk(TCONF,
+			        "FALLOC_FL_COLLAPSE_RANGE not supported");
 		}
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+		tst_brk(TFAIL | TERRNO, "fallocate failed");
 	}
 
 	size_t alloc_size1 = get_allocsize();
 
-	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
 	if ((alloc_size0 - block_size) != alloc_size1)
-		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+		tst_brk(TFAIL, "not expected allocated size");
 
 	size_t size = buf_size - block_size;
 	char tmp_buf[buf_size];
@@ -274,36 +258,36 @@ static void test04(void)
 	exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
 	check_file_data(exp_buf, size);
 
-	tst_resm(TPASS, "test-case succeeded");
+	tst_res(TPASS, "test-case succeeded");
 }
 
 static void test05(void)
 {
-	tst_resm(TINFO, "inserting space with FALLOC_FL_INSERT_RANGE");
+	tst_res(TINFO, "inserting space with FALLOC_FL_INSERT_RANGE");
 
 	size_t alloc_size0 = get_allocsize();
 
-	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+	tst_res(TINFO, "read current allocated file size '%zu'", alloc_size0);
 
 	if (fallocate(fd, FALLOC_FL_INSERT_RANGE, block_size,
 	    block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brkm(TCONF, cleanup,
-				 "FALLOC_FL_INSERT_RANGE not supported");
+			tst_brk(TCONF,
+				"FALLOC_FL_INSERT_RANGE not supported");
 		}
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+		tst_brk(TFAIL | TERRNO, "fallocate failed");
 	}
 
 	/* allocate space and ensure that it filled with zeroes */
 	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size, block_size) == -1)
-		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+		tst_brk(TFAIL | TERRNO, "fallocate failed");
 
 	size_t alloc_size1 = get_allocsize();
 
-	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
 	if ((alloc_size0 + block_size) != alloc_size1)
-		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+		tst_brk(TFAIL, "not expected allocated size");
 
 	char exp_buf[buf_size];
 
@@ -312,26 +296,27 @@ static void test05(void)
 
 	check_file_data(exp_buf, buf_size);
 
-	tst_resm(TPASS, "test-case succeeded");
+	tst_res(TPASS, "test-case succeeded");
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, help);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		test01();
-		test02();
-		test03();
-		test04();
-		test05();
-	}
+	test01();
+	test02();
+	test03();
+	test04();
+	test05();
+}
 
-	cleanup();
+static struct tst_option opts[] = {
+	{"v", &verbose, "-v       Turns on verbose mode"},
+	{NULL, NULL, NULL}
+};
 
-	tst_exit();
-}
+static struct tst_test test = {
+	.options = opts,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.13.0

