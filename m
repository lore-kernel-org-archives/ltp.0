From: Li Wang <liwang@redhat.com>
Date: Thu,  4 Apr 2019 11:09:19 +0800
Subject: [LTP] [PATCH] hugeshmat04: fix long integer overflow on 32bit system
Message-ID: <20190404030919.32192-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix an obvious integer overflow when system(32bit) original nr_hugepages >= 512.

  --- Error log ---
  # grep -i hugepage /proc/meminfo
  HugePages_Total:     512
  HugePages_Free:      512
  HugePages_Rsvd:        0
  HugePages_Surp:        0
  Hugepagesize:       2048 kB

  # readelf -h hugeshmat04 |grep -i ELF
  ELF Header:
    Class:                             ELF32

  # ./hugeshmat04
  tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
  mem.c:814: INFO: set nr_hugepages to -1024
  mem.c:823: BROK: nr_hugepages = 512, but expect -1024
  mem.c:814: INFO: set nr_hugepages to 512
  -----------------

Reported-by: Zhonghua Hao <zhao@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index b4dea53d1..d375810cb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -99,7 +99,7 @@ static void setup(void)
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
+	hugepages = orig_hugepages + SIZE / hpage_size;
 	set_sys_tune("nr_hugepages", hugepages, 1);
 }
 
-- 
2.20.1

