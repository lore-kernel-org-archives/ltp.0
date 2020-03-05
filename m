From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Mar 2020 14:48:34 +0100
Subject: [LTP] [PATCH 8/8] syscalls/timerfd04: Add time namespace test
In-Reply-To: <20200305134834.16736-1-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
Message-ID: <20200305134834.16736-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/containers                            |  1 +
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/timerfd/.gitignore  |  1 +
 testcases/kernel/syscalls/timerfd/timerfd04.c | 95 +++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 testcases/kernel/syscalls/timerfd/timerfd04.c

diff --git a/runtest/containers b/runtest/containers
index 23e4a533d..276096709 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -91,3 +91,4 @@ sysinfo03 sysinfo03
 clock_nanosleep03 clock_nanosleep03
 clock_gettime03 clock_gettime03
 timens01 timens01
+timerfd04 timerfd04
diff --git a/runtest/syscalls b/runtest/syscalls
index 778f722a3..8494a8b04 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1473,6 +1473,7 @@ times03 times03
 timerfd01 timerfd01
 timerfd02 timerfd02
 timerfd03 timerfd03
+timerfd04 timerfd04
 timerfd_create01 timerfd_create01
 timerfd_gettime01 timerfd_gettime01
 timerfd_settime01 timerfd_settime01
diff --git a/testcases/kernel/syscalls/timerfd/.gitignore b/testcases/kernel/syscalls/timerfd/.gitignore
index 1c5329966..ef388685d 100644
--- a/testcases/kernel/syscalls/timerfd/.gitignore
+++ b/testcases/kernel/syscalls/timerfd/.gitignore
@@ -1,6 +1,7 @@
 /timerfd01
 /timerfd02
 /timerfd03
+/timerfd04
 /timerfd_create01
 /timerfd_gettime01
 /timerfd_settime01
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
new file mode 100644
index 000000000..3b8bf761d
--- /dev/null
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+
+  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+
+ */
+/*
+
+   Test that timerfd adds correctly an offset with absolute expiration time.
+
+   After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+   process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+   and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
+
+ */
+
+#include <stdlib.h>
+#include "tst_safe_clocks.h"
+#include "tst_safe_timerfd.h"
+#include "tst_timer.h"
+#include "lapi/namespaces_constants.h"
+#include "tst_test.h"
+
+#define SLEEP_US 40000
+
+static struct tcase {
+	int clk_id;
+	int clk_off;
+	int off;
+} tcases[] = {
+	{CLOCK_MONOTONIC, CLOCK_MONOTONIC, 10},
+	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, 10},
+
+	{CLOCK_MONOTONIC, CLOCK_MONOTONIC, -10},
+	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, -10},
+};
+
+static void verify_timerfd(unsigned int n)
+{
+	struct timespec start, end;
+	struct itimerspec it = {};
+	struct tcase *tc = &tcases[n];
+
+	SAFE_UNSHARE(CLONE_NEWTIME);
+
+	SAFE_FILE_PRINTF("/proc/self/timens_offsets", "%d %d 0",
+	                 tc->clk_off, tc->off);
+
+	SAFE_CLOCK_GETTIME(tc->clk_id, &start);
+
+	it.it_value = tst_timespec_add_us(start, 1000000 * tc->off + SLEEP_US);
+
+	if (!SAFE_FORK()) {
+		uint64_t exp;
+		int fd = SAFE_TIMERFD_CREATE(tc->clk_id, 0);
+
+		SAFE_TIMERFD_SETTIME(fd, TFD_TIMER_ABSTIME, &it, NULL);
+
+		SAFE_READ(1, fd, &exp, sizeof(exp));
+
+		if (exp != 1)
+			tst_res(TFAIL, "Got %llu expirations", (long long unsigned)exp);
+
+		SAFE_CLOSE(fd);
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
+		tst_res(TFAIL, "timerfd %s slept too long %lli",
+		        tst_clock_name(tc->clk_id), diff);
+		return;
+	}
+
+	if (diff < SLEEP_US) {
+		tst_res(TFAIL, "timerfd %s slept too short %lli",
+		        tst_clock_name(tc->clk_id), diff);
+		return;
+	}
+
+	tst_res(TPASS, "timerfd %s slept correctly %lli",
+		tst_clock_name(tc->clk_id), diff);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_timerfd,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.23.0

