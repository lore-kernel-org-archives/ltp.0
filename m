Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A90C32774
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 10:01:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A146B3CA31C
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 12:01:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9133D3C2E42
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:01:04 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD3EB1000C01
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 12:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661248862; i=@fujitsu.com;
 bh=mG28gNcbIvsVoJ8wuwpApT75POaLWoSqJqck/OnIhBk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=qtw2RpJwIOUI7c3lWDKO6uV5sCPb8YijvO2+LxOcW+BQ5uDTsOjWw6r40xozvgHDj
 yxOELrkQ3yqnt+nHraao1Woj7/W7J7Av5E1Zkxx1qy+DzCxUoB+Np2cC4qYOvmvMse
 iM5w4nUkGRK4DDIhCo0XoMqW4E448wCIfyod48PeSW9pZqGrMpDDDJINukythv0WHn
 XsxWQGtBNQB66F6VlnQCxZrUwqkoZ7KDrg7mjB4E8uqJ1rf9N8crbNil1Xxz9qqg4M
 PNHKVttcLTx/GKcD+T33h41iDMLKv2uvz+K7O7jlshDXWW6SjQvPdP/lwea3Zi0wIP
 hHVQjPswnzXyQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8ORqBu3lCX
 ZYOFvdosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPvo1tsBaflK9r+3mVsYPwl1cXIxSEkcJZR
 YlPTPzYI5yCTxMPnt9ghnL2MEov3nmPtYuTkYBPQlHjWuYAZxBYRkJDoaHjLDmIzC6hLLJ/0i
 wnEFhYIk1i/dxGYzSKgKnFxxgtGEJtXwENiVv8hsF4JAQWJKQ/fg9mcAp4Sk3tOQi1rY5Q43z
 qBGaJBUOLkzCcsEAskJA6+eAHVrChxqeMb0FAOILtS4sbjVIiwmsTVc5uYJzAKzkLSPQtJ9wJ
 GplWMNklFmekZJbmJmTm6hgYGuoaGprqWZrqGJhZ6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6
 xZW5yTkpenmpJZsYgaGcUpwwZQfj4X2/9A4xSnIwKYnyOtSzJAvxJeWnVGYkFmfEF5XmpBYfY
 pTh4FCS4BWeBJQTLEpNT61Iy8wBxhVMWoKDR0mE9+gioDRvcUFibnFmOkTqFKOilDgvy2SghA
 BIIqM0D64NFsuXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzHgKZwpOZVwI3/RXQYiagxUG
 7mUEWlyQipKQamLxYBcKuM2zZk5U+L/YId5X1SofMshlG0q9DXYwLa29xSbXp1zyT1bXslooU
 Ef/xvnWJyluT0tpvhzV0GUpC34oumr55/czXvW9CNuSfkwssnrLx4Lqm9NKViYf4LxUvOqr7d
 YvylpV8cdLPRY6pSLJ8Wr6UZUmbNv+JVTnOqi3tLNdf8zrt3vqxWVLmiLDYxTlz1yY2KZmYfP
 nLaqWf7y6c1Mg46ZSoAH/+fv2gltnLVHJ/V2S6LpQXVFgap9/8ebnTlt78k1+9ulds5EyLzJN
 zfGYnyrZMi6vJ8+3syB8LmR6GBpTfLKrUFzn7jHfi8WW5Naa+AWxbZmydIPX0Ya+y18riR8en
 KffeWOyhxFKckWioxVxUnAgAsIJz5mADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-732.messagelabs.com!1661248861!42258!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28843 invoked from network); 23 Aug 2022 10:01:02 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-13.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 23 Aug 2022 10:01:02 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 73FB710018D
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:01:01 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6FD8F100043
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:01:01 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 23 Aug 2022 11:00:59 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 23 Aug 2022 19:01:19 +0800
Message-ID: <1661252479-2363-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661252479-2363-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] core01: copy from kernel selftest
 test_cgcore_lesser_euid_open
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
 testcases/kernel/controllers/cgroup/core01.c  | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/core01.c

diff --git a/runtest/controllers b/runtest/controllers
index 22d482050..c0052713e 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -1,4 +1,5 @@
 #DESCRIPTION:Resource Management testing
+core01		core01
 cgroup		cgroup_regression_test.sh
 memcg_regression	memcg_regression_test.sh
 memcg_test_3	memcg_test_3
diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index eb91cc4e1..f1c878d74 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -1,3 +1,4 @@
 /cgroup_regression_fork_processes
 /cgroup_regression_getdelays
 /cgroup_regression_6_2
+/core01
diff --git a/testcases/kernel/controllers/cgroup/core01.c b/testcases/kernel/controllers/cgroup/core01.c
new file mode 100644
index 000000000..80ffec85c
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/core01.c
@@ -0,0 +1,107 @@
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
+ * should use the credentials of the latter task.
+ *
+ * It is copy from kernel selftests cgroup test_core test_cgcore_lesser_euid_open
+ * subcase. The difference is that kernel selftest only supports cgroup v2 but
+ * here we also support cgroup v1 and v2.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+static struct tst_cg_group *cg_child_a, *cg_child_b;
+static uid_t nobody_uid, save_uid;
+
+static void test_lesser_euid_open(void)
+{
+	int fds[ROOTS_MAX] = {-1};
+	int i, loops;
+
+	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
+	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
+
+	if (!SAFE_FORK()) {
+		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
+		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
+		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);
+		SAFE_SETEUID(nobody_uid);
+
+		loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, fds);
+		SAFE_SETEUID(save_uid);
+
+		for (i = 0; i < loops; i++) {
+			if (fds[i] < 1) {
+				tst_res(TFAIL, "unexpected negative fd %d", fds[i]);
+				exit(1);
+			}
+
+			TEST(write(fds[i], "0", 1));
+			if (TST_RET >= 0 || TST_ERR != EACCES)
+				tst_res(TFAIL, "%s failed", __func__);
+			else
+				tst_res(TPASS | TTERRNO, "%s passed", __func__);
+
+			SAFE_CLOSE(fds[i]);
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
+	save_uid = geteuid();
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
+	.test_all = test_lesser_euid_open,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const[]){"memory",  NULL},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57457641613"},
+		{}
+	},
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
