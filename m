From: Yi, Ammy <ammy.yi@intel.com>
Date: Fri, 21 Sep 2018 05:58:11 +0000
Subject: [LTP] [PATCH v3 ltp] Add Intel PT full trace mode basic test
	case
In-Reply-To: <20180913015431.6411-1-ammy.yi@intel.com>
References: <20180913015431.6411-1-ammy.yi@intel.com>
Message-ID: <6A26F11783B7464A9CE09DB41C14533C542322C4@SHSMSX101.ccr.corp.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi ,

Is there any other comments for this patch? Thanks.

Best Regards
Ammy Yi


-----Original Message-----
From: Yi, Ammy 
Sent: Thursday, September 13, 2018 9:55 AM
To: ltp@lists.linux.it
Cc: Yi, Ammy <ammy.yi@intel.com>
Subject: [PATCH v3 ltp] Add Intel PT full trace mode basic test case

This test will do Intel PT full trace mode with test case PID to check if enable/stop/trace generation works with Intel PT.

Signed-off-by: Ammy Yi <ammy.yi@intel.com>
---
 runtest/tracing                             |   1 +
 testcases/kernel/tracing/pt_test/.gitignore |   1 +
 testcases/kernel/tracing/pt_test/Makefile   |  21 ++++
 testcases/kernel/tracing/pt_test/pt_test.c  | 185 ++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 testcases/kernel/tracing/pt_test/.gitignore
 create mode 100644 testcases/kernel/tracing/pt_test/Makefile
 create mode 100644 testcases/kernel/tracing/pt_test/pt_test.c

diff --git a/runtest/tracing b/runtest/tracing index 8285eeb43..504132d70 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -3,3 +3,4 @@ ftrace_regression01	ftrace_regression01.sh
 ftrace_regression02	ftrace_regression02.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
