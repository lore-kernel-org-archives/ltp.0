Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D37DCF07A5
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 05:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728539263; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=huGorKIsaB7g+W+cp5hpzqYxbWKV8buujAivn3KtDLM=;
 b=jRqbmu9rLCQuHyTXGrE+wgOGVnyHNal2YHGFxWrT2C/CsPz99hwCCOkcwEWK+gybrlxec
 tqF6D3IXhsVVxjI09jSJoIqaLxSaw8TZHk6jAytw4gg19xGajZ+FRIiY04jhvIGFkmCDPQ8
 OjerVzlybTwMgpucVfCLILxtfpIiEhU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C361D3C2A38
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 07:47:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD363C0714
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 07:47:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 266EA2348D6
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 07:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1728539243; x=1760075243;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=87G6cU3tkzh9KuIXKYZxrHTv+Pl+ld5W00YXPuzmqi8=;
 b=VwSkepWcG34JDmaFT1VlU4S7uJsgbJDfyn9/yAFf0fqLWRQStJKlfvVY
 hrjuxIrIoopqEsMuc6w/ra3OGgMN7UN4YENphkXOKBOK2UZq3VZ10j29/
 N9MXSYMk67xVB0GQ+QX0g3+I4gIH2OEYQeiWfQaHxaHTCjkb5AlkOWuA6
 XW1FJZpjFcxGEwR6t2u1AwooCKnbkxlh0W6BL1ASieZvin2HIvX8c0hBr
 rQnYlOoeLMT6jYcxvhKquiSXzlBz5nbDpOM+ijWWea1ubIF4nRvXMCPAc
 ALfomse01t5nU4CRoNVonXX5oeMiXi+Mu9kDqEfNdF/UiJenRvlZlihl8 A==;
X-CSE-ConnectionGUID: w9DjAPQOScWPnKQqn3erDQ==
X-CSE-MsgGUID: IgYDt6GuSVysM+J8OnBpKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="155357909"
X-IronPort-AV: E=Sophos;i="6.11,192,1725289200"; d="scan'208";a="155357909"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 14:47:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CA85DB3BD
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:47:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C23A2D4649
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:47:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5859420083895
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:47:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B48651A000A;
 Thu, 10 Oct 2024 13:47:15 +0800 (CST)
To: ltp@lists.linux.it,
	chrubis@suse.cz
Date: Thu, 10 Oct 2024 13:47:57 +0800
Message-ID: <20241010054757.1839779-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28720.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28720.005
X-TMASE-Result: 10--11.783900-10.000000
X-TMASE-MatchedRID: cSoPLjBYd51SuJfEWZSQfB1kSRHxj+Z5TJDl9FKHbrk6FHRWx2FGsP/6
 Rwrmf2vUhjf50HClX+Dmn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoTyZnEl0t0euxbvb8FR053hV9AgBtmvFeWqh5pv1eDPz/lSepWcgdLPWSYg69K24mwHLJ
 WKaOYkk63z5aSds3pLRBFLm7DY5F3vEJY6jb7huovefyp1glN0x2HzO3L11dWbKItl61J/yfJvo
 cwUrWp7ijciq9xw8kXfd+P6wwCt84RtqopBKUBlhH681zK2WpeLX+p3Ne/5Y80WgB0zSifmzKaf
 S2aSzivU453Pcb9t8g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] rt_sigqueueinfo02: Add negative tests for
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
 runtest/syscalls                              |  1 +
 .../syscalls/rt_sigqueueinfo/.gitignore       |  1 +
 .../rt_sigqueueinfo/rt_sigqueueinfo02.c       | 99 +++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 02e721df9..837fa5699 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1224,6 +1224,7 @@ rt_sigaction03 rt_sigaction03
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
index 000000000..ab30c2abd
--- /dev/null
+++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo02.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that, rt_sigqueueinfo(2) sets errno to
+ *
+ * - EINVAL if sig is invalid
+ * - EPERM if uinfo->si_code is invalid
+ * - ESRCH if no thread group matching tgid is found
+ */
+
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
+	TST_CHECKPOINT_WAKE(0);
+}
+
+static void child_do(void)
+{
+	TST_CHECKPOINT_WAIT(0);
+}
+
+static void verify_rt_sigqueueinfo(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	pid_t pid = SAFE_FORK();
+
+	if (!pid) {
+		child_do();
+		exit(0);
+	}
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
+	.bufs = (struct tst_buffers []) {
+		{&siginfo_einval, .size = sizeof(siginfo_einval)},
+		{&siginfo_eperm, .size = sizeof(siginfo_eperm)},
+		{&siginfo_esrch, .size = sizeof(siginfo_esrch)},
+		{},
+	}
+};
+
+#else
+	TST_TEST_TCONF("This system does not support rt_sigqueueinfo()");
+#endif /* HAVE_STRUCT_SIGACTION_SA_SIGACTION */
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
