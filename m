From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 17 Jul 2017 14:53:57 +0800
Subject: [LTP] [PATCH] lib/tst_timer_test.c: fix unsigned int overflow on
	RHEL5.11GA
Message-ID: <1500274437-26154-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On RHEL5.11GA, pselect01 gets signal SIGSEGV due to unsigned int
overflow when all members of the samples array are less than usec
in do_timer_test().  all tests which apply timer measurement library
could trigger this issue on RHEL5.11GA regularly.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_timer_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index f30ad73..178e232 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -295,9 +295,9 @@ void do_timer_test(long long usec, unsigned int nsamples)
 			i, samples[0], samples[i-1]);
 	}
 
-	for (i = nsamples - 1; samples[i] < usec; i--);
+	for (i = nsamples - 1; i < nsamples && samples[i] < usec; i--);
 
-	if (i < nsamples - 1) {
+	if (i != nsamples - 1) {
 		tst_res(TFAIL, "%s woken up early %u times range: [%lli,%lli]",
 			scall, nsamples - 1 - i,
 			samples[i+1], samples[nsamples-1]);
-- 
1.8.3.1



