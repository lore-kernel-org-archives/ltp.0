From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 24 Apr 2020 17:04:22 +0200
Subject: [LTP] [PATCH] Add env variable as workaround for test issues in VMs
Message-ID: <20200424150422.17467-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Timer tests often fail on sleep overrun when LTP is running inside a VM.
The main cause is usually that the VM doesn't get enough CPU time to wake up
the test process in time.

Disable upper bound checks in the tst_timer_test library if LTP_VM_ENV is set
to non-zero value.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/user-guide.txt   |  1 +
 include/tst_test.h   |  2 ++
 lib/tst_test.c       | 11 +++++++++++
 lib/tst_timer_test.c |  8 +++++++-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 13865bc88..20f9c50ad 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -16,6 +16,7 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
                           Variable is also used in shell tests, but ceiled to int.
+| 'LTP_VM_ENV'          | Set to '1' if LTP is run inside a virtual machine.
 | 'PATH'                | It's required to addjust path:
                           `PATH="$PATH:$LTPROOT/testcases/bin"`
 | 'TMPDIR'              | Base directory for template directory, which is required by C tests
diff --git a/include/tst_test.h b/include/tst_test.h
index 5bedb4f6f..8e02003c9 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -301,6 +301,8 @@ unsigned int tst_timeout_remaining(void);
 unsigned int tst_multiply_timeout(unsigned int timeout);
 void tst_set_timeout(int timeout);
 
+int tst_vm_env(void);
+
 
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 64cd3ac33..4facd4bf8 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1378,3 +1378,14 @@ void tst_flush(void)
 		tst_brk(TBROK | TERRNO, "fflush(stdout) failed");
 
 }
+
+int tst_vm_env(void)
+{
+	const char *env = getenv("LTP_VM_ENV");
+
+	if (env) {
+		return atoi(env);
+	}
+
+	return 0;
+}
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 13e9deff2..ff3a53c36 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -26,6 +26,7 @@ static long long *samples;
 static unsigned int cur_sample;
 static unsigned int monotonic_resolution;
 static unsigned int timerslack;
+static int virt_env;
 
 static char *print_frequency_plot;
 static char *file_name;
@@ -306,7 +307,7 @@ void do_timer_test(long long usec, unsigned int nsamples)
 		samples[nsamples-1], samples[0], median,
 		1.00 * trunc_mean / keep_samples, discard);
 
-	if (trunc_mean > (nsamples - discard) * usec + threshold) {
+	if (!virt_env && trunc_mean > (nsamples - discard) * usec + threshold) {
 		tst_res(TFAIL, "%s slept for too long", scall);
 
 		if (!print_frequency_plot)
@@ -343,6 +344,11 @@ static void timer_setup(void)
 	if (setup)
 		setup();
 
+	/*
+	 * Running tests in VM may cause timing issues, disable upper bound
+	 * checks if LTP_VM_ENV is set to non-zero.
+	 */
+	virt_env = tst_vm_env();
 	tst_clock_getres(CLOCK_MONOTONIC, &t);
 
 	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
-- 
2.26.0

