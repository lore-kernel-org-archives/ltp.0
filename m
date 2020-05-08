From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:53:55 +0530
Subject: [LTP] [PATCH V2 10/17] syscalls/mq_timed{send|receive}: Add support
 for time64 tests
In-Reply-To: <cover.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <16d390a25afe9120517e2d9bbf5b8f96a4a3d200.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing
mq_timed{send|receive}() syscall tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/tst_timer.h                           |  41 +++++++
 .../mq_timedreceive/mq_timedreceive01.c       |  97 ++++++++++++-----
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 101 ++++++++++++------
 testcases/kernel/syscalls/utils/mq_timed.h    |  42 +++-----
 4 files changed, 192 insertions(+), 89 deletions(-)

diff --git a/include/tst_timer.h b/include/tst_timer.h
index b4280042c77f..28f11c7376b4 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -14,6 +14,7 @@
 
 #include <sched.h>
 #include <sys/time.h>
+#include <mqueue.h>
 #include <time.h>
 #include "tst_test.h"
 #include "lapi/common_timers.h"
@@ -255,6 +256,46 @@ static inline int sys_futex_time64(int *uaddr, int futex_op, int val, void *to,
 	return tst_syscall(__NR_futex_time64, uaddr, futex_op, val, to, uaddr2, val3);
 }
 
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
 static inline int libc_sched_rr_get_interval(pid_t pid, void *ts)
 {
 	return sched_rr_get_interval(pid, ts);
diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index 1be515ced671..f2a4c5c0f8f1 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
@@ -6,29 +7,17 @@
  * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
 #include <limits.h>
+#include "lapi/abisize.h"
 
 static int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
 
 #include "mq_timed.h"
 
-static struct timespec ts;
+static struct tst_ts ts;
 
 static struct test_case tcase[] = {
 	{
@@ -95,21 +84,27 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.tv_sec = -1,
+		.tv_nsec = 0,
+		.rq = &ts,
 		.ret = -1,
 		.err = EINVAL,
 	},
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.tv_sec = 0,
+		.tv_nsec = -1,
+		.rq = &ts,
 		.ret = -1,
 		.err = EINVAL,
 	},
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.tv_sec = 0,
+		.tv_nsec = 1000000000,
+		.rq = &ts,
 		.ret = -1,
 		.err = EINVAL,
 	},
@@ -131,8 +126,44 @@ static struct test_case tcase[] = {
 	},
 };
 
