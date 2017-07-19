From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 11:13:48 +0200
Subject: [LTP] [PATCH v3 1/9] Add fuzzy synchronisation library for
 triggering races
In-Reply-To: <20170623122211.29575-2-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-2-rpalethorpe@suse.com>
Message-ID: <20170719091348.GA1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes (see diff below), thanks.

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 122a6d736..229217495 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -34,7 +34,7 @@
 #include <time.h>
 
 #ifndef CLOCK_MONOTONIC_RAW
-#define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
+# define CLOCK_MONOTONIC_RAW CLOCK_MONOTONIC
 #endif
 
 /**
@@ -133,7 +133,7 @@ static inline void tst_fzsync_time_b(struct tst_fzsync_pair *pair)
 
 /**
  * tst_exp_moving_avg - Exponential moving average
- * @alpha: The preference for receant samples over old ones.
+ * @alpha: The preference for recent samples over old ones.
  * @sample: The current sample
  * @prev_avg: The average of the all the previous samples
  *
@@ -165,7 +165,6 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 {
        long diff;
        long inc = pair->delay_inc;
-       long delay = pair->delay;
        double target = pair->avg_diff_trgt;
        double avg = pair->avg_diff;
 
@@ -174,11 +173,10 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 
        if (!(loop_index & pair->update_gap)) {
                if (avg > target)
-                       delay -= inc;
+                       pair->delay -= inc;
                else if (avg < target)
-                       delay += inc;
+                       pair->delay += inc;
        }
 
        pair->avg_diff = avg;
-       pair->delay = delay;
 }

Apart from fixing obvious typo and minor style issue I've changed this function
not to tuch the pair->delay unless we recalculated it, as the code is a bit
easier to understand that way.

-- 
Cyril Hrubis
chrubis@suse.cz
