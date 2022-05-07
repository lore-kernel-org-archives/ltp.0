Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CDEC433EF
	for <ltp@archiver.kernel.org>; Sat,  7 May 2022 07:38:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F7E3CA8F4
	for <ltp@archiver.kernel.org>; Sat,  7 May 2022 09:38:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE7263C004D
 for <ltp@lists.linux.it>; Sat,  7 May 2022 09:38:16 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9DD81A00486
 for <ltp@lists.linux.it>; Sat,  7 May 2022 09:38:13 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KwK5q6PVKzhYpp
 for <ltp@lists.linux.it>; Sat,  7 May 2022 15:37:35 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 15:38:08 +0800
To: <ltp@lists.linux.it>
Date: Sat, 7 May 2022 15:36:42 +0800
Message-ID: <20220507073642.219085-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nice05: Add testcase for nice() syscall
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

Add test verify that the low nice thread execute more cycles than
the high nice thread since the two thread binded on the same cpu.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/nice/.gitignore |   1 +
 testcases/kernel/syscalls/nice/Makefile   |   2 +
 testcases/kernel/syscalls/nice/nice05.c   | 183 ++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 testcases/kernel/syscalls/nice/nice05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 24d0f955d..0b47e67c6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -897,6 +897,7 @@ nice01 nice01
 nice02 nice02
 nice03 nice03
 nice04 nice04
+nice04 nice05

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
index 044619fb8..adba57060 100644
--- a/testcases/kernel/syscalls/nice/Makefile
+++ b/testcases/kernel/syscalls/nice/Makefile
@@ -3,6 +3,8 @@

 top_srcdir		?= ../../../..

+nice05: CFLAGS+=-pthread
+
 include $(top_srcdir)/include/mk/testcases.mk

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
new file mode 100644
index 000000000..814260296
--- /dev/null
+++ b/testcases/kernel/syscalls/nice/nice05.c
@@ -0,0 +1,183 @@
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
+ * 3. Verify that the low nice thread execute more cycles than
+ *    the high nice thread
+ */
+
+#define _GNU_SOURCE
+#include <pthread.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+#define LIMIT_TIME 3
+#define RUN_TIMES 1000000
+
+static pthread_barrier_t barrier;
+static long long time_nice_low, time_nice_high;
+static int some_cpu;
+static cpu_set_t *set;
+
+static void set_nice(int nice_inc)
+{
+	int orig_nice;
+
+	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
+	TEST(nice(nice_inc));
+
+	if (TST_RET != (orig_nice + nice_inc)) {
+		tst_brk(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
+				nice_inc, TST_RET, orig_nice + nice_inc);
+	}
+
+	if (TST_ERR)
+		tst_brk(TFAIL | TTERRNO, "nice(%d) failed", nice_inc);
+
+}
+
+static void* nice_low_thread(void* arg)
+{
+	int number = 0;
+	int ret = 0;
+
+	set_nice(*(int*)arg);
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
+		tst_brk(TBROK, "pthread_barrier_wait() returned %s",
+				tst_strerrno(-ret));
+	}
+
+	while (1) {
+		for (int i = 0; i < RUN_TIMES; ++i)
+			number++;
+
+		pthread_testcancel();
+		time_nice_low++;
+	}
+	return NULL;
+}
+
+static void* nice_high_thread(void* arg)
+{
+	int number = 0;
+	int ret = 0;
+
+	set_nice(*(int*)arg);
+	ret = pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
+		tst_brk(TBROK, "pthread_barrier_wait() returned %s",
+				tst_strerrno(-ret));
+	}
+
+	while (1) {
+		for (int i = 0; i < RUN_TIMES; ++i)
+			number++;
+
+		pthread_testcancel();
+		time_nice_high++;
+	}
+	return NULL;
+}
+
+static void setup(void)
+{
+	size_t size;
+	int index;
+	int nrcpus = 1024;
+
+	set = CPU_ALLOC(nrcpus);
+	if (!set)
+		tst_brk(TBROK | TERRNO, "CPU_ALLOC()");
+
+	size = CPU_ALLOC_SIZE(nrcpus);
+	CPU_ZERO_S(size, set);
+	if (sched_getaffinity(0, size, set) < 0) {
+		tst_brk(TBROK | TERRNO, "sched_getaffinity()");
+	}
+
+	for (index = 0; index < (int)size * 8; index++)
+		if (CPU_ISSET_S(index, size, set))
+			some_cpu = index;
+
+	CPU_ZERO_S(size, set);
+	CPU_SET_S(some_cpu, size, set);
+	if (sched_setaffinity(0, size, set) < 0) {
+		tst_brk(TBROK | TERRNO, "sched_setaffinity()");
+	}
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
+	int ret;
+	int nice_inc_high = -1;
+	int nice_inc_low = -2;
+	pthread_t nice_low, nice_high;
+
+	ret = pthread_barrier_init(&barrier, NULL, 3);
+	if (ret != 0) {
+		tst_brk(TBROK, "pthread_barrier_init() returned %s",
+			tst_strerrno(-ret));
+	}
+
+	SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread, (void*)&nice_inc_high);
+	SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread, (void*)&nice_inc_low);
+
+	pthread_barrier_wait(&barrier);
+	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
+		tst_brk(TBROK | TERRNO, "pthread_barrier_wait() failed");
+
+	sleep(LIMIT_TIME);
+
+	ret = pthread_cancel(nice_high);
+	if(ret) {
+		tst_brk(TBROK, "pthread_cancel() returned %s",
+			tst_strerrno(-ret));
+	}
+
+	ret = pthread_cancel(nice_low);
+	if(ret) {
+		tst_brk(TBROK, "pthread_cancel() returned %s",
+			tst_strerrno(-ret));
+	}
+
+	ret = pthread_barrier_destroy(&barrier);
+	if (ret) {
+		tst_brk(TBROK, "pthread_barrier_destroy() returned %s",
+			tst_strerrno(-ret));
+	}
+
+	SAFE_PTHREAD_JOIN(nice_high, NULL);
+	SAFE_PTHREAD_JOIN(nice_low, NULL);
+
+	if (time_nice_low > time_nice_high) {
+		tst_res(TPASS, "time_nice_low = %lld time_nice_high = %lld",
+			time_nice_low, time_nice_high);
+	} else {
+		tst_brk(TFAIL | TTERRNO, "Test failed :"
+			"time_nice_low = %lld time_nice_high = %lld",
+			time_nice_low, time_nice_high);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_nice,
+	.needs_root = 1,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
