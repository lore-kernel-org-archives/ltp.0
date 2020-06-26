From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 26 Jun 2020 11:52:14 +0530
Subject: [LTP] [PATCH V7 01/19] tst_timer: Add new definitions
In-Reply-To: <cover.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <6c96466165bb88f052676e6ce5c8eed41cbe628a.1593152309.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds new helpers for itimerspec and wrapper functions for
multiple syscalls. These will be used by later patches.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h | 326 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 305 insertions(+), 21 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 82e3e1e308f1..7fd4a7093960 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -12,9 +12,12 @@
 #ifndef TST_TIMER
 #define TST_TIMER
 
+#include <sched.h>
 #include <sys/time.h>
+#include <mqueue.h>
 #include <time.h>
 #include "tst_test.h"
+#include "lapi/common_timers.h"
 #include "lapi/posix_types.h"
 #include "lapi/syscalls.h"
 
@@ -112,6 +115,16 @@ struct __kernel_timespec {
 	__kernel_time64_t       tv_sec;                 /* seconds */
 	long long               tv_nsec;                /* nanoseconds */
 };
+
+struct __kernel_old_itimerspec {
+	struct __kernel_old_timespec it_interval;    /* timer period */
+	struct __kernel_old_timespec it_value;       /* timer expiration */
+};
+
+struct __kernel_itimerspec {
+	struct __kernel_timespec it_interval;    /* timer period */
+	struct __kernel_timespec it_value;       /* timer expiration */
+};
 #endif
 
 enum tst_ts_type {
@@ -129,6 +142,14 @@ struct tst_ts {
 	} ts;
 };
 
+struct tst_its {
+	enum tst_ts_type type;
+	union {
+		struct __kernel_old_itimerspec kern_old_its;
+		struct __kernel_itimerspec kern_its;
+	} ts;
+};
+
 static inline void *tst_ts_get(struct tst_ts *t)
 {
 	if (!t)
@@ -147,6 +168,22 @@ static inline void *tst_ts_get(struct tst_ts *t)
 	}
 }
 
+static inline void *tst_its_get(struct tst_its *t)
+{
+	if (!t)
+		return NULL;
+
+	switch (t->type) {
+	case TST_KERN_OLD_TIMESPEC:
+		return &t->ts.kern_old_its;
+	case TST_KERN_TIMESPEC:
+		return &t->ts.kern_its;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", t->type);
+		return NULL;
+	}
+}
+
 static inline int libc_clock_getres(clockid_t clk_id, void *ts)
 {
 	return clock_getres(clk_id, ts);
@@ -212,6 +249,117 @@ static inline int sys_clock_nanosleep64(clockid_t clk_id, int flags,
 			   request, remain);
 }
 
