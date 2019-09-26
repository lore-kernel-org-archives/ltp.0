From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Sep 2019 17:39:21 +0800
Subject: [LTP] [Patch v4.1] fzsync: revoke thread_b if parent hits
 accidental break
Message-ID: <20190926093921.21247-1-liwang@redhat.com>
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

We fix the problem via a way to kill thread_b with pthread_cancel. With new
thread wrapper involves enabling thread cancel at the start of the thread B,
then do asynchronous cancellation in tst_fzsync_pair_cleanup if pair->exit
is not being set to 1.

Workaround: [commit 2e74d996: Check recvmmsg exists before entering fuzzy loop]
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index f9a1947c7..c1d0b00f9 100644
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
@@ -218,12 +219,36 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
 	if (pair->thread_b) {
-		tst_atomic_store(1, &pair->exit);
+		/* Revoke thread B if parent hits accidental break */
+		if (!pair->exit) {
+			tst_atomic_store(1, &pair->exit);
+			usleep(100000);
+			pthread_cancel(pair->thread_b);
+		}
 		SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
 		pair->thread_b = 0;
 	}
 }
 
+/** To store the run_b pointer and pass to tst_fzsync_thread_wrapper */
+struct tst_fzsync_run_thread {
+	void *(*func)(void *);
+	void *arg;
+};
+
+/**
+ * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
+ * at the start of the thread B.
+ */
+static void *tst_fzsync_thread_wrapper(void *run_thread)
+{
+       struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)run_thread;
+
+       pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+       pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+       return t.func(t.arg);
+}
+
 /**
  * Zero some stat fields
  *
@@ -271,8 +296,10 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	pair->a_cntr = 0;
 	pair->b_cntr = 0;
 	pair->exit = 0;
-	if (run_b)
-		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
+	if (run_b) {
+		struct tst_fzsync_run_thread wrap_run_b = {.func = run_b, .arg = NULL};
+		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
+	}
 
 	pair->exec_time_start = (float)tst_timeout_remaining();
 }
-- 
2.20.1

