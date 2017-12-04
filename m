From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:48 +0000
Subject: [LTP] [PATCH v3 05/12] hugeshmctl02: Fix allocation size for odd
	number of hugepages
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-6-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

The test tries to allocate 2 * (half the number of available hugepages).
If we have odd number hugepages, the calculated allocation size is not
page-aligned and allocation fails.

e.g, (use -s option to trigger it manually)

$ hugeshmctl02 -s 7 -i 5
hugeshmctl02    0  TINFO  :  set nr_hugepages to 7
hugeshmctl02    1  TBROK  :  hugeshmctl02.c:153: shmget #2: errno=ENOMEM(12): Cannot allocate memory
hugeshmctl02    2  TBROK  :  hugeshmctl02.c:153: Remaining cases broken
hugeshmctl02    0  TINFO  :  set nr_hugepages to 0

Align the size to hugepage_size.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 8a3eee474..af2bf4a3a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -99,7 +99,7 @@ static void setup(void)
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
+	shm_size = hpage_size * (hugepages / 2);
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
 
-- 
2.15.0