+static inline int sys_futex(int *uaddr, int futex_op, int val, void *to,
+			    int *uaddr2, int val3)
+{
+	return tst_syscall(__NR_futex, uaddr, futex_op, val, to, uaddr2, val3);
+}
+
+static inline int sys_futex_time64(int *uaddr, int futex_op, int val, void *to,
+				   int *uaddr2, int val3)
+{
+	return tst_syscall(__NR_futex_time64, uaddr, futex_op, val, to, uaddr2, val3);
+}
+
+static inline int libc_mq_timedsend(mqd_t mqdes, const char *msg_ptr,
+		size_t msg_len, unsigned int msg_prio, void *abs_timeout)
+{
+	return mq_timedsend(mqdes, msg_ptr, msg_len, msg_prio, abs_timeout);
+}
+
+static inline int sys_mq_timedsend(mqd_t mqdes, const char *msg_ptr,
+		size_t msg_len, unsigned int msg_prio, void *abs_timeout)
+{
+	return tst_syscall(__NR_mq_timedsend, mqdes, msg_ptr, msg_len, msg_prio,
+			   abs_timeout);
+}
+
+static inline int sys_mq_timedsend64(mqd_t mqdes, const char *msg_ptr,
+		size_t msg_len, unsigned int msg_prio, void *abs_timeout)
+{
+	return tst_syscall(__NR_mq_timedsend_time64, mqdes, msg_ptr, msg_len,
+			   msg_prio, abs_timeout);
+}
+
+static inline ssize_t libc_mq_timedreceive(mqd_t mqdes, char *msg_ptr,
+		size_t msg_len, unsigned int *msg_prio, void *abs_timeout)
+{
+	return mq_timedreceive(mqdes, msg_ptr, msg_len, msg_prio, abs_timeout);
+}
+
+static inline ssize_t sys_mq_timedreceive(mqd_t mqdes, char *msg_ptr,
+		size_t msg_len, unsigned int *msg_prio, void *abs_timeout)
+{
+	return tst_syscall(__NR_mq_timedreceive, mqdes, msg_ptr, msg_len,
+			   msg_prio, abs_timeout);
+}
+
+static inline ssize_t sys_mq_timedreceive64(mqd_t mqdes, char *msg_ptr,
+		size_t msg_len, unsigned int *msg_prio, void *abs_timeout)
+{
+	return tst_syscall(__NR_mq_timedreceive_time64, mqdes, msg_ptr, msg_len,
+			   msg_prio, abs_timeout);
+}
+
+static inline int libc_sched_rr_get_interval(pid_t pid, void *ts)
+{
+	return sched_rr_get_interval(pid, ts);
+}
+
+static inline int sys_sched_rr_get_interval(pid_t pid, void *ts)
+{
+	return tst_syscall(__NR_sched_rr_get_interval, pid, ts);
+}
+
+static inline int sys_sched_rr_get_interval64(pid_t pid, void *ts)
+{
+	return tst_syscall(__NR_sched_rr_get_interval_time64, pid, ts);
+}
+
+static inline int sys_timer_gettime(timer_t timerid, void *its)
+{
+	return tst_syscall(__NR_timer_gettime, timerid, its);
+}
+
+static inline int sys_timer_gettime64(timer_t timerid, void *its)
+{
+	return tst_syscall(__NR_timer_gettime64, timerid, its);
+}
+
+static inline int sys_timer_settime(timer_t timerid, int flags, void *its,
+				    void *old_its)
+{
+	return tst_syscall(__NR_timer_settime, timerid, flags, its, old_its);
+}
+
+static inline int sys_timer_settime64(timer_t timerid, int flags, void *its,
+				      void *old_its)
+{
+	return tst_syscall(__NR_timer_settime64, timerid, flags, its, old_its);
+}
+
+static inline int sys_timerfd_gettime(int fd, void *its)
+{
+	return tst_syscall(__NR_timerfd_gettime, fd, its);
+}
+
+static inline int sys_timerfd_gettime64(int fd, void *its)
+{
+	return tst_syscall(__NR_timerfd_gettime64, fd, its);
+}
+
+static inline int sys_timerfd_settime(int fd, int flags, void *its,
+				      void *old_its)
+{
+	return tst_syscall(__NR_timerfd_settime, fd, flags, its, old_its);
+}
+
+static inline int sys_timerfd_settime64(int fd, int flags, void *its,
+				      void *old_its)
+{
+	return tst_syscall(__NR_timerfd_settime64, fd, flags, its, old_its);
+}
+
 /*
  * Returns tst_ts seconds.
  */
@@ -248,27 +396,6 @@ static inline long long tst_ts_get_nsec(struct tst_ts ts)
 	}
 }
 
-/*
- * Checks that timespec is valid, i.e. that the timestamp is not zero and that
- * the nanoseconds are normalized i.e. in <0, 1s) interval.
- *
- *  0: On success, i.e. timespec updated correctly.
- * -1: Error, timespec not updated.
- * -2: Error, tv_nsec is corrupted.
- */
-static inline int tst_ts_valid(struct tst_ts *t)
-{
-	long long nsec = tst_ts_get_nsec(*t);
-
-	if (nsec < 0 || nsec >= 1000000000)
-		return -2;
-
-	if (tst_ts_get_sec(*t) == 0 && tst_ts_get_nsec(*t) == 0)
-		return -1;
-
-	return 0;
-}
-
 /*
  * Sets tst_ts seconds.
  */
@@ -309,6 +436,163 @@ static inline void tst_ts_set_nsec(struct tst_ts *ts, long long nsec)
 	}
 }
 
