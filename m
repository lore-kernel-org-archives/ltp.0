From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 14 Apr 2020 16:30:38 +0530
Subject: [LTP] [PATCH V2 1/2] tst_timer: Add time64 related helpers
In-Reply-To: <cover.1586861885.git.viresh.kumar@linaro.org>
References: <cover.1586861885.git.viresh.kumar@linaro.org>
Message-ID: <0b30a19ac2938561f6e5e8e3264528aad6e42a76.1586861885.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This introduces a new set of helpers to handle the time64 related
timespec. Instead of duplicating the code, this moves the existing code
into a macro and then defines timespec and time64 related helpers using
it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h | 363 ++++++++++++++++++++++++--------------------
 1 file changed, 195 insertions(+), 168 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index cdb8de7987d9..3c8426fbe37d 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -15,26 +15,28 @@
 #include <sys/time.h>
 #include <time.h>
 
-static inline long long tst_timespec_to_ns(struct timespec t)
-{
-	return t.tv_sec * 1000000000 + t.tv_nsec;
-}
+#ifndef __kernel_timespec
 
-/*
- * Converts timespec to microseconds.
- */
-static inline long long tst_timespec_to_us(struct timespec t)
-{
-	return t.tv_sec * 1000000 + (t.tv_nsec + 500) / 1000;
-}
+#if defined(__x86_64__) && defined(__ILP32__)
+typedef long long __kernel_long_t;
+#else
+typedef long __kernel_long_t;
+#endif
 
