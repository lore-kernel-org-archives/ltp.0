Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353CAECAAA2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 02:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AEB03CA44B
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 04:59:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741233CA48E
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:59:01 +0200 (CEST)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77F941000359
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 04:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1661482739; i=@fujitsu.com;
 bh=ZmiPqISGZU1y1qrOLJCvi1Pyi3qbodIjbVyKQ68R5C8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Wu9AZWxIZV5Di8IpWfGR15P9xZHjRP2MC2S1FWLcxyuxweUwOE2QhoIVyIhQr2W3D
 wSST4bgcG8LoF9Ey8iFGou5BXfTCOisY28N8BY8qpNvjPpl1dG7uq4/kLfjDr/3lYv
 L/Iq6DQdQCQcNYt5w7k9YpfXjTzGtXcpjvHvNx5thWaGB6xYxEaBQn80X+lBmQPqZl
 i2y8o3XhUNYZ97aexlZQrnSm/iIolufAXhCKuoK+fQKputXWajNRV70n09+rTANIIm
 YjFHbp3KTHuezvYQmgFlVzs+UtgvHsGJwSJxY5XeEPAL0t8MYEnywn5nuKxK5JvDLl
 8R/x1fWgwzrjg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8OxWfeTGUe
 ywb3fJhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bK9xtZC3YqVCxceZCpgfGZdBcjF4eQwClG
 iesbX7JAOHuZJN6v2cgO5TBKXD61AMjh5GAT0JR41rmAGcQWEZCQ6Gh4CxZnFlCXWD7pF1MXI
 weHsECsxJLXTCBhFgFVib5t3xhBbF4BD4mpDW1sILaEgILElIfvwcZwCnhKXNq7FywuJJAk8W
 pHJzNEvaDEyZlPWCDGS0gcfPGCGaJXUeJSB8hMDiC7UuLG41SIsJrE1XObmCcwCs5C0j0LSfc
 CRqZVjJZJRZnpGSW5iZk5uoYGBrqGhqa6hrqmlnqJVbqJeqmluuWpxSW6hnqJ5cV6qcXFesWV
 uck5KXp5qSWbGIEBnFLMaL2DsaPvp94hRkkOJiVRXv1n7MlCfEn5KZUZicUZ8UWlOanFhxhlO
 DiUJHjVTDiShQSLUtNTK9Iyc4DRBJOW4OBREuGVFgVK8xYXJOYWZ6ZDpE4xKkqJ8140BUoIgC
 QySvPg2mARfIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9dkCk8mXklcNNfAS1mAlostYE
 dZHFJIkJKqoFpjjKfUOfLBd7CBbaHnx0PY/Pfz3Zt2rqXF8Rfn5/eLsLOf89iTyf/oYj3hxdk
 Rm1slDnEphm1PcNx7tXUuSt/Tgme+CLFv+DNq7Y5jOuv+187fcXuyUr3Syt3OV5OimbRvJWw8
 opAXhtbsfmlB4oC52Q4BHUrrvpvZfkh/nvRtYwpM+5wvDz7q/tK3xFenuw71vUbVAuZY5VqGJ
 88VVndVdn4srSh31Vpz5ZAjdXHukovbf2dtKZMitHo5hTRzQrFf88+fNOsNj3i8d+VZrckbr/
 4wBT5eo6ogl9UVNEWl8inC/1jDz/Jfm0Ttz6ImcX41D+d0yfVNm3Z2Ze/68xS0Q+Tr5z/u7jW
 t6x5sfipfiWW4oxEQy3mouJEAKk8aaBbAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1661482738!125010!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31032 invoked from network); 26 Aug 2022 02:58:58 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 26 Aug 2022 02:58:58 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 77434142
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:58 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 6B7087B
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 03:58:58 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 26 Aug 2022 03:58:56 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 26 Aug 2022 11:59:25 +0800
Message-ID: <1661486365-2361-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <871qt42tev.fsf@suse.de>
 <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] cgroup_core01: copy from kernel selftest
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

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/controllers                           |   1 +
 .../kernel/controllers/cgroup/.gitignore      |   1 +
 .../kernel/controllers/cgroup/cgroup_core01.c | 107 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/controllers/cgroup/cgroup_core01.c

diff --git a/runtest/controllers b/runtest/controllers
index 22d482050..41f8367e4 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -1,4 +1,5 @@
 #DESCRIPTION:Resource Management testing
+cgroup_core01	cgroup_core01
 cgroup		cgroup_regression_test.sh
 memcg_regression	memcg_regression_test.sh
 memcg_test_3	memcg_test_3
diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
index eb91cc4e1..382f2d9f2 100644
--- a/testcases/kernel/controllers/cgroup/.gitignore
+++ b/testcases/kernel/controllers/cgroup/.gitignore
@@ -1,3 +1,4 @@
 /cgroup_regression_fork_processes
 /cgroup_regression_getdelays
 /cgroup_regression_6_2
+/cgroup_core01
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
new file mode 100644
index 000000000..fc60ae5aa
--- /dev/null
+++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
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
+	int fds[TST_CG_ROOTS_MAX] = {-1};
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
