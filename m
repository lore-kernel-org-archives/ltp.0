Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF4FC25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717057568; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Qg+GRFKsDOV2LjNlWMUxgWekkh7GpJTMdpCHAnLNhpw=;
 b=Jm9RAHhSByIp2pcYGnOhUmiC3/i0IOBW1lHm01V8F7wdS2NCTlViwDGLLJE0uRzukvh11
 pYSfbodAuQMwZpN0kHtKjoM2koaSyL3Cx4IiwVlr+4YjJVooE3h5fSzCDZc+oMkfQ9K+Bo/
 NDpiy/ZMzE/THiVLtKyl7RPQmytXMpo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD61C3D06EE
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 10:26:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C415A3C885D
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:25:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.37.100;
 helo=esa12.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83E5320032E
 for <ltp@lists.linux.it>; Thu, 30 May 2024 10:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1717057545; x=1748593545;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mMbpIP66faS1Zg0WAs5crG4Maih1gTXOgmVpw+7GsmY=;
 b=ewOGl/yPhw3F04G7j4jHXPbfhhSdFSL/asVedV3eW7zOLoJlqma1ME+O
 bvCEgqjpkq4ycn1Oyq2ct755xkPo9AOfyOvkld0OpCKUjfdSuqY7WpTJX
 wcfYhCE8G6zlKLA0L0T+BY3OsQj7PAaoMmIZFhYhoPV+FKEBMKS98zA9e
 5ygcJu9Qk5Du17lBQbJpD1P/0ACXHSEU1XZFLSVqvPfBOeM03QsOL/fVG
 F1gk4ftEAA7jHEjikqnnXixoxZ6blN9mklGlVecuZSDLkIJURrZth0jMY
 kn1VsH2R0IDVNM34BmY5DqfSc+fR4lIbcJwarHCVGSywwI6nokMJcVK3H w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="139894323"
X-IronPort-AV: E=Sophos;i="6.08,199,1712588400"; d="scan'208";a="139894323"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 17:25:42 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D6985D4F60
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:25:40 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A6C2D3F12
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:25:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E0E4200930B3
 for <ltp@lists.linux.it>; Thu, 30 May 2024 17:25:39 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 323B91A000A;
 Thu, 30 May 2024 16:25:39 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 30 May 2024 16:25:23 +0800
Message-Id: <20240530082522.2505-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
In-Reply-To: <8a4a1452-0d8b-473e-be89-c0d4fb286abd@suse.com>
References: <8a4a1452-0d8b-473e-be89-c0d4fb286abd@suse.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28418.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28418.005
X-TMASE-Result: 10--14.278400-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfNSuJfEWZSQfB1kSRHxj+Z5QAKUX1R86jTfUZT83lbkEHU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoQo5ye27KXf5H+Kx4IA1XTXL7fGpDjikVaVF2HD8EHNp6TYf9v9flol3m7FRTxl32QWWg
 76IlE/zJoi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/s3UdNCtakJ4gIdyjxwr2jHtfPe
 Z+aFn+ACCL9D2N12K++j225mDeWcw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] signalfd: Add negative tests
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

Add negative cases for signalfd(), when errno is EBADF or EINVAL

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/signalfd/.gitignore |  1 +
 .../kernel/syscalls/signalfd/signalfd02.c     | 82 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/signalfd/signalfd02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a06b046ac..2dac79798 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1487,6 +1487,7 @@ signal05 signal05
 signal06 signal06
 
 signalfd01 signalfd01
+signalfd02 signalfd02
 
 signalfd4_01 signalfd4_01
 signalfd4_02 signalfd4_02
diff --git a/testcases/kernel/syscalls/signalfd/.gitignore b/testcases/kernel/syscalls/signalfd/.gitignore
index 3c9ed737c..959022f41 100644
--- a/testcases/kernel/syscalls/signalfd/.gitignore
+++ b/testcases/kernel/syscalls/signalfd/.gitignore
@@ -1 +1,2 @@
 /signalfd01
+/signalfd02
diff --git a/testcases/kernel/syscalls/signalfd/signalfd02.c b/testcases/kernel/syscalls/signalfd/signalfd02.c
new file mode 100644
index 000000000..527e1aff9
--- /dev/null
+++ b/testcases/kernel/syscalls/signalfd/signalfd02.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that signalfd(2) fails with
+ *
+ * - EBADF when fd is invalid
+ * - EINVAL when fd is not a valid signalfd file descriptor
+ * - EINVAL when flags are invalid
+ */
+
+#include <sys/signalfd.h>
+#include "tst_test.h"
+
+#define SIGNAL_FILE "signal_file"
+
+static int fd_ebadf = -2;
+static int fd_einval1;
+static int fd_einval2 = -1;
+
+static sigset_t mask1;
+static sigset_t mask2;
+static sigset_t mask3;
+
+static struct test_case_t {
+	int *fd;
+	sigset_t *mask;
+	int flags;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{&fd_ebadf, &mask1, 0, EBADF, "fd is invalid"},
+	{&fd_einval1, &mask2, 0, EINVAL,
+		"fd is not a valid signalfd file descriptor"},
+	{&fd_einval2, &mask3, -1, EINVAL, "flags are invalid"},
+};
+
+static void setup(void)
+{
+	SAFE_SIGEMPTYSET(&mask1);
+	SAFE_SIGADDSET(&mask1, SIGUSR1);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask1, NULL);
+	SAFE_SIGEMPTYSET(&mask2);
+	SAFE_SIGADDSET(&mask2, SIGUSR2);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask2, NULL);
+	SAFE_SIGEMPTYSET(&mask2);
+	SAFE_SIGADDSET(&mask3, SIGUSR2);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask3, NULL);
+
+	fd_einval1 = SAFE_OPEN(SIGNAL_FILE, O_CREAT, 0777);
+}
+
+static void cleanup(void)
+{
+	if (fd_ebadf > 0)
+		SAFE_CLOSE(fd_ebadf);
+	if (fd_einval1 > 0)
+		SAFE_CLOSE(fd_einval1);
+	if (fd_einval2 > 0)
+		SAFE_CLOSE(fd_einval2);
+}
+
+static void verify_signalfd(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	TST_EXP_FAIL2(signalfd(*(tc->fd), tc->mask, tc->flags),
+		tc->expected_errno, "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_signalfd,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