+/*
+ * Returns tst_its it_interval seconds.
+ */
+static inline long long tst_its_get_interval_sec(struct tst_its its)
+{
+	switch (its.type) {
+	case TST_KERN_OLD_TIMESPEC:
+		return its.ts.kern_old_its.it_interval.tv_sec;
+	case TST_KERN_TIMESPEC:
+		return its.ts.kern_its.it_interval.tv_sec;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its.type);
+		return -1;
+	}
+}
+
+/*
+ * Returns tst_its it_interval nanoseconds.
+ */
+static inline long long tst_its_get_interval_nsec(struct tst_its its)
+{
+	switch (its.type) {
+	case TST_KERN_OLD_TIMESPEC:
+		return its.ts.kern_old_its.it_interval.tv_nsec;
+	case TST_KERN_TIMESPEC:
+		return its.ts.kern_its.it_interval.tv_nsec;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its.type);
+		return -1;
+	}
+}
+
+/*
+ * Sets tst_its it_interval seconds.
+ */
+static inline void tst_its_set_interval_sec(struct tst_its *its, long long sec)
+{
+	switch (its->type) {
+	break;
+	case TST_KERN_OLD_TIMESPEC:
+		its->ts.kern_old_its.it_interval.tv_sec = sec;
+	break;
+	case TST_KERN_TIMESPEC:
+		its->ts.kern_its.it_interval.tv_sec = sec;
+	break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its->type);
+	}
+}
+
+/*
+ * Sets tst_its it_interval nanoseconds.
+ */
+static inline void tst_its_set_interval_nsec(struct tst_its *its, long long nsec)
+{
+	switch (its->type) {
+	break;
+	case TST_KERN_OLD_TIMESPEC:
+		its->ts.kern_old_its.it_interval.tv_nsec = nsec;
+	break;
+	case TST_KERN_TIMESPEC:
+		its->ts.kern_its.it_interval.tv_nsec = nsec;
+	break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its->type);
+	}
+}
+
+/*
+ * Returns tst_its it_value seconds.
+ */
+static inline long long tst_its_get_value_sec(struct tst_its its)
+{
+	switch (its.type) {
+	case TST_KERN_OLD_TIMESPEC:
+		return its.ts.kern_old_its.it_value.tv_sec;
+	case TST_KERN_TIMESPEC:
+		return its.ts.kern_its.it_value.tv_sec;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its.type);
+		return -1;
+	}
+}
+
+/*
+ * Returns tst_its it_value nanoseconds.
+ */
+static inline long long tst_its_get_value_nsec(struct tst_its its)
+{
+	switch (its.type) {
+	case TST_KERN_OLD_TIMESPEC:
+		return its.ts.kern_old_its.it_value.tv_nsec;
+	case TST_KERN_TIMESPEC:
+		return its.ts.kern_its.it_value.tv_nsec;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its.type);
+		return -1;
+	}
+}
+
+/*
+ * Sets tst_its it_value seconds.
+ */
+static inline void tst_its_set_value_sec(struct tst_its *its, long long sec)
+{
+	switch (its->type) {
+	break;
+	case TST_KERN_OLD_TIMESPEC:
+		its->ts.kern_old_its.it_value.tv_sec = sec;
+	break;
+	case TST_KERN_TIMESPEC:
+		its->ts.kern_its.it_value.tv_sec = sec;
+	break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its->type);
+	}
+}
+
+/*
+ * Sets tst_its it_value nanoseconds.
+ */
+static inline void tst_its_set_value_nsec(struct tst_its *its, long long nsec)
+{
+	switch (its->type) {
+	break;
+	case TST_KERN_OLD_TIMESPEC:
+		its->ts.kern_old_its.it_value.tv_nsec = nsec;
+	break;
+	case TST_KERN_TIMESPEC:
+		its->ts.kern_its.it_value.tv_nsec = nsec;
+	break;
+	default:
+		tst_brk(TBROK, "Invalid type: %d", its->type);
+	}
+}
+
+/*
+ * Checks that timespec is valid, i.e. that the timestamp is not zero and that
+ * the nanoseconds are normalized i.e. in <0, 1s) interval.
+ *
+ *  0: On success, i.e. timespec updated correctly.
+ * -1: Error, timespec not updated.
+ * -2: Error, tv_nsec is corrupted.
+ */
+static inline int tst_ts_valid(struct tst_ts *t)
+{
+	long long nsec = tst_ts_get_nsec(*t);
+
+	if (nsec < 0 || nsec >= 1000000000)
+		return -2;
+
+	if (tst_ts_get_sec(*t) == 0 && tst_ts_get_nsec(*t) == 0)
+		return -1;
+
+	return 0;
+}
+
 /*
  * Converts timespec to tst_ts.
  */
-- 
2.25.0.rc1.19.g042ed3e048af

