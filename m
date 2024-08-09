Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD07C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723186421; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=PGG58VrcQ9mclczRGkoAM8b3s9IVhHqYm0Oc1oh7K90=;
 b=antcFrvpXnr8B7P6tcK06TRCv6KKtM0fALCq+6oQWDSAU4kRysriqGqn4tuZrgavRKsOX
 blork2p8QYErOIlObIBkAfthwNXjICFLfUoDTfDqEGxFz6MPs5bSm/f+zRHR83eAJQQb2QX
 mAAav0EvJyJcGbj/XT5Ou0BAMCqWqPk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3D13D208E
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 08:53:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5C473D1F4C
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 08:53:17 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19183140517F
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 08:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1723186397; x=1754722397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Xvmg2qVy5/bHKxrxUnllhRi1FgIm8alW5U2GFGvrgg0=;
 b=q+yPFd9WHda5IRLRDUPkgyaJ+jjKHKMwzAkJ6axOluQOes1gS/HQxCai
 fJ0HWcp1UbKGR5R///BMyt5xbWtbISAwkzwv7g2q7JegqzXPGjRypGpvN
 xW0muS+amM7g3i+gki8i3ATzY3H20Ac/mi5KyfzaREi5v7Ej3tdQfm+98
 CWnRUYMKzPurqebn7nmd/FRduaffsVSbqGBH3jrPaznPOFKUujag+AyzD
 Ri9OXkz2nARWezYCNA8F/Yaw5/ZIvVigHOlOVbNUpPyYuITtkQ7sbK6Vv
 2/lk6QgdQK9zfrmWrfCnD5vGaVc33AzOlWgu80MEENaos18AZDeOOPtXA w==;
X-CSE-ConnectionGUID: VZLUQ2ZyQTmim+QjXNnF/A==
X-CSE-MsgGUID: wR0iGsObS0yOkFiz9An3wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="157666924"
X-IronPort-AV: E=Sophos;i="6.09,275,1716217200"; d="scan'208";a="157666924"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2024 15:53:12 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E9055D2AC1
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 15:53:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 30FCBD8BB2
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 15:53:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B83E72008FBB5
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 15:53:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 39F901A0002;
 Fri,  9 Aug 2024 14:53:03 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri,  9 Aug 2024 14:49:18 +0800
Message-ID: <20240809064918.769102-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28584.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28584.005
X-TMASE-Result: 10--8.884000-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfC+6f/7y7+Gz9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatT4xnGicftABGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoT4XJPAGTaiPKuLQx6TP/2yNCash9Gq0CRrzsINdopFUgRryDXHx6oX1n3UyIV+D/OIRF
 pl34/EAeLzNWBegCW2wgn7iDBesS3fd+P6wwCt84RtqopBKUBlYIoL3gfMOKn4xVLn1GnvIb9XA
 Zh/9OmH3Yen9Xj1xfDF3lhvmGMI2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] getcpu: Add testcase for EFAULT
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a testcase with the arguments point to an invalid address.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/getcpu/.gitignore |  1 +
 testcases/kernel/syscalls/getcpu/getcpu02.c | 72 +++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b8728c1c5..1537b5022 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -448,6 +448,7 @@ futimesat01 futimesat01
 getcontext01 getcontext01
 
 getcpu01 getcpu01
+getcpu02 getcpu02
 
 getcwd01 getcwd01
 getcwd02 getcwd02
diff --git a/testcases/kernel/syscalls/getcpu/.gitignore b/testcases/kernel/syscalls/getcpu/.gitignore
index 31fec5d35..cd3022bbb 100644
--- a/testcases/kernel/syscalls/getcpu/.gitignore
+++ b/testcases/kernel/syscalls/getcpu/.gitignore
@@ -1 +1,2 @@
 /getcpu01
+/getcpu02
diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
new file mode 100644
index 000000000..83d236a78
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2024
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ *
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that getcpu(2) fails with EFAULT if:
+ *
+ * 1) cpu_id points outside the calling process's address space.
+ * 2) node_id points outside the calling process's address space.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+static unsigned int cpu_id, node_id;
+
+static struct tcase {
+	unsigned int *cpu_id;
+	unsigned int *node_id;
+	char *desc;
+} tcases[] = {
+	{NULL, &node_id, "cpu_id"},
+	{&cpu_id, NULL, "node_id"},
+};
+
+static void check_getcpu(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int status;
+	pid_t pid;
+
+	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
+
+	if (!tc->cpu_id)
+		tc->cpu_id = tst_get_bad_addr(NULL);
+
+	if (!tc->node_id)
+		tc->node_id = tst_get_bad_addr(NULL);
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL(getcpu(tc->cpu_id, tc->node_id), EFAULT);
+
+		exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "getcpu() caused SIGSEGV");
+		return;
+	}
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
+		return;
+
+	tst_res(TFAIL, "child %s", tst_strstatus(status));
+}
+
+static struct tst_test test = {
+	.test = check_getcpu,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
