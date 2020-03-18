From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Mar 2020 16:38:00 +0100
Subject: [LTP] [PATCH v2 8/9] containers/timens: Add basic error test
In-Reply-To: <20200318153801.3529-1-chrubis@suse.cz>
References: <20200318153801.3529-1-chrubis@suse.cz>
Message-ID: <20200318153801.3529-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add basic error handling test for the /proc/$PID/timens_offsets file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/containers                            |  1 +
 testcases/kernel/containers/timens/.gitignore |  1 +
 testcases/kernel/containers/timens/Makefile   |  6 ++
 testcases/kernel/containers/timens/timens01.c | 68 +++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 testcases/kernel/containers/timens/.gitignore
 create mode 100644 testcases/kernel/containers/timens/Makefile
 create mode 100644 testcases/kernel/containers/timens/timens01.c

diff --git a/runtest/containers b/runtest/containers
index 1006d8d35..23e4a533d 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -90,3 +90,4 @@ userns07 userns07
 sysinfo03 sysinfo03
 clock_nanosleep03 clock_nanosleep03
 clock_gettime03 clock_gettime03
+timens01 timens01
diff --git a/testcases/kernel/containers/timens/.gitignore b/testcases/kernel/containers/timens/.gitignore
new file mode 100644
index 000000000..bcd2dd9dd
--- /dev/null
+++ b/testcases/kernel/containers/timens/.gitignore
@@ -0,0 +1 @@
+timens01
diff --git a/testcases/kernel/containers/timens/Makefile b/testcases/kernel/containers/timens/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/containers/timens/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kernel/containers/timens/timens01.c
new file mode 100644
index 000000000..2dbfebfa8
--- /dev/null
+++ b/testcases/kernel/containers/timens/timens01.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+
+  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+
+ */
+/*
+
+  Basic test for timens_offsets error handling.
+
+  After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
+  process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
+  and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
+
+ */
+
+#define _GNU_SOURCE
+#include "lapi/namespaces_constants.h"
+#include "lapi/posix_clocks.h"
+#include "tst_test.h"
+
+static struct tcase {
+	const char *desc;
+	const char *offsets;
+	int exp_err;
+} tcases[] = {
+	{"Obvious garbage", "not an offset", EINVAL},
+	{"Missing nanoseconds", "1 10", EINVAL},
+	{"Negative nanoseconds", "1 10 -10", EINVAL},
+	{"Nanoseconds > 1s", "1 10 1000000001", EINVAL},
+	{"Unsupported CLOCK_REALTIME", "0 10 0", EINVAL},
+	{"Mess on the second line", "1 10 0\na", EINVAL},
+	{"Overflow kernel 64bit ns timer", "1 9223372036 0", ERANGE},
+	{"Overflow kernel 64bit ns timer", "1 -9223372036 0", ERANGE},
+};
+
+static void verify_ns_clock(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd, ret;
+
+	SAFE_UNSHARE(CLONE_NEWTIME);
+
+	fd = SAFE_OPEN("/proc/self/timens_offsets", O_WRONLY);
+	ret = write(fd, tc->offsets, strlen(tc->offsets));
+
+	if (ret != -1) {
+		tst_res(TFAIL, "%s returned %i", tc->desc, ret);
+		return;
+	}
+
+	if (errno != tc->exp_err) {
+		tst_res(TFAIL | TERRNO, "%s should fail with %s, got:",
+			tc->desc, tst_strerrno(tc->exp_err));
+		return;
+	}
+
+	tst_res(TPASS | TERRNO, "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_ns_clock,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TIME_NS=y"
+	}
+};
-- 
2.24.1

