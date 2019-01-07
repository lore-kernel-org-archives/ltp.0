From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Jan 2019 14:51:22 +0800
Subject: [LTP] [PATCH RFC] fzsync: tst_fzsync_pair_wait exit when parent
 hit accidental break
In-Reply-To: <878t00mpnl.fsf@rpws.prws.suse.cz>
References: <20190104095256.12266-1-liwang@redhat.com>
 <878t00mpnl.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2eq49h48bxe17i3c_GWrbhTAHQMHr0t1_rwEdZvccJ-mg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> This is how it worked before, so it is fairly safe. However I don't like
> atomically checking for the exit value on every spin of the delay
> loop. Also because setting exit just causes it to drop through there is
> still the (theoretical) risk of it getting stuck on another operation
> before breaking out of thread B's main loop.

Yes, and I noticed you removed the exit checking in last update, but I
didn't realize that thread B will fall into infinite loop when parent
is break abnormally.

>
> Also removing the exit variable makes formal verification a bit easier.

Good point.

>
> Another option might be to use pthread_kill with a realtime signal and
> a signal handler which immediately exits the current thread. I am not
> sure how much complexity that will introduce though?

Well we can have a try, seems the only disadvantage of this method is
thread_B sets signal handler at each loop start in tst_fzsync_run_b
repeatedly.

Not sure if I understand correctly, what drafted in my mind is:

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index de0402c9b..6ef6bee01 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -63,6 +63,8 @@
 #include <time.h>
 #include <math.h>
 #include <stdlib.h>
+#include <pthread.h>
+#include <errno.h>
 #include "tst_atomic.h"
 #include "tst_timer.h"
 #include "tst_safe_pthread.h"
@@ -156,8 +158,6 @@ struct tst_fzsync_pair {
        int a_cntr;
        /** Internal; Atomic counter used by fzsync_pair_wait() */
        int b_cntr;
-       /** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
-       int exit;
        /**
         * The maximum desired execution time as a proportion of the timeout
         *
@@ -217,13 +217,28 @@ static void tst_fzsync_pair_init(struct
tst_fzsync_pair *pair)
  */
 static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
+       int kill_ret;
+
        if (pair->thread_b) {
-               tst_atomic_store(1, &pair->exit);
-               SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
-               pair->thread_b = 0;
+               kill_ret = pthread_kill(pair->thread_b, SIGUSR1);
+
+               if(kill_ret == 0) {
+                       SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
+                       pair->thread_b = 0;
+               } else if (kill_ret == EINVAL) {
+                       tst_res(TINFO, "Invalid signal was specified");
+               } else if (kill_ret == ESRCH) {
+                       tst_res(TINFO, "thread_b is not exist");
+               }
        }
 }

+static void sighandler(int sig)
+{
+       if (sig == SIGUSR1)
+               pthread_exit(NULL);
+}
+
 /**
  * Zero some stat fields
  *
@@ -270,7 +285,6 @@ static void tst_fzsync_pair_reset(struct
tst_fzsync_pair *pair,

        pair->a_cntr = 0;
        pair->b_cntr = 0;
-       pair->exit = 0;
        if (run_b)
                SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);

@@ -613,7 +627,6 @@ static inline int tst_fzsync_run_a(struct
tst_fzsync_pair *pair)
                exit = 1;
        }

-       tst_atomic_store(exit, &pair->exit);
        tst_fzsync_wait_a(pair);

        if (exit) {
@@ -632,8 +645,9 @@ static inline int tst_fzsync_run_a(struct
tst_fzsync_pair *pair)
  */
 static inline int tst_fzsync_run_b(struct tst_fzsync_pair *pair)
 {
+       SAFE_SIGNAL(SIGUSR1, sighandler);
        tst_fzsync_wait_b(pair);
-       return !tst_atomic_load(&pair->exit);
+       return 1;
 }

 /**


-- 
Regards,
Li Wang
