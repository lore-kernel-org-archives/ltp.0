Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBC6C43334
	for <ltp@archiver.kernel.org>; Sat,  2 Jul 2022 02:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFB393C9B52
	for <ltp@archiver.kernel.org>; Sat,  2 Jul 2022 04:47:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9154A3C8CCF
 for <ltp@lists.linux.it>; Sat,  2 Jul 2022 04:46:58 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F1D0F600A6D
 for <ltp@lists.linux.it>; Sat,  2 Jul 2022 04:46:55 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LZbxq1W4mz1L8X3
 for <ltp@lists.linux.it>; Sat,  2 Jul 2022 10:44:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 2 Jul 2022 10:46:50 +0800
To: <ltp@lists.linux.it>
Date: Sat, 2 Jul 2022 10:44:28 +0800
Message-ID: <20220702024428.207153-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/nice05: Add testcase for nice() syscall
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
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/nice/.gitignore |   1 +
 testcases/kernel/syscalls/nice/Makefile   |   2 +
 testcases/kernel/syscalls/nice/nice05.c   | 184 ++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 36fc50aeb..784f3184d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -901,6 +901,7 @@ nice01 nice01
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
index 000000000..c0a528974
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -0,0 +1,184 @@
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
+static pthread_barrier_t barrier;
+static int some_cpu;
+static cpu_set_t *set;
+static pid_t *child_tid;
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
+
+}
+
+static void *nice_low_thread(void *arg)
+{
+	volatile int number = 0;
+
+	child_tid[0] = tst_syscall(__NR_gettid);
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
+	child_tid[1] = tst_syscall(__NR_gettid);
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
+
+	child_tid = SAFE_MMAP(0, sizeof(pid_t) * 2,
+			PROT_WRITE | PROT_READ,
+			MAP_SHARED | MAP_ANONYMOUS, 0, 0);
+}
+
+static void cleanup(void)
+{
+	if (set)
+		CPU_FREE(set);
+
+	if (child_tid)
+		SAFE_MUNMAP(child_tid, sizeof(pid_t) * 2);
+}
+
+static void verify_nice(void)
+{
+	intptr_t nice_inc_high = -1;
+	intptr_t nice_inc_low = -2;
+	char buf[4096] = {0};
+	float sum_exec_runtime[2];
+	pthread_t nice_low, nice_high;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TEST(pthread_barrier_init(&barrier, NULL, 3));
+		if (TST_RET != 0) {
+			tst_brk(TBROK | TTERRNO,
+				"pthread_barrier_init() failed");
+		}
+
+		SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread,
+			(void *)nice_inc_high);
+		SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread,
+			(void *)nice_inc_low);
+
+		TEST(pthread_barrier_wait(&barrier));
+		if (TST_RET != 0 && TST_RET != PTHREAD_BARRIER_SERIAL_THREAD) {
+			tst_brk(TBROK | TTERRNO,
+				"pthread_barrier_wait() failed");
+		}
+
+		while (1)
+			pause();
+	}
+
+	sleep(tst_remaining_runtime());
+	SAFE_KILL(pid, SIGSTOP);
+
+	sprintf(buf, "/proc/%d/sched", child_tid[0]);
+	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
+			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
+			&sum_exec_runtime[0]);
+
+	sprintf(buf, "/proc/%d/sched", child_tid[1]);
+	SAFE_FILE_SCANF(buf, "%*s %*s %*s %*s %*s"
+			"%*s %*s %*f %*s %*s %*f %*s %*s %f",
+			&sum_exec_runtime[1]);
+
+	if (sum_exec_runtime[0] < sum_exec_runtime[1]) {
+		tst_res(TFAIL, "nice_low_thread sum_exec_runtime: %f "
+			"nice_high_thread sum_exec_runtime: %f",
+			sum_exec_runtime[0], sum_exec_runtime[1]);
+	} else {
+		tst_res(TPASS, "executes more cycles "
+			"than the high nice thread");
+	}
+
+	SAFE_KILL(pid, SIGKILL);
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
