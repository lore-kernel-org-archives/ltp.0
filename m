From: Ammy Yi <ammy.yi@intel.com>
Date: Tue,  9 Oct 2018 13:11:49 +0800
Subject: [LTP] [PATCH v4 ltp] Add Intel PT full trace mode basic test case
Message-ID: <20181009051149.6055-1-ammy.yi@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test will do Intel PT full trace mode with test case PID to check
if enable/stop/trace generation works with Intel PT.

Signed-off-by: Ammy Yi <ammy.yi@intel.com>
---
 runtest/tracing                             |   1 +
 testcases/kernel/tracing/pt_test/.gitignore |   1 +
 testcases/kernel/tracing/pt_test/Makefile   |  21 ++++
 testcases/kernel/tracing/pt_test/pt_test.c  | 170 ++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 testcases/kernel/tracing/pt_test/.gitignore
 create mode 100644 testcases/kernel/tracing/pt_test/Makefile
 create mode 100644 testcases/kernel/tracing/pt_test/pt_test.c

diff --git a/runtest/tracing b/runtest/tracing
index 8285eeb43..504132d70 100644
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
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
new file mode 100644
index 000000000..bbd641b06
--- /dev/null
+++ b/testcases/kernel/tracing/pt_test/pt_test.c
@@ -0,0 +1,170 @@
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
+ * This test will check if Intel PT(Intel Processer Trace) full trace mode is
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
+int fde = -1;
+//map head and size
+uint64_t **bufm;
+long buhsz;
+
+uint64_t **create_map(int fde, long bufsize)
+{
+	int PROTo;
+	uint64_t **buf_ev;
+	struct perf_event_mmap_page *pc;
+
+	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
+
+	PROTo = PROT_READ | PROT_WRITE;
+	buf_ev[0] = NULL;
+	buf_ev[1] = NULL;
+//try to mmap for trace
+	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
+							MAP_SHARED, fde, 0);
+
+	pc = (struct perf_event_mmap_page *)buf_ev[0];
+	pc->aux_offset = INTEL_PT_MEMSIZE;
+	pc->aux_size = bufsize;
+	buf_ev[1] = SAFE_MMAP(NULL, bufsize, PROTo,
+					MAP_SHARED, fde, INTEL_PT_MEMSIZE);
+	return buf_ev;
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
+void del_map(uint64_t **buf_ev, long bufsize)
+{
+	long pbuhsz;
+
+	pbuhsz = INTEL_PT_MEMSIZE;
+	if (buf_ev) {
+		if (buf_ev[0])
+			munmap(buf_ev[0], pbuhsz);
+		if (buf_ev[1])
+			munmap(buf_ev[1], bufsize);
+	}
+
+	free(buf_ev);
+}
+
+static void intel_pt_full_trace_check(void)
+{
+	uint64_t aux_head = 0;
+	struct perf_event_mmap_page *pmp;
+	/* enable tracing */
+	SAFE_IOCTL(fde, PERF_EVENT_IOC_RESET);
+	SAFE_IOCTL(fde, PERF_EVENT_IOC_ENABLE);
+
+	/* stop tracing */
+	SAFE_IOCTL(fde, PERF_EVENT_IOC_DISABLE);
+
+	// check if there is some trace generated
+	pmp = (struct perf_event_mmap_page *)bufm[0];
+	aux_head = *(volatile uint64_t *)&pmp->aux_head;
+	if (aux_head == 0) {
+		tst_res(TFAIL, "There is no trace, so failed!");
+		return;
+	}
+
+	tst_res(TPASS, "perf trace full mode is passed!");
+}
+
+void setup(void)
+{
+	struct perf_event_attr attr = {};
+
+	buhsz = 2 * PAGESIZE;
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
+	fde = tst_syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+	if (fde < 0) {
+		tst_res(TINFO, "Open Intel PT event failed!");
+		tst_res(TFAIL, "perf trace full mode is failed!");
+		return;
+	}
+	bufm = NULL;
+	/* allocate memory for trace */
+	bufm =  create_map(fde, buhsz);
+
+}
+
+void cleanup(void)
+{
+	if (fde != -1)
+		close(fde);
+
+	del_map(bufm, buhsz);
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