-/*
- * Converts timespec to milliseconds.
- */
-static inline long long tst_timespec_to_ms(struct timespec t)
-{
-	return t.tv_sec * 1000 + (t.tv_nsec + 500000) / 1000000;
-}
+typedef __kernel_long_t	__kernel_old_time_t;
+
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	__kernel_old_time_t	tv_nsec;	/* nanoseconds */
+};
+
+typedef long long __kernel_time64_t;
+
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif
 
 /*
  * Converts timeval to microseconds.
@@ -78,134 +80,183 @@ static inline struct timeval tst_us_to_timeval(long long us)
 	return ret;
 }
 
-/*
- * Converts ms to struct timespec
- */
-static inline struct timespec tst_ms_to_timespec(long long ms)
-{
-	struct timespec ret;
-
-	ret.tv_sec = ms / 1000;
-	ret.tv_nsec = (ms % 1000) * 1000000;
-
-	return ret;
-}
-
-/*
- * Converts us to struct timespec
- */
-static inline struct timespec tst_us_to_timespec(long long us)
-{
-	struct timespec ret;
-
-	ret.tv_sec = us / 1000000;
-	ret.tv_nsec = (us % 1000000) * 1000;
-
-	return ret;
-}
-
-/*
- * Comparsions
- */
-static inline int tst_timespec_lt(struct timespec t1, struct timespec t2)
-{
-	if (t1.tv_sec == t2.tv_sec)
-		return t1.tv_nsec < t2.tv_nsec;
-
-	return t1.tv_sec < t2.tv_sec;
-}
-
-static inline struct timespec tst_timespec_normalize(struct timespec t)
-{
-	if (t.tv_nsec >= 1000000000) {
-		t.tv_sec++;
-		t.tv_nsec -= 1000000000;
-	}
-
-	if (t.tv_nsec < 0) {
-		t.tv_sec--;
-		t.tv_nsec += 1000000000;
-	}
-
-	return t;
-}
-
-/*
- * Adds us microseconds to t.
- */
-static inline struct timespec tst_timespec_add_us(struct timespec t,
-                                                  long long us)
-{
-	t.tv_sec += us / 1000000;
-	t.tv_nsec += (us % 1000000) * 1000;
-
-
-	return tst_timespec_normalize(t);
-}
-
-/*
- * Adds two timespec structures.
- */
-static inline struct timespec tst_timespec_add(struct timespec t1,
-                                               struct timespec t2)
-{
-	struct timespec res;
-
-	res.tv_sec = t1.tv_sec + t2.tv_sec;
-	res.tv_nsec = t1.tv_nsec + t2.tv_nsec;
-
-	return tst_timespec_normalize(res);
+#define DEFINE_TST_TIMESPEC_HELPERS(_name, _type)		\
+static inline long long tst_##_name##_to_ns(struct _type t)	\
+{								\
+	return t.tv_sec * 1000000000 + t.tv_nsec;		\
+}								\
+								\
+/*								\
+ * Converts timespec to microseconds.				\
+ */								\
+static inline long long tst_##_name##_to_us(struct _type t)	\
+{								\
+	return t.tv_sec * 1000000 + (t.tv_nsec + 500) / 1000;	\
+}								\
+								\
+/*								\
+ * Converts timespec to milliseconds.				\
+ */								\
+static inline long long tst_##_name##_to_ms(struct _type t)	\
+{								\
+	return t.tv_sec * 1000 + (t.tv_nsec + 500000) / 1000000;\
+}								\
+								\
+/*								\
+ * Converts ms to struct timespec				\
+ */								\
+static inline struct _type tst_ms_to_##_name(long long ms)	\
+{								\
+	struct _type ret;					\
+								\
+	ret.tv_sec = ms / 1000;					\
+	ret.tv_nsec = (ms % 1000) * 1000000;			\
+								\
+	return ret;						\
+}								\
+								\
+/*								\
+ * Converts us to struct timespec				\
+ */								\
+static inline struct _type tst_us_to_##_name(long long us)	\
+{								\
+	struct _type ret;					\
+								\
+	ret.tv_sec = us / 1000000;				\
+	ret.tv_nsec = (us % 1000000) * 1000;			\
+								\
+	return ret;						\
+}								\
+								\
+/*								\
+ * Comparsions							\
+ */								\
+static inline int tst_##_name##_lt(struct _type t1, struct _type t2) \
+{								\
+	if (t1.tv_sec == t2.tv_sec)				\
+		return t1.tv_nsec < t2.tv_nsec; 		\
+								\
+	return t1.tv_sec < t2.tv_sec;				\
+}								\
+								\
+static inline struct _type tst_##_name##_normalize(struct _type t) \
+{								\
+	if (t.tv_nsec >= 1000000000) {				\
+		t.tv_sec++;					\
+		t.tv_nsec -= 1000000000;			\
+	}							\
+								\
+	if (t.tv_nsec < 0) {					\
+		t.tv_sec--;					\
+		t.tv_nsec += 1000000000;			\
+	}							\
+								\
+	return t;						\
+}								\
+								\
+/*								\
+ * Adds us microseconds to t.					\
+ */								\
+static inline struct _type tst_##_name##_add_us(struct _type t, \
+                                                  long long us)	\
+{								\
+	t.tv_sec += us / 1000000;				\
+	t.tv_nsec += (us % 1000000) * 1000;			\
+								\
+								\
+	return tst_##_name##_normalize(t);			\
+}								\
+								\
+/*								\
+ * Adds two timespec structures.				\
+ */								\
+static inline struct _type tst_##_name##_add(struct _type t1, \
+                                               struct _type t2) \
+{								\
+	struct _type res;					\
+								\
+	res.tv_sec = t1.tv_sec + t2.tv_sec;			\
+	res.tv_nsec = t1.tv_nsec + t2.tv_nsec;			\
+								\
+	return tst_##_name##_normalize(res);			\
+}								\
+								\
+/*								\
+ * Subtracts us microseconds from t.				\
+ */								\
+static inline struct _type tst_##_name##_sub_us(struct _type t, \
+                                                  long long us)	\
+{								\
+	t.tv_sec -= us / 1000000;				\
+	t.tv_nsec -= (us % 1000000) * 1000;			\
+								\
+	return tst_##_name##_normalize(t);			\
+}								\
+								\
+/*								\
+ * Returns difference between two timespec structures.		\
+ */								\
+static inline struct _type tst_##_name##_diff(struct _type t1, \
+                                                struct _type t2) \
+{								\
+	struct _type res;					\
+								\
+	res.tv_sec = t1.tv_sec - t2.tv_sec;			\
+								\
+	if (t1.tv_nsec < t2.tv_nsec) {				\
+		res.tv_sec--;					\
+		res.tv_nsec = 1000000000 - (t2.tv_nsec - t1.tv_nsec); \
+	} else {						\
+		res.tv_nsec = t1.tv_nsec - t2.tv_nsec;		\
+	}							\
+								\
+	return res;						\
+}								\
+								\
+static inline long long tst_##_name##_diff_ns(struct _type t1, \
+					     struct _type t2) \
+{								\
+	return t1.tv_nsec - t2.tv_nsec + 1000000000LL * (t1.tv_sec - t2.tv_sec); \
+}								\
+								\
+	static inline long long tst_##_name##_diff_us(struct _type t1, \
+                                             struct _type t2) \
+{								\
+	return tst_##_name##_to_us(tst_##_name##_diff(t1, t2));	\
+}								\
+								\
+static inline long long tst_##_name##_diff_ms(struct _type t1, \
+                                             struct _type t2) \
+{								\
+	return tst_##_name##_to_ms(tst_##_name##_diff(t1, t2));	\
+}								\
+								\
+/*								\
+ * Returns absolute value of difference between two timespec structures. \
+ */								\
+static inline struct _type tst_##_name##_abs_diff(struct _type t1, \
+                                                    struct _type t2) \
+{								\
+	if (tst_##_name##_lt(t1, t2))				\
+		return tst_##_name##_diff(t2, t1);		\
+	else							\
+		return tst_##_name##_diff(t1, t2);		\
+}								\
+								\
+static inline long long tst_##_name##_abs_diff_us(struct _type t1, \
+                                                 struct _type t2) \
+{								\
+       return tst_##_name##_to_us(tst_##_name##_abs_diff(t1, t2)); \
+}								\
+								\
+static inline long long tst_##_name##_abs_diff_ms(struct _type t1, \
+                                                 struct _type t2) \
+{								\
+       return tst_##_name##_to_ms(tst_##_name##_abs_diff(t1, t2)); \
 }
 
