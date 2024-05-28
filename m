Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2DEC25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 10:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716892451; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5RFXQ4BAZKt/AWLMV0lYmS56g4rMIm2ZjXTfq3TvihE=;
 b=UQBS6z13F+gXFYZdQpM06bG6qKHwocl9R7eCOyAGhnFWW/6zJo0ephGqsRE5BqoIGGPOB
 /KBRTXa3NQLmPjzk3mQYYbcMHR4aVsNDRIMm+3wjvtsnBliLuGAnPQBLnte5JUFTLF9XRab
 7B3ZcvlUn6MBHkFG5jXipoBOPMDQlF4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1554D3D0528
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:34:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A4F83D04BD
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:33:35 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C490602743
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716892415; x=1748428415;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dfo3A+FjIxBp9qyJ0xJspxnAqZ2Uc3kVkyPXBbmsUBs=;
 b=G7ACqexHKi/GC0esslPcjtQKk6i8Hv2QaoxnpwQKzw1UkaBCwRnhbQDU
 dEzV3iUqFL53RTejcDFYYf+hsypiM5QEqb2wgUQPM5snNtpLu2vdpFxUO
 8Hx8BgSUrlVZS8k+k7opdkhnCAmq1i0ZsCKWhAlXaKfmM2EKIWTBM9cUl
 W6x3bpPD4m2R8Pa8gXx/kr3+NN/WsX42Xqiy0grLnH3eMUOREYf62guqh
 S0/avDAZEM0HN08XO+JQsg3rdF1emxhSz2lUaeqUCDTGXrwUHtYdRi6Qo
 QGOgesEApIBtl9MMaiWpOyJDo6AWJ+Iw+cJByOAdmnfuXZXIuMvaMlimN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="148846892"
X-IronPort-AV: E=Sophos;i="6.08,195,1712588400"; d="scan'208";a="148846892"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 19:33:33 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3AA71C68E4
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:30 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 83E96D560E
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 16D79200501B6
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:33:29 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A0D2D1A000A;
 Tue, 28 May 2024 18:33:28 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 18:33:00 +0800
Message-Id: <20240528103258.2390-2-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
In-Reply-To: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
References: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28414.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28414.007
X-TMASE-Result: 10--14.666600-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiJSuJfEWZSQfB1kSRHxj+Z5QAKUX1R86jTfUZT83lbkEHU3
 oKSu0J1xUh5maKIJAx/mn3xyPJAJoimyf2R1E4xpGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoS1/NE2jc9NGC1KtRlVMLIXxQx249G3sHlvYc2JZpUvMPlSepWcgdLPWSYg69K24my/jz
 9RTmfNFGWdS71W+uwVMBbXb6klnc03KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7kHNK
 C4s5iDs+LwTDRh43b8M09TZXvtvYTokQ9oCm+TysBTJSD2iAW0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] signalfd: Add negative tests
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
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/signalfd/.gitignore |   1 +
 .../kernel/syscalls/signalfd/signalfd02.c     | 115 ++++++++++++++++++
 3 files changed, 117 insertions(+)
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
index 000000000..9ca943942
--- /dev/null
+++ b/testcases/kernel/syscalls/signalfd/signalfd02.c
@@ -0,0 +1,115 @@
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
+#define _GNU_SOURCE
+
+#include <signal.h>
+#include "tst_test.h"
+#include "config.h"
+
+#ifndef HAVE_SIGNALFD
+#define USE_STUB
+#endif
+
+#ifdef HAVE_SYS_SIGNALFD_H
+#include <sys/signalfd.h>
+#elif defined HAVE_LINUX_SIGNALFD_H
+#include <linux/signalfd.h>
+#define USE_OWNIMPL
+#else
+#define USE_STUB
+#endif /* HAVE_SYS_SIGNALFD_H */
+
+#ifndef HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
+#define USE_STUB
+#endif /* HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO */
+
+#ifdef USE_STUB
+TST_TEST_TCONF("This system does not support signalfd()");
+#else /* USE_STUB */
+#if defined USE_OWNIMPL
+#include "lapi/syscalls.h"
+int signalfd(int fd, const sigset_t *mask, int flags)
+{
+	return tst_syscall(__NR_signalfd, fd, mask, flags);
+}
+#endif /* USE_OWNIMPL */
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
+
+#endif /* USE_STUB */
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
