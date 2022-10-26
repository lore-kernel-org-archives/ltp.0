Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D91FC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 03:55:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33B723CA710
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 05:55:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4120B3C9111
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 05:55:03 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1086B140096D
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 05:55:00 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mxw1H5P4rzHvGn
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 11:54:43 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:54:56 +0800
To: <ltp@lists.linux.it>
Date: Wed, 26 Oct 2022 11:51:30 +0800
Message-ID: <20221026035130.198906-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/sched_setscheduler04: new test for
 sched_setscheduler()
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

Verify that the scheduling policy and parameters are in fact per-thread
attributes on Linux:
1. Specifying pid as 0 will operate on the attributes of the calling thread
2. The value returned from a call to gettid(2) can be passed in the argument
   pid.
3. Passing the value returned from a call to getpid(2) will operate on the
   attributes of the main thread of the  thread  group

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                              |  1 +
 .../syscalls/sched_setscheduler/.gitignore    |  1 +
 .../syscalls/sched_setscheduler/Makefile      |  2 +
 .../sched_setscheduler/sched_setscheduler04.c | 91 +++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3dc6fa397..ff516af3d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1204,6 +1204,7 @@ sched_getscheduler02 sched_getscheduler02
 sched_setscheduler01 sched_setscheduler01
 sched_setscheduler02 sched_setscheduler02
 sched_setscheduler03 sched_setscheduler03
+sched_setscheduler04 sched_setscheduler04

 sched_yield01 sched_yield01

diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
index aa8ad9695..1b8860d2c 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/.gitignore
+++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
@@ -1,3 +1,4 @@
 /sched_setscheduler01
 /sched_setscheduler02
 /sched_setscheduler03
+/sched_setscheduler04
diff --git a/testcases/kernel/syscalls/sched_setscheduler/Makefile b/testcases/kernel/syscalls/sched_setscheduler/Makefile
index 044619fb8..e3d54e33e 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/Makefile
+++ b/testcases/kernel/syscalls/sched_setscheduler/Makefile
@@ -3,6 +3,8 @@

 top_srcdir		?= ../../../..

+sched_setscheduler04: CFLAGS += -pthread
+
 include $(top_srcdir)/include/mk/testcases.mk

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
new file mode 100644
index 000000000..6f985be88
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that the scheduling policy and parameters are in fact per-thread
+ * attributes on Linux:
+ * 1. Specifying pid as 0 will operate on the attributes of the calling thread
+ * 2. The value returned from a call to gettid(2) can be passed in the argument
+ *    pid.
+ * 3. Passing the value returned from a call to getpid(2) will operate on the
+ *    attributes of the main thread of the  thread  group
+ */
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_pthread.h"
+#include <pthread.h>
+
+static struct sched_param param;
+static volatile int sched_prio;
+
+#define SCHED_POLICY SCHED_FIFO
+
+static void set_param(int tid)
+{
+	param.sched_priority = sched_prio;
+
+	if (sched_setscheduler(tid, SCHED_POLICY, &param)) {
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(%d, %d, ...) failed",
+			tid, SCHED_POLICY);
+	}
+}
+
+static void check_prio(int tid)
+{
+	if (sched_getparam(tid, &param) != 0)
+		tst_brk(TBROK | TERRNO, "sched_getparam() failed");
+
+	if (param.sched_priority != sched_prio)
+		tst_res(TFAIL, "Checking of thread priority failed");
+	else
+		tst_res(TPASS, "Checking of thread priority passed");
+}
+
+static void *thread_func(LTP_ATTRIBUTE_UNUSED void *arg)
+{
+	pid_t threadid = tst_syscall(__NR_gettid);
+
+	sched_prio++;
+	set_param(0);
+	check_prio(threadid);
+
+	sched_prio++;
+	set_param(threadid);
+	check_prio(threadid);
+
+	return NULL;
+}
+
+static void test_sched_setscheduler01(void)
+{
+	sched_prio++;
+	set_param(getpid());
+	check_prio(tst_syscall(__NR_gettid));
+}
+
+static void test_sched_setscheduler02(void)
+{
+	pthread_t tid;
+
+	SAFE_PTHREAD_CREATE(&tid, NULL, thread_func, NULL);
+	SAFE_PTHREAD_JOIN(tid, NULL);
+}
+
+
+static void run(void)
+{
+	sched_prio = sched_get_priority_min(SCHED_POLICY);
+
+	test_sched_setscheduler01();
+	test_sched_setscheduler02();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
