From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  3 Aug 2017 17:33:48 +0200
Subject: [LTP] [RFC PATCH 3/4] fzsync: Correctly handle timestamps across
	second boundaries
In-Reply-To: <20170803153349.32766-1-rpalethorpe@suse.com>
References: <20170803153349.32766-1-rpalethorpe@suse.com>
Message-ID: <20170803153349.32766-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously we only calculated the difference between timestamps based on
tv_nsec so when a.tv_sec: 281122, a.tv_nsec: 999996364, b.tv_sec: 281123,
b.tv_nsec: 31. The difference between a and b is incorrectly calculated
as (a - b = 999996364 - 31) even though b happened after a.

Now, one second is added to b's tv_nsec so that the calculation in the above
example becomes (999996364 - 1000000031). It is assumed that a and b will
never be more than a second apart. However the average diff should not be too
badly effected if they occasionally are.
---
 include/tst_fuzzy_sync.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 5234c5aa5..5305f88e8 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -172,6 +172,12 @@ static void tst_fzsync_pair_update(int loop_index, struct tst_fzsync_pair *pair)
 	double target = pair->avg_diff_trgt;
 	double avg = pair->avg_diff;
 
+	if (pair->a.tv_sec > pair->b.tv_sec) {
+		pair->a.tv_nsec += 1000000000;
+	} else if (pair->a.tv_sec < pair->b.tv_sec) {
+		pair->b.tv_nsec += 1000000000;
+	}
+
 	diff = pair->a.tv_nsec - pair->b.tv_nsec;
 	avg = tst_exp_moving_avg(pair->avg_alpha, diff, avg);
 
-- 
2.13.3

