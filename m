From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 29 Jan 2019 15:36:55 -0200
Subject: [LTP] [PATCH v4 4/8] lib: new restore_wallclock field to restore
	realtime clock
In-Reply-To: <20190129173659.27901-1-rafael.tinoco@linaro.org>
References: <20190124161159.GC16804@rei.lan>
 <20190129173659.27901-1-rafael.tinoco@linaro.org>
Message-ID: <20190129173659.27901-4-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some tests that change the system-wide clock need to have a way to
restore the correct time after their execution.

This commit introduces a new field to tst_test struct called
"restore_wallclock": it makes the test to save current realtime clock
during setup phase, and, later, during cleanup, restore it to the
appropriate time using a monotonic raw clock difference.

Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 doc/test-writing-guidelines.txt | 35 +++++++++++++++++++++++++
 include/tst_test.h              |  1 +
 include/tst_wallclock.h         | 15 +++++++++++
 lib/tst_test.c                  |  7 +++++
 lib/tst_wallclock.c             | 45 +++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 include/tst_wallclock.h
 create mode 100644 lib/tst_wallclock.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 731be7692..f2f72c4d6 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1539,6 +1539,41 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.29 Changing the Wall Clock Time during test execution
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There are some tests that, for different reasons, might need to change the
+system-wide clock time. Whenever this happens, it is imperative that the clock
+is restored, at the end of test's execution, taking in consideration the amount
+of time elapsed during that test.
+
+In order for that to happen, struct tst_test has a variable called
+"restore_wallclock" that should be set to "1" so LTP knows it should: (1)
+initialize a monotonic clock during test setup phase and (2) use that monotonic
+clock to fix the system-wide clock time at the test cleanup phase.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static void setup(void)
+{
+	...
+}
+
+static void run(void)
+{
+	...
+}
+
+sturct tst_test test = {
+	...
+	.setup = setup,
+	.test_all = run,
+	.restore_wallclock = 1,
+	...
+};
+-------------------------------------------------------------------------------
 
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/tst_test.h b/include/tst_test.h
index b37890959..12dda2e79 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -135,6 +135,7 @@ struct tst_test {
 	int needs_rofs:1;
 	int child_needs_reinit:1;
 	int needs_devfs:1;
+	int restore_wallclock:1;
 	/*
 	 * If set the test function will be executed for all available
 	 * filesystems and the current filesytem type would be set in the
diff --git a/include/tst_wallclock.h b/include/tst_wallclock.h
new file mode 100644
index 000000000..7d6723a7a
--- /dev/null
+++ b/include/tst_wallclock.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
+ * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
+ */
+
+
+#ifndef TST_WALLCLK_H__
+#define TST_WALLCLK_H__
+
+void tst_wallclock_save(void);
+
+void tst_wallclock_restore(void);
+
+#endif	/* TST_WALLCLK_H__ */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index da3e0c8a0..7dd890b8d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -35,6 +35,7 @@
 #include "tst_timer_test.h"
 #include "tst_clocks.h"
 #include "tst_timer.h"
+#include "tst_wallclock.h"
 #include "tst_sys_conf.h"
 #include "tst_kconfig.h"
 
@@ -872,6 +873,9 @@ static void do_setup(int argc, char *argv[])
 
 	if (tst_test->resource_files)
 		copy_resources();
+
+	if (tst_test->restore_wallclock)
+		tst_wallclock_save();
 }
 
 static void do_test_setup(void)
@@ -903,6 +907,9 @@ static void do_cleanup(void)
 		tst_sys_conf_restore(0);
 
 	cleanup_ipc();
+
+	if (tst_test->restore_wallclock)
+		tst_wallclock_restore();
 }
 
 static void run_tests(void)
diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
new file mode 100644
index 000000000..1513882f4
--- /dev/null
+++ b/lib/tst_wallclock.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Linaro Limited. All rights reserved.
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
+#include "tst_wallclock.h"
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
+	adjust = tst_timespec_add(real_begin, elapsed);
+
+	/* restore realtime clock based on monotonic delta */
+
+	if (tst_clock_settime(CLOCK_REALTIME, &adjust))
+		tst_brk(TBROK | TERRNO, "tst_clock_settime() realtime failed");
+}
-- 
2.20.1

