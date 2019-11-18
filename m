From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Nov 2019 10:34:55 +0800
Subject: [LTP] [PATCH v6 2/2] syscalls/prctl09: New timer sample test for
 PR_SET_TIMERSLACK
In-Reply-To: <1574044495-2813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20191115163517.GB25964@rei.lan>
 <1574044495-2813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1574044495-2813-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/prctl/.gitignore |  1 +
 testcases/kernel/syscalls/prctl/Makefile   |  2 +-
 testcases/kernel/syscalls/prctl/prctl09.c  | 47 ++++++++++++++++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/prctl/prctl09.c

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
index 000000000..0d94df7b5
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
+ *  This is a timer sample test that timer slack is 200us.
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



