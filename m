Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ADDC433FE
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 06:54:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86A713CB1BD
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 08:54:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F06F3C93AA
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 08:54:08 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4781E1A011DC
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 08:54:06 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mtw8c3DFNzpVmJ
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 14:50:40 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:54:00 +0800
To: <ltp@lists.linux.it>
Date: Fri, 21 Oct 2022 14:50:32 +0800
Message-ID: <20221021065032.139738-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fork02: new test for fork()
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

Verify that current workdir correctly inherited by child.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/fork/.gitignore |  1 +
 testcases/kernel/syscalls/fork/fork02.c   | 51 +++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fork/fork02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7a425439a..39b7f21f6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -364,6 +364,7 @@ flock06 flock06
 fmtmsg01 fmtmsg01

 fork01 fork01
+fork02 fork02
 fork03 fork03
 fork04 fork04
 fork05 fork05
diff --git a/testcases/kernel/syscalls/fork/.gitignore b/testcases/kernel/syscalls/fork/.gitignore
index b817e9c05..8a08c586b 100644
--- a/testcases/kernel/syscalls/fork/.gitignore
+++ b/testcases/kernel/syscalls/fork/.gitignore
@@ -1,4 +1,5 @@
 /fork01
+/fork02
 /fork03
 /fork04
 /fork05
diff --git a/testcases/kernel/syscalls/fork/fork02.c b/testcases/kernel/syscalls/fork/fork02.c
new file mode 100644
index 000000000..54ad50712
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork02.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd
+ * Author: Zhao Gongyi <zhaogongyi@huawei.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that current workdir correctly inherited by child.
+ */
+
+#include "tst_test.h"
+
+#define NEW_DIR "new_dir"
+
+static char parent_cwd[PATH_MAX];
+static char child_cwd[PATH_MAX];
+
+static void run(void)
+{
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		SAFE_GETCWD(child_cwd, sizeof(child_cwd));
+		if (strcmp(child_cwd, parent_cwd)) {
+			tst_res(TFAIL, "checking of cwd failed: "
+					"child_cwd %s parent_cwd %s ",
+					child_cwd, parent_cwd);
+		} else
+			tst_res(TPASS, "Checking of cwd passed");
+		return;
+	}
+
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(NEW_DIR, 00770);
+	SAFE_CHDIR(NEW_DIR);
+	SAFE_GETCWD(parent_cwd, sizeof(parent_cwd));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+};
+
--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