+pt_full_trace_basic pt_test
diff --git a/testcases/kernel/tracing/pt_test/.gitignore b/testcases/kernel/tracing/pt_test/.gitignore
new file mode 100644
index 000000000..96efc142d
--- /dev/null
+++ b/testcases/kernel/tracing/pt_test/.gitignore
@@ -0,0 +1 @@
+/pt_test
diff --git a/testcases/kernel/tracing/pt_test/Makefile b/testcases/kernel/tracing/pt_test/Makefile
new file mode 100644
index 000000000..a114fed1b
--- /dev/null
+++ b/testcases/kernel/tracing/pt_test/Makefile
@@ -0,0 +1,21 @@
+#
+# Copyright (C) 2018 Intel Corporation
+#
+# This program is free software: you can redistribute it and/or modify 
+# it under the terms of the GNU General Public License as published by 
+# the Free Software Foundation, either version 2 of the License, or # 
+(at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, # but 
+WITHOUT ANY WARRANTY; without even the implied warranty of # 
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the # GNU 
+General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License # 
+along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
new file mode 100644
index 000000000..fb9cd9631
--- /dev/null
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -0,0 +1,185 @@
+/*
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * author: Ammy Yi (ammy.yi@intel.com)
+ * date:   8/20/2018
+ */
+
+/*
+ * This test will check if Intel PT(Intel Processer Trace) full trace 
+mode is
+ * working. It is only applied on X86 platforms.
+ */
+
+#include <linux/perf_event.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define PAGESIZE 4096
+#define INTEL_PT_MEMSIZE (17*PAGESIZE)
+
+#define BIT(nr)                 (1UL << (nr))
+
+#define INTEL_PT_PMU_TYPE "/sys/devices/intel_pt/type"
+#define INTEL_PT_FORMAT_TSC "/sys/devices/intel_pt/format/tsc"
+#define INTEL_PT_FORMAT_NRT "/sys/devices/intel_pt/format/noretcomp"
+
+//Intel PT event handle
+int FDE = -1;
+//map head and size
+uint64_t **BUFM;
+long BUFSZ;
+
+uint64_t **create_map(int fde, long bufsize) {
+	int PROTo;
+	long pbufSz;
+	uint64_t **bufEv;
+	struct perf_event_mmap_page *pc;
+
+	bufEv = SAFE_MALLOC(2*sizeof(uint64_t *));
+
+	PROTo = PROT_READ | PROT_WRITE;
+
+	pbufSz = INTEL_PT_MEMSIZE;
+//try to mmap for trace
+	bufEv[0] = SAFE_MMAP(NULL, pbufSz, PROT_READ | PROT_WRITE,
+							MAP_SHARED, fde, 0);
+
+	if (bufEv[0] != MAP_FAILED) {
+		pc = (struct perf_event_mmap_page *)bufEv[0];
+		pc->aux_offset = pbufSz;
+		pc->aux_size = bufsize;
+		bufEv[1] = SAFE_MMAP(NULL, bufsize, PROTo, MAP_SHARED,
+								fde, pbufSz);
+	}
+	return bufEv;
+}
+
+
+int intel_pt_pmu_value(char *dir)
+{
+	char *value;
+	int val = 0;
+	char delims[] = ":";
+
+	SAFE_FILE_SCANF(dir, "%m[^\n]", &value);
+	if (strstr(value, delims) == NULL) {
+		val = atoi(value);
+	} else {
+		strsep(&value, delims);
+		val = atoi(value);
+	}
+	return val;
+}
+
+void del_map(uint64_t **bufEv, long bufsize) {
+	long pbufSz;
+
+	pbufSz = INTEL_PT_MEMSIZE;
+
+	munmap(bufEv[0], pbufSz);
+	munmap(bufEv[1], bufsize);
+
+	free(bufEv);
+}
+
+static void intel_pt_full_trace_check(void) {
+	uint64_t aux_head = 0;
+	struct perf_event_mmap_page *pmp;
+	/* enable tracing */
+	if (ioctl(FDE, PERF_EVENT_IOC_RESET) != 0) {
+		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_RESET is failed!");
+		return;
+	}
+	if (ioctl(FDE, PERF_EVENT_IOC_ENABLE) != 0) {
+		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_ENABLE is failed!");
+		return;
+	}
+
+	/* stop tracing */
+	if (ioctl(FDE, PERF_EVENT_IOC_DISABLE) != 0) {
+		tst_res(TFAIL, "ioctl with PERF_EVENT_IOC_DISABLE is failed!");
+		return;
+	}
+
+	// check if there is some trace generated
+	pmp = (struct perf_event_mmap_page *)BUFM[0];
+	aux_head = *(volatile uint64_t *)&pmp->aux_head;
+	if (aux_head == 0) {
+		tst_res(TFAIL, "There is no trace, so failed!");
+		return;
+	}
+
+	tst_res(TPASS, "perf trace full mode is passed!"); }
+
+void setup(void)
+{
+	struct perf_event_attr attr = {};
+
+	BUFSZ = 2 * PAGESIZE;
+
+	//set attr for Intel PT trace
+	attr.type	= intel_pt_pmu_value(INTEL_PT_PMU_TYPE);
+	attr.read_format = PERF_FORMAT_ID | PERF_FORMAT_TOTAL_TIME_RUNNING |
+				PERF_FORMAT_TOTAL_TIME_ENABLED;
+	attr.disabled	= 1;
+	attr.config	= BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_TSC)) |
+				BIT(intel_pt_pmu_value(INTEL_PT_FORMAT_NRT));
+	attr.size	= sizeof(struct perf_event_attr);
+	attr.exclude_kernel		= 0;
+	attr.exclude_user		= 0;
+	attr.mmap			= 1;
+
+	//only get trace for own pid
+	FDE = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (FDE < 0) {
+		tst_res(TINFO, "Open Intel PT event failed!");
+		tst_res(TFAIL, "perf trace full mode is failed!");
+		return;
+	}
+	BUFM = NULL;
+	/* allocate memory for trace */
+	BUFM =  create_map(FDE, BUFSZ);
+
+	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED) {
+		tst_res(TINFO, "create_map failed!");
+		tst_res(TFAIL, "perf trace full mode is failed!");
+		return;
+	}
+}
+
+void cleanup(void)
+{
+	if (FDE != -1)
+		close(FDE);
+
+	if (!BUFM || (BUFM)[0] == MAP_FAILED || (BUFM)[1] == MAP_FAILED)
+		del_map(BUFM, BUFSZ);
+}
+
+static struct tst_test test = {
+	.test_all = intel_pt_full_trace_check,
+	.min_kver = "4.1",
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
--
2.14.1

