From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jun 2018 11:28:46 +0200
Subject: [LTP] [RFC] [PATCH] tst_timer: Add tst_timer_expired_ms()
Message-ID: <20180628092846.21204-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Recently we were in the need of easy way to run a testcase for a given
time interval. We nearly had everything in the timer library already but
the problem was that the sampling function i.e. tst_timer_stop() and
conversion functions e.g. tst_timer_elapsed_ms() were separated.

This commit adds a tst_timer_expired_ms() function that combines the
sampling and comparsion, the intended usage is:

static void setup(void)
{
	...
	tst_timer_check(CLOCK_MONOTONIC);
	...
}

static void run(void)
{
	...

	tst_timer_start(CLOCK_MONOTONIC);

	...

	while (!tst_timer_expired_ms(5000)) {
		...
	}

	...
}

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Eric Biggers <ebiggers3@gmail.com>
---
 doc/test-writing-guidelines.txt         | 41 +++++++++++++++++++++++++++++-
 include/tst_timer.h                     |  8 ++++++
 lib/newlib_tests/.gitignore             |  1 +
 lib/newlib_tests/Makefile               |  1 +
 lib/newlib_tests/tst_expiration_timer.c | 45 +++++++++++++++++++++++++++++++++
 lib/tst_timer.c                         | 10 ++++++++
 6 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 lib/newlib_tests/tst_expiration_timer.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index bf421e11d..97b4fd875 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1167,7 +1167,7 @@ const char *const cmd[] = { "ls", "-l", NULL };
 
 [source,c]
 -------------------------------------------------------------------------------
-#include "tst_test.h"
+#include "tst_timer.h"
 
 void tst_timer_check(clockid_t clk_id);
 
@@ -1180,6 +1180,8 @@ struct timespec tst_timer_elapsed(void);
 long long tst_timer_elapsed_ms(void);
 
 long long tst_timer_elapsed_us(void);
+
+int tst_timer_expired_ms(long long ms);
 -------------------------------------------------------------------------------
 
 The 'tst_timer_check()' function checks if specified 'clk_id' is suppored and
@@ -1196,12 +1198,49 @@ call to 'tst_timer_start()'.
 The 'tst_timer_elapsed*()' returns time difference between the timer start and
 last timer stop in several formats and units.
 
+The 'tst_timer_expired_ms()' function checks if the timer started by
+'tst_timer_start()' has been running longer than ms miliseconds. The function
+returns non-zero if timer has expired and zero otherwise.
+
 IMPORTANT: The timer functions use 'clock_gettime()' internally which needs to
            be linked with '-lrt' on older glibc. Please do not forget to add
 	   'LDLIBS+=-lrt' in Makefile.
 
 [source,c]
 -------------------------------------------------------------------------------
+#include "tst_test.h"
+#include "tst_timer.h"
+
+static void setup(void)
+{
+	...
+	tst_timer_check(CLOCK_MONOTONIC);
+	...
+}
+
+static void run(void)
+{
+	...
+	tst_timer_start(CLOCK_MONOTONIC);
+	...
+	while (!tst_timer_expired_ms(5000)) {
+		...
+	}
+	...
+}
+
+sturct tst_test test = {
+	...
+	.setup = setup,
+	.test_all = run,
+	...
+};
+-------------------------------------------------------------------------------
+
+Expiration timer example usage.
+
+[source,c]
+-------------------------------------------------------------------------------
 long long tst_timespec_to_us(struct timespec t);
 long long tst_timespec_to_ms(struct timespec t);
 
diff --git a/include/tst_timer.h b/include/tst_timer.h
index 1b00e3cd1..0fd7ed6cf 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -252,6 +252,14 @@ void tst_timer_check(clockid_t clk_id);
 void tst_timer_start(clockid_t clk_id);
 
 /*
+ * Returns true if timer started by tst_timer_start() has been running for
+ * longer than ms seconds.
+ *
+ * @ms: Time interval in miliseconds.
+ */
+int tst_timer_expired_ms(long long ms);
+
+/*
  * Marks timer end time.
  */
 void tst_timer_stop(void);
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index d0ff41929..8c0981ec8 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -19,3 +19,4 @@ tst_safe_fileops
 tst_res_hexd
 tst_strstatus
 test17
+tst_expiration_timer
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index afa09373e..2fc50160a 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -10,6 +10,7 @@ test09: CFLAGS+=-pthread
 test15: CFLAGS+=-pthread
 test16: CFLAGS+=-pthread
 test16: LDLIBS+=-lrt
+tst_expiration_timer: LDLIBS+=-lrt
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
diff --git a/lib/newlib_tests/tst_expiration_timer.c b/lib/newlib_tests/tst_expiration_timer.c
new file mode 100644
index 000000000..2543d53ec
--- /dev/null
+++ b/lib/newlib_tests/tst_expiration_timer.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+/*
+ * Test for expiration timer the test should run for roughly 5 seconds
+ * when executed as time ./tst_expiration_timer
+ */
+
+#include "tst_test.h"
+#include "tst_timer.h"
+
+static void do_test(void)
+{
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	while (!tst_timer_expired_ms(5000))
+		usleep(1);
+
+	tst_res(TPASS, "All done!");
+}
+
+static void setup(void)
+{
+	tst_timer_check(CLOCK_MONOTONIC);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = do_test,
+};
diff --git a/lib/tst_timer.c b/lib/tst_timer.c
index afdb44172..53ff36777 100644
--- a/lib/tst_timer.c
+++ b/lib/tst_timer.c
@@ -77,6 +77,16 @@ void tst_timer_start(clockid_t clk_id)
 		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
 }
 
+int tst_timer_expired_ms(long long ms)
+{
+	struct timespec cur_time;
+
+	if (tst_clock_gettime(clock_id, &cur_time))
+		tst_resm(TWARN | TERRNO, "tst_clock_gettime() failed");
+
+	return tst_timespec_diff_ms(cur_time, start_time) >= ms;
+}
+
 void tst_timer_stop(void)
 {
 	if (tst_clock_gettime(clock_id, &stop_time))
-- 
2.13.6

