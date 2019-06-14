From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 14 Jun 2019 22:54:02 +0200
Subject: [LTP] [PATCH 1/2] mtest06: tweak DISTANT_MMAP_SIZE
Message-ID: <67bee9aca637a86b8101b122d149094b50397553.1560545529.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allocating further away works as a better reproducer for:
  7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force flush")

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index b7b742653114..50d2dafbd952 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -12,8 +12,11 @@
  * between mmap/munmap worked, then its value must match expected
  * value.
  *
- * Can trigger panics/stalls since at least 4.14 on some arches. See:
+ * Can trigger panics/stalls since at least 4.14 on some arches:
  *   fc8efd2ddfed ("mm/memory.c: do_fault: avoid usage of stale vm_area_struct")
+ * Can trigger user-space stalls on aarch64:
+ *   7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force flush")
+ *   https://lore.kernel.org/linux-mm/1817839533.20996552.1557065445233.JavaMail.zimbra@redhat.com
  */
 #include <errno.h>
 #include <float.h>
@@ -25,7 +28,11 @@
 #include "tst_test.h"
 #include "tst_safe_pthread.h"
 
-#define DISTANT_MMAP_SIZE (64*1024*1024)
+#ifdef TST_ABI32
+#  define DISTANT_MMAP_SIZE (256*1024*1024)
+#else
+#  define DISTANT_MMAP_SIZE (2L*1024*1024*1024)
+#endif
 #define TEST_FILENAME "ashfile"
 
 /* seconds remaining before reaching timeout */
-- 
1.8.3.1

