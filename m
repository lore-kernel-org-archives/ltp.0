From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 6 Nov 2015 06:33:02 +0000
Subject: [LTP] [PATCH] sched_getattr/sched_getattr02: Add some message to
	describe the case
Message-ID: <1446791582-214212-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add some message to describe the testcase

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 .../syscalls/sched_getattr/sched_getattr02.c       |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
index c5201c5..5db9942 100644
--- a/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
+++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -11,6 +11,14 @@
  * the GNU General Public License for more details.
  */
 
+ /* Description:
+ *   Verify that:
+ *              1) sched_getattr fails with unused pid
+ *              2) sched_getattr fails with invalid address
+ *              3) sched_getattr fails with invalid value
+ *              4) sched_getattr fails with invalid flag
+ */
+
 #define _GNU_SOURCE
 
 #include <unistd.h>
-- 
1.6.0.2

