From: Li Wang <liwang@redhat.com>
Date: Mon, 25 May 2020 18:54:10 +0800
Subject: [LTP] [PATCH] hugemmap05: check if the reserving hpages as expected
Message-ID: <20200525105410.4328-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get rid of TBROK on small box:
  hugemmap05.c:88: BROK: mmap((nil),201326592,3,1,6,0) failed: ENOMEM (12)

And, reduce the reserved testing huge pages to 2, it also works well.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
---

Notes:
      I didn't remove the variable 'size' and 'length' because that could be
      used to reset testing hpages via parameter '-a xxx'
    
      # ./hugemmap05 -a 128

 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index d80a636c8..dee3ef685 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -57,9 +57,9 @@ static char path_sys_sz_huge[BUFSIZ];
 static unsigned long long shmmax;
 static char *path, *pathover;
 static int key = -1, shmid = -1, fd = -1;
-static int mounted, restore_shmmax, restore_nr_hgpgs, restore_overcomm_hgpgs;
-static long hugepagesize, nr_hugepages, nr_overcommit_hugepages;
-static long size = 128, length = 384;
+static int mounted, restore_shmmax, restore_overcomm_hgpgs;
+static long hugepagesize, nr_overcommit_hugepages;
+static long size = 2, length = 6;
 
 char *opt_sysfs;
 char *opt_alloc;
@@ -176,11 +176,6 @@ static void cleanup(void)
 	if (mounted)
 		tst_umount(MOUNT_DIR);
 
-	if (restore_nr_hgpgs) {
-		tst_res(TINFO, "restore nr_hugepages to %ld.", nr_hugepages);
-		SAFE_FILE_PRINTF(path, "%ld", nr_hugepages);
-	}
-
 	if (restore_shmmax)
 		SAFE_FILE_PRINTF(PATH_SHMMAX, "%llu", shmmax);
 
@@ -193,7 +188,9 @@ static void cleanup(void)
 
 static void setup(void)
 {
-	check_hugepage();
+	if (tst_hugepages != 2)
+		tst_brk(TCONF, "Not enough hugepages for testing!");
+
 	hugepagesize = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	init_sys_sz_paths();
 
@@ -219,12 +216,8 @@ static void setup(void)
 		}
 	}
 
-	SAFE_FILE_SCANF(path, "%ld", &nr_hugepages);
-	tst_res(TINFO, "original nr_hugepages is %ld", nr_hugepages);
-
 	/* Reset. */
 	SAFE_FILE_PRINTF(path, "%ld", size);
-	restore_nr_hgpgs = 1;
 
 	if (access(pathover, F_OK)) {
 		tst_brk(TCONF, "file %s does not exist in the system",
@@ -309,4 +302,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = test_overcommit,
+	.request_hugepages = 2,
 };
-- 
2.21.1

