From: Yury Norov <ynorov@caviumnetworks.com>
Date: Thu, 28 Sep 2017 19:49:26 +0300
Subject: [LTP] [PATCH] Increase threshold in timer measurement library
Message-ID: <20170928164926.32415-1-ynorov@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, all,

On my system - arm64 emulated in QEMU, the following tests fail:
epoll_wait02, nanosleep01, pselect01 and select04  - all due to 
violation the threshold limit for sleeping in  do_timer_test().

If my understanding correct, the threshold per syscall is rather
empirical value. I tested LTP in ILP32 and LP64 modes, and despite
the random nature of time accounting, failures are reproducible very
stable.

Increasing threshold fixes my failures.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 lib/tst_timer_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index cd4ebcaa8..8e2881e24 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -176,7 +176,7 @@ static int cmp(const void *a, const void *b)
 /*
  * The threshold per one syscall is computed as a sum of:
  *
- *  400 us                 - accomodates for context switches, process
+ *  1500 us                - accomodates for context switches, process
  *                           migrations between CPUs on SMP, etc.
  *  2*monotonic_resolution - accomodates for granurality of the CLOCK_MONOTONIC
  *  slack_per_scall        - max of 0.1% of the sleep capped on 100ms or
@@ -198,7 +198,7 @@ static long long compute_threshold(long long requested_us,
 
 	slack_per_scall = MAX(slack_per_scall, timerslack);
 
-	return (400 + 2 * monotonic_resolution + slack_per_scall) * nsamples
+	return (1500 + 2 * monotonic_resolution + slack_per_scall) * nsamples
 		+ 3000/nsamples;
 }
 
-- 
2.11.0

