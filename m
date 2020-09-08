From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue,  8 Sep 2020 11:49:20 +0530
Subject: [LTP] [PATCH 07/16] syscalls: mq_timed: Reuse struct time64_variants
In-Reply-To: <cover.1599545766.git.viresh.kumar@linaro.org>
References: <cover.1599545766.git.viresh.kumar@linaro.org>
Message-ID: <ed55accdb4ceaa11362875959558430ae1f99a6b.1599545766.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Lets reuse the common structure here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../mq_timedreceive/mq_timedreceive01.c        | 14 +++++++-------
 .../syscalls/mq_timedsend/mq_timedsend01.c     | 16 ++++++++--------
 testcases/kernel/syscalls/utils/mq_timed.h     | 18 +++++-------------
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index de0505106d04..be437e19a47f 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -135,10 +135,10 @@ static struct test_case tcase[] = {
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
-	ts.type = tv->type;
+	ts.type = tv->ts_type;
 
 	bad_addr = tst_get_bad_addr(NULL);
 
@@ -147,7 +147,7 @@ static void setup(void)
 
 static void do_test(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
 	unsigned int j;
 	unsigned int prio;
@@ -160,13 +160,13 @@ static void do_test(unsigned int i)
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
 	if (tc->signal)
-		pid = set_sig(tc->rq, tv->gettime);
+		pid = set_sig(tc->rq, tv->clock_gettime);
 
 	if (tc->timeout)
-		set_timeout(tc->rq, tv->gettime);
+		set_timeout(tc->rq, tv->clock_gettime);
 
 	if (tc->send) {
-		if (tv->send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+		if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
 			tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
 			return;
 		}
@@ -180,7 +180,7 @@ static void do_test(unsigned int i)
 	else
 		abs_timeout = tst_ts_get(tc->rq);
 
-	TEST(tv->receive(*tc->fd, rmsg, len, &prio, abs_timeout));
+	TEST(tv->mqt_receive(*tc->fd, rmsg, len, &prio, abs_timeout));
 
 	if (pid > 0)
 		kill_pid(pid);
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index d72f5d41ad61..334131402c9d 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -148,10 +148,10 @@ static struct test_case tcase[] = {
 
 static void setup(void)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
-	ts.type = tv->type;
+	ts.type = tv->ts_type;
 
 	bad_addr = tst_get_bad_addr(cleanup_common);
 
@@ -160,7 +160,7 @@ static void setup(void)
 
 static void do_test(unsigned int i)
 {
-	struct test_variants *tv = &variants[tst_variant];
+	struct time64_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
 	unsigned int j;
 	unsigned int prio;
@@ -173,14 +173,14 @@ static void do_test(unsigned int i)
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
 	if (tc->signal)
-		pid = set_sig(tc->rq, tv->gettime);
+		pid = set_sig(tc->rq, tv->clock_gettime);
 
 	if (tc->timeout)
-		set_timeout(tc->rq, tv->gettime);
+		set_timeout(tc->rq, tv->clock_gettime);
 
 	if (tc->send) {
 		for (j = 0; j < MSG_LENGTH; j++)
-			if (tv->send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+			if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
 				tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
 				return;
 			}
@@ -196,7 +196,7 @@ static void do_test(unsigned int i)
 	else
 		abs_timeout = tst_ts_get(tc->rq);
 
-	TEST(tv->send(*tc->fd, msg_ptr, tc->len, tc->prio, abs_timeout));
+	TEST(tv->mqt_send(*tc->fd, msg_ptr, tc->len, tc->prio, abs_timeout));
 
 	if (pid > 0)
 		kill_pid(pid);
@@ -215,7 +215,7 @@ static void do_test(unsigned int i)
 		return;
 	}
 
-	TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
+	TEST(tv->mqt_receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
 
 	if (*tc->fd == fd)
 		cleanup_queue(fd);
diff --git a/testcases/kernel/syscalls/utils/mq_timed.h b/testcases/kernel/syscalls/utils/mq_timed.h
index a217e864e1e4..adf46034bdc6 100644
--- a/testcases/kernel/syscalls/utils/mq_timed.h
+++ b/testcases/kernel/syscalls/utils/mq_timed.h
@@ -7,26 +7,18 @@
 #define MQ_TIMED_H
 
 #include "mq.h"
+#include "time64_variants.h"
 #include "tst_timer.h"
 
-static struct test_variants {
-	int (*send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
-		    unsigned int msg_prio, void *abs_timeout);
-	ssize_t (*receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,
-			   unsigned int *msg_prio, void *abs_timeout);
-
-	int (*gettime)(clockid_t clk_id, void *ts);
-	enum tst_ts_type type;
-	char *desc;
-} variants[] = {
-	{ .gettime = libc_clock_gettime, .send = libc_mq_timedsend, .receive = libc_mq_timedreceive, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+static struct time64_variants variants[] = {
+	{ .clock_gettime = libc_clock_gettime, .mqt_send = libc_mq_timedsend, .mqt_receive = libc_mq_timedreceive, .ts_type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
 
 #if (__NR_mq_timedsend != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
+	{ .clock_gettime = sys_clock_gettime, .mqt_send = sys_mq_timedsend, .mqt_receive = sys_mq_timedreceive, .ts_type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
 #endif
 
 #if (__NR_mq_timedsend_time64 != __LTP__NR_INVALID_SYSCALL)
-	{ .gettime = sys_clock_gettime64, .send = sys_mq_timedsend64, .receive = sys_mq_timedreceive64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
+	{ .clock_gettime = sys_clock_gettime64, .mqt_send = sys_mq_timedsend64, .mqt_receive = sys_mq_timedreceive64, .ts_type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
 #endif
 };
 
-- 
2.25.0.rc1.19.g042ed3e048af

