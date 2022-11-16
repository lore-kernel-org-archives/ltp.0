Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A7C4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 05:27:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4ABB3CBEF2
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 06:27:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6E5C3CBAA3
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:26:53 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46269600A2E
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1668576411; i=@fujitsu.com;
 bh=mrw0beodN4DKSujw04/c3utrLPU+T5xu1sTTrbm6Llw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=rwq7GaGYG9UFap1JU3poHBSzz3uXgaDBUZuNBbqdpiA6S5b3f8qcgrYKv5ko30T7+
 6jw73tY3pp4A6tHILwaF4noWYcq3IhzSumytkz9qv8nBRdvMmMfRuWfYLFa2ERL6c+
 iETSmve/bmr8kBxNkng+94rgWtxbrxr+rYTLqOavCtYMxPR3HgsyIBlsywjcOuzL76
 ipp+P4Ho6zD8LK3B7Xj0r7aOSks+0HIYgr6Jdl2OeeS0gkMuzMSDvMyuCVDxef/+Me
 Tny+FS6Uf7SpqwRHEVp/rSKobhMi6RvS3idiPqb1ImFc/3HG3CiBNnuan2nQNSf9KK
 TTfDs2GHFsVTA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRWlGSWpSXmKPExsViZ8ORpDurpCT
 Z4P13Q4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNeNd92W2gh0qFSdmHGBvYOyV72Lk4hASOMUo
 8e7uC1YIZy+TxIKjx9ggnD2MEnNnNwFlODnYBDQlnnUuYAaxRQQkJDoa3rKD2MwC6hLLJ/1iA
 rGFBaIlHpxfAVbPIqAqsXbrR0YQm1fAQ+J311IWEFtCQEFiysP3YHM4BTwlbl3YDBTnAFrmIb
 F1dy5EuaDEyZlPWCDGS0gcfPGCGaJVUeJSxzdGCLtCYtasNiYIW03i6rlNzBMYBWchaZ+FpH0
 BI9MqRrPi1KKy1CJdQ1O9pKLM9IyS3MTMHL3EKt1EvdRS3fLU4hJdQ73E8mK91OJiveLK3OSc
 FL281JJNjMDgTSlmL97B+GDZH71DjJIcTEqivBxuxclCfEn5KZUZicUZ8UWlOanFhxhlODiUJ
 Hhz5wLlBItS01Mr0jJzgJEEk5bg4FES4ZVrAErzFhck5hZnpkOkTjEqSonz8oH0CYAkMkrz4N
 pg0XuJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjDv5RlAU3gy80rgpr8CWswEtPiAXxHI4pJ
 EhJRUA1O1wf4570208sw2ejd+/P64eevewqIPj3d8brknIX4pe84sE1lDsTc/bprFTf6rr8fY
 IfX9/hz7Q8ZTtQQahJbFB108ZVb+MNjlu739n1rLsAPRCYpCk14leHMGTlR9EOd657rqpYuxX
 TtW6mTy9FsfmCmpLMzoYb38w+Mb91W7nl6KcLPQtFxeb+r/8Oz7dVPqvx6IejD9zsYJFnO7g7
 NvTTKb8Ct+wudPm+0P3bCaoMcgpuOw6//+0+tuRLAatr/dM0mxomXDORd3i9pfnh8X792SucW
 +u2hGGYPKI+0KllQpzk1/ym4qzL7mIHT70faUV16+d1MPNL3IYzDsSPh37TPHGSv1At7aPf7t
 c2uUWIozEg21mIuKEwE1plbkWQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-587.messagelabs.com!1668576410!5524!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2677 invoked from network); 16 Nov 2022 05:26:50 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-20.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Nov 2022 05:26:50 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 726EF1B3
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 05:26:50 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 673DE1AF
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 05:26:50 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 16 Nov 2022 05:26:48 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Nov 2022 14:26:44 +0800
Message-ID: <1668580004-2088-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] cgroup_core02: copy from kernel selftest
 test_cgcore_lesser_ns_open
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/.gitignore      |   1 +
 .../kernel/controllers/cgroup/cgroup_core02.c | 129 ++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/cgroup_core02.c

