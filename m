Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF50C19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:19:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 898993C4CA9
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 11:19:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11CF93C93FF
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:22 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 567EC600A57
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 11:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1659518360; i=@fujitsu.com;
 bh=/1D0MiabFTr8K+3Ep+xNLATXhvGYv+zdLm/gOGM5Mjc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=IqQsB495OsulgfyNeOAhKM+fFNiAcA+6BVVj0ZUJw0oBCsuYl9HuN6Ya6tDD0/ZoH
 wCd7ik05lKDDdoIFbG8dwAH4hg6B2BtqEMThfhbOqF9i/Q8PW6Zc6EVThwpoDL1dWY
 lTKVT20wrKfn+Xgjs1VJr4HkLA7R3cyKEgh5TaL8B3DdxHELXAJN2L7utkhEPO1HKM
 nVa7/WuAFTW58Pk2y6BAonZaU7u+5kIyHemSm43GN1M2/N1ZSpgI3je6skPTAjfOfQ
 9U3Ofw+gyIoptS0YcBYiSoacG55R6i1lZTsu2UP9HIv9WbuBZf9uMW8fbj8BCyJkir
 yA0+Cq/M0/rag==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRWlGSWpSXmKPExsViZ8OxWXeG7as
 kg317WC0271nHYrHi+w5Gi+5He1gdmD32/V7H6vF+31U2j82nqwOYo1gz85LyKxJYM9adfclU
 sES24smXw8wNjLMkuxi5OIQENjBKHH1+gRnCWcIksWTNfVYIZzejxJWGj0xdjJwcbAKaEs86F
 zCD2CICEhIdDW/ZQWxmgRCJd5PXs4DYwgIxEh0/XrGC2CwCKhIf9i0Dq+cV8JDY9qgFrEZCQE
 FiysP3YHFOAU+JXzPegtlCQDUn50xkhKgXlDg58wkLxHwJiYMvXjBD9CpKXOr4xghhV0i8Pnw
 JKq4mcfXcJuYJjIKzkLTPQtK+gJFpFaN1UlFmekZJbmJmjq6hgYGuoaGprrG5rqGZkV5ilW6i
 XmqpbnlqcYkukFterJdaXKxXXJmbnJOil5dasokRGO4pxaqLdjDuX/VT7xCjJAeTkijvGfNXS
 UJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeAusgXKCRanpqRVpmTnA2INJS3DwKInwfrcCSvMWFy
 TmFmemQ6ROMepybNrXdYBZiCUvPy9VSpx3tg1QkQBIUUZpHtwIWBq4xCgrJczLyMDAIMRTkFq
 Um1mCKv+KUZyDUUmY9wTIJTyZeSVwm14BHcEEdIQO1wuQI0oSEVJSDUwa3h4dSo3S8bpyMtbp
 0tf6WIVeOGjwWFsd3F2xMne+3vuX+RufOiaJhzA++2AzcfeNL2eTLiiVpUVlaumwzikyeWisE
 XnbTDZvkfEBhR+X5NXmVskFSt33Ec76pvD3zfxsk6a5H3z3hyauCQjo3vtgblDin5ff+he5Hb
 n45UabW19KuZm67OaiBr8vD24vFt27IJ6joOP6mZjdF46rP69f+EnyTcme+TseRpSt3Kxueab
 M4mbBzN2rQ6e/Xyl/a0VM/6xSR+b1iRfOPZh4w/nAzda++Bd/41a5mO0wm125RCRxluv+n9XH
 uXT3Pma2fT2N5dZT9uvTtOZcf7+b2V93d295ut+tVU/tj/C+Wv5ZiaU4I9FQi7moOBEADjGaT
 34DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-548.messagelabs.com!1659518359!51098!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11950 invoked from network); 3 Aug 2022 09:19:20 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-4.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Aug 2022 09:19:20 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id C1E627B;
 Wed,  3 Aug 2022 10:19:19 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id B56BB155;
 Wed,  3 Aug 2022 10:19:19 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 10:19:17 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 3 Aug 2022 18:19:41 +0800
Message-ID: <1659521981-2241-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] memcontrol05: copy from kernel selftest
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
TODO: In the future, also add a regression test in cgroup namespace[1]
if I have free time. Or, I will add it on v2.
[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf35a787
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
index 000000000..24976b602
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
+		SAFE_CG_FCHOWN(cg_child, "cgroup.procs", nobody_uid, -1);
+		SAFE_SETEUID(nobody_uid);
+
+		fd = SAFE_CG_OPEN(cg_child, "cgroup.procs", O_RDWR);
+		SAFE_SETEUID(save_uid);
+
+		TEST(write(fd, "0", 1));
+		if (TST_RET >= 0 || TST_ERR != EACCES)
+			tst_res(TFAIL, "lesser_euid_open failed");
+		else
+			tst_res(TPASS | TTERRNO, "less_euid_open passed");
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
+	.needs_cgroup_ctrls = (const char *const[]){ "memory", NULL },
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "e57457641613"},
+		{}
+	},
+};
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
