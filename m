From: Ammy Yi <ammy.yi@intel.com>
Date: Fri, 15 Mar 2019 15:14:07 +0800
Subject: [LTP] [PATCH ltp] Add 4 more cases for Intel PT.
Message-ID: <20190315071407.14523-1-ammy.yi@intel.com>
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
 testcases/kernel/tracing/pt_test/pt_test.c | 79 +++++++++++++++++++++++++-----
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/runtest/tracing b/runtest/tracing
index 504132d70..7a181f942 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -4,3 +4,7 @@ ftrace_regression02	ftrace_regression02.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
 pt_full_trace_basic pt_test
+pt_snapshot_trace_basic pt_test -m 0
+pt_ex_user pt_test -e 1
+pt_ex_kernel pt_test -e 2
+pt_disable_branch pt_test -b 0
diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
index 5feb1aa63..33fcf7b8c 100644
--- a/testcases/kernel/tracing/pt_test/pt_test.c
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -6,14 +6,16 @@
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
 
+/* 10/2018 Add full trace check test case */
+/* 2/2019  Add snapshot/disable branch/user/kernel trace */
+
 #include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -40,22 +42,36 @@ int fde = -1;
 //map head and size
 uint64_t **bufm;
 long buhsz;
-
-static uint64_t **create_map(int fde, long bufsize)
+char *str_mode;
+char *str_exclude_info;
+char *str_branch_flag;
+int mode = 1;
+int exclude_info = 3;
+int branch_flag = 1;
+
+static uint64_t **create_map(int fde, long bufsize, int flag)
 {
 	uint64_t **buf_ev;
+	int pro_flag;
 	struct perf_event_mmap_page *pc;
 
 	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
 	buf_ev[0] = NULL;
 	buf_ev[1] = NULL;
+	if (flag == 1) {
+		tst_res(TINFO, "memory will be r/w!");
+		pro_flag = PROT_READ | PROT_WRITE;
+	} else {
+		tst_res(TINFO, "memory will be r only!");
+		pro_flag = PROT_READ;
+	}
 	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
 							MAP_SHARED, fde, 0);
 
 	pc = (struct perf_event_mmap_page *)buf_ev[0];
 	pc->aux_offset = INTEL_PT_MEMSIZE;
 	pc->aux_size = bufsize;
-	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROT_READ | PROT_WRITE,
+	buf_ev[1] = SAFE_MMAP(NULL, bufsize, pro_flag,
 					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
 	return buf_ev;
 }
@@ -89,7 +105,7 @@ static void del_map(uint64_t **buf_ev, long bufsize)
 	free(buf_ev);
 }
 
-static void intel_pt_full_trace_check(void)
+static void intel_pt_trace_check(void)
 {
 	uint64_t aux_head = 0;
 	struct perf_event_mmap_page *pmp;
@@ -108,7 +124,19 @@ static void intel_pt_full_trace_check(void)
 		return;
 	}
 
-	tst_res(TPASS, "perf trace full mode is passed!");
+	tst_res(TPASS, "perf trace test is passed!");
+}
+
+static void parse_options(void)
+{
+	if (tst_parse_int(str_mode, &mode, 0, 1))
+		tst_brk(TBROK, "Invalid mode '%s'", str_mode);
+
+	if (tst_parse_int(str_exclude_info, &exclude_info, 1, 2))
+		tst_brk(TBROK, "Invalid exclude info '%s'", str_exclude_info);
+
+	if (tst_parse_int(str_branch_flag, &branch_flag, 0, 1))
+		tst_brk(TBROK, "Invalid branch flag '%s'", str_branch_flag);
 }
 
 static void setup(void)
@@ -116,6 +144,9 @@ static void setup(void)
 	struct perf_event_attr attr = {};
 
 	buhsz = 2 * PAGESIZE;
+
+	parse_options();
+
 	if (access(INTEL_PT_PATH, F_OK)) {
 		tst_brk(TCONF,
 			"Requires Intel Core 5th+ generation (Broadwell and newer)"
@@ -130,9 +161,24 @@ static void setup(void)
 	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
 				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
 	attr.size	= sizeof(struct perf_event_attr);
-	attr.exclude_kernel		= 0;
-	attr.exclude_user		= 0;
-	attr.mmap			= 1;
+	attr.mmap	= 1;
+	if (branch_flag == 0) {
+		tst_res(TINFO, "Intel PT will disable branch trace!");
+		attr.config |= 1;
+	}
+
+	attr.exclude_kernel	= 0;
+	attr.exclude_user	= 0;
+
+	if (exclude_info == 1) {
+		tst_res(TINFO, "Intel PT will exclude user trace!");
+		attr.exclude_user = 1;
+	}
+
+	if (exclude_info == 2) {
+		tst_res(TINFO, "Intel PT will exclude kernel trace!");
+		attr.exclude_kernel = 1;
+	}
 
 	/* only get trace for own pid */
 	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
@@ -142,7 +188,7 @@ static void setup(void)
 		return;
 	}
 	bufm = NULL;
-	bufm = create_map(fde, buhsz);
+	bufm = create_map(fde, buhsz, mode);
 
 }
 
@@ -154,8 +200,17 @@ static void cleanup(void)
 	del_map(bufm, buhsz);
 }
 
+static struct tst_option options[] = {
+	{"m:", &str_mode, "-m different mode, as full trace or snapshot trace"},
+	{"e:", &str_exclude_info, "-e exclude info, 1->user, 2->kernel"},
+	{"b:", &str_branch_flag, "-b if disable branch trace"},
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

