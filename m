Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10597C3F6B0
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 09:55:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856ED3CA36D
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 11:55:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CCA13CA334
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 11:55:09 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5842B1000A0E
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 11:55:07 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MCLw46SB7z1N7VH
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 17:51:32 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 17:55:02 +0800
To: <ltp@lists.linux.it>
Date: Wed, 24 Aug 2022 17:51:44 +0800
Message-ID: <20220824095144.259871-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] syscalls/nice05: Add testcase for nice() syscall
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add test verifies that the low nice thread executes more
time than the high nice thread since the two thread binded
on the same cpu.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 include/tst_safe_pthread.h                |  22 +++
 lib/safe_pthread.c                        |  65 +++++++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/nice/.gitignore |   1 +
 testcases/kernel/syscalls/nice/Makefile   |   2 +
 testcases/kernel/syscalls/nice/nice05.c   | 159 ++++++++++++++++++++++
 6 files changed, 250 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice05.c

diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
index 0c6d4d201..cc6da2de8 100644
--- a/include/tst_safe_pthread.h
+++ b/include/tst_safe_pthread.h
@@ -30,4 +30,26 @@ int safe_pthread_join(const char *file, const int lineno,
 #define SAFE_PTHREAD_JOIN(thread_id, retval) \
 	safe_pthread_join(__FILE__, __LINE__, thread_id, retval)

+int safe_pthread_barrier_wait(const char *file, const int lineno,
+			      pthread_barrier_t *barrier);
+#define SAFE_PTHREAD_BARRIER_WAIT(barrier) \
+	safe_pthread_barrier_wait(__FILE__, __LINE__, barrier);
+
+int safe_pthread_barrier_destroy(const char *file, const int lineno,
+				 pthread_barrier_t *barrier);
+#define SAFE_PTHREAD_BARRIER_DESTROY(barrier) \
+	safe_pthread_barrier_destroy(__FILE__, __LINE__, barrier);
+
+int safe_pthread_barrier_init(const char *file, const int lineno,
+			      pthread_barrier_t *restrict barrier,
+			      const pthread_barrierattr_t *restrict attr,
+			      unsigned count);
+#define SAFE_PTHREAD_BARRIER_INIT(barrier, attr, count) \
+	safe_pthread_barrier_init(__FILE__, __LINE__, barrier, attr, count);
+
+int safe_pthread_cancel(const char *file, const int lineno,
+			pthread_t thread_id);
+#define SAFE_PTHREAD_CANCEL(thread_id) \
+	safe_pthread_cancel(__FILE__, __LINE__, thread_id);
+
 #endif /* TST_SAFE_PTHREAD_H__ */
diff --git a/lib/safe_pthread.c b/lib/safe_pthread.c
index 2866aa594..d7bfee4cc 100644
--- a/lib/safe_pthread.c
+++ b/lib/safe_pthread.c
@@ -41,3 +41,68 @@ int safe_pthread_join(const char *file, const int lineno,

 	return rval;
 }
+
+int safe_pthread_barrier_wait(const char *file, const int lineno,
+			      pthread_barrier_t *barrier)
+{
+	int rval;
+
+	rval =  pthread_barrier_wait(barrier);
+
+	if (rval && rval != PTHREAD_BARRIER_SERIAL_THREAD) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_barrier_wait(%p) failed: %s",
+			 barrier, tst_strerrno(rval));
+	}
+
+	return rval;
+}
+
+int safe_pthread_barrier_destroy(const char *file, const int lineno,
+				 pthread_barrier_t *barrier)
+{
+	int rval;
+
+	rval = pthread_barrier_destroy(barrier);
+
+	if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_barrier_destroy(%p) failed: %s",
+			 barrier, tst_strerrno(rval));
+	}
+
+	return rval;
+}
+
+int safe_pthread_cancel(const char *file, const int lineno,
+			pthread_t thread_id)
+{
+	int rval;
+
+	rval = pthread_cancel(thread_id);
+
+	if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_cancel(...) failed: %s", tst_strerrno(rval));
+	}
+
+	return rval;
+}
+
+int safe_pthread_barrier_init(const char *file, const int lineno,
+			      pthread_barrier_t *restrict barrier,
+			      const pthread_barrierattr_t *restrict attr,
+			      unsigned count)
+{
+	int rval;
+
+	rval = pthread_barrier_init(barrier, attr, count);
+
+	if (rval) {
+		tst_brk_(file, lineno, TBROK,
+			 "pthread_barrier_init(%p, %p, %u)failed: %s",
+			 barrier, attr, count, tst_strerrno(rval));
+	}
+
+	return rval;
+}
diff --git a/runtest/syscalls b/runtest/syscalls
index 9d58e0aa1..98fcbbe1e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -903,6 +903,7 @@ nice01 nice01
 nice02 nice02
 nice03 nice03
 nice04 nice04
+nice05 nice05

 open01 open01
 open01A symlink01 -T open01
diff --git a/testcases/kernel/syscalls/nice/.gitignore b/testcases/kernel/syscalls/nice/.gitignore
index 9d7a1bb43..58d64779e 100644
--- a/testcases/kernel/syscalls/nice/.gitignore
+++ b/testcases/kernel/syscalls/nice/.gitignore
@@ -2,3 +2,4 @@
 /nice02
 /nice03
 /nice04
