From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Oct 2018 16:02:44 +0200
Subject: [LTP] [PATCH v5 ltp] Add Intel PT full trace mode basic test
	case
In-Reply-To: <20181017055929.28193-1-ammy.yi@intel.com>
References: <20181017055929.28193-1-ammy.yi@intel.com>
Message-ID: <20181017140244.GC31018@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following changes, thanks.

diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index d46d7726e..517427992 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -7,7 +7,10 @@
 
 /*
  * This test will check if Intel PT(Intel Processer Trace) full trace mode is
- * working. It is only applied on X86 platforms.
+ * working.
+ *
+ * Intel CPU of 5th-generation Core (Broadwell) or newer is required for the test.
+ *
  * kconfig requirement: CONFIG_PERF_EVENTS
  */


I found out that the perf manual says we need at least broadwell to run
the test, so I documented it here (and I had to borow recent enough
machine to check the test, since the newest I have is Ivy Bridge).


@@ -93,11 +96,11 @@ static void intel_pt_full_trace_check(void)
 	/* stop tracing */
 	SAFE_IOCTL(fde, PERF_EVENT_IOC_DISABLE);
 
-	// check if there is some trace generated
+	/* check if there is some trace generated */
 	pmp = (struct perf_event_mmap_page *)bufm[0];
 	aux_head = *(volatile uint64_t *)&pmp->aux_head;
 	if (aux_head == 0) {
-		tst_res(TFAIL, "There is no trace, so failed!");
+		tst_res(TFAIL, "There is no trace!");
 		return;
 	}
 
@@ -109,10 +112,13 @@ static void setup(void)
 	struct perf_event_attr attr = {};
 
 	buhsz = 2 * PAGESIZE;
-	if (tst_dir_is_empty(INTEL_PT_PATH, 1))
-		tst_brk(TCONF, "PT not enabled, please check kconfig!");
+	if (access(INTEL_PT_PATH, F_OK)) {
+		tst_brk(TCONF,
+			"Requires Intel Core 5th+ generation (Broadwell and newer)"
+			" and CONFIG_PERF_EVENTS enabled.");
+	}


The tst_dir_is_empty() does not work here because the directory does not
exists, at least on my machines, if the CPU does not support PT.

We usually use acess() with F_OK in these cases.

-	//set attr for Intel PT trace
+	/* set attr for Intel PT trace */
 	attr.type	= intel_pt_pmu_value(INTEL_PT_PMU_TYPE);
 	attr.read_format = PERF_FORMAT_ID | PERF_FORMAT_TOTAL_TIME_RUNNING |
 				PERF_FORMAT_TOTAL_TIME_ENABLED;
@@ -124,7 +130,7 @@ static void setup(void)
 	attr.exclude_user		= 0;
 	attr.mmap			= 1;
 
-	//only get trace for own pid
+	/* only get trace for own pid */
 	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
 	if (fde < 0) {
 		tst_res(TINFO, "Open Intel PT event failed!");

-- 
Cyril Hrubis
chrubis@suse.cz
