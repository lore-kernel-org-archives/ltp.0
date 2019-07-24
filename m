From: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>
Date: Wed, 24 Jul 2019 20:23:44 +0200
Subject: [LTP] [PATCH] tst_timer: fix verification of execution time
In-Reply-To: <1563992624-4968-1-git-send-email-piotr.krzysztof.gawel@gmail.com>
References: <1563992624-4968-1-git-send-email-piotr.krzysztof.gawel@gmail.com>
Message-ID: <1563992624-4968-3-git-send-email-piotr.krzysztof.gawel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Each sample needs to be in range:
    t < s[i] < t + threshold
Thus for i from the interval [d...n]:
    (n-d)*t < sum(s[d...n]) < (n-d)*(t + threshold)
This patch fixes that check.

Signed-off-by: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>
---
 lib/tst_timer_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index f6459e5..4508e29 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -306,7 +306,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
 		samples[nsamples-1], samples[0], median,
 		1.00 * trunc_mean / keep_samples, discard);
 
-	if (trunc_mean > (nsamples - discard) * usec + threshold) {
+	if (trunc_mean > keep_samples * (usec + threshold)) {
 		tst_res(TFAIL, "%s slept for too long", scall);
 
 		if (!print_frequency_plot)
-- 
2.7.4