+/nice05
diff --git a/testcases/kernel/syscalls/nice/Makefile b/testcases/kernel/syscalls/nice/Makefile
index 044619fb8..02e78a295 100644
--- a/testcases/kernel/syscalls/nice/Makefile
+++ b/testcases/kernel/syscalls/nice/Makefile
@@ -3,6 +3,8 @@

 top_srcdir		?= ../../../..

+nice05: CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/testcases.mk

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
new file mode 100644
index 000000000..62a862a97
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd
+ * Author: Li Mengfei <limengfei4@huawei.com>
+ *         Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * 1. Create a high nice thread and a low nice thread, the main
+ *    thread wake them at the same time
+ * 2. Both threads run on the same CPU
+ * 3. Verify that the low nice thread executes more time than
+ *    the high nice thread
+ */
+
+#define _GNU_SOURCE
+#include <pthread.h>
+#include <sys/types.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_clocks.h"
+#include "tst_timer.h"
+
+static pthread_barrier_t barrier;
+
+static void set_nice(int nice_inc)
+{
+	int orig_nice;
+
+	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
+
+	TEST(nice(nice_inc));
+
+	if (TST_RET != (orig_nice + nice_inc)) {
+		tst_brk(TBROK | TTERRNO, "nice(%d) returned %li, expected %i",
+			nice_inc, TST_RET, orig_nice + nice_inc);
+	}
+
+	if (TST_ERR)
+		tst_brk(TBROK | TTERRNO, "nice(%d) failed", nice_inc);
+}
+
+static void do_something(void)
+{
+	volatile int number = 0;
+
+	while (1) {
+		number++;
+
+		TEST(pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL));
+		if (TST_RET != 0) {
+			tst_brk(TBROK | TRERRNO,
+				"pthread_setcancelstate() failed");
+		}
+		pthread_testcancel();
+	}
+}
+
+static void *thread_fn(void *arg)
+{
+	set_nice((intptr_t)arg);
+	SAFE_PTHREAD_BARRIER_WAIT(&barrier);
+	do_something();
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	size_t size;
+	size_t i;
+	int nrcpus = 1024;
+	cpu_set_t *set;
+	int some_cpu;
+
+	set = CPU_ALLOC(nrcpus);
+	if (!set)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
+
+	size = CPU_ALLOC_SIZE(nrcpus);
+	CPU_ZERO_S(size, set);
+	if (sched_getaffinity(0, size, set) < 0)
+		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
+
+	for (i = 0; i < size * 8; i++)
+		if (CPU_ISSET_S(i, size, set))
+			some_cpu = i;
+
+	CPU_ZERO_S(size, set);
+	CPU_SET_S(some_cpu, size, set);
+	if (sched_setaffinity(0, size, set) < 0)
+		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
+
+	CPU_FREE(set);
+}
+
+static void verify_nice(void)
+{
+	intptr_t nice_inc_high = -1;
+	intptr_t nice_inc_low = -2;
+	clockid_t nice_low_clockid, nice_high_clockid;
+	struct timespec nice_high_ts, nice_low_ts;
+	long long delta;
+	pthread_t thread[2];
+
+	SAFE_PTHREAD_BARRIER_INIT(&barrier, NULL, 3);
+
+	SAFE_PTHREAD_CREATE(&thread[0], NULL, thread_fn,
+			(void *)nice_inc_high);
+	SAFE_PTHREAD_CREATE(&thread[1], NULL, thread_fn,
+			(void *)nice_inc_low);
+
+	SAFE_PTHREAD_BARRIER_WAIT(&barrier);
+
+	sleep(tst_remaining_runtime());
+
+	TEST(pthread_getcpuclockid(thread[1], &nice_low_clockid));
+	if (TST_RET != 0)
+		tst_brk(TBROK | TRERRNO, "clock_getcpuclockid() failed");
+
+	TEST(pthread_getcpuclockid(thread[0], &nice_high_clockid));
+	if (TST_RET != 0)
+		tst_brk(TBROK | TRERRNO, "clock_getcpuclockid() failed");
+
+	SAFE_CLOCK_GETTIME(nice_low_clockid, &nice_low_ts);
+	SAFE_CLOCK_GETTIME(nice_high_clockid, &nice_high_ts);
+
+	tst_res(TINFO, "Nice low thread CPU time: %ld.%09ld s",
+			nice_low_ts.tv_sec, nice_low_ts.tv_nsec);
+	tst_res(TINFO, "Nice high thread CPU time: %ld.%09ld s",
+			nice_high_ts.tv_sec, nice_high_ts.tv_nsec);
+
+	delta = tst_timespec_diff_ns(nice_low_ts, nice_high_ts);
+	if (delta < 0) {
+		tst_res(TFAIL, "executes less cycles than "
+				"the high nice thread, delta: %lld ns", delta);
+	} else {
+		tst_res(TPASS, "executes more cycles than "
+				"the high nice thread, delta: %lld ns", delta);
+	}
+
+	SAFE_PTHREAD_CANCEL(thread[0]);
+	SAFE_PTHREAD_CANCEL(thread[1]);
+	SAFE_PTHREAD_BARRIER_DESTROY(&barrier);
+	SAFE_PTHREAD_JOIN(thread[0], NULL);
+	SAFE_PTHREAD_JOIN(thread[1], NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = verify_nice,
+	.needs_root = 1,
+	.forks_child = 1,
+	.max_runtime = 3,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
