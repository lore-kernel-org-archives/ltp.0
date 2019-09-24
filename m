From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Sep 2019 18:58:01 +0800
Subject: [LTP] [PATCH v3] fzsync: revoke thread_b if parent hits an
 accidental break
Message-ID: <20190924105801.7616-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We shouldn't rely entirely on the pair->exit flag in tst_fzsync_pair_cleanup()
since there is possible to call tst_brk() at anyplace of thread_a, that will
lead to timeout eventually because of thread_b(tst_fzsync_wait_b) fall into
an infinite(no explicit condition to exit) loop.

Thread_a path trace:
  tst_brk()
    cleanup()
      tst_fzsync_pair_cleanup()
        SAFE_PTHREAD_JOIN(pair->thread_b, NULL)
        #Or pthread_cancel(pair->thread_b)

We fix the problem via a way to kill thread_b with pthread_cancel.

Work-around: [commit 2e74d996: Check recvmmsg exists before entering fuzzy loop]
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    Patch V2: http://lists.linux.it/pipermail/ltp/2019-January/010489.html
    Patch V1: http://lists.linux.it/pipermail/ltp/2019-January/010438.html

 include/tst_fuzzy_sync.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index f9a1947c7..152f779cb 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -63,6 +63,7 @@
 #include <time.h>
 #include <math.h>
 #include <stdlib.h>
+#include <pthread.h>
 #include "tst_atomic.h"
 #include "tst_timer.h"
 #include "tst_safe_pthread.h"
@@ -218,9 +219,13 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
 	if (pair->thread_b) {
-		tst_atomic_store(1, &pair->exit);
-		SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
-		pair->thread_b = 0;
+		if (pair->exit == 1) {
+			SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
+			pair->thread_b = 0;
+		} else {
+			pthread_cancel(pair->thread_b);
+			pair->thread_b = 0;
+		}
 	}
 }
 
@@ -271,8 +276,11 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	pair->a_cntr = 0;
 	pair->b_cntr = 0;
 	pair->exit = 0;
-	if (run_b)
+	if (run_b) {
+		pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+		pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
 		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
+	}
 
 	pair->exec_time_start = (float)tst_timeout_remaining();
 }
-- 
2.20.1

