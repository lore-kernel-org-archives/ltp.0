From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  5 Sep 2019 14:08:36 +0200
Subject: [LTP] [PATCH v2] fzsync: drop pair->spins_avg.avg check
In-Reply-To: <2ded10ab8d989ba7ee0cc1e9f1ac28acdf14c947.1567606698.git.jstancek@redhat.com>
References: <2ded10ab8d989ba7ee0cc1e9f1ac28acdf14c947.1567606698.git.jstancek@redhat.com>
Message-ID: <750a63b18523493412cb53e748b519b7dfbd70b0.1567685224.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_fzsync_pair.spins is increased at least by one on every iteration.
If during all calibration loops, both A and B manage to complete at
nearly same time, then spins is increased only by one.

spins_avg starts as 0, and tst_exp_moving_avg() will move it closer
and closer to 1, but it will never be 1:
        float f = 0; int i;
        for (i = 0; i < 4096; i++)
                f = tst_exp_moving_avg(0.25f, 1, f);
        printf("%.15f %d\n", f, f >= 1);
	$ 0.999999880790710 0
which on rare occasion can cause: "Can't calculate random delay".

Drop check and use MAX(pair->spins_avg.avg, 1f) to calculate per_spin_time.
Also print stats one more time when we hit the warning.

Suggested-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_fuzzy_sync.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index de0402c9bbe9..f9a1947c7542 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -477,8 +477,8 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 			tst_res(TINFO, "Minimum sampling period ended");
 			tst_fzsync_pair_info(pair);
 		}
-	} else if (fabsf(pair->diff_ab.avg) >= 1 && pair->spins_avg.avg >= 1) {
-		per_spin_time = fabsf(pair->diff_ab.avg) / pair->spins_avg.avg;
+	} else if (fabsf(pair->diff_ab.avg) >= 1) {
+		per_spin_time = fabsf(pair->diff_ab.avg) / MAX(pair->spins_avg.avg, 1.0f);
 		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
 			- pair->diff_sb.avg;
 		pair->delay += (int)(time_delay / per_spin_time);
@@ -495,6 +495,7 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 		}
 	} else if (!pair->sampling) {
 		tst_res(TWARN, "Can't calculate random delay");
+		tst_fzsync_pair_info(pair);
 		pair->sampling = -1;
 	}
 
-- 
1.8.3.1

