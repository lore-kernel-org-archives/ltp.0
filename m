From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 19 May 2021 10:19:16 -0300
Subject: [LTP] [PATCH] mtest06/mmap1: Further limit distant mmap size
Message-ID: <20210519131916.314184-1-cascardo@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Though on recent kernels (starting with 5.2, commit
8c7829b04c523cdc732cb77f59f03320e09f3386 ("mm: fix false-positive
OVERCOMMIT_GUESS failures"), overcommit accounting allows for allocating up
to MemTotal memory, older kernels have a much more complicated overcommit
guess accounting.

That leads to mmap failing on small enough systems:

mmap1.c:205: TBROK: mmap((nil),2088370176,3,34,-1,0) failed: ENOMEM (12)

Allocating only half of the total memory would generally work on test
systems.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 56588e1ebaff..10c47c35cb02 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -186,7 +186,7 @@ static void setup(void)
 {
 	struct sigaction sigptr;
 	size_t distant_mmap_size;
-	long mem_total;
+	size_t mem_total;
 
 	page_sz = getpagesize();
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
@@ -195,7 +195,7 @@ static void setup(void)
 #ifdef TST_ABI32
 	distant_mmap_size = 256*1024*1024;
 #else
-	distant_mmap_size = (mem_total > 2 * GIGABYTE) ? 2 * GIGABYTE : mem_total;
+	distant_mmap_size = (mem_total > 4 * GIGABYTE) ? 2 * GIGABYTE : mem_total / 2;
 #endif
 	/*
 	 * Used as hint for mmap thread, so it doesn't interfere
-- 
2.30.2

