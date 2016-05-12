From: Li Wang <liwang@redhat.com>
Date: Thu, 12 May 2016 16:49:49 +0800
Subject: [LTP] [PATCH 2/6] syscalls/madvise02: Convert to new test API
In-Reply-To: <1463042993-398-1-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
Message-ID: <1463042993-398-2-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 117 +++++++++++---------------
 1 file changed, 48 insertions(+), 69 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index b9eb77d..4cf61bf 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -48,20 +48,16 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_kvercmp.h"
+#include "tst_test.h"
 
 #define TEST_FILE "testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
-
 #define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
 
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(int expected_errno);
-
 static void test_addr_einval(void);
 static void test_advice_einval(void);
 #if !defined(UCLINUX)
@@ -92,73 +88,36 @@ static void (*test_func[])(void) = {
 	test_ebadf,
 };
 
-char *TCID = "madvise02";
-int TST_TOTAL = ARRAY_SIZE(test_func);
-
 static int fd;
 static struct stat st;
 static int pagesize;
 
-int main(int argc, char *argv[])
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*test_func[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static void setup(void)
 {
 	int i;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	fd = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0664);
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 
 	pagesize = getpagesize();
 
 	/* Writing 16 pages of random data into this file */
 	for (i = 0; i < (pagesize / 2); i++)
-		SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
+		SAFE_WRITE(1, fd, STR, sizeof(STR) - 1);
 
-	SAFE_FSTAT(cleanup, fd, &st);
-}
-
-static void cleanup(void)
-{
-	if (fd && close(fd) < 0)
-		tst_resm(TWARN | TERRNO, "close failed");
-
-	tst_rmdir();
+	SAFE_FSTAT(fd, &st);
 }
 
 static void check_and_print(int expected_errno)
 {
 	if (TEST_RETURN == -1) {
 		if (TEST_ERRNO == expected_errno)
-			tst_resm(TPASS | TTERRNO, "failed as expected");
+			tst_res(TPASS | TTERRNO, "failed as expected");
 		else
-			tst_resm(TFAIL | TTERRNO,
+			tst_res(TFAIL | TTERRNO,
 				 "failed unexpectedly; expected - %d : %s",
 				 expected_errno, strerror(expected_errno));
 	} else {
-		tst_resm(TFAIL, "madvise succeeded unexpectedly");
+		tst_res(TFAIL, "madvise succeeded unexpectedly");
 	}
 }
 
@@ -166,26 +125,26 @@ static void test_addr_einval(void)
 {
 	char *file;
 
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+	file = SAFE_MMAP(0, st.st_size, PROT_READ,
 					 MAP_SHARED, fd, 0);
 
 	TEST(madvise(file + 100, st.st_size, MADV_NORMAL));
 	check_and_print(EINVAL);
 
-	SAFE_MUNMAP(cleanup, file, st.st_size);
+	SAFE_MUNMAP(file, st.st_size);
 }
 
 static void test_advice_einval(void)
 {
 	char *file;
 
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+	file = SAFE_MMAP(0, st.st_size, PROT_READ,
 					 MAP_SHARED, fd, 0);
 
 	TEST(madvise(file, st.st_size, 1212));
 	check_and_print(EINVAL);
 
-	SAFE_MUNMAP(cleanup, file, st.st_size);
+	SAFE_MUNMAP(file, st.st_size);
 }
 
 #if !defined(UCLINUX)
@@ -193,16 +152,16 @@ static void test_lock_einval(void)
 {
 	char *file;
 
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+	file = SAFE_MMAP(0, st.st_size, PROT_READ,
 					 MAP_SHARED, fd, 0);
 
 	if (mlock(file, st.st_size) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "mlock failed");
+		tst_brk(TBROK | TERRNO, "mlock failed");
 
 	TEST(madvise(file, st.st_size, MADV_DONTNEED));
 	check_and_print(EINVAL);
 
-	SAFE_MUNMAP(cleanup, file, st.st_size);
+	SAFE_MUNMAP(file, st.st_size);
 }
 #endif /* if !defined(UCLINUX) */
 
@@ -212,18 +171,18 @@ static void test_mergeable_einval(void)
 	char *file;
 
 	if (access(KSM_SYS_DIR, F_OK) >= 0) {
-		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
+		tst_res(TCONF, "kernel configured with CONFIG_KSM, "
 				 "skip EINVAL test for MADV_MERGEABLE.");
 		return;
 	}
 
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
-					 MAP_SHARED, fd, 0);
+	file = SAFE_MMAP(0, st.st_size, PROT_READ,
+				 MAP_SHARED, fd, 0);
 
 	TEST(madvise(file, st.st_size, MADV_MERGEABLE));
 	check_and_print(EINVAL);
 