-/*
- * Subtracts us microseconds from t.
- */
-static inline struct timespec tst_timespec_sub_us(struct timespec t,
-                                                  long long us)
-{
-	t.tv_sec -= us / 1000000;
-	t.tv_nsec -= (us % 1000000) * 1000;
-
-	return tst_timespec_normalize(t);
-}
-
-/*
- * Returns difference between two timespec structures.
- */
-static inline struct timespec tst_timespec_diff(struct timespec t1,
-                                                struct timespec t2)
-{
-	struct timespec res;
-
-	res.tv_sec = t1.tv_sec - t2.tv_sec;
-
-	if (t1.tv_nsec < t2.tv_nsec) {
-		res.tv_sec--;
-		res.tv_nsec = 1000000000 - (t2.tv_nsec - t1.tv_nsec);
-	} else {
-		res.tv_nsec = t1.tv_nsec - t2.tv_nsec;
-	}
-
-	return res;
-}
-
-static inline long long tst_timespec_diff_ns(struct timespec t1,
-					     struct timespec t2)
-{
-	return t1.tv_nsec - t2.tv_nsec + 1000000000LL * (t1.tv_sec - t2.tv_sec);
-}
-
-static inline long long tst_timespec_diff_us(struct timespec t1,
-                                             struct timespec t2)
-{
-	return tst_timespec_to_us(tst_timespec_diff(t1, t2));
-}
-
-static inline long long tst_timespec_diff_ms(struct timespec t1,
-                                             struct timespec t2)
-{
-	return tst_timespec_to_ms(tst_timespec_diff(t1, t2));
-}
+DEFINE_TST_TIMESPEC_HELPERS(timespec, timespec);
+DEFINE_TST_TIMESPEC_HELPERS(timespec64, __kernel_timespec);
 
 /*
  * Returns difference between two timeval structures.
@@ -239,30 +290,6 @@ static inline long long tst_timeval_diff_ms(struct timeval t1,
 	return tst_timeval_to_ms(tst_timeval_diff(t1, t2));
 }
 
-/*
- * Returns absolute value of difference between two timespec structures.
- */
-static inline struct timespec tst_timespec_abs_diff(struct timespec t1,
-                                                    struct timespec t2)
-{
-	if (tst_timespec_lt(t1, t2))
-		return tst_timespec_diff(t2, t1);
-	else
-		return tst_timespec_diff(t1, t2);
-}
-
-static inline long long tst_timespec_abs_diff_us(struct timespec t1,
-                                                 struct timespec t2)
-{
-       return tst_timespec_to_us(tst_timespec_abs_diff(t1, t2));
-}
-
-static inline long long tst_timespec_abs_diff_ms(struct timespec t1,
-                                                 struct timespec t2)
-{
-       return tst_timespec_to_ms(tst_timespec_abs_diff(t1, t2));
-}
-
 /*
  * Exits the test with TCONF if particular timer is not supported. This is
  * intended to be used in test setup. There is no cleanup callback parameter as
-- 
2.21.0.rc0.269.g1a574e7a288b

