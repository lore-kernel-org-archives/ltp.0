Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5BDC52D6F
	for <ltp@archiver.kernel.org>; Wed,  7 Aug 2024 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723030469; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=b7+0YHuSw7InJPeP8BSg6CMoHtwlHRRfbKs5bpIf1Tw=;
 b=oX90U0wcTqSyWO0JefAc3XrHJ/jSdw7vZE99OpM53/Xoi6Q1Y6WDGbMg3FAIVhx1vEVb9
 +AlS5q0tQAMLa3wb1wFDseWyNVoflcw0LezLpivBCss73eyMxQV43gyUMU1SYXIu8ugz/kZ
 Lb9DwDbueLzHKoXD7VxzuFJ9VbeYkbw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 369AB3D2054
	for <ltp@archiver.kernel.org>; Wed,  7 Aug 2024 13:34:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E8BF3D1F6A
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 13:34:08 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 296F4600949
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 13:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1723030447; x=1754566447;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=85GIIkolLKWmRlAZm7RS92yRO3oXUvGFrfh6pi1uTWo=;
 b=tr/V+d2LrZSlbmmkxSFRByP0qfqEsyPugRbXX3QFlVtgt72HIioYdpYz
 uYnUyX64H4kCyvHcOjHuz1aupbAFrzGBXeuliH5CnM6RZxFkkR5UmK7xw
 8+soEBF27Y/q3LFGXw55UxBLlR8yjH5rmb3b6Fvr8zJVk4EhZ2FFF1TwM
 vDBZnzPko0opm0qzHeFiFAc7/mzxvVhpO5FTqy9OzuuRhQ7/QQcLf1irk
 t2iP0O76nKvlNlQ/5HflJO1XnEQ4Ze8mg1pJlBFGMytXHhb9U4RPxkJeU
 gMJHaRP+YabFAzh1eWdr8KDl8SC2PZ4+uq5VwJT5gtOAyTtBuPuh6qEFZ A==;
X-CSE-ConnectionGUID: dzEOM1M0RhqcPiKMeBwyAg==
X-CSE-MsgGUID: uJQWx7HRSxWI1qbcBMl45Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="170049565"
X-IronPort-AV: E=Sophos;i="6.09,269,1716217200"; d="scan'208";a="170049565"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 20:34:05 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id BC1ABC68E2
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 20:34:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 07E16D50FB
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 20:34:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 76E922288CC
 for <ltp@lists.linux.it>; Wed,  7 Aug 2024 20:34:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C2BB01A000B;
 Wed,  7 Aug 2024 19:34:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed,  7 Aug 2024 19:36:01 +0800
Message-ID: <20240807113601.3882356-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28580.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28580.007
X-TMASE-Result: 10--8.884000-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfC+6f/7y7+Gz9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatT4xnGicftABGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoT4XJPAGTaiPKuLQx6TP/2yNCash9Gq0CRrzsINdopFUgRryDXHx6oX1n3UyIV+D/OIRF
 pl34/EAeLzNWBegCW2wgn7iDBesS3fd+P6wwCt84RtqopBKUBlvvOGuO0ekIuySBnJjXNdBO1Gb
 5/b+rsZckahIIZDODEJByASOcj6zg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] getcpu: Add testcase for EFAULT
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/getcpu/getcpu02.c | 71 +++++++++++++++++++++
 2 files changed, 72 insertions(+)
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
index 000000000..859cb0d3e
--- /dev/null
+++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -0,0 +1,71 @@
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
+ * Verify that getcpu(2) fails with EFAULT:
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
+} tcases[] = {
+	{NULL, &node_id},
+	{&cpu_id, NULL}
+};
+
+static void check_getcpu(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int status;
+	pid_t pid;
+
+	if (n == 0) {
+		tst_res(TINFO, "Make cpu_id point outside the calling process's address space.");
+		tc->cpu_id = tst_get_bad_addr(NULL);
+	} else if (n == 1) {
+		tst_res(TINFO, "Make node_id point outside the calling process's address space.");
+		tc->node_id = tst_get_bad_addr(NULL);
+	}
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