+static struct test_variants {
+	int (*send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
+		    unsigned int msg_prio, void *abs_timeout);
+	ssize_t (*receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,
+			   unsigned int *msg_prio, void *abs_timeout);
+
+	int (*gettime)(clockid_t clk_id, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .gettime = libc_clock_gettime, .send = libc_mq_timedsend, .receive = libc_mq_timedreceive, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_mq_timedsend_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .send = sys_mq_timedsend64, .receive = sys_mq_timedreceive64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	ts.type = tv->type;
+
+	setup_common();
+}
+
 static void do_test(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
 	unsigned int j;
 	unsigned int prio;
@@ -140,19 +171,26 @@ static void do_test(unsigned int i)
 	char rmsg[len];
 	pid_t pid = -1;
 
+	tst_ts_set_sec(&ts, tc->tv_sec);
+	tst_ts_set_nsec(&ts, tc->tv_nsec);
+
 	if (tc->signal)
-		pid = set_sig(tc->rq);
+		pid = set_sig(tc->rq, tv->gettime);
 
 	if (tc->timeout)
-		set_timeout(tc->rq);
+		set_timeout(tc->rq, tv->gettime);
 
-	if (tc->send)
-		send_msg(*tc->fd, tc->len, tc->prio);
+	if (tc->send) {
+		if (tv->send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+			tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
+			return;
+		}
+	}
 
 	if (tc->invalid_msg)
 		len -= 1;
 
-	TEST(mq_timedreceive(*tc->fd, rmsg, len, &prio, tc->rq));
+	TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
 
 	if (pid > 0)
 		kill_pid(pid);
@@ -163,22 +201,22 @@ static void do_test(unsigned int i)
 	if (TST_RET < 0) {
 		if (tc->err != TST_ERR)
 			tst_res(TFAIL | TTERRNO,
-				"mq_timedreceive failed unexpectedly, expected %s",
+				"mq_timedreceive() failed unexpectedly, expected %s",
 				tst_strerrno(tc->err));
 		else
-			tst_res(TPASS | TTERRNO, "mq_timedreceive failed expectedly");
+			tst_res(TPASS | TTERRNO, "mq_timedreceive() failed expectedly");
 
 		return;
 	}
 
 	if (tc->len != TST_RET) {
-		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %zu",
+		tst_res(TFAIL, "mq_timedreceive() wrong length %ld, expected %u",
 			TST_RET, tc->len);
 		return;
 	}
 
 	if (tc->prio != prio) {
-		tst_res(TFAIL, "mq_timedreceive wrong prio %d, expected %d",
+		tst_res(TFAIL, "mq_timedreceive() wrong prio %d, expected %d",
 			prio, tc->prio);
 		return;
 	}
@@ -186,20 +224,21 @@ static void do_test(unsigned int i)
 	for (j = 0; j < tc->len; j++) {
 		if (rmsg[j] != smsg[j]) {
 			tst_res(TFAIL,
-				"mq_timedreceive wrong data %d in %u, expected %d",
+				"mq_timedreceive() wrong data %d in %u, expected %d",
 				rmsg[j], i, smsg[j]);
 			return;
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %zu",
+	tst_res(TPASS, "mq_timedreceive() returned %ld, priority %u, length: %zu",
 			TST_RET, prio, len);
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-	.setup = setup_common,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.cleanup = cleanup_common,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 8f209d396040..292b8ab5b429 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007-2008, Hitachi, Ltd
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
@@ -6,29 +7,18 @@
  * Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
  * Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
  * Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <errno.h>
 #include <limits.h>
+#include "lapi/abisize.h"
 
 static int fd, fd_root, fd_nonblock, fd_maxint = INT_MAX - 1, fd_invalid = -1;
-static struct timespec ts;
 
 #include "mq_timed.h"
 
+static struct tst_ts ts;
+
 static struct test_case tcase[] = {
 	{
 		.fd = &fd,
@@ -95,7 +85,9 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = -1, .tv_nsec = 0},
+		.tv_sec = -1,
+		.tv_nsec = 0,
+		.rq = &ts,
 		.send = 1,
 		.ret = -1,
 		.err = EINVAL,
@@ -103,7 +95,9 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = -1},
+		.tv_sec = 0,
+		.tv_nsec = -1,
+		.rq = &ts,
 		.send = 1,
 		.ret = -1,
 		.err = EINVAL,
@@ -111,7 +105,9 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.rq = &(struct timespec) {.tv_sec = 0, .tv_nsec = 1000000000},
+		.tv_sec = 0,
+		.tv_nsec = 1000000000,
+		.rq = &ts,
 		.send = 1,
 		.ret = -1,
 		.err = EINVAL,
@@ -136,8 +132,44 @@ static struct test_case tcase[] = {
 	},
 };
 
+static struct test_variants {
+	int (*send)(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
+		    unsigned int msg_prio, void *abs_timeout);
+	ssize_t (*receive)(mqd_t mqdes, char *msg_ptr, size_t msg_len,
+			   unsigned int *msg_prio, void *abs_timeout);
+
+	int (*gettime)(clockid_t clk_id, void *ts);
+	enum tst_ts_type type;
+	char *desc;
+} variants[] = {
+#if defined(TST_ABI32)
+	{ .gettime = libc_clock_gettime, .send = libc_mq_timedsend, .receive = libc_mq_timedreceive, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_LIBC_TIMESPEC, .desc = "syscall with libc spec"},
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with kernel spec32"},
+#endif
+
+#if defined(TST_ABI64)
+	{ .gettime = sys_clock_gettime, .send = sys_mq_timedsend, .receive = sys_mq_timedreceive, .type = TST_KERN_TIMESPEC, .desc = "syscall with kernel spec64"},
+#endif
+
+#if (__NR_mq_timedsend_time64 != __LTP__NR_INVALID_SYSCALL)
+	{ .gettime = sys_clock_gettime64, .send = sys_mq_timedsend64, .receive = sys_mq_timedreceive64, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec64"},
+#endif
+};
+
+static void setup(void)
+{
+	struct test_variants *tv = &variants[tst_variant];
+
+	tst_res(TINFO, "Testing variant: %s", tv->desc);
+	ts.type = tv->type;
+
+	setup_common();
+}
+
 static void do_test(unsigned int i)
 {
+	struct test_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
 	unsigned int j;
 	unsigned int prio;
@@ -145,18 +177,24 @@ static void do_test(unsigned int i)
 	char rmsg[len];
 	pid_t pid = -1;
 
+	tst_ts_set_sec(&ts, tc->tv_sec);
+	tst_ts_set_nsec(&ts, tc->tv_nsec);
+
 	if (tc->signal)
-		pid = set_sig(tc->rq);
+		pid = set_sig(tc->rq, tv->gettime);
 
 	if (tc->timeout)
-		set_timeout(tc->rq);
+		set_timeout(tc->rq, tv->gettime);
 
 	if (tc->send) {
 		for (j = 0; j < MSG_LENGTH; j++)
-			send_msg(*tc->fd, tc->len, tc->prio);
+			if (tv->send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+				tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
+				return;
+			}
 	}
 
-	TEST(mq_timedsend(*tc->fd, smsg, tc->len, tc->prio, tc->rq));
+	TEST(tv->send(*tc->fd, smsg, tc->len, tc->prio, tst_ts_get(tc->rq)));
 
 	if (pid > 0)
 		kill_pid(pid);
@@ -164,10 +202,10 @@ static void do_test(unsigned int i)
 	if (TST_RET < 0) {
 		if (tc->err != TST_ERR)
 			tst_res(TFAIL | TTERRNO,
-				"mq_timedsend failed unexpectedly, expected %s",
+				"mq_timedsend() failed unexpectedly, expected %s",
 				tst_strerrno(tc->err));
 		else
-			tst_res(TPASS | TTERRNO, "mq_timedreceive failed expectedly");
+			tst_res(TPASS | TTERRNO, "mq_timedreceive() failed expectedly");
 
 		if (*tc->fd == fd)
 			cleanup_queue(fd);
@@ -175,7 +213,7 @@ static void do_test(unsigned int i)
 		return;
 	}
 
-	TEST(mq_timedreceive(*tc->fd, rmsg, len, &prio, tc->rq));
+	TEST(tv->receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
 
 	if (*tc->fd == fd)
 		cleanup_queue(fd);
@@ -183,26 +221,26 @@ static void do_test(unsigned int i)
 	if (TST_RET < 0) {
 		if (tc->err != TST_ERR) {
 			tst_res(TFAIL | TTERRNO,
-				"mq_timedreceive failed unexpectedly, expected %s",
+				"mq_timedreceive() failed unexpectedly, expected %s",
 				tst_strerrno(tc->err));
 			return;
 		}
 
 		if (tc->ret >= 0) {
-			tst_res(TFAIL | TTERRNO, "mq_timedreceive returned %ld, expected %d",
+			tst_res(TFAIL | TTERRNO, "mq_timedreceive() returned %ld, expected %d",
 					TST_RET, tc->ret);
 			return;
 		}
 	}
 
 	if (tc->len != TST_RET) {
-		tst_res(TFAIL, "mq_timedreceive wrong length %ld, expected %d",
+		tst_res(TFAIL, "mq_timedreceive() wrong length %ld, expected %u",
 			TST_RET, tc->len);
 		return;
 	}
 
 	if (tc->prio != prio) {
-		tst_res(TFAIL, "mq_timedreceive wrong prio %d, expected %d",
+		tst_res(TFAIL, "mq_timedreceive() wrong prio %d, expected %d",
 			prio, tc->prio);
 		return;
 	}
@@ -210,20 +248,21 @@ static void do_test(unsigned int i)
 	for (j = 0; j < tc->len; j++) {
 		if (rmsg[j] != smsg[j]) {
 			tst_res(TFAIL,
-				"mq_timedreceive wrong data %d in %u, expected %d",
+				"mq_timedreceive() wrong data %d in %u, expected %d",
 				rmsg[j], i, smsg[j]);
 			return;
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive returned %ld, priority %u, length: %zu",
+	tst_res(TPASS, "mq_timedreceive() returned %ld, priority %u, length: %zu",
 			TST_RET, prio, len);
 }
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-	.setup = setup_common,
+	.test_variants = ARRAY_SIZE(variants),
+	.setup = setup,
 	.cleanup = cleanup_common,
 	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/utils/mq_timed.h b/testcases/kernel/syscalls/utils/mq_timed.h
index a163ddcee3af..1d5515f9d629 100644
--- a/testcases/kernel/syscalls/utils/mq_timed.h
+++ b/testcases/kernel/syscalls/utils/mq_timed.h
@@ -1,30 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef MQ_TIMED_H
 #define MQ_TIMED_H
 
 #include "mq.h"
+#include "tst_timer.h"
 
 struct test_case {
 	int *fd;
 	unsigned int len;
 	unsigned int prio;
-	struct timespec *rq;
+	struct tst_ts *rq;
+	long tv_sec;
+	long tv_nsec;
 	int invalid_msg;
 	int send;
 	int signal;
@@ -33,27 +24,20 @@ struct test_case {
 	int err;
 };
 
-static pid_t set_sig(struct timespec *ts)
+static pid_t set_sig(struct tst_ts *ts,
+		     int (*gettime)(clockid_t clk_id, void *ts))
 {
-	clock_gettime(CLOCK_REALTIME, ts);
-	ts->tv_sec += 3;
+	gettime(CLOCK_REALTIME, tst_ts_get(ts));
+	*ts = tst_ts_add_us(*ts, 3000000);
 
 	return create_sig_proc(SIGINT, 40, 200000);
 }
 
-static void set_timeout(struct timespec *ts)
+static void set_timeout(struct tst_ts *ts,
+			int (*gettime)(clockid_t clk_id, void *ts))
 {
-	clock_gettime(CLOCK_REALTIME, ts);
-	ts->tv_nsec += 50000000;
-	ts->tv_sec += ts->tv_nsec / 1000000000;
-	ts->tv_nsec %= 1000000000;
-}
-
-static void send_msg(int fd, int len, int prio)
-{
-	if (mq_timedsend(fd, smsg, len, prio,
-		&((struct timespec){0})) < 0)
-		tst_brk(TBROK | TERRNO, "mq_timedsend failed");
+	gettime(CLOCK_REALTIME, tst_ts_get(ts));
+	*ts = tst_ts_add_us(*ts, 50000);
 }
 
 static void kill_pid(pid_t pid)
-- 
2.25.0.rc1.19.g042ed3e048af

