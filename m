From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 8 Nov 2019 20:00:19 +0800
Subject: [LTP] [PATCH v5 2/2] syscalls/prctl09: New timer sample test for
 PR_SET_TIMERSLACK
In-Reply-To: <1573214419-15435-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191107130543.GD22352@rei.lan>
 <1573214419-15435-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1573214419-15435-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It also moves test setup function before timer setup function,
so we can get this set value.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_timer_test.c                       |  8 ++--
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/prctl/.gitignore |  1 +
 testcases/kernel/syscalls/prctl/Makefile   |  2 +-
 testcases/kernel/syscalls/prctl/prctl09.c  | 47 ++++++++++++++++++++++
 5 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/prctl/prctl09.c

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index f6459e5c0..13e9deff2 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -340,6 +340,9 @@ static void timer_setup(void)
 	struct timespec t;
 	int ret;
 
+	if (setup)
+		setup();
+
 	tst_clock_getres(CLOCK_MONOTONIC, &t);
 
 	tst_res(TINFO, "CLOCK_MONOTONIC resolution %lins", (long)t.tv_nsec);
@@ -360,16 +363,11 @@ static void timer_setup(void)
 	tst_res(TINFO, "PR_GET_TIMERSLACK not defined, using %uus",
 		timerslack);
 #endif /* PR_GET_TIMERSLACK */
-
 	parse_timer_opts();
 
 	samples = SAFE_MALLOC(sizeof(long long) * MAX(MAX_SAMPLES, sample_cnt));
-
 	if (set_latency() < 0)
 		tst_res(TINFO, "Failed to set zero latency constraint: %m");
-
-	if (setup)
-		setup();
 }
 
 static void timer_cleanup(void)
diff --git a/runtest/syscalls b/runtest/syscalls
index fee91f909..e4e162b23 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -880,6 +880,7 @@ prctl05 prctl05
 prctl06 prctl06
 prctl07 prctl07
 prctl08 prctl08
+prctl09 prctl09
 
 pread01 pread01
 pread01_64 pread01_64
diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
index fe36a8e0f..0f2c9b194 100644
--- a/testcases/kernel/syscalls/prctl/.gitignore
+++ b/testcases/kernel/syscalls/prctl/.gitignore
@@ -7,3 +7,4 @@
 /prctl06_execve
 /prctl07
 /prctl08
+/prctl09
diff --git a/testcases/kernel/syscalls/prctl/Makefile b/testcases/kernel/syscalls/prctl/Makefile
index cf19507c0..c02b6d1de 100644
--- a/testcases/kernel/syscalls/prctl/Makefile
+++ b/testcases/kernel/syscalls/prctl/Makefile
@@ -21,5 +21,5 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 prctl07: LDLIBS += $(CAP_LIBS)
-
+prctl09: LDLIBS += -lrt
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/prctl/prctl09.c b/testcases/kernel/syscalls/prctl/prctl09.c
new file mode 100644
index 000000000..e4d76ef85
--- /dev/null
+++ b/testcases/kernel/syscalls/prctl/prctl09.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*
+ * Test Description:
+ *  This is a timer sampling tests that timer slack is 200us.
+ */
+
+#include <errno.h>
+#include <sys/prctl.h>
+#include "lapi/prctl.h"
+#include "tst_timer_test.h"
+
+int sample_fn(int clk_id, long long usec)
+{
+	struct timespec t = tst_us_to_timespec(usec);
+
+	tst_timer_start(clk_id);
+	TEST(nanosleep(&t, NULL));
+	tst_timer_stop();
+	tst_timer_sample();
+
+	if (TST_RET != 0) {
+		tst_res(TFAIL | TTERRNO,
+			"nanosleep() returned %li", TST_RET);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void setup(void)
+{
+	TEST(prctl(PR_SET_TIMERSLACK, 200000));
+	if (TST_RET != 0)
+		tst_brk(TBROK | TTERRNO,
+			"prctl set timerslack 200us failed");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.scall = "prctl()",
+	.sample = sample_fn,
+};
-- 
2.18.0



