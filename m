From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Jun 2017 18:00:34 +0200
Subject: [LTP] [RFC] [PATCH 2/2] tst_timer.h: Make time conversions saturated
In-Reply-To: <20170613160034.10042-1-chrubis@suse.cz>
References: <20170613160034.10042-1-chrubis@suse.cz>
Message-ID: <20170613160034.10042-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The conversions of struct timeval and struct timespec to us and ms are
now saturated so instead of overflowing/underflowing long long these
return LLONG_MAX/LLONG_MIN.

This commit also adds tst_us_to_timespec(), tst_ms_to_timespec() and
newlib_tests/tst_timer test to assert that the saturated conversion
actually works.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_timer.h          | 129 ++++++++++++++++++++++++++++++++++++++++---
 lib/newlib_tests/.gitignore  |   1 +
 lib/newlib_tests/tst_timer.c | 126 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 8 deletions(-)
 create mode 100644 lib/newlib_tests/tst_timer.c

diff --git a/include/tst_timer.h b/include/tst_timer.h
index f294b0eb7..b1f595bd4 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -33,37 +33,124 @@
 
 #include <sys/time.h>
 #include <time.h>
+#include <limits.h>
+
+#define LLONG_MAX_USEC_OVERFLOW(sec, usec) \
+	(sizeof(time_t) == 8 && ((sec == LLONG_MAX/1000000 && usec > LLONG_MAX%1000000) \
+	 || (sec > LLONG_MAX/1000000)))
+
+#define LLONG_MIN_USEC_UNDERFLOW(sec, usec) \
+	((sec == LLONG_MIN/1000000 && usec < LLONG_MIN%1000000) \
+	 || (sec < LLONG_MIN/1000000))
+
+#define LLONG_MAX_MSEC_OVERFLOW(sec, msec) \
+	((sec == LLONG_MAX/1000 && msec > LLONG_MAX%1000) \
+	 || (sec > LLONG_MAX/1000))
+
+#define LLONG_MIN_MSEC_UNDERFLOW(sec, msec) \
+	((sec == LLONG_MIN/1000 && msec < LLONG_MIN%1000) \
+	 || (sec < LLONG_MIN/1000))
+
+/*
+ * Normalize timespec so that abs(tv_nsec) is smaller than 1s.
+ */
+static inline struct timespec tst_normalize_timespec(struct timespec t)
+{
+	t.tv_sec += t.tv_nsec / 1000000000;
+	t.tv_nsec %= 1000000000;
+
+	return t;
+}
+
+/*
+ * Normalize timeval so that abs(tv_usec) is smaller than 1s.
+ */
+static inline struct timeval tst_normalize_timeval(struct timeval t)
+{
+	t.tv_sec += t.tv_usec / 1000000;
+	t.tv_usec %= 1000000;
+
+	return t;
+}
 
 /*
- * Converts timespec to microseconds.
+ * Saturated conversion from timespec to microseconds.
  */
 static inline long long tst_timespec_to_us(struct timespec t)
 {
-	return t.tv_sec * 1000000 + (t.tv_nsec + 500) / 1000;
+	t = tst_normalize_timespec(t);
+
+	long long usec = (t.tv_nsec + 500) / 1000;
+
+#if LONG_MAX > 0xffffffff
+	if (LLONG_MAX_USEC_OVERFLOW(t.tv_sec, usec))
+		return LLONG_MAX;
+
+	if (LLONG_MIN_USEC_UNDERFLOW(t.tv_sec, usec))
+		return LLONG_MIN;
+#endif
+
+	return t.tv_sec * 1000000 + usec;
 }
 
 /*
- * Converts timespec to miliseconds.
+ * Saturated conversion from timespec to miliseconds.
  */
 static inline long long tst_timespec_to_ms(struct timespec t)
 {
-	return t.tv_sec * 1000 + (t.tv_nsec + 500000) / 1000000;
+	t = tst_normalize_timespec(t);
+
+	long long msec = (t.tv_nsec + 500000) / 1000000;
+
+#if LONG_MAX > 0xffffffff
+	if (LLONG_MAX_MSEC_OVERFLOW(t.tv_sec, msec))
+		return LLONG_MAX;
+
+	if (LLONG_MIN_MSEC_UNDERFLOW(t.tv_sec, msec))
+		return LLONG_MIN;
+#endif
+
+	return t.tv_sec * 1000 + msec;
 }
 
 /*
- * Converts timeval to microseconds.
+ * Saturated conversion from timeval to microseconds.
  */
 static inline long long tst_timeval_to_us(struct timeval t)
 {
-	return t.tv_sec * 1000000 + t.tv_usec;
+	t = tst_normalize_timeval(t);
+
+	long long usec = t.tv_usec;
+
+#if LONG_MAX > 0xffffffff
+	if (LLONG_MAX_USEC_OVERFLOW(t.tv_sec, usec))
+		return LLONG_MAX;
+
+	if (LLONG_MIN_USEC_UNDERFLOW(t.tv_sec, usec))
+		return LLONG_MIN;
+#endif
+
+	return t.tv_sec * 1000000 + usec;
 }
 
 /*
- * Converts timeval to miliseconds.
+ * Saturated conversion from timeval to miliseconds.
  */
 static inline long long tst_timeval_to_ms(struct timeval t)
 {
-	return t.tv_sec * 1000 + (t.tv_usec + 500) / 1000;
+	t = tst_normalize_timeval(t);
+
+	long long msec = (t.tv_usec + 500) / 1000;
+
+#if LONG_MAX > 0xffffffff
+	if (LLONG_MAX_MSEC_OVERFLOW(t.tv_sec, msec))
+		return LLONG_MAX;
+
+	if (LLONG_MIN_MSEC_UNDERFLOW(t.tv_sec, msec))
+		return LLONG_MIN;
+#endif
+
+	return t.tv_sec * 1000 + msec;
 }
 
 /*
@@ -93,6 +180,32 @@ static inline struct timeval tst_us_to_timeval(long long us)
 }
 
 /*
+ * Converts ms to struct timespec
+ */
+static inline struct timespec tst_ms_to_timespec(long long ms)
+{
+	struct timespec ret;
+
+	ret.tv_sec = ms / 1000;
+	ret.tv_nsec = (ms % 1000) * 1000000;
+
+	return ret;
+}
+
+/*
+ * Converts us to struct timespec
+ */
+static inline struct timespec tst_us_to_timespec(long long us)
+{
+	struct timespec ret;
+
+	ret.tv_sec = us / 1000000;
+	ret.tv_nsec = (us % 1000000) * 1000;
+
+	return ret;
+}
+
+/*
  * Comparsions
  */
 static inline int tst_timespec_lt(struct timespec t1, struct timespec t2)
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 8e120074e..0405c3e2e 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -15,3 +15,4 @@ test14
 tst_device
 tst_safe_fileops
 tst_res_hexd
