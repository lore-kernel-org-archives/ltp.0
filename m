From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Fri, 12 Oct 2018 11:00:08 +0800
Subject: [LTP] [PATCH] fallocate04: continues after failure of front test
Message-ID: <20181012030008.GA26983@hptatwork>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When run this case, a failure of test02 will prevent test03, test04, ...
to be run. This patch replace tst_brk() with tst_res() and return after
a failure in each sub-cases.
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 74 +++++++++++++++--------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index e576d728d..afb4cd107 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -96,9 +96,12 @@ static void test01(void)
 	tst_res(TINFO, "allocate '%zu' bytes", buf_size);
 
 	if (fallocate(fd, 0, 0, buf_size) == -1) {
-		if (errno == ENOSYS || errno == EOPNOTSUPP)
-			tst_brk(TCONF, "fallocate() not supported");
-		tst_brk(TFAIL | TERRNO, "fallocate() failed");
+		if (errno == ENOSYS || errno == EOPNOTSUPP) {
+			tst_res(TCONF, "fallocate() not supported");
+			return;
+		}
+		tst_res(TFAIL | TERRNO, "fallocate() failed");
+		return;
 	}
 
 	char buf[buf_size];
@@ -118,17 +121,20 @@ static void test02(void)
 	tst_res(TINFO, "make a hole with FALLOC_FL_PUNCH_HOLE");
 
 	if (tst_kvercmp(2, 6, 38) < 0) {
-		tst_brk(TCONF,
+		tst_res(TCONF,
 			"FALLOC_FL_PUNCH_HOLE needs Linux 2.6.38 or newer");
+		return;
 	}
 
 	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 	    block_size, block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF,
+			tst_res(TCONF,
 			        "FALLOC_FL_PUNCH_HOLE not supported");
+			return;
 		}
-		tst_brk(TFAIL | TERRNO, "fallocate() failed");
+		tst_res(TFAIL | TERRNO, "fallocate() failed");
+		return;
 	}
 
 	tst_res(TINFO, "check that file has a hole with lseek(,,SEEK_HOLE)");
@@ -137,14 +143,15 @@ static void test02(void)
 	if (ret != (ssize_t)block_size) {
 		/* exclude error when kernel doesn't have SEEK_HOLE support */
 		if (errno != EINVAL) {
-			tst_brk(TFAIL | TERRNO,
+			tst_res(TFAIL | TERRNO,
 				 "fallocate() or lseek() failed");
+			return;
 		}
 		if (tst_kvercmp(3, 1, 0) < 0) {
 			tst_res(TINFO, "lseek() doesn't support SEEK_HOLE, "
 				 "this is expected for < 3.1 kernels");
 		} else {
-			tst_brk(TBROK | TERRNO,
+			tst_res(TBROK | TERRNO,
 				 "lseek() doesn't support SEEK_HOLE");
 		}
 	} else {
@@ -155,8 +162,10 @@ static void test02(void)
 
 	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
-	if ((alloc_size0 - block_size) != alloc_size1)
-		tst_brk(TFAIL, "not expected allocated size");
+	if ((alloc_size0 - block_size) != alloc_size1) {
+		tst_res(TFAIL, "not expected allocated size");
+		return;
+	}
 
 	char exp_buf[buf_size];
 
@@ -173,8 +182,9 @@ static void test03(void)
 	tst_res(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
 
 	if (tst_kvercmp(3, 15, 0) < 0) {
-		tst_brk(TCONF,
+		tst_res(TCONF,
 			"FALLOC_FL_ZERO_RANGE needs Linux 3.15 or newer");
+		return;
 	}
 
 	size_t alloc_size0 = get_allocsize();
@@ -184,10 +194,12 @@ static void test03(void)
 	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size - 1,
 	    block_size + 2) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF,
+			tst_res(TCONF,
 			        "FALLOC_FL_ZERO_RANGE not supported");
+			return;
 		}
-		tst_brk(TFAIL | TERRNO, "fallocate failed");
+		tst_res(TFAIL | TERRNO, "fallocate failed");
+		return;
 	}
 
 	/* The file hole in the specified range must be allocated and
@@ -197,8 +209,10 @@ static void test03(void)
 
 	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
-	if ((alloc_size0 + block_size) != alloc_size1)
-		tst_brk(TFAIL, "not expected allocated size");
+	if ((alloc_size0 + block_size) != alloc_size1) {
+		tst_res(TFAIL, "not expected allocated size");
+		return;
+	}
 
 	char exp_buf[buf_size];
 
@@ -221,18 +235,22 @@ static void test04(void)
 	if (fallocate(fd, FALLOC_FL_COLLAPSE_RANGE, block_size,
 	    block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF,
+			tst_res(TCONF,
 			        "FALLOC_FL_COLLAPSE_RANGE not supported");
+			return;
 		}
-		tst_brk(TFAIL | TERRNO, "fallocate failed");
+		tst_res(TFAIL | TERRNO, "fallocate failed");
+		return;
 	}
 
 	size_t alloc_size1 = get_allocsize();
 
 	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
-	if ((alloc_size0 - block_size) != alloc_size1)
-		tst_brk(TFAIL, "not expected allocated size");
+	if ((alloc_size0 - block_size) != alloc_size1) {
+		tst_res(TFAIL, "not expected allocated size");
+		return;
+	}
 
 	size_t size = buf_size - block_size;
 	char tmp_buf[buf_size];
@@ -261,22 +279,28 @@ static void test05(void)
 	if (fallocate(fd, FALLOC_FL_INSERT_RANGE, block_size,
 	    block_size) == -1) {
 		if (errno == EOPNOTSUPP) {
-			tst_brk(TCONF,
+			tst_res(TCONF,
 				"FALLOC_FL_INSERT_RANGE not supported");
+			return;
 		}
-		tst_brk(TFAIL | TERRNO, "fallocate failed");
+		tst_res(TFAIL | TERRNO, "fallocate failed");
+		return;
 	}
 
 	/* allocate space and ensure that it filled with zeroes */
-	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size, block_size) == -1)
-		tst_brk(TFAIL | TERRNO, "fallocate failed");
+	if (fallocate(fd, FALLOC_FL_ZERO_RANGE, block_size, block_size) == -1) {
+		tst_res(TFAIL | TERRNO, "fallocate failed");
+		return;
+	}
 
 	size_t alloc_size1 = get_allocsize();
 
 	tst_res(TINFO, "allocated file size before '%zu' and after '%zu'",
 		 alloc_size0, alloc_size1);
-	if ((alloc_size0 + block_size) != alloc_size1)
-		tst_brk(TFAIL, "not expected allocated size");
+	if ((alloc_size0 + block_size) != alloc_size1) {
+		tst_res(TFAIL, "not expected allocated size");
+		return;
+	}
 
 	char exp_buf[buf_size];
 
-- 
2.14.4

