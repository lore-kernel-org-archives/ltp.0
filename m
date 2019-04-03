From: Xiao Liang <xiliang@redhat.com>
Date: Wed,  3 Apr 2019 15:59:35 +0800
Subject: [LTP] [PATCH] hugetlb/hugemmap01: dynamically change default
	hugepages
Message-ID: <20190403075935.8407-1-xiliang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the system's Hugepagesize is large(eg. 512MiB), the test may
break as cannot set nr_hugepages to default 128.

This patch checks the memory available and Hugepagesize registered
to set a reasonable num.

With this patch:
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
hugemmap01.c:99: INFO: max page available count is 54
mem.c:814: INFO: set nr_hugepages to 54
hugemmap01.c:73: PASS: call succeeded
mem.c:814: INFO: set nr_hugepages to 0

Without this patch:
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
mem.c:814: INFO: set nr_hugepages to 128
mem.c:823: BROK: nr_hugepages = 54, but expect 128
mem.c:814: INFO: set nr_hugepages to 0

Signed-off-by: Xiao Liang <xiliang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 4dc330dc0..ea2f42827 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -89,14 +89,26 @@ static void test_hugemmap(void)
 
 void setup(void)
 {
+	long page_sz = 0;
+	long mem_avail = 0;
+	long max_pages = 0;
+
+	page_sz = SAFE_READ_MEMINFO("Hugepagesize:");
+	mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
+	max_pages = mem_avail/page_sz;
+	tst_res(TINFO, "max page available count is %ld", max_pages);
+
 	save_nr_hugepages();
 
 	if (!Hopt)
 		Hopt = tst_get_tmpdir();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
-	if (nr_opt)
+	if (nr_opt) {
 		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
+	} else {
+		hugepages=(page_sz*hugepages>mem_avail)?max_pages:hugepages;
+	}
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
-- 
2.17.2

