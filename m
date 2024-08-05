Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F1DC3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722849738; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=4sWxrWHbH4cjaYfElVewuiWH5bUe774fqUVDCLBvxhw=;
 b=QG2lwnxXFhVD2sHBMgQHPeAFMrGje91w3hLvKFu/N8WcHxBVlUGeTqxnpEpAobhaJ2sty
 io6mUAoxeOmLW8Kq5WnSC5+vnPgzVxuRXFKPhG1C7JgTV0LJ3E43T0pv1xBErCOS9iBBHBl
 t3ZUaYyvlMvCy+/+2Ysvm+vpwGXPczg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E1D73D1FCC
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 11:22:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 622623D1CCA
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 11:21:55 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66AE81A010C9
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 11:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1722849715; x=1754385715;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5dV3hLKX0emUWOleSdecp9plbhWZcwLXmCRj9aAITsE=;
 b=MhjkmnrhQulZaRspts+xX67cCl+JZ/GiHXPAbawDlBpvVY1V8IeuyGbZ
 xmB03BcZ0rreuAM6TVyAhFnSKpzEIjX9+jKvWgLSTYOMDfA1j8AOFPYch
 8QBgHfgFP/m5DlM+qIvvk5rcXMtTSqUM3LVB/S+fTuCmuMp8sMjDj/ld9
 Z3YMrDdJKspq7QoiK+07EdcmGWk882uF5yNHpGcRsBO6nl9duamdATsKP
 HszrZWipE+yhFxtzEZI4sXEYkHlYBy8S4hAUWXOVC+yp+tq2FnHQw2H30
 gbM+wIGHNVjpnxLTNNP/rxRaYEhlZBZH7eYBpq6BPh9cibJw1QRYKtVgR w==;
X-CSE-ConnectionGUID: HHJSAp7qRPO+PNhFGeKrXg==
X-CSE-MsgGUID: LwC0QOqPRtWMBdzkTK6+vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="157809734"
X-IronPort-AV: E=Sophos;i="6.09,264,1716217200"; d="scan'208";a="157809734"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 18:21:52 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B3A09D64B9
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 18:21:50 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F24AEBF3D5
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 18:21:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 883796BA7C
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 18:21:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id EC8D31A0002;
 Mon,  5 Aug 2024 17:21:48 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon,  5 Aug 2024 17:22:19 +0800
Message-ID: <20240805092219.2659302-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28576.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28576.006
X-TMASE-Result: 10--10.106800-10.000000
X-TMASE-MatchedRID: GQw6Xh/XS6VSuJfEWZSQfC+6f/7y7+Gz9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatT4xnGicftABGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoT4XJPAGTaiPKuLQx6TP/2yNCash9Gq0CRrzsINdopFUn2/mTu5B5RIHuFj9GoNsR8slu
 zAtRjp4e2nx5BJmn2Tp8u4Ge2SD5evvxILmKK/HBRFJJyf5BJe3QfwsVk0Ubv+efAnnZBiL8z+B
 a7+nv3uxi/CHDFVSiVhMwjGIB4Uir2kumqOITYM/GMBz7cXaep+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] getcpu: Add testcase for EFAULT
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/getcpu/getcpu02.c | 97 +++++++++++++++++++++
 2 files changed, 98 insertions(+)
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
diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
new file mode 100644
index 000000000..f32660ef9
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -0,0 +1,97 @@
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
+ * Verify that getcpu(2) fails with
+ *
+ * - EFAULT arguments point outside the calling process's address
+ *          space.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+
+static void *bad_addr;
+
+static void setup(void)
+{
+	bad_addr = tst_get_bad_addr(NULL);
+}
+
+static void check_bad_cpu_id(void *bad_addr, unsigned int *node_id)
+{
+	int status;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL(getcpu(bad_addr, node_id), EFAULT);
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
+static void check_bad_node_id(unsigned int *cpu_id, void *bad_addr)
+{
+	int status;
+	pid_t pid;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		TST_EXP_FAIL(getcpu(cpu_id, bad_addr), EFAULT);
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
+static void run_test(void)
+{
+	unsigned int cpu_id, node_id = 0;
+
+	check_bad_cpu_id(bad_addr, &node_id);
+	check_bad_node_id(&cpu_id, bad_addr);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run_test,
+	.forks_child = 1,
+};
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
