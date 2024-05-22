Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D0C25B77
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716357879; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BuNSHk5x8l57tjpJISuqDyXC9bjR1yU1yYppegFnMds=;
 b=bR0qGqqKOXFB1oCTIHDIfzTpjQu2EEWaMzeB+iE4gIInDJJqWU9sPqosCsGshxiZdWeGw
 p3CUBVOj2nn648rq7JXcribGy+p/ForPaYNFvgZOt6+9DC3VP6stvtcdq8ZVCxgGXDWguYw
 QaAbNL4zLdSvfwVzGZN/yaioEMpa89c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BF633D00B9
	for <ltp@archiver.kernel.org>; Wed, 22 May 2024 08:04:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8819E3C0B8E
 for <ltp@lists.linux.it>; Wed, 22 May 2024 08:04:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5700600FF8
 for <ltp@lists.linux.it>; Wed, 22 May 2024 08:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716357856; x=1747893856;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w2gGXSbB6jQRuxvFr5sD3NFA19rC79jZRpW3ziOXNhw=;
 b=Dcygihv0l+UiHHpaJYzxtMViPaFmPN4Ltfe0/ZwbpUtmdsImiEcfwOrb
 mVn5PR0OO7q7CDdjVsyppipCRy0Xhig8NZsOvFwp9mwHf0XqIef98J31u
 vaOuYY/UcTY74VAvO2mmKaTB3dBNc9SZaCEffANcO1lwR0htM0HhlOAz6
 ckXaWFpdTKx3LnvuvW8Mc86h12iRBE7F3Zg5a0JFQmoK4B+nkGjdC7fjd
 qnBIZQguWm8KebKrJHAi6pHH3GBH7o+aitiuLlo7+sv2iphouNaY+gXyg
 nq2syjnTw/YM0d6swIOkRCPkQyr7m6lGwZgrSJD39NAsef45rtRz5C5aD A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="158954781"
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; d="scan'208";a="158954781"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 15:04:14 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CEBCCD7E3
 for <ltp@lists.linux.it>; Wed, 22 May 2024 15:04:11 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6FF10D6FE9
 for <ltp@lists.linux.it>; Wed, 22 May 2024 15:04:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4B136B4C8
 for <ltp@lists.linux.it>; Wed, 22 May 2024 15:04:09 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7D6381A000A;
 Wed, 22 May 2024 14:04:09 +0800 (CST)
To: ltp@lists.linux.it
Date: Wed, 22 May 2024 14:03:22 +0800
Message-Id: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28402.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28402.005
X-TMASE-Result: 10--11.914900-10.000000
X-TMASE-MatchedRID: HRm6PbbemxdSuJfEWZSQfB1kSRHxj+Z5TJDl9FKHbrk6FHRWx2FGsP/6
 Rwrmf2vUhjf50HClX+Dmn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoTyZnEl0t0euxbvb8FR053hV9AgBtmvFeWqh5pv1eDPz/lSepWcgdLPWSYg69K24mxrQg
 SRg6yiRfNa5GcjfgJtg5TiQkMQ4aqOrUPm9PNUUt9JA2lmQRNUHLMdyB+LKtyJQ38lB610wqPFj
 JEFr+olwXCBO/GKkVqOhzOa6g8KrYcNf8QQGNcyHuRVAZ2qvMioRbDy51gfX1WkhPD+za7K19IE
 tO1v1B8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rt_sigqueueinfo: Add negative tests for
 rt_sigqueueinfo
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

Add negative cases for rt_sigqueueinfo(), when errno is EINVAL, EPERM or ESRCH

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 .../syscalls/rt_sigqueueinfo/.gitignore       |   1 +
 .../rt_sigqueueinfo/rt_sigqueueinfo02.c       | 108 ++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c04359fcd..c6f577de9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1200,6 +1200,7 @@ rt_sigaction03 rt_sigaction03
 rt_sigprocmask01 rt_sigprocmask01
 rt_sigprocmask02 rt_sigprocmask02
 rt_sigqueueinfo01 rt_sigqueueinfo01
+rt_sigqueueinfo02 rt_sigqueueinfo02
 rt_sigsuspend01 rt_sigsuspend01
 rt_sigtimedwait01 rt_sigtimedwait01
 rt_tgsigqueueinfo01 rt_tgsigqueueinfo01
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore b/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
index 37cd20621..a26811b08 100644
--- a/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/.gitignore
@@ -1 +1,2 @@
 /rt_sigqueueinfo01
+/rt_sigqueueinfo02
diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
new file mode 100644
index 000000000..dc6b42f46
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that rt_sigqueueinfo(2) fails with
+ *
+ * - EINVAL when sig is invalid
+ * - EPERM when uinfo->si_code is invalid
+ * - ESRCH when no thread group matching tgid is found
+ */
+#include <pwd.h>
+#include <signal.h>
+#include "config.h"
+#include "tst_test.h"
+
+#ifdef HAVE_STRUCT_SIGACTION_SA_SIGACTION
+#include "rt_sigqueueinfo.h"
+
+static siginfo_t siginfo_einval;
+static siginfo_t siginfo_eperm;
+static siginfo_t siginfo_esrch;
+
+static pid_t tgid_notfound = -1;
+
+static struct test_case_t {
+	pid_t *tgid;
+	int sig;
+	siginfo_t *uinfo;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{NULL, -1, &siginfo_einval, EINVAL, "sig is invalid"},
+	{NULL, SIGUSR1, &siginfo_eperm, EPERM, "uinfo->si_code is invalid"},
+	{&tgid_notfound, SIGUSR1, &siginfo_esrch, ESRCH,
+		"no thread group matching tgid is found"},
+};
+
+static void setup(void)
+{
+	siginfo_einval.si_code = SI_QUEUE;
+	siginfo_eperm.si_code = 0;
+	siginfo_esrch.si_code = SI_QUEUE;
+}
+
+static void sig_handler(int sig)
+{
+	tst_res(TINFO, "Receive signal %s(%d)", tst_strsig(sig), sig);
+}
+
+static void parent_do(struct test_case_t *tc, pid_t pid)
+{
+	pid_t real_pid;
+
+	if (tc->tgid)
+		real_pid = *(tc->tgid);
+	else
+		real_pid = pid;
+
+	TST_EXP_FAIL(sys_rt_sigqueueinfo(real_pid, tc->sig, tc->uinfo),
+		tc->expected_errno, "%s", tc->desc);
+	TST_CHECKPOINT_WAKE(1);
+}
+
+static void child_do(struct test_case_t *tc)
+{
+	struct sigaction sa;
+
+	sa.sa_handler = sig_handler;
+	SAFE_SIGEMPTYSET(&sa.sa_mask);
+	if (tc->sig > 0)
+		SAFE_SIGACTION(tc->sig, &sa, NULL);
+	else
+		SAFE_SIGACTION(SIGUSR1, &sa, NULL);
+
+	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAIT(1);
+}
+
+static void verify_rt_sigqueueinfo(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		child_do(tc);
+		exit(0);
+	}
+	TST_CHECKPOINT_WAIT(0);
+	parent_do(tc, pid);
+	SAFE_WAITPID(pid, NULL, 0);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_rt_sigqueueinfo,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
+
+#else
+	TST_TEST_TCONF("This system does not support rt_sigqueueinfo()");
+#endif /* HAVE_STRUCT_SIGACTION_SA_SIGACTION */
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
