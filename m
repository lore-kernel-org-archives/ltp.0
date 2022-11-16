Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9B8C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 02:20:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACC4C3CD1A7
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 03:20:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A37E3CA330
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:20:14 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C824F1000485
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 03:20:12 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBmvt1YHHzHvy8
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 10:19:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:20:08 +0800
To: <ltp@lists.linux.it>
Date: Wed, 16 Nov 2022 10:16:51 +0800
Message-ID: <20221116021651.21104-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/sched_setscheduler04: new test for
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
 runtest/syscalls                              |   1 +
 .../syscalls/sched_setscheduler/.gitignore    |   1 +
 .../syscalls/sched_setscheduler/Makefile      |   2 +
 .../sched_setscheduler/sched_setscheduler04.c | 101 ++++++++++++++++++
 4 files changed, 105 insertions(+)
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
index 000000000..38f5750ba
--- /dev/null
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
@@ -0,0 +1,101 @@
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
+ * 1. Specifying pid as 0 will operate on the attributes of the calling thread.
+ * 2. The value returned from a call to gettid(2) can be passed in the argument
+ *    pid.
+ * 3. Passing the value returned from a call to getpid(2) will operate on the
+ *    attributes of the main thread of the  thread  group.
+ */
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "tst_safe_pthread.h"
+#include <pthread.h>
+#include <linux/capability.h>
+
+static struct sched_param param;
+static volatile int sched_prio;
+static pid_t pid;
+
+#define ORG_POLICY SCHED_OTHER
+#define EXP_POLICY SCHED_FIFO
+
+static void verify_sched_setscheduler(pid_t tid)
+{
+	int new_policy;
+	pid_t threadid = tst_syscall(__NR_gettid);
+
+	tst_res(TINFO, "Setting of tid: %d", threadid);
+
+	param.sched_priority = sched_prio;
+	if (sched_setscheduler(tid, EXP_POLICY, &param)) {
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(%d, %d, ...) failed",
+			tid, EXP_POLICY);
+	}
+
+	tst_res(TINFO, "Getting and checking of tid: %d", threadid);
+
+	new_policy = sched_getscheduler(threadid);
+	if (new_policy < 0)
+		tst_brk(TBROK | TERRNO, "sched_getscheduler() failed");
+
+	if (sched_getparam(threadid, &param) != 0)
+		tst_brk(TBROK | TERRNO, "sched_getparam() failed");
+
+	TST_EXP_EQ_LI(param.sched_priority, sched_prio);
+	TST_EXP_EQ_LI(new_policy, EXP_POLICY);
+}
+
+static void *thread_func(LTP_ATTRIBUTE_UNUSED void *arg)
+{
+	pid_t threadid = tst_syscall(__NR_gettid);
+
+	sched_prio++;
+	verify_sched_setscheduler(0);
+	sched_prio++;
+	verify_sched_setscheduler(threadid);
+
+	return NULL;
+}
+
+static void run(void)
+{
+	pthread_t tid;
+
+	sched_prio = sched_get_priority_min(EXP_POLICY);
+
+	sched_prio++;
+	verify_sched_setscheduler(pid);
+
+	SAFE_PTHREAD_CREATE(&tid, NULL, thread_func, NULL);
+	SAFE_PTHREAD_JOIN(tid, NULL);
+}
+
+static void setup(void)
+{
+	pid = getpid();
+
+	if (sched_setscheduler(pid, ORG_POLICY, &param)) {
+		tst_brk(TBROK | TERRNO,
+			"sched_setscheduler(%d, %d, ...) failed",
+			pid, ORG_POLICY);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.caps = (struct tst_cap[]) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_NICE),
+		{}
+	}
+};
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
