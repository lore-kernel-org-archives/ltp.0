From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 19 May 2020 14:21:12 +0530
Subject: [LTP] [PATCH 5/5] syscalls: Don't pass struct timeval to
 tst_syscall()
In-Reply-To: <cover.1589877853.git.viresh.kumar@linaro.org>
References: <cover.1589877853.git.viresh.kumar@linaro.org>
Message-ID: <ac47a49846fe338dd14e55fc05ed0715db60bc85.1589877853.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are compatibility issues here as we are calling the direct
syscalls with the "struct timeval" (which is a libc definition). We
must use struct __kernel_old_timeval instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                                     | 6 ++++++
 testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h | 5 -----
 testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 3 ++-
 testcases/kernel/syscalls/stime/stime_var.h             | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index 071061f5b280..814b70797643 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -12,6 +12,7 @@
 #ifndef TST_TIMER
 #define TST_TIMER
 
+#include <asm/posix_types.h>
 #include <sched.h>
 #include <sys/time.h>
 #include <mqueue.h>
@@ -104,6 +105,11 @@ typedef long __kernel_long_t;
 
 typedef __kernel_long_t	__kernel_old_time_t;
 
+struct __kernel_old_timeval {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	__kernel_suseconds_t	tv_usec;	/* microseconds */
+};
+
 struct __kernel_old_timespec {
 	__kernel_old_time_t	tv_sec;		/* seconds */
 	__kernel_old_time_t	tv_nsec;	/* nanoseconds */
diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
index eb60f707f776..dbe0a561a3ab 100644
--- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
+++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime.h
@@ -18,11 +18,6 @@
 #include "lapi/timex.h"
 
 #ifndef __kernel_timex
-struct __kernel_old_timeval {
-	__kernel_old_time_t	tv_sec;		/* seconds */
-	__kernel_suseconds_t	tv_usec;	/* microseconds */
-};
-
 struct __kernel_old_timex {
 	unsigned int modes;	/* mode selector */
 	__kernel_long_t offset;	/* time offset (usec) */
diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index b7687468d39d..b73bf129b116 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -21,6 +21,7 @@
 #include <errno.h>
 
 #include "tst_test.h"
+#include "tst_timer.h"
 #include "lapi/syscalls.h"
 
 static volatile sig_atomic_t done;
@@ -39,7 +40,7 @@ static void breakout(int sig)
 
 static void verify_gettimeofday(void)
 {
-	struct timeval tv1, tv2;
+	struct __kernel_old_timeval tv1, tv2;
 	unsigned long long cnt = 0;
 
 	done = 0;
diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index b33c5704e94a..708b80573167 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -9,6 +9,7 @@
 
 #include <sys/time.h>
 #include "config.h"
+#include "tst_timer.h"
 #include "lapi/syscalls.h"
 
 #define TEST_VARIANTS 3
@@ -26,7 +27,7 @@ static int do_stime(time_t *ntime)
 	case 1:
 		return tst_syscall(__NR_stime, ntime);
 	case 2: {
-		struct timeval tv;
+		struct __kernel_old_timeval tv;
 
 		tv.tv_sec = *ntime;
 		tv.tv_usec = 0;
-- 
2.25.0.rc1.19.g042ed3e048af

