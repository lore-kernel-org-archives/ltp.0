From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 3 Aug 2021 16:26:06 +0800
Subject: [LTP] [PATCH] syscalls/madvise06: Add madvise WILLNEED performance
 problem tag
Message-ID: <1627979166-967-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running this case on 5.10-rc1 kernel, it will trigger the following failure
......
madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 1752 Kb
madvise06.c:208: TPASS: more than 102400 Kb were moved to the swap cache
madvise06.c:217: TINFO: PageFault(madvice / no mem access): 102400
madvise06.c:221: TINFO: PageFault(madvice / mem access): 105600
madvise06.c:82: TINFO: After page access
madvise06.c:84: TINFO:  Swap: 307540 Kb
madvise06.c:86: TINFO:  SwapCached: 100480 Kb
madvise06.c:88: TINFO:  Cached: 102056 Kb
madvise06.c:74: TINFO:  memory.current: 204636 Kb
madvise06.c:74: TINFO:  memory.swap.current: 411476 Kb
madvise06.c:74: TINFO:  memory.kmem.usage_in_bytes: 1752 Kb
madvise06.c:226: TFAIL: 3200 pages were faulted out of 2 max

It fails because of madvise WILLNEED performance problem, so add the introduced and
fixed commit.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 63d8d5452..f2f65ff96 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -35,6 +35,12 @@
  * faults. Two faults are allowed incase some tasklet or something
  * else unexpected, but irrelevant procedure, registers a fault to
  * our process.
+ *
+ * It also can reproduce the MADV_WILLNEED preformance problem.
+ * It was introduced since 5.9 kernel with the following commit
+ *   e6e88712e43b ("mm: optimise madvise WILLNEED")
+ * and fixed since 5.10-rc5 kernel with the following commit
+ *   66383800df9c ("mm: fix madvise WILLNEED performance problem").
  */
 
 #include <errno.h>
@@ -242,6 +248,8 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "55231e5c898c"},
 		{"linux-git", "8de15e920dc8"},
+		{"linux-git", "e6e88712e43b"},
+		{"linux-git", "66383800df9c"},
 		{}
 	}
 };
-- 
2.23.0

