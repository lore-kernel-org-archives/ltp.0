From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 17:38:34 +0800
Subject: [LTP] [PATCH v2] lib/tst_timer_test.c: fix unsigned int overflow on
	RHEL5.11GA
In-Reply-To: <20170720091359.GA27245@rei>
References: <20170720091359.GA27245@rei>
Message-ID: <1500543514-5800-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On RHEL5.11GA, pselect01 gets signal SIGSEGV due to unsigned int
overflow when all members of the samples array are less than usec
in do_timer_test().  all tests which apply timer measurement library
could trigger this issue on RHEL5.11GA regularly.  We add check the
array boundary to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_timer_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index f30ad73..c8e2d38 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -266,7 +266,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
 	unsigned int discard = compute_discard(nsamples);
 	unsigned int keep_samples = nsamples - discard;
 	long long threshold = compute_threshold(usec, keep_samples);
-	unsigned int i;
+	int i;
 	int failed = 0;
 
 	tst_res(TINFO,
@@ -295,7 +295,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
 			i, samples[0], samples[i-1]);
 	}
 
-	for (i = nsamples - 1; samples[i] < usec; i--);
+	for (i = nsamples - 1; samples[i] < usec && i > -1; i--);
 
 	if (i < nsamples - 1) {
 		tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
-- 
1.8.3.1



