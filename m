From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Aug 2017 16:33:09 +0200
Subject: [LTP] [PATCH 1/2] [COMMITTED] syscalls/mmap12: Convert to the new
	library
Message-ID: <20170817143310.11634-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/mmap/mmap12.c | 103 +++++++++++---------------------
 1 file changed, 36 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 2b9c8664e..32cbe4431 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -40,57 +40,17 @@
 #include <sys/mman.h>
 #include <sys/shm.h>
 
-#include "test.h"
+#include "tst_test.h"
 
 #define TEMPFILE        "mmapfile"
 #define PATHLEN         256
 #define MMAPSIZE        (1UL<<20)
 
-char *TCID = "mmap12";
-int TST_TOTAL = 1;
-
 static int fildes;
 static char *addr;
 
-static int page_check(void);
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_POPULATE, fildes, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		if (page_check())
-			tst_resm(TFAIL, "Not all pages are present");
-		else
-			tst_resm(TPASS, "Functionality of mmap() "
-						"successful");
-		if (munmap(addr, MMAPSIZE) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-	}
-
-	cleanup();
-	tst_exit();
-}
-
 static int page_check(void)
 {
-	int ret;
 	int i = 1;
 	int flag = 0;
 	int pm;
@@ -110,28 +70,26 @@ static int page_check(void)
 	pm = open("/proc/self/pagemap", O_RDONLY);
 	if (pm == -1) {
 		if ((errno == EPERM) && (geteuid() != 0)) {
-			tst_brkm(TCONF | TERRNO, NULL,
+			tst_brk(TCONF | TERRNO,
 				"don't have permission to open dev pagemap");
 		} else {
-			tst_brkm(TFAIL | TERRNO, NULL,
-				"Open dev pagemap failed");
+			tst_brk(TFAIL | TERRNO, "pen dev pagemap failed");
 		}
 	}
 
-	offset = lseek(pm, index, SEEK_SET);
+	offset = SAFE_LSEEK(pm, index, SEEK_SET);
 	if (offset != index)
-		tst_brkm(TFAIL | TERRNO, NULL, "Reposition offset failed");
+		tst_brk(TFAIL | TERRNO, "Reposition offset failed");
 
 	while (i <= num_pages) {
-		ret = read(pm, &pagemap, sizeof(uint64_t));
-		if (ret < 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "Read pagemap failed");
+		SAFE_READ(1, pm, &pagemap, sizeof(uint64_t));
+
 		/*
 		 * Check if the page is present.
 		 */
 		if (!(pagemap & (1ULL<<63))) {
-			tst_resm(TINFO, "The %dth page addressed at %lX is not "
-					"present", i, vmstart + i * page_sz);
+			tst_res(TINFO, "The %dth page addressed@%lX is not "
+				       "present", i, vmstart + i * page_sz);
 			flag = 1;
 		}
 
@@ -146,30 +104,41 @@ static int page_check(void)
 	return 0;
 }
 
-static void setup(void)
+void verify_mmap(void)
 {
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	if ((tst_kvercmp(2, 6, 25)) < 0)
-		tst_brkm(TCONF, NULL,
-			"This test can only run on kernels that are 2.6.25 and "
-			"higher");
+	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_POPULATE, fildes, 0);
 
-	TEST_PAUSE;
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
+		return;
+	}
 
-	tst_tmpdir();
+	if (page_check())
+		tst_res(TFAIL, "Not all pages are present");
+	else
+		tst_res(TPASS, "Functionality of mmap() successful");
 
-	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0766);
-	if (fildes < 0)
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
+	SAFE_MUNMAP(addr, MMAPSIZE);
+}
 
-	if (ftruncate(fildes, MMAPSIZE) < 0)
-		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate file failed");
+static void setup(void)
+{
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0766);
 
+	SAFE_FTRUNCATE(fildes, MMAPSIZE);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	tst_rmdir();
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_mmap,
+	.needs_tmpdir = 1,
+	.min_kver = "2.6.25",
+};
-- 
2.13.0

