From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  3 Aug 2021 17:58:21 +0200
Subject: [LTP] [PATCH v2 1/2] Add test for CVE 2020-25704
Message-ID: <20210803155822.1973-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #740

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Use memory statistics from /proc/meminfo instead of sysinfo()

 runtest/cve                                   |  2 +
 runtest/syscalls                              |  3 +
 .../syscalls/perf_event_open/.gitignore       |  1 +
 .../perf_event_open/perf_event_open.h         | 39 +++++++++
 .../perf_event_open/perf_event_open03.c       | 84 +++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/perf_event_open/perf_event_open.h
 create mode 100644 testcases/kernel/syscalls/perf_event_open/perf_event_open03.c

diff --git a/runtest/cve b/runtest/cve
index 5b7bf5323..e0d3723de 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -67,3 +67,5 @@ cve-2020-25705 icmp_rate_limit01
 cve-2020-29373 io_uring02
 cve-2021-3444 bpf_prog05
 cve-2021-26708 vsock01
+# Tests below may cause kernel memory leak
+cve-2020-25704 perf_event_open03
diff --git a/runtest/syscalls b/runtest/syscalls
index b379b2d90..5e3ac517f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1737,3 +1737,6 @@ membarrier01 membarrier01
 
 io_uring01 io_uring01
 io_uring02 io_uring02
+
+# Tests below may cause kernel memory leak
+perf_event_open03 perf_event_open03
diff --git a/testcases/kernel/syscalls/perf_event_open/.gitignore b/testcases/kernel/syscalls/perf_event_open/.gitignore
index 057690063..a1e5987b6 100644
--- a/testcases/kernel/syscalls/perf_event_open/.gitignore
+++ b/testcases/kernel/syscalls/perf_event_open/.gitignore
@@ -1,2 +1,3 @@
 /perf_event_open01
 /perf_event_open02
+/perf_event_open03
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open.h b/testcases/kernel/syscalls/perf_event_open/perf_event_open.h
new file mode 100644
index 000000000..02f0dd72e
--- /dev/null
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * Common definitions for perf_event_open tests
+ */
+
+#ifndef _PERF_EVENT_OPEN_H
+#define _PERF_EVENT_OPEN_H
+
+#include <linux/types.h>
+#include <linux/perf_event.h>
+#include <inttypes.h>
+
+static int perf_event_open(struct perf_event_attr *event, pid_t pid,
+	int cpu, int group_fd, unsigned long flags)
+{
+	int ret;
+
+	ret = tst_syscall(__NR_perf_event_open, event, pid, cpu,
+		group_fd, flags);
+
+	if (ret != -1)
+		return ret;
+
+	tst_res(TINFO, "%s event.type: %"PRIu32
+		", event.config: %"PRIu64, __func__, (uint32_t)event->type,
+		(uint64_t)event->config);
+	if (errno == ENOENT || errno == ENODEV) {
+		tst_brk(TCONF | TERRNO, "%s type/config not supported",
+			__func__);
+	}
+	tst_brk(TBROK | TERRNO, "%s failed", __func__);
+
+	/* unreachable */
+	return -1;
+}
+
+#endif /* _PERF_EVENT_OPEN_H */
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
new file mode 100644
index 000000000..f58bea79e
--- /dev/null
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+ *
+ * CVE-2020-25704
+ *
+ * Check for memory leak in PERF_EVENT_IOC_SET_FILTER ioctl command. Fixed in:
+ *
+ *  commit 7bdb157cdebbf95a1cd94ed2e01b338714075d00
+ *  Author: kiyin(??) <kiyin@tencent.com>
+ *  Date:   Wed Nov 4 08:23:22 2020 +0300
+ *
+ *  perf/core: Fix a memory leak in perf_event_parse_addr_filter()
+ */
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#if HAVE_PERF_EVENT_ATTR
+#include "perf_event_open.h"
+
+#define INTEL_PT_PATH "/sys/bus/event_source/devices/intel_pt/type"
+
+static int fd = -1;
+
+static void setup(void)
+{
+	struct perf_event_attr ev = {
+		.size = sizeof(struct perf_event_attr),
+		.exclude_kernel = 1,
+		.exclude_hv = 1,
+		.exclude_idle = 1
+	};
+
+	/* intel_pt is currently the only event source that supports filters */
+	if (access(INTEL_PT_PATH, F_OK))
+		tst_brk(TCONF, "intel_pt is not available");
+
+	SAFE_FILE_SCANF(INTEL_PT_PATH, "%d", &ev.type);
+	fd = perf_event_open(&ev, getpid(), -1, -1, 0);
+}
+
+static void run(void)
+{
+	long diff;
+	int i;
+
+	diff = SAFE_READ_MEMINFO("MemAvailable:");
+
+	/* leak about 100MB of RAM */
+	for (i = 0; i < 12000000; i++)
+		ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
+
+	diff -= SAFE_READ_MEMINFO("MemAvailable:");
+
+	if (diff > 50 * 1024)
+		tst_res(TFAIL, "Likely kernel memory leak detected");
+	else
+		tst_res(TPASS, "No memory leak found");
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "7bdb157cdebb"},
+		{"CVE", "2020-25704"},
+		{}
+	}
+};
+
+#else /* HAVE_PERF_EVENT_ATTR */
+TST_TEST_TCONF("This system doesn't have <linux/perf_event.h> or "
+	"struct perf_event_attr is not defined.");
+#endif
-- 
2.32.0

