From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Aug 2017 17:33:49 +0200
Subject: [LTP] [RFC PATCH 4/4] fzsync: Print info from pair_update
In-Reply-To: <20170803153349.32766-1-rpalethorpe@suse.com>
References: <20170803153349.32766-1-rpalethorpe@suse.com>
Message-ID: <20170803153349.32766-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is very useful to see some stats so we include it in the update function by
default.
---
 include/tst_fuzzy_sync.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 5305f88e8..e361322d8 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -49,6 +49,7 @@
  * @delay_inc: The step size of a delay increment, defaults to 10
  * @update_gap: The number of iterations between recalculating the delay.
  *              Defaults to 0xF and must be of the form $2^n - 1$
+ * @info_gap: The number of iterations between printing some stats.
  * @yin: Used by fzsync_pair_wait()
  * @yang: Used by fzsync_pair_wait()
  *
@@ -65,6 +66,7 @@ struct tst_fzsync_pair {
 	long delay;
 	long delay_inc;
 	int update_gap;
+	int info_gap;
 	unsigned int yin;
 	unsigned int yang;
 };
@@ -75,7 +77,8 @@ struct tst_fzsync_pair {
 #define TST_FZSYNC_PAIR_INIT {	\
 	.avg_alpha = 0.25,	\
 	.delay_inc = 1,	        \
-	.update_gap = 0xF	\
+	.update_gap = 0xF,	\
+	.info_gap = 0x7FFFF     \
 }
 
 static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
@@ -188,6 +191,9 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 			pair->delay += inc;
 	}
 
+	if (!(loop_index & pair->info_gap))
+		tst_fzsync_pair_info(pair);
+
 	pair->avg_diff = avg;
 }
 
-- 
2.13.3

