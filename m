From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Jul 2020 22:24:25 +0200
Subject: [LTP] [PATCH] tst_timer: pass kernel_timer_t type to syscalls
Message-ID: <bd80f928abee6dac85d051c022afe559f5da8d0a.1594758146.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

timer_[gs]etttime tests are failing on s390, which is big endian
system, because tests are passing timer_t type, which is glibc
type (void *). Kernel expects and sets only int portion, so the
tests fail for all but first (0) timer id.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_timer.h                                       | 8 ++++----
 testcases/kernel/syscalls/timer_gettime/timer_gettime01.c | 6 +++---
 testcases/kernel/syscalls/timer_settime/timer_settime01.c | 6 +++---
 testcases/kernel/syscalls/timer_settime/timer_settime02.c | 8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index e42b54f0e92a..d2c3f3cb1328 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -316,23 +316,23 @@ static inline int sys_sched_rr_get_interval64(pid_t pid, void *ts)
 	return tst_syscall(__NR_sched_rr_get_interval_time64, pid, ts);
 }
 
-static inline int sys_timer_gettime(timer_t timerid, void *its)
+static inline int sys_timer_gettime(kernel_timer_t timerid, void *its)
 {
 	return tst_syscall(__NR_timer_gettime, timerid, its);
 }
 
-static inline int sys_timer_gettime64(timer_t timerid, void *its)
+static inline int sys_timer_gettime64(kernel_timer_t timerid, void *its)
 {
 	return tst_syscall(__NR_timer_gettime64, timerid, its);
 }
 
-static inline int sys_timer_settime(timer_t timerid, int flags, void *its,
+static inline int sys_timer_settime(kernel_timer_t timerid, int flags, void *its,
 				    void *old_its)
 {
 	return tst_syscall(__NR_timer_settime, timerid, flags, its, old_its);
 }
 
-static inline int sys_timer_settime64(timer_t timerid, int flags, void *its,
+static inline int sys_timer_settime64(kernel_timer_t timerid, int flags, void *its,
 				      void *old_its)
 {
 	return tst_syscall(__NR_timer_settime64, timerid, flags, its, old_its);
diff --git a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
index f7083917317c..02d5b416d1a2 100644
--- a/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
+++ b/testcases/kernel/syscalls/timer_gettime/timer_gettime01.c
@@ -15,7 +15,7 @@
 #include "tst_timer.h"
 
 static struct test_variants {
-	int (*func)(timer_t timer, void *its);
+	int (*func)(kernel_timer_t timer, void *its);
 	enum tst_ts_type type;
 	char *desc;
 } variants[] = {
@@ -28,7 +28,7 @@ static struct test_variants {
 #endif
 };
 
-static timer_t timer;
+static kernel_timer_t timer;
 
 static void setup(void)
 {
@@ -66,7 +66,7 @@ static void verify(void)
 		tst_res(TFAIL | TTERRNO, "timer_gettime() Failed");
 	}
 
-	TEST(tv->func((timer_t)-1, tst_its_get(&spec)));
+	TEST(tv->func((kernel_timer_t)-1, tst_its_get(&spec)));
 	if (TST_RET == -1 && TST_ERR == EINVAL)
 		tst_res(TPASS, "timer_gettime(-1) Failed: EINVAL");
 	else
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 76f283b81fe3..48b37d8e7624 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -29,7 +29,7 @@
 
 static struct tst_ts timenow;
 static struct tst_its new_set, old_set;
-static timer_t timer;
+static kernel_timer_t timer;
 
 static struct testcase {
 	struct tst_its		*old_ptr;
@@ -46,8 +46,8 @@ static struct testcase {
 
 static struct test_variants {
 	int (*cgettime)(clockid_t clk_id, void *ts);
-	int (*tgettime)(timer_t timer, void *its);
-	int (*func)(timer_t timerid, int flags, void *its, void *old_its);
+	int (*tgettime)(kernel_timer_t timer, void *its);
+	int (*func)(kernel_timer_t timerid, int flags, void *its, void *old_its);
 	enum tst_ts_type type;
 	char *desc;
 } variants[] = {
diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index 14c907bd19e1..f1225c1ccfad 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -30,8 +30,8 @@
 static struct tst_its new_set, old_set;
 static struct tst_its *pnew_set = &new_set, *pold_set = &old_set, *null_set = NULL;
 static void *faulty_set;
-static timer_t timer;
-static timer_t timer_inval = (timer_t)-1;
+static kernel_timer_t timer;
+static kernel_timer_t timer_inval = (kernel_timer_t)-1;
 
 /* separate description-array to (hopefully) improve readability */
 static const char * const descriptions[] = {
@@ -44,7 +44,7 @@ static const char * const descriptions[] = {
 };
 
 static struct testcase {
-	timer_t			*timer_id;
+	kernel_timer_t		*timer_id;
 	struct tst_its		**new_ptr;
 	struct tst_its		**old_ptr;
 	int			it_value_tv_nsec;
@@ -59,7 +59,7 @@ static struct testcase {
 };
 
 static struct test_variants {
-	int (*func)(timer_t timerid, int flags, void *its,
+	int (*func)(kernel_timer_t timerid, int flags, void *its,
 		    void *old_its);
 	enum tst_ts_type type;
 	char *desc;
-- 
2.18.1