diff --git a/runtest/controllers b/runtest/controllers
index 41f8367e4..8d1b936bf 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -1,5 +1,6 @@
 #DESCRIPTION:Resource Management testing
 cgroup_core01	cgroup_core01
+cgroup_core02	cgroup_core02
 cgroup		cgroup_regression_test.sh
 memcg_regression	memcg_regression_test.sh
 memcg_test_3	memcg_test_3
diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index 382f2d9f2..012aedcca 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -2,3 +2,4 @@
 /cgroup_regression_getdelays
 /cgroup_regression_6_2
 /cgroup_core01
+/cgroup_core02
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
new file mode 100644
index 000000000..0dff71eea
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * When a task is writing to an fd opened by a different task, the perm check
+ * should use the cgroup namespace of the latter task.
+ *
+ * It is copy from kernel selftests cgroup test_core test_cgcore_lesser_ns_open
+ * subcase. Note that this case only runs on cgroup2 as cgroup1 doesn't have
+ * namespace support.
+ *
+ * It is a regression test for
+ *
+ * commit e57457641613fef0d147ede8bd6a3047df588b95
+ * Author: Tejun Heo <tj@kernel.org>
+ * Date:   Thu Jan 6 11:02:29 2022 -1000
+ *
+ * cgroup: Use open-time cgroup namespace for process migration perm checks
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+static struct tst_cg_group *cg_child_a, *cg_child_b;
+static uid_t nobody_uid;
+
+struct lesser_ns_open_thread_arg {
+	int fds[TST_CG_ROOTS_MAX];
+	int loops;
+};
+
+static int lesser_ns_open_thread_fn(void *arg)
+{
+	struct lesser_ns_open_thread_arg *targ = arg;
+
+	targ->loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, targ->fds);
+	return 0;
+}
+
+static void test_lesser_ns_open(void)
+{
+	int i;
+	static char stack[65536];
+	pid_t pid;
+	int status;
+	struct lesser_ns_open_thread_arg targ = { .fds = {0}, .loops = -1};
+
+	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
+	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
+
+	if (!SAFE_FORK()) {
+		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
+		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
+		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);
+		pid  = ltp_clone(CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
+					lesser_ns_open_thread_fn, &targ, 65536, stack);
+		if (pid < 0)  {
+			tst_res(TFAIL, "unexpected negative pid %d", pid);
+			exit(1);
+		}
+
+		SAFE_WAITPID(pid, &status, 0);
+		for (i = 0; i < targ.loops; i++) {
+			if (targ.fds[i] < 1) {
+				tst_res(TFAIL, "unexpected negative fd %d", targ.fds[i]);
+				exit(1);
+			}
+
+			TEST(write(targ.fds[i], "0", 1));
+			if (TST_RET >= 0 || TST_ERR != ENOENT)
+				tst_res(TFAIL, "%s failed", __func__);
+			else
+				tst_res(TPASS | TTERRNO, "%s passed", __func__);
+
+			SAFE_CLOSE(targ.fds[i]);
+		}
+		exit(0);
+	}
+
+	tst_reap_children();
+	cg_child_b = tst_cg_group_rm(cg_child_b);
+	cg_child_a = tst_cg_group_rm(cg_child_a);
+}
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_uid = pw->pw_uid;
+}
+
+static void cleanup(void)
+{
+	if (cg_child_a) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child_a = tst_cg_group_rm(cg_child_a);
+	}
+	if (cg_child_b) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child_b = tst_cg_group_rm(cg_child_b);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_lesser_ns_open,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
+	.needs_cgroup_ver = TST_CG_V2,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57457641613"},
+		{"CVE", "2021-4197"},
+		{}
+	},
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
