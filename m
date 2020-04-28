From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 28 Apr 2020 17:47:27 +0200
Subject: [LTP] [PATCH v2 2/2] Skip oversleep checks in timer tests under VM
In-Reply-To: <20200428154727.29206-1-mdoucha@suse.cz>
References: <20200428154727.29206-1-mdoucha@suse.cz>
Message-ID: <20200428154727.29206-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Timer tests often fail on sleep overrun when LTP is running inside a VM.
The main cause is usually that the VM doesn't get enough CPU time to wake up
the test process in time. Disable oversleep tests if tst_is_virt() detects
any hypervisor.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Use tst_is_virt() instead of env variable.

 lib/tst_timer_test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 13e9deff2..a9693a5a1 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -26,6 +26,7 @@ static long long *samples;
 static unsigned int cur_sample;
 static unsigned int monotonic_resolution;
 static unsigned int timerslack;
+static int virt_env;
 
 static char *print_frequency_plot;
 static char *file_name;
@@ -306,7 +307,10 @@ void do_timer_test(long long usec, unsigned int nsamples)
 		samples[nsamples-1], samples[0], median,
 		1.00 * trunc_mean / keep_samples, discard);
 
-	if (trunc_mean > (nsamples - discard) * usec + threshold) {
+	if (virt_env) {
+		tst_res(TINFO,
+			"Virtualisation detected, skipping oversleep checks");
+	} else if (trunc_mean > (nsamples - discard) * usec + threshold) {
 		tst_res(TFAIL, "%s slept for too long", scall);
 
 		if (!print_frequency_plot)
@@ -343,6 +347,11 @@ static void timer_setup(void)
 	if (setup)
 		setup();
 
+	/*
+	 * Running tests in VM may cause timing issues, disable upper bound
+	 * checks if LTP_VM_ENV is set to non-zero.
+	 */
+	virt_env = tst_is_virt(VIRT_ANY);
 	tst_clock_getres(CLOCK_MONOTONIC, &t);
 
 	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
-- 
2.26.0

