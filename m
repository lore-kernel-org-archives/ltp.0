From: Li Wang <liwang@redhat.com>
Date: Thu,  5 Dec 2019 18:33:42 +0800
Subject: [LTP] [PATCH v2 2/2] pkey01: disable hugetlb test if failed to
 reserve hugepage
In-Reply-To: <20191205103342.5980-1-liwang@redhat.com>
References: <20191205103342.5980-1-liwang@redhat.com>
Message-ID: <20191205103342.5980-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To handle the false positive:
  pkey01.c:69: BROK: nr_hugepages = 0, but expect 1

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/pkeys/pkey01.c | 27 ++++++------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index fa84e71f3..929be4e7c 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -36,12 +36,6 @@
 #define PATH_VM_NRHPS "/proc/sys/vm/nr_hugepages"
 
 static int size;
-static int no_hugepage;
-
-static const char * const save_restore[] = {
-	"?/proc/sys/vm/nr_hugepages",
-	NULL,
-};
 
 static struct tcase {
 	unsigned long flags;
@@ -56,21 +50,12 @@ static void setup(void)
 {
 	int i, fd;
 
-	if (access("/sys/kernel/mm/hugepages/", F_OK)) {
-		tst_res(TINFO, "Huge page is not supported");
+	check_pkey_support();
+
+	if (tst_no_hugepage)
 		size = getpagesize();
-		no_hugepage = 1;
-	} else {
-		int val;
-		SAFE_FILE_PRINTF(PATH_VM_NRHPS, "%d", 1);
-		SAFE_FILE_SCANF(PATH_VM_NRHPS, "%d", &val);
-		if (val != 1)
-			tst_brk(TBROK, "nr_hugepages = %d, but expect %d",
-					val, 1);
+	else
 		size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
-	}
-
-	check_pkey_support();
 
 	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
 	for (i = 0; i < 128; i++)
@@ -147,7 +132,7 @@ static void pkey_test(struct tcase *tc, struct mmap_param *mpa)
 	int pkey, status;
 	int fd = mpa->fd;
 
-	if (no_hugepage && (mpa->flags & MAP_HUGETLB)) {
+	if (tst_no_hugepage && (mpa->flags & MAP_HUGETLB)) {
 		tst_res(TINFO, "Skip test on (%s) buffer", flag_to_str(mpa->flags));
 		return;
 	}
@@ -236,5 +221,5 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test = verify_pkey,
 	.setup = setup,
-	.save_restore = save_restore,
+	.needs_hugepages = 1,
 };
-- 
2.20.1

