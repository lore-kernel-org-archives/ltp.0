From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Wed, 30 Dec 2020 19:36:15 +0300
Subject: [LTP] [PATCH v1] mem/mtest06: mmap1: Limit distant mmap size
Message-ID: <20201230163615.318-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Limit the distant mmap size by a total memory value.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 9d3e9d097..18c4e67e2 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -32,11 +32,7 @@
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
-#ifdef TST_ABI32
-#  define DISTANT_MMAP_SIZE (256*1024*1024)
-#else
-#  define DISTANT_MMAP_SIZE (2L*1024*1024*1024)
-#endif
+#define GIGABYTE (1L*1024*1024*1024)
 #define TEST_FILENAME "ashfile"
 
 /* seconds remaining before reaching timeout */
@@ -189,17 +185,26 @@ int mkfile(int size)
 static void setup(void)
 {
 	struct sigaction sigptr;
+	size_t distant_mmap_size;
+	long mem_total;
 
 	page_sz = getpagesize();
+	mem_total = SAFE_READ_MEMINFO("MemTotal:");
+	mem_total *= 1024;
 
+#ifdef TST_ABI32
+	distant_mmap_size = 256*1024*1024;
+#else
+	distant_mmap_size = (mem_total > 2 * GIGABYTE) ? 2 * GIGABYTE : mem_total;
+#endif
 	/*
 	 * Used as hint for mmap thread, so it doesn't interfere
 	 * with other potential (temporary) mappings from libc
 	 */
-	distant_area = SAFE_MMAP(0, DISTANT_MMAP_SIZE, PROT_WRITE | PROT_READ,
+	distant_area = SAFE_MMAP(0, distant_mmap_size, PROT_WRITE | PROT_READ,
 			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	SAFE_MUNMAP(distant_area, (size_t)DISTANT_MMAP_SIZE);
-	distant_area += DISTANT_MMAP_SIZE / 2;
+	SAFE_MUNMAP(distant_area, distant_mmap_size);
+	distant_area += distant_mmap_size / 2;
 
 	if (tst_parse_float(str_exec_time, &exec_time, 0, FLT_MAX)) {
 		tst_brk(TBROK, "Invalid number for exec_time '%s'",
-- 
2.26.2

