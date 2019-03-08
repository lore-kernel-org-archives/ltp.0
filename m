From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  8 Mar 2019 11:09:46 +0100
Subject: [LTP] [PATCH COMMITTED] mtest06/mmap1: add note about known
	panics/stalls on s390x
Message-ID: <197485f5586d355497da022fd264ab8d7f3ce0d1.1552039754.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 6e8269be02be..b7b742653114 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -11,6 +11,9 @@
  * hit SIGSEGV in between mmap/munmap it is a failure. If a read
  * between mmap/munmap worked, then its value must match expected
  * value.
+ *
+ * Can trigger panics/stalls since at least 4.14 on some arches. See:
+ *   fc8efd2ddfed ("mm/memory.c: do_fault: avoid usage of stale vm_area_struct")
  */
 #include <errno.h>
 #include <float.h>
-- 
1.8.3.1