-	SAFE_MUNMAP(cleanup, file, st.st_size);
+	SAFE_MUNMAP(file, st.st_size);
 }
 #endif
 
@@ -233,18 +192,18 @@ static void test_unmergeable_einval(void)
 	char *file;
 
 	if (access(KSM_SYS_DIR, F_OK) >= 0) {
-		tst_resm(TCONF, "kernel configured with CONFIG_KSM, "
+		tst_res(TCONF, "kernel configured with CONFIG_KSM, "
 				 "skip EINVAL test for MADV_UNMERGEABLE.");
 		return;
 	}
 
-	file = SAFE_MMAP(cleanup, 0, st.st_size, PROT_READ,
+	file = SAFE_MMAP(0, st.st_size, PROT_READ,
 					 MAP_SHARED, fd, 0);
 
 	TEST(madvise(file, st.st_size, MADV_UNMERGEABLE));
 	check_and_print(EINVAL);
 
-	SAFE_MUNMAP(cleanup, file, st.st_size);
+	SAFE_MUNMAP(file, st.st_size);
 }
 #endif
 
@@ -254,10 +213,10 @@ static void test_enomem(void)
 	char *high;
 	unsigned long len;
 
-	low = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
+	low = SAFE_MMAP(0, st.st_size / 2, PROT_READ,
 					MAP_SHARED, fd, 0);
 
-	high = SAFE_MMAP(cleanup, 0, st.st_size / 2, PROT_READ,
+	high = SAFE_MMAP(0, st.st_size / 2, PROT_READ,
 					 MAP_SHARED, fd, st.st_size / 2);
 
 	/* Swap if necessary to make low < high */
@@ -270,12 +229,12 @@ static void test_enomem(void)
 
 	len = (high - low) + pagesize;
 
-	SAFE_MUNMAP(cleanup, high, st.st_size / 2);
+	SAFE_MUNMAP(high, st.st_size / 2);
 
 	TEST(madvise(low, len, MADV_NORMAL));
 	check_and_print(ENOMEM);
 
-	SAFE_MUNMAP(cleanup, low, st.st_size / 2);
+	SAFE_MUNMAP(low, st.st_size / 2);
 }
 
 static void test_ebadf(void)
@@ -302,9 +261,29 @@ static void test_ebadf(void)
 	 * prefretch.
 	 */
 	} else {
-		tst_resm(TPASS, "madvise succeeded as expected, see "
+		tst_res(TPASS, "madvise succeeded as expected, see "
 				"kernel commit 1998cc0 for details.");
 	}
 
 	free(ptr_memory_allocated);
 }
+
+static void verify_madvise(unsigned int i)
+{
+	(*test_func[i])();
+}
+
+static void cleanup(void)
+{
+	if (fd && close(fd) < 0)
+		tst_res(TWARN | TERRNO, "close failed");
+}
+
+static struct tst_test test = {
+	.tid = "madvise02",
+	.tcnt = ARRAY_SIZE(test_func),
+	.test = verify_madvise,
+	.needs_tmpdir = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
1.8.3.1

