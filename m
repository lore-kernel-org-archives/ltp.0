Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C4EC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 08:00:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABC583CA1D5
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 10:00:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91F8E3C8E63
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:00:26 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B777C1000942
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 10:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660809623; i=@fujitsu.com;
 bh=ErxE7EnqWMCAc24o0SLWXZbBChysqQv6HJWflQ5k/e0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=FbtreI3N7A3xIGmeRN5WrEn/a/Wa8P1xmsK6XEQYTO2mVtz+wklKYbG2V43tf0WuZ
 g7l3jYaPJZk2wuZgK9p9HUa3aC39JgWTnBfHxepo7B4OM5LsF+Lh2fcNL98iMioBXI
 qYLGSZWgc07H09utvCWrDXCh+kVylvbQl+atie9Kz77ZLm+vmTchtrPPr/5CaeXpJ8
 lfx/xxIq53hr+oSZn8xA6PBXXpj4S6IF+PqL0MEhpmFmkKoHwGu7q/hHGDY58GjT6i
 1FA6kwxlUzvImxozBukpz+XjXRebmIIcUTNkJMJTx1TuAoOh4wApqk/cxjrlaH6KTK
 xPaaSstnXUyyQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRWlGSWpSXmKPExsViZ8OxWXf6x79
 JBotfKFhs3rOOxWLF9x2MFt2P9rA6MHvs+72O1eP9vqtsHptPVwcwR7Fm5iXlVySwZhy6epix
 4IV0xfod/1kaGL+IdzFycQgJbGSUeDT3CDOEs4RJ4vKjwywQzh5GiVM3dwM5nBxsApoSzzoXM
 IPYIgISEh0Nb9lBbGaBEIn/l++zgdjCAlESe+f+AKtnEVCVWH74AlgNr4CHxJE/3WA1EgIKEl
 Mevgeaw8HBKeAp8e1FAogpJJAkseKZN0S1oMTJmU9YIKZLSBx88YIZolNR4lLHN0YIu0Li9eF
 LUHE1iavnNjFPYBSchaR9FpL2BYxMqxitk4oy0zNKchMzc3QNDQx0DQ1NdY3NdQ3NjPQSq3QT
 9VJLdctTi0t0gdzyYr3U4mK94src5JwUvbzUkk2MwFBPKVZdtINx/6qfeocYJTmYlER5Tz35m
 yTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgrfzA1BOsCg1PbUiLTMHGHcwaQkOHiUR3n0grbzFBY
 m5xZnpEKlTjIpS4ry2IH0CIImM0jy4NlisX2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzPv
 nHdAUnsy8Erjpr4AWMwEtPnbxN8jikkSElFQD0+4j57j3lT8VnaeywPTkzo+pYh+rmKJurJrE
 /K3iotcEjdmuUvmMOy9rVUdN//8gXefljw0iUcbLE0zyOMuDzQL2tap1r7oeGx5kULZ10rmH+
 syrjsyNit+/dIPjhhU7j1ebf97xcMW1Pzd8kko/6dVMk2m7IPhamDXSSuvkr9xd6ccvzvFtuh
 drF1awe6XOXZ9tvA27l2wSZZbkfd+7YfHshi8n58q1zJ1Yv+qb2ovzvnvDGjcULNjq9J+jbsP
 8bT/X88/Wsv90juPqzZl2G2zWfRB41af+/dBDNx6NPa4WKotYt2xgPFbeJ503ebXy7S9z17J4
 TvC2LS4L3yBx9EJG6r5590qDUyeoHmGosNmjxFKckWioxVxUnAgAYtAdgnADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-548.messagelabs.com!1660809623!74289!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14165 invoked from network); 18 Aug 2022 08:00:23 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-2.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Aug 2022 08:00:23 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id AB17C16F;
 Thu, 18 Aug 2022 09:00:22 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id BB58B154;
 Thu, 18 Aug 2022 09:00:20 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 18 Aug 2022 09:00:18 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 18 Aug 2022 17:00:32 +0800
Message-ID: <1660813232-2378-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660813232-2378-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <87fshwlh5t.fsf@suse.de>
 <1660813232-2378-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC v2 3/3] memcontrol05: copy from kernel selftest
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
 runtest/controllers                           |  1 +
 testcases/kernel/controllers/memcg/.gitignore |  1 +
 .../kernel/controllers/memcg/memcontrol05.c   | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol05.c

diff --git a/runtest/controllers b/runtest/controllers
index 22d482050..5c51a414a 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -21,6 +21,7 @@ memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03
 memcontrol04 memcontrol04
+memcontrol05 memcontrol05
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/memcg/.gitignore b/testcases/kernel/controllers/memcg/.gitignore
index 3883cede6..8b9f6005c 100644
--- a/testcases/kernel/controllers/memcg/.gitignore
+++ b/testcases/kernel/controllers/memcg/.gitignore
@@ -9,3 +9,4 @@ memcontrol01
 memcontrol02
 memcontrol03
 memcontrol04
+memcontrol05
diff --git a/testcases/kernel/controllers/memcg/memcontrol05.c b/testcases/kernel/controllers/memcg/memcontrol05.c
new file mode 100644
index 000000000..6343536ff
--- /dev/null
+++ b/testcases/kernel/controllers/memcg/memcontrol05.c
@@ -0,0 +1,90 @@
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
+static struct tst_cg_group *cg_child;
+static uid_t nobody_uid, save_uid;
+
+static void test_lesser_euid_open(void)
+{
+	int fd;
+
+	cg_child = tst_cg_group_mk(tst_cg, "child");
+	if (!SAFE_FORK()) {
+		SAFE_CG_FCHOWN(cg_child, "cgroup.procs", CTRL_MEMORY, nobody_uid, -1);
+		SAFE_SETEUID(nobody_uid);
+
+		fd = SAFE_CG_OPEN(cg_child, "cgroup.procs", CTRL_MEMORY, O_RDWR);
+		SAFE_SETEUID(save_uid);
+
+		TEST(write(fd, "0", 1));
+		if (TST_RET >= 0 || TST_ERR != EACCES)
+			tst_res(TFAIL, "%s failed", __func__);
+		else
+			tst_res(TPASS | TTERRNO, "%s passed", __func__);
+
+		SAFE_CLOSE(fd);
+		exit(0);
+	}
+
+	tst_reap_children();
+	cg_child = tst_cg_group_rm(cg_child);
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
+	if (cg_child) {
+		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+		cg_child = tst_cg_group_rm(cg_child);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_lesser_euid_open,
+	.forks_child = 1,
+	.needs_root = 1,
+	.needs_cgroup_ctrls = (const char *const[]){ "memory", NULL},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57457641613"},
+		{}
+	},
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
