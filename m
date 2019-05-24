From: Ammy Yi <ammy.yi@intel.com>
Date: Fri, 24 May 2019 10:01:23 +0800
Subject: [LTP] [PATCH v3 ltp] Add 4 more cases for Intel PT.
Message-ID: <20190524020123.7623-1-ammy.yi@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Add Intel PT sanpshot mode test.
2. Add Intel PT exclude user trace mode test.
3. Add Intel PT exclude kernel trace mode test.
4. Add Intel PT disable branch trace mode test.

Signed-off-by: Ammy Yi <ammy.yi@intel.com>
---
 runtest/tracing                            |  4 ++
 testcases/kernel/tracing/pt_test/pt_test.c | 66 +++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/runtest/tracing b/runtest/tracing
index 504132d70..d2700ca57 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -4,3 +4,7 @@ ftrace_regression02	ftrace_regression02.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
 pt_full_trace_basic pt_test
+pt_snapshot_trace_basic pt_test -m
+pt_ex_user pt_test -e user
+pt_ex_kernel pt_test -e kernel
+pt_disable_branch pt_test -b
diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index 5feb1aa63..7bee9c951 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -6,14 +6,14 @@
  */
 
 /*
- * This test will check if Intel PT(Intel Processer Trace) full trace mode is
- * working.
+ * This test will check if Intel PT(Intel Processer Trace) is working.
  *
  * Intel CPU of 5th-generation Core (Broadwell) or newer is required for the test.
  *
  * kconfig requirement: CONFIG_PERF_EVENTS
  */
 
+
 #include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -40,22 +40,34 @@ int fde = -1;
 //map head and size
 uint64_t **bufm;
 long buhsz;
+static char *str_mode;
+static char *str_exclude_info;
+static char *str_branch_flag;
+int mode = 1;
 
-static uint64_t **create_map(int fde, long bufsize)
+static uint64_t **create_map(int fde, long bufsize, int flag)
 {
 	uint64_t **buf_ev;
+	int pro_flag;
 	struct perf_event_mmap_page *pc;
 
 	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
 	buf_ev[0] = NULL;
 	buf_ev[1] = NULL;
-	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
+	if (flag == 1) {
+		tst_res(TINFO, "memory will be r/w for full trace mode!");
+		pro_flag = PROT_READ | PROT_WRITE;
+	} else {
+		tst_res(TINFO, "memory will be r only for snapshot mode!");
+		pro_flag = PROT_READ;
+	}
+	buf_ev[0] = SAFE_MMAP(fde, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
 							MAP_SHARED, fde, 0);
 
 	pc = (struct perf_event_mmap_page *)buf_ev[0];
 	pc->aux_offset = INTEL_PT_MEMSIZE;
 	pc->aux_size = bufsize;
-	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROT_READ | PROT_WRITE,
+	buf_ev[1] = SAFE_MMAP(NULL, bufsize, pro_flag,
 					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
 	return buf_ev;
 }
@@ -89,7 +101,7 @@ static void del_map(uint64_t **buf_ev, long bufsize)
 	free(buf_ev);
 }
 
-static void intel_pt_full_trace_check(void)
+static void intel_pt_trace_check(void)
 {
 	uint64_t aux_head = 0;
 	struct perf_event_mmap_page *pmp;
@@ -104,11 +116,11 @@ static void intel_pt_full_trace_check(void)
 	pmp = (struct perf_event_mmap_page *)bufm[0];
 	aux_head = *(volatile uint64_t *)&pmp->aux_head;
 	if (aux_head == 0) {
-		tst_res(TFAIL, "There is no trace!");
+		tst_res(TFAIL, "There is no trace.");
 		return;
 	}
 
-	tst_res(TPASS, "perf trace full mode is passed!");
+	tst_res(TPASS, "perf trace test is passed.");
 }
 
 static void setup(void)
@@ -116,6 +128,7 @@ static void setup(void)
 	struct perf_event_attr attr = {};
 
 	buhsz = 2 * PAGESIZE;
+
 	if (access(INTEL_PT_PATH, F_OK)) {
 		tst_brk(TCONF,
 			"Requires Intel Core 5th+ generation (Broadwell and newer)"
@@ -130,20 +143,36 @@ static void setup(void)
 	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
 				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
 	attr.size	= sizeof(struct perf_event_attr);
-	attr.exclude_kernel		= 0;
-	attr.exclude_user		= 0;
 	attr.mmap			= 1;
+	if (str_branch_flag) {
+		tst_res(TINFO, "Intel PT will disable branch trace.");
+		attr.config |= 1;
+	}
+
+	attr.exclude_kernel	= 0;
+	attr.exclude_user	= 0;
+
+	if (str_exclude_info && strcmp(str_exclude_info, "user")) {
+		tst_res(TINFO, "Intel PT will exclude kernel trace.");
+		attr.exclude_kernel = 1;
+	}
+	if (str_exclude_info && strcmp(str_exclude_info, "kernel")) {
+		tst_res(TINFO, "Intel PT will exclude user trace.");
+		attr.exclude_user = 1;
+	}
 
 	/* only get trace for own pid */
 	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
 	if (fde < 0) {
-		tst_res(TINFO, "Open Intel PT event failed!");
-		tst_res(TFAIL, "perf trace full mode is failed!");
+		tst_res(TINFO, "Open Intel PT event failed.");
+		tst_res(TFAIL, "perf trace full mode is failed.");
 		return;
 	}
 	bufm = NULL;
-	bufm = create_map(fde, buhsz);
+	if (str_mode)
+		mode = 0;
 
+	bufm = create_map(fde, buhsz, mode);
 }
 
 static void cleanup(void)
@@ -154,8 +183,17 @@ static void cleanup(void)
 	del_map(bufm, buhsz);
 }
 
+static struct tst_option options[] = {
+	{"m", &str_mode, "-m different mode, default is full mode"},
+	{"e:", &str_exclude_info, "-e exclude info, user or kernel"},
+	{"b", &str_branch_flag, "-b if disable branch trace"},
+	{NULL, NULL, NULL}
+};
+
+
 static struct tst_test test = {
-	.test_all = intel_pt_full_trace_check,
+	.test_all = intel_pt_trace_check,
+	.options = options,
 	.min_kver = "4.1",
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.14.1

