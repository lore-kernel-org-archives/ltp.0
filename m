From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 12 Dec 2018 18:37:21 -0200
Subject: [LTP] [PATCH v3 4/6] lib: new restore_wallclock field to restore
	realtime clock
In-Reply-To: <20181212203723.18810-1-rafael.tinoco@linaro.org>
References: <20181211142750.GA27159@rei>
 <20181212203723.18810-1-rafael.tinoco@linaro.org>
Message-ID: <20181212203723.18810-4-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests around clocks need to restore the correct date and time after
the tests, including possible iterations, run.

This commit introduces a new field to tst_test called
"restore_wallclock", which makes the test to save current realtime clock
during setup phase, and, later, during cleanup, restore it to the
appropriate time using a monotonic raw clock difference.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/tst_test.h  |  1 +
 lib/tst_test.c      |  6 ++++++
 lib/tst_wallclock.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 lib/tst_wallclock.c

diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746eb..170bddc21 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -131,6 +131,7 @@ struct tst_test {
 	int needs_rofs:1;
 	int child_needs_reinit:1;
 	int needs_devfs:1;
+	int restore_wallclock:1;
 	/*
 	 * If set the test function will be executed for all available
 	 * filesystems and the current filesytem type would be set in the
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbfce..aa3d674f0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -868,6 +868,9 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->resource_files)
 		copy_resources();
+
+	if (tst_test->restore_wallclock)
+		tst_wallclock_save();
 }
 
 static void do_test_setup(void)
@@ -899,6 +902,9 @@ static void do_cleanup(void)
 		tst_sys_conf_restore(0);
 
 	cleanup_ipc();
+
+	if (tst_test->restore_wallclock)
+		tst_wallclock_restore();
 }
 
 static void run_tests(void)
diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
new file mode 100644
index 000000000..ef08e1dba
--- /dev/null
+++ b/lib/tst_wallclock.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+#include <errno.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_timer.h"
+#include "tst_clocks.h"
+#include "lapi/posix_clocks.h"
+
+static struct timespec real_begin, mono_begin;
+
+void tst_wallclock_save(void)
+{
+	/* save initial monotonic time to restore it when needed */
+
+	if (tst_clock_gettime(CLOCK_REALTIME, &real_begin))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() realtime failed");
+
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_begin))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+}
+
+void tst_wallclock_restore(void)
+{
+	static struct timespec mono_end, elapsed, adjust;
+
+	if (tst_clock_gettime(CLOCK_MONOTONIC_RAW, &mono_end))
+		tst_brk(TBROK | TERRNO, "tst_clock_gettime() monotonic failed");
+
+	elapsed = tst_timespec_diff(mono_end, mono_begin);
+
+	adjust = tst_timespec_add_us(real_begin, tst_timespec_to_us(elapsed));
+
+	/* restore realtime clock based on monotonic delta */
+
+	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
+		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
+}
-- 
2.20.0.rc1

