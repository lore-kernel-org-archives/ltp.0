From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 Jul 2019 15:43:54 +0200
Subject: [LTP] [PATCH COMMITTED] mtest06/mmap1: add note about known rwsem
 issue on aarch64
Message-ID: <4577f24c6e0dffa93ef5911acb99b821aba29405.1564494005.git.jstancek@redhat.com>
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
index e16357e3c795..8d84a0bb76f3 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -17,6 +17,9 @@
  * Can trigger user-space stalls on aarch64:
  *   7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force flush")
  *   https://lore.kernel.org/linux-mm/1817839533.20996552.1557065445233.JavaMail.zimbra@redhat.com
+ * Can trigger "still mapped when deleted" BUG at mm/filemap.c:171, on aarch64 since 4.20
+ *   e1b98fa31664 ("locking/rwsem: Add missing ACQUIRE to read_slowpath exit when queue is empty")
+ *   99143f82a255 ("lcoking/rwsem: Add missing ACQUIRE to read_slowpath sleep loop")
  */
 #include <errno.h>
 #include <float.h>
-- 
1.8.3.1

