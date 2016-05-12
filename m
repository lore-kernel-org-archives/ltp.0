From: Li Wang <liwang@redhat.com>
Date: Thu, 12 May 2016 16:49:48 +0800
Subject: [LTP] [PATCH 1/6] syscalls/madvise01: Convert to new test API
Message-ID: <1463042993-398-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise01.c | 134 ++++++++++----------------
 1 file changed, 53 insertions(+), 81 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 4b1286d..53468dd 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -32,107 +32,79 @@
 #include <string.h>
 #include <unistd.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
+static char filename[64];
 
-char *TCID = "madvise01";
-int TST_TOTAL = 5;
+static void setup(void)
+{
+	sprintf(filename, "madvise01.%d", getpid());
+}
 
-int main(int argc, char *argv[])
+static void check_and_print(char *advice)
+{
+	if (TEST_RETURN == -1)
+		tst_res(TFAIL | TTERRNO, "madvise test for %s failed", advice);
+	else
+		tst_res(TPASS, "madvise test for %s PASSED", advice);
+}
+
+static void verify_madvise(void)
 {
-	int lc, fd;
 	int i = 0;
+	int fd;
 	char *file = NULL;
 	struct stat stat;
-	char filename[64];
-	char *progname = NULL;
 	char *str_for_file = "abcdefghijklmnopqrstuvwxyz12345\n";
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	progname = *argv;
-	sprintf(filename, "%s-out.%d", progname, getpid());
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0664);
-		if (fd < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = open(filename, O_RDWR | O_CREAT, 0664);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "open failed");
 #ifdef DEBUG
-		tst_resm(TINFO, "filename = %s opened successfully", filename);
+	tst_res(TINFO, "filename = %s opened successfully", filename);
 #endif
 
-		/* Writing 40 KB of random data into this file
-		   [32 * 1280 = 40960] */
-		for (i = 0; i < 1280; i++)
-			if (write(fd, str_for_file, strlen(str_for_file)) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "write failed");
-
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
-
-		/* Map the input file into memory */
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK, cleanup, "mmap failed");
+	/* Writing 40 KB of random data into this file
+	   [32 * 1280 = 40960] */
+	for (i = 0; i < 1280; i++)
+		if (write(fd, str_for_file, strlen(str_for_file)) == -1)
+			tst_brk(TBROK | TERRNO, "write failed");
 
-		/* (1) Test case for MADV_NORMAL */
-		TEST(madvise(file, stat.st_size, MADV_NORMAL));
-		check_and_print("MADV_NORMAL");
+	if (fstat(fd, &stat) == -1)
+		tst_brk(TBROK, "fstat failed");
 
-		/* (2) Test case for MADV_RANDOM */
-		TEST(madvise(file, stat.st_size, MADV_RANDOM));
-		check_and_print("MADV_RANDOM");
+	/* Map the input file into memory */
+	file = SAFE_MMAP(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
 
-		/* (3) Test case for MADV_SEQUENTIAL */
-		TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
-		check_and_print("MADV_SEQUENTIAL");
+	/* (1) Test case for MADV_NORMAL */
+	TEST(madvise(file, stat.st_size, MADV_NORMAL));
+	check_and_print("MADV_NORMAL");
 
-		/* (4) Test case for MADV_WILLNEED */
-		TEST(madvise(file, stat.st_size, MADV_WILLNEED));
-		check_and_print("MADV_WILLNEED");
+	/* (2) Test case for MADV_RANDOM */
+	TEST(madvise(file, stat.st_size, MADV_RANDOM));
+	check_and_print("MADV_RANDOM");
 
-		/* (5) Test case for MADV_DONTNEED */
-		TEST(madvise(file, stat.st_size, MADV_DONTNEED));
-		check_and_print("MADV_DONTNEED");
+	/* (3) Test case for MADV_SEQUENTIAL */
+	TEST(madvise(file, stat.st_size, MADV_SEQUENTIAL));
+	check_and_print("MADV_SEQUENTIAL");
 
-		if (munmap(file, stat.st_size) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
+	/* (4) Test case for MADV_WILLNEED */
+	TEST(madvise(file, stat.st_size, MADV_WILLNEED));
+	check_and_print("MADV_WILLNEED");
 
-		close(fd);
-	}
+	/* (5) Test case for MADV_DONTNEED */
+	TEST(madvise(file, stat.st_size, MADV_DONTNEED));
+	check_and_print("MADV_DONTNEED");
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
+	if (munmap(file, stat.st_size) == -1)
+		tst_brk(TBROK | TERRNO, "munmap failed");
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
+	close(fd);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-
-}
-
-static void check_and_print(char *advice)
-{
-	if (TEST_RETURN == -1)
-		tst_resm(TFAIL | TTERRNO, "madvise test for %s failed", advice);
-	else
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
-}
+static struct tst_test test = {
+	.tid = "madvise01",
+	.test_all = verify_madvise,
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
-- 
1.8.3.1

