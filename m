From: Leo Yu-Chi Liang <ycliang@andestech.com>
Date: Wed, 20 Jan 2021 15:00:53 +0800
Subject: [LTP] [PATCH 1/1] fzsync: Add sched_yield for single core machine
Message-ID: <20210120070053.11490-1-ycliang@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fuzzy sync library uses spin waiting mechanism
to implement thread barrier behavior, which would
cause this test to be time-consuming on single core machine.

Fix this by adding sched_yield in the spin waiting loop,
so that the thread yields cpu as soon as it enters the waiting loop.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 include/tst_fuzzy_sync.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 4141f5c64..64d172681 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -59,9 +59,11 @@
  * @sa tst_fzsync_pair
  */
 
+#include <sys/sysinfo.h>
 #include <sys/time.h>
 #include <time.h>
 #include <math.h>
+#include <sched.h>
 #include <stdlib.h>
 #include <pthread.h>
 #include "tst_atomic.h"
@@ -564,6 +566,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		       && tst_atomic_load(our_cntr) < INT_MAX) {
 			if (spins)
 				(*spins)++;
+			if(get_nprocs() == 1)
+				sched_yield();
 		}
 
 		tst_atomic_store(0, other_cntr);
@@ -581,6 +585,8 @@ static inline void tst_fzsync_pair_wait(int *our_cntr,
 		while (tst_atomic_load(our_cntr) < tst_atomic_load(other_cntr)) {
 			if (spins)
 				(*spins)++;
+			if(get_nprocs() == 1)
+				sched_yield();
 		}
 	}
 }
-- 
2.17.0

