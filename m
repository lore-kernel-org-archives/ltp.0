From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 22 Jun 2016 19:15:45 +0300
Subject: [LTP] [PATCH] syscalls/fallocate04: add 'FALLOC_FL_INSERT_RANGE'
	test-case
Message-ID: <1466612145-13233-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check that it can insert space in the middle of the file.
Verify new size and file's content. The flag is available
since Linux 4.1. Supported FS: XFS(4.1+) & ext4(4.2+).

Also fix test04() if number of blocks more than 3.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/fallocate/fallocate.h   |    4 ++
 testcases/kernel/syscalls/fallocate/fallocate04.c |   50 ++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h b/testcases/kernel/syscalls/fallocate/fallocate.h
index 1900aa0..5119988 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate.h
+++ b/testcases/kernel/syscalls/fallocate/fallocate.h
@@ -47,6 +47,10 @@
 #define FALLOC_FL_ZERO_RANGE 0x10
 #endif
 
+#ifndef FALLOC_FL_INSERT_RANGE
+#define FALLOC_FL_INSERT_RANGE 0x20
+#endif
+
 #if !defined(HAVE_FALLOCATE)
 static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 {
diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index 910d0fb..4a66376 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -35,7 +35,7 @@
 #include "fallocate.h"
 
 char *TCID = "fallocate04";
-int TST_TOTAL = 4;
+int TST_TOTAL = 5;
 
 static int fd;
 static const char fname[] = "fallocate04.txt";
@@ -266,7 +266,8 @@ static void test04(void)
 	fill_tst_buf(tmp_buf);
 
 	memcpy(exp_buf, tmp_buf, block_size);
-	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
+	memcpy(exp_buf + block_size, tmp_buf + 2 * block_size,
+	       buf_size - block_size * 2);
 
 	exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
 	check_file_data(exp_buf, size);
@@ -274,6 +275,50 @@ static void test04(void)
 	tst_resm(TPASS, "test-case succeeded");
 }
 
+static void test05(void)
+{
+	tst_resm(TINFO, "inserting space with FALLOC_FL_INSERT_RANGE");
+
+	size_t alloc_size0 = get_allocsize();
+
+	tst_resm(TINFO, "read current allocated file size '%zu'", alloc_size0);
+
+	if (fallocate(fd, FALLOC_FL_INSERT_RANGE, block_size,
+	    block_size) == -1) {
+		if (errno == EOPNOTSUPP) {
+			tst_brkm(TCONF, cleanup,
+			         "FALLOC_FL_INSERT_RANGE not supported");
+		}
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+	}
+
+	/* allocate space and ensure that it filled with zeroes */
+	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size, block_size) == -1)
+		tst_brkm(TFAIL | TERRNO, cleanup, "fallocate failed");
+
+	size_t alloc_size1 = get_allocsize();
+
+	tst_resm(TINFO, "allocated file size before '%zu' and after '%zu'",
+		 alloc_size0, alloc_size1);
+	if ((alloc_size0 + block_size) != alloc_size1)
+		tst_brkm(TFAIL, cleanup, "not expected allocated size");
+
+	size_t size = buf_size;
+	char tmp_buf[buf_size];
+	char exp_buf[size];
+
+	fill_tst_buf(tmp_buf);
+
+	memcpy(exp_buf, tmp_buf, block_size);
+	memcpy(exp_buf +  2 * block_size, tmp_buf + 2 * block_size,
+	       buf_size - block_size * 2);
+	memset(exp_buf + block_size - 1, 0, block_size + 2);
+
+	check_file_data(exp_buf, size);
+
+	tst_resm(TPASS, "test-case succeeded");
+}
+
 int main(int argc, char *argv[])
 {
 	int lc;
@@ -287,6 +332,7 @@ int main(int argc, char *argv[])
 		test02();
 		test03();
 		test04();
+		test05();
 	}
 
 	cleanup();
-- 
1.7.1

