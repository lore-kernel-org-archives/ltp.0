From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Mar 2020 14:48:30 +0100
Subject: [LTP] [PATCH 4/8] syscalls/sysinfo03: Add time namespace test
In-Reply-To: <20200305134834.16736-1-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
Message-ID: <20200305134834.16736-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This tests that the uptime in sysinfo() is adjusted correctly by the
namespace offset.

Also check that /proc/uptime is consistent with the uptime from the
sysinfo() syscall.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/containers                            |  3 +
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/sysinfo/.gitignore  |  1 +
 testcases/kernel/syscalls/sysinfo/sysinfo03.c | 78 +++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sysinfo/sysinfo03.c

diff --git a/runtest/containers b/runtest/containers
index 871cd2a42..4dc05af93 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -85,3 +85,6 @@ userns04 userns04
 userns05 userns05
 userns06 userns06
 userns07 userns07
+
+# time namespaces
+sysinfo03 sysinfo03
diff --git a/runtest/syscalls b/runtest/syscalls
index 06d96470c..34bd5c3da 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1441,6 +1441,7 @@ sysfs06 sysfs06
 
 sysinfo01 sysinfo01
 sysinfo02 sysinfo02
+sysinfo03 sysinfo03
 
 syslog01 syslog01
 syslog02 syslog02
diff --git a/testcases/kernel/syscalls/sysinfo/.gitignore b/testcases/kernel/syscalls/sysinfo/.gitignore
index aa7c26946..8ad2279a4 100644
--- a/testcases/kernel/syscalls/sysinfo/.gitignore
+++ b/testcases/kernel/syscalls/sysinfo/.gitignore
@@ -1,2 +1,3 @@
 /sysinfo01
 /sysinfo02
+/sysinfo03
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
new file mode 100644
index 000000000..979e6e0a7
--- /dev/null
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ */
+/*
+
+  Test if CLOCK_BOOTTIME namespace offset is applied to sysinfo uptime and that
+  it's consistent with /proc/uptime as well.
+
+  After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+  process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+  and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
+
+ */
+
+#include <sys/sysinfo.h>
+#include "lapi/namespaces_constants.h"
+#include "tst_test.h"
+
+static int offsets[] = {
+	10,
+	-10,
+	3600,
+};
+
+static long read_proc_uptime(void)
+{
+	long sec, sec_rem;
+
+	SAFE_FILE_SCANF("/proc/uptime", "%li.%li", &sec, &sec_rem);
+
+	return sec + (sec_rem ? 1 : 0);
+}
+
+static void verify_sysinfo(unsigned int n)
+{
+	struct sysinfo si;
+	long uptime;
+	int off = offsets[n];
+
+	SAFE_UNSHARE(CLONE_NEWTIME);
+
+        SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
+	                 CLOCK_BOOTTIME, off);
+
+	sysinfo(&si);
+
+	uptime = si.uptime;
+
+	if (!SAFE_FORK()) {
+		sysinfo(&si);
+		long proc_uptime = read_proc_uptime();
+
+		long diff = si.uptime - uptime;
+
+		if (diff < off || diff > off + 1)
+			tst_res(TFAIL, "Wrong sysinfo uptime offset %li", diff);
+		else
+			tst_res(TPASS, "Correct sysinfo uptime offset %i", off);
+
+		if (si.uptime < proc_uptime || si.uptime > proc_uptime + 1) {
+			tst_res(TFAIL, "/proc/uptime %li differs from sysinfo %li",
+			        proc_uptime, si.uptime);
+		} else {
+			tst_res(TPASS, "/proc/uptime is consistent with sysinfo");
+		}
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(offsets),
+	.test = verify_sysinfo,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TIME_NS=y"
+	}
+};
-- 
2.23.0

