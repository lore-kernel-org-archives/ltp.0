From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Apr 2020 13:40:38 +0200
Subject: [LTP] [PATCH v2] hugetlb: check for requested huge pages first
In-Reply-To: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
References: <bc3c52ff5b97feefa4200c3d87002de5a61ee360.1587539566.git.jstancek@redhat.com>
Message-ID: <3529bb886952f26fa38095ce99ceef115f71cb18.1587554860.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/sys/kernel/mm/hugepages is not present when there are no
supported hugepage sizes. This is common for ppc64le KVM guests,
when hypervisor does not enable hugepages. Guest will boot with:
  hugetlbfs: disabling because there are no supported hugepage sizes

  # cat /proc/filesystems  | grep huge; echo $?
  1

Move the check up in setup to check it as first thing to avoid
running into TBROK on mount or set_sys_tune when hugetlbfs is
not available:
  safe_macros.c:766: BROK: hugemmap01.c:82: mount(none, /mnt/testarea/ltp-07Kg6lCOmm/Ai9D0M, hugetlbfs, 0, (nil)) failed: ENODEV (19)
  safe_macros.c:766: BROK: hugemmap02.c:129: mount(none, /mnt/testarea/ltp-07Kg6lCOmm/Cxf7A6, hugetlbfs, 0, (nil)) failed: ENODEV (19)
  safe_macros.c:766: BROK: hugemmap04.c:100: mount(none, /mnt/testarea/ltp-07Kg6lCOmm/kS60Mk, hugetlbfs, 0, (nil)) failed: ENODEV (19)
  safe_file_ops.c:219: BROK: Expected 1 conversions got 0 at hugemmap06.c:42
  safe_file_ops.c:155: BROK: The FILE '/proc/sys/vm/nr_hugepages' ended prematurely at mem.c:836
  safe_file_ops.c:219: BROK: Expected 1 conversions got 0 at hugeshmat05.c:39

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c   | 6 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c   | 6 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c   | 6 +++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c   | 2 +-
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 3 +++
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c | 6 +++---
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 891c42e4613c..d7ea6d87ae85 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -77,13 +77,13 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "No enough hugepages for testing.");
-
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index c0dbb60d659e..85f39c5d5829 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -124,13 +124,13 @@ static void test_hugemmap(void)
 
 static void setup(void)
 {
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "No enough hugepages for testing.");
-
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 5fcbe27891c6..7c8ed8a78975 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -95,13 +95,13 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing!");
+
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (tst_hugepages == 0)
-		tst_brk(TCONF, "No enough hugepages for testing!");
-
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
 }
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
index 93f9af7f3901..ab2ccc40b82d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c
@@ -39,9 +39,9 @@ struct mp {
 
 static void setup(void)
 {
-	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	if (tst_hugepages != test.request_hugepages)
 		tst_brk(TCONF, "System RAM is not enough to test.");
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }
 
 static void *thr(void *arg)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 0808496711fc..e9bb9fbf7b4b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -74,6 +74,9 @@ static void setup(void)
 {
 	long mem_total, hpage_size, orig_hugepages;
 
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index a30e1e3c3d3f..7152e3363acd 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -35,11 +35,11 @@ static long hpage_size;
 
 void setup(void)
 {
+	if (tst_hugepages != test.request_hugepages)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
 	page_size = getpagesize();
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
-
-	if (tst_hugepages != test.request_hugepages)
-		tst_brk(TCONF, "No enough hugepages for testing.");
 }
 
 void shm_test(int size)
-- 
2.18.1