+tst_timer
diff --git a/lib/newlib_tests/tst_timer.c b/lib/newlib_tests/tst_timer.c
new file mode 100644
index 000000000..d29ac263b
--- /dev/null
+++ b/lib/newlib_tests/tst_timer.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+ /*
+  * Tests saturated timeval and timespec to us and ms conversions.
+  */
+
+#include "tst_test.h"
+#include "tst_timer.h"
+
+static void timeval_overflow_us_test(long long us_add)
+{
+	struct timeval tv;
+	long long us;
+
+	tst_res(TINFO, "Testing for timeval overflow by %llius", us_add);
+
+	tv = tst_us_to_timeval(LLONG_MAX);
+	tv.tv_usec += us_add;
+
+	tst_res(TINFO, "tv_sec=%li tv_usec=%li", tv.tv_sec, tv.tv_usec);
+
+	us = tst_timeval_to_us(tv);
+
+	long long expected = LLONG_MAX;
+
+	if (us_add < 0)
+		expected = LLONG_MAX + us_add;
+
+	if (us != expected)
+		tst_res(TFAIL, "Got %lli, expected %lli", us, expected);
+	else
+		tst_res(TPASS, "Got %lli", expected);
+}
+
+static void timeval_underflow_us_test(long long us_add)
+{
+	struct timeval tv;
+	long long us;
+
+	tst_res(TINFO, "Testing for timeval underflow by %llius", us_add);
+
+	tv = tst_us_to_timeval(LLONG_MIN);
+	tv.tv_usec += us_add;
+
+	tst_res(TINFO, "tv_sec=%li tv_usec=%li", tv.tv_sec, tv.tv_usec);
+
+	us = tst_timeval_to_us(tv);
+
+	long long expected = LLONG_MIN;
+
+	if (us_add > 0)
+		expected = LLONG_MIN + us_add;
+
+	if (us != expected)
+		tst_res(TFAIL, "Got %lli, expected %lli", us, expected);
+	else
+		tst_res(TPASS, "Got %lli", expected);
+}
+
+static void timespec_overflow_us_test(long long us_add)
+{
+	struct timespec ts;
+	long long us;
+
+	tst_res(TINFO, "Testing for timespec overflow by %llius", us_add);
+
+	ts = tst_us_to_timespec(LLONG_MAX);
+	ts.tv_nsec += us_add * 1000;
+
+	tst_res(TINFO, "tv_sec=%li tv_nsec=%li", ts.tv_sec, ts.tv_nsec);
+
+	us = tst_timespec_to_us(ts);
+
+	long long expected = LLONG_MAX;
+
+	if (us_add < 0)
+		expected = LLONG_MAX + us_add;
+
+	if (us != expected)
+		tst_res(TFAIL, "Got %lli, expected %lli", us, expected);
+	else
+		tst_res(TPASS, "Got %lli", expected);
+}
+
+static void do_test(void)
+{
+	if (sizeof(time_t) == 4)
+		tst_brk(TCONF, "sizeof(time_t) == 4");
+
+	timeval_overflow_us_test(0);
+	timeval_overflow_us_test(1);
+	timeval_overflow_us_test(-1);
+	timeval_overflow_us_test(1000000);
+	timeval_overflow_us_test(-1000000);
+
+	timeval_underflow_us_test(0);
+	timeval_underflow_us_test(1);
+	timeval_underflow_us_test(-1);
+	timeval_underflow_us_test(1000000);
+	timeval_underflow_us_test(-1000000);
+
+	timespec_overflow_us_test(0);
+	timespec_overflow_us_test(1);
+	timespec_overflow_us_test(-1);
+	timespec_overflow_us_test(100000);
+	timespec_overflow_us_test(-100000);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.13.0

