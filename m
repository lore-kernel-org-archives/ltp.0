From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Mar 2020 14:48:31 +0100
Subject: [LTP] [PATCH 5/8] syscalls/clock_nanosleep03: Add test for time
 namespace
In-Reply-To: <20200305134834.16736-1-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
Message-ID: <20200305134834.16736-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test that absolute timeout for clock nanosleep is adjusted by the offset
correctly inside of a time namespace.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/containers                            |  1 +
 runtest/syscalls                              |  1 +
 .../syscalls/clock_nanosleep/.gitignore       |  1 +
 .../clock_nanosleep/clock_nanosleep03.c       | 71 +++++++++++++++++++
 4 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c

diff --git a/runtest/containers b/runtest/containers
index 4dc05af93..8100cd2bc 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -88,3 +88,4 @@ userns07 userns07
 
 # time namespaces
 sysinfo03 sysinfo03
+clock_nanosleep03 clock_nanosleep03
diff --git a/runtest/syscalls b/runtest/syscalls
index 34bd5c3da..d19ae0041 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -87,6 +87,7 @@ clock_getres01 clock_getres01
 clock_nanosleep01 clock_nanosleep01
 clock_nanosleep02 clock_nanosleep02
 clock_nanosleep2_01 clock_nanosleep2_01
+clock_nanosleep03 clock_nanosleep03
 
 clock_gettime01 clock_gettime01
 clock_gettime02 clock_gettime02
diff --git a/testcases/kernel/syscalls/clock_nanosleep/.gitignore b/testcases/kernel/syscalls/clock_nanosleep/.gitignore
index 6714ff468..406897cde 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/.gitignore
+++ b/testcases/kernel/syscalls/clock_nanosleep/.gitignore
@@ -1,2 +1,3 @@
 /clock_nanosleep01
 /clock_nanosleep02
+/clock_nanosleep03
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
new file mode 100644
index 000000000..99ff99736
--- /dev/null
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+
+  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+
+ */
+/*
+
+   Test that clock_nanosleep() adds correctly an offset with absolute timeout
+   and CLOCK_MONOTONIC inside of a timer namespace.
+
+   After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+   process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+   and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
+
+ */
+
+#include <stdlib.h>
+#include "tst_safe_clocks.h"
+#include "tst_timer.h"
+#include "lapi/namespaces_constants.h"
+#include "tst_test.h"
+
+#define OFFSET_S 10
+#define SLEEP_US 100000
+
+static void verify_clock_nanosleep(void)
+{
+	struct timespec start, end, sleep_abs;
+
+	SAFE_UNSHARE(CLONE_NEWTIME);
+
+	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0", CLOCK_MONOTONIC, OFFSET_S);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &start);
+
+	sleep_abs = tst_timespec_add_us(start, 1000000 * OFFSET_S + SLEEP_US);
+
+	if (!SAFE_FORK()) {
+		clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &sleep_abs, NULL);
+		exit(0);
+	}
+
+	SAFE_WAIT(NULL);
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &end);
+
+	long long diff = tst_timespec_diff_us(end, start);
+
+	if (diff > 5 * SLEEP_US) {
+		tst_res(TFAIL, "clock_nanosleep() slept too long %lli", diff);
+		return;
+	}
+
+	if (diff < SLEEP_US) {
+		tst_res(TFAIL, "clock_nanosleep() slept too short %lli", diff);
+		return;
+	}
+
+	tst_res(TPASS, "clock_nanosleep() slept correctly %lli", diff);
+}
+
+static struct tst_test test = {
+	.test_all = verify_clock_nanosleep,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TIME_NS=y"
+	}
+
+};
-- 
2.23.0

