From: Li Wang <liwang@redhat.com>
Date: Thu, 12 May 2016 16:49:51 +0800
Subject: [LTP] [PATCH 4/6] syscalls/madvise04: Convert to new test API
In-Reply-To: <1463042993-398-3-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
Message-ID: <1463042993-398-4-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise04.c | 137 ++++++++++----------------
 1 file changed, 53 insertions(+), 84 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
index e89babc..07af2dc 100644
--- a/testcases/kernel/syscalls/madvise/madvise04.c
+++ b/testcases/kernel/syscalls/madvise/madvise04.c
@@ -27,112 +27,81 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 
-#include "test.h"
-
-char *TCID = "madvise04";
+#include "tst_test.h"
 
 #ifdef MADV_DONTDUMP
 
-int TST_TOTAL = 2;
-
 #define BUFFER_SIZE  256
 
-static void setup(void);
-static void cleanup(void);
-static void check_and_print(char *advice);
+static char filename[64];
+
+static void setup(void)
+{
+	sprintf(filename, "madvise04.%d", getpid());
+}
+
+static void check_and_print(char *advice)
+{
+	if (TEST_RETURN == -1) {
+		tst_res(TFAIL,
+			 "madvise test for %s failed with "
+			 "return = %ld, errno = %d : %s",
+			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
+	} else {
+		tst_res(TPASS, "madvise test for %s PASSED", advice);
+	}
+}
 
-int main(int argc, char *argv[])
+static void verify_madvise(void)
 {
-	int lc, fd;
-	int i;
+	int i, fd;
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
-			tst_brkm(TBROK, cleanup, "open failed");
+	fd = open(filename, O_RDWR | O_CREAT, 0664);
+	if (fd < 0)
+		tst_brk(TBROK, "open failed");
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
+	/* Writing 40 KB of random data into this file
+	   [32 * 1280 = 40960] */
+	for (i = 0; i < 1280; i++)
+		if (write(fd, str_for_file, strlen(str_for_file)) == -1)
+			tst_brk(TBROK | TERRNO, "write failed");
 
-		if (fstat(fd, &stat) == -1)
-			tst_brkm(TBROK, cleanup, "fstat failed");
+	if (fstat(fd, &stat) == -1)
+		tst_brk(TBROK, "fstat failed");
 
-		file = mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
-		if (file == MAP_FAILED)
-			tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
+	file = SAFE_MMAP(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0);
 
-		/* (1) Test case for MADV_DONTDUMP */
-		TEST(madvise(file, stat.st_size, MADV_DONTDUMP));
-		check_and_print("MADV_DONTDUMP");
+	/* (1) Test case for MADV_DONTDUMP */
+	TEST(madvise(file, stat.st_size, MADV_DONTDUMP));
+	check_and_print("MADV_DONTDUMP");
 
-		/* (2) Test case for MADV_DODUMP */
-		TEST(madvise(file, stat.st_size, MADV_DODUMP));
-		check_and_print("MADV_DODUMP");
+	/* (2) Test case for MADV_DODUMP */
+	TEST(madvise(file, stat.st_size, MADV_DODUMP));
+	check_and_print("MADV_DODUMP");
 
-		/* Finally Unmapping the whole file */
-		if (munmap(file, stat.st_size) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "munmap failed");
+	/* Finally Unmapping the whole file */
+	SAFE_MUNMAP(file, stat.st_size);
 
-		close(fd);
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-	tst_tmpdir();
+	close(fd);
 }
 
-static void cleanup(void)
-{
-	tst_rmdir();
-}
-
-static void check_and_print(char *advice)
-{
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL,
-			 "madvise test for %s failed with "
-			 "return = %ld, errno = %d : %s",
-			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
-	} else {
-		tst_resm(TPASS, "madvise test for %s PASSED", advice);
-	}
-}
+static struct tst_test test = {
+	.tid = "madvise04",
+	.test_all = verify_madvise,
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
 
 #else
-int main(void)
-{
-	/* Requires kernel version >= 3.4 */
-	tst_brkm(TCONF, NULL,
-		 "This system doesn't have required madvise support, "
-		 "MADV_DONTDUMP and MADV_DODUMP were added from 3.4. "
-		 "If your kernel version >= 3.4, maybe you need updating "
-		 "your glibc-headers");
-}
+/* Requires kernel version >= 3.4 */
+TST_TEST_TCONF("This system doesn't have required madvise support, "
+		"MADV_DONTDUMP and MADV_DODUMP were added from 3.4. "
+		"If your kernel version >= 3.4, maybe you need updating "
+		"your glibc-headers");
 #endif
-- 
1.8.3.1

