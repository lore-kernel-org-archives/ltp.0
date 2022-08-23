Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40979C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 12:48:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809543CA3F8
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 14:48:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 848B83C8854
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 14:48:31 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C35A2600858
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 14:48:29 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBppc69LkzkWQC
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 20:44:56 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 20:48:25 +0800
To: <ltp@lists.linux.it>
Date: Tue, 23 Aug 2022 20:45:06 +0800
Message-ID: <20220823124506.58936-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls/nice05: Add testcase for nice() syscall
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
v3->v4: Replace getting exec time from sum_exec_runtime with pthread_getcpuclockid().

 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/nice/.gitignore |   1 +
 testcases/kernel/syscalls/nice/Makefile   |   2 +
 testcases/kernel/syscalls/nice/nice05.c   | 188 ++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice05.c

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
index 000000000..8ef33f932
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -0,0 +1,188 @@
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
+
+#define SEC2NS(sec)  ((sec) * 1000000000LL)
+
+static pthread_barrier_t barrier;
+static int some_cpu;
+static cpu_set_t *set;
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
+static void *nice_low_thread(void *arg)
+{
+	volatile int number = 0;
+
+	set_nice((intptr_t)arg);
+	TEST(pthread_barrier_wait(&barrier));
+	if (TST_RET != 0 && TST_RET != PTHREAD_BARRIER_SERIAL_THREAD)
+		tst_brk(TBROK | TRERRNO, "pthread_barrier_wait() failed");
+
+	while (1)
+		number++;
+
+	return NULL;
+}
+
+static void *nice_high_thread(void *arg)
+{
+	volatile int number = 0;
+
+	set_nice((intptr_t)arg);
+	TEST(pthread_barrier_wait(&barrier));
+	if (TST_RET != 0 && TST_RET != PTHREAD_BARRIER_SERIAL_THREAD)
+		tst_brk(TBROK | TRERRNO, "pthread_barrier_wait() failed");
+
+	while (1)
+		number++;
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	size_t size;
+	size_t i;
+	int nrcpus = 1024;
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
+}
+
+static void cleanup(void)
+{
+	if (set)
+		CPU_FREE(set);
+}
+
+static void verify_nice(void)
+{
+	intptr_t nice_inc_high = -1;
+	intptr_t nice_inc_low = -2;
+	clockid_t nice_low_clockid, nice_high_clockid;
+	struct timespec nice_high_ts, nice_low_ts;
+	long long delta;
+	pid_t pid;
+	pthread_t thread[2];
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(pthread_barrier_init(&barrier, NULL, 3));
+		if (TST_RET != 0) {
+			tst_brk(TBROK | TTERRNO,
+					"pthread_barrier_init() failed");
+		}
+
+		SAFE_PTHREAD_CREATE(&thread[0], NULL, nice_high_thread,
+				(void *)nice_inc_high);
+		SAFE_PTHREAD_CREATE(&thread[1], NULL, nice_low_thread,
+				(void *)nice_inc_low);
+
+		TEST(pthread_barrier_wait(&barrier));
+		if (TST_RET != 0 && TST_RET != PTHREAD_BARRIER_SERIAL_THREAD) {
+			tst_brk(TBROK | TTERRNO,
+					"pthread_barrier_wait() failed");
+		}
+
+		sleep(tst_remaining_runtime());
+
+		if (pthread_getcpuclockid(thread[1], &nice_low_clockid) != 0) {
+			perror("clock_getcpuclockid");
+			tst_brk(TBROK | TERRNO,
+					"clock_getcpuclockid() failed");
+		}
+		if (pthread_getcpuclockid(thread[0], &nice_high_clockid) != 0) {
+			perror("clock_getcpuclockid");
+			tst_brk(TBROK | TERRNO,
+					"clock_getcpuclockid() failed");
+		}
+
+		if (clock_gettime(nice_low_clockid, &nice_low_ts) == -1) {
+			tst_brk(TBROK | TERRNO,
+					"clock_getcpuclockid() failed");
+		}
+
+		if (clock_gettime(nice_high_clockid, &nice_high_ts) == -1) {
+			tst_brk(TBROK | TERRNO,
+					"clock_getcpuclockid() failed");
+		}
+
+		tst_res(TINFO, "Nice low thread CPU time: %ld.%09ld s",
+			nice_low_ts.tv_sec, nice_low_ts.tv_nsec);
+		tst_res(TINFO, "Nice high thread CPU time: %ld.%09ld s",
+			nice_high_ts.tv_sec, nice_high_ts.tv_nsec);
+
+		delta = SEC2NS(nice_low_ts.tv_sec - nice_high_ts.tv_sec) +
+			(nice_low_ts.tv_nsec - nice_high_ts.tv_nsec);
+		if (delta < 0) {
+			tst_res(TFAIL, "executes less cycles than "
+				"the high nice thread, delta: %lld ns", delta);
+		} else {
+			tst_res(TPASS, "executes more cycles than "
+				"the high nice thread, delta: %lld ns", delta);
+		}
+		return;
+	}
+	SAFE_WAIT(NULL);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_nice,
+	.needs_root = 1,
+	.forks_child = 1,
+	.max_runtime = 3,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
