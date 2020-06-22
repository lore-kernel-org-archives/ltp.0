From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 22 Jun 2020 22:15:34 +0100
Subject: [LTP] [PATCH] fzsync: Add 10% margin of error to delay calculation
Message-ID: <20200622211534.27270-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It appears that the number of spins required to align the start of A with the
end of B (or the opposite) can be underestimated by some small amount on
x86_64. The amount is probably highly dependant on architecture and other
factors. It may be non-linear, but hopefully 10% will cover most cases.

Consider the following race:

Thread B:
	tst_fzsync_start_race_b(&pair);
	nanosleep(&delay, NULL);
	winner = 'B';
	tst_fzsync_end_race_b(&pair);

Thread A:
	winner = 'A';

	tst_fzsync_start_race_a(&pair);
	if (winner == 'A' && winner == 'B')
		winner = 'A';
	tst_fzsync_end_race_a(&pair);

delay is 1ns, but nanosleep() takes about ~30,000-60000ns probably because of
context switching. The race window is only about 1 instruction and A can only
win if A is delayed for the entire time B is in the kernel.

Because the delay is slightly underestimated (approx by 1000ns on my machine)
this will only happen on rare occasions when A receives a small extra delay
for other reasons.

After adding 10% the race is usually won by A within 100K iterations (a few
seconds on my machine).

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fuzzy_sync.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 9ff3a78ae..4141f5c64 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -511,7 +511,7 @@ static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 		per_spin_time = fabsf(pair->diff_ab.avg) / MAX(pair->spins_avg.avg, 1.0f);
 		time_delay = drand48() * (pair->diff_sa.avg + pair->diff_sb.avg)
 			- pair->diff_sb.avg;
-		pair->delay += (int)(time_delay / per_spin_time);
+		pair->delay += (int)(1.1 * time_delay / per_spin_time);
 
 		if (!pair->sampling) {
 			tst_res(TINFO,
-- 
2.27.0

