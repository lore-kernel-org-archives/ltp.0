Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7BCC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A312B3CA08B
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:05:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38CFC3CA09E
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:56 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51BDA1401272
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645005894; i=@fujitsu.com;
 bh=fvNzt4/tJYZRQ3QeiKe20NuyfpOXVj+lpUqRVnlCZdE=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=aVwvDTSHQRffCqKTEQ3GpXdPo1ThBhpQpkOgRA8qqsu2HML9zJQO+gO9Bh1CkfLmx
 kBTu0gG28hwPliUHUVNVHqzMUnLVvZF8UyRvvDsKHdGpqNhjq2XBwwLxDb4nFaV0s/
 IVIuV0uYjkEBaSbakeFtzc9tAifLJ3lsFONE3rHEixlmG/cCD31pAuRKymJ1B1bBCc
 +cwF+Ah5PPl9SBCT9c+TQQKunRJTLo+ZciSVPYc1LBfZZzHfwiTwlNtgqYJmoP8q9h
 x2IqLp96FvMqcTHMhBmsAzM1TPW+NJvda+UVzpmk5nIWaIEZt2MzTLS6v0aoxIEPeO
 AGlJqrkUYBGuw==
Received: from [100.115.69.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-central-1.aws.ess.symcld.net id 2D/B2-13301-64CCC026;
 Wed, 16 Feb 2022 10:04:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRWlGSWpSXmKPExsViZ8MxRdftDE+
 SwbFSixXfdzA6MHrs+72ONYAxijUzLym/IoE1o/tVP2PBOtWK86cfsDYwrlToYuTiEBJoYpK4
 3PaTBcLZwyjxZ+Np5i5GTg42AU2JZ50LwGwRAQmJjoa37CA2s4C6xPJJv5hAbGEBbYltf/eyd
 jFycLAIqEo0PvMDCfMKeEisv3ESrFxCQEFiysP3YGM4BTwlmns/sYLYQkA1/y6tYoWoF5Q4Of
 MJC8R4CYmDL14wQ/QqSlzq+MYIYVdIzJrVxjSBkX8WkpZZSFoWMDKtYrRLKspMzyjJTczM0TU
 0MNA1NDTVNTPTNTKy0Eus0k3USy3VTU7NKylKBErrJZYX66UWF+sVV+Ym56To5aWWbGIEBmZK
 sdOTHYyv+37qHWKU5GBSEuW1WsWTJMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCN38vUE6wKDU9t
 SItMwcYJTBpCQ4eJRFe6ZNAad7igsTc4sx0iNQpRkUpcd7Jp4ASAiCJjNI8uDZYZF5ilJUS5m
 VkYGAQ4ilILcrNLEGVf8UozsGoJMzrcRpoCk9mXgnc9FdAi5mAFis2coEsLklESEk1MO3ZKWV
 4QmQr+4bzWQYq7+U7G9JzLvc/8rh/R2DTCv9zM2qtdtV8VeezXGD0XSf59hyRQ/9Fe2/s+hYR
 8m2xpdLrjXttJHfmfZVddHHWRgmN6kOXDStMO7j36yXYWWfo/S+ZEKVafcwtia3sjm/SNCcXp
 f4l8keSnqqJNOmFmNep7lsTfjfjpMRkPTOnwEXtb9pLPp7eWc0/37BgmoDe73cSW3Zc1QmY4f
 TZ/2XJis659rr81vrTG1UOWR35YGbP95mL48b8krp3m325p6vpOCjuZlumsOv5FYvXnF4OS0K
 jDxsm/D9ue3Yjb9emU+9+7hIRnf+xvEj21i6dS7fqfNevym96YCNy5gCfYnjQWiWW4oxEQy3m
 ouJEAHUf4YNHAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-28.tower-545.messagelabs.com!1645005893!5905!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32699 invoked from network); 16 Feb 2022 10:04:53 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-28.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Feb 2022 10:04:53 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21GA4cqL007853
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:04:53 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:04:36 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Feb 2022 18:04:27 +0800
Message-ID: <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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

The pidfd_getfd() system call allocates a new file descriptor in the calling process.
This new file descriptor is a duplicate of an existing file descriptor, targetfd, in
the process referred to by the PID file descriptor pidfd.

pidfd_getfd was introduced since kernel 5.6 and pidfd_open was introduced since kernel 5.3.
pidfd_getfd is not similar to pidfd_send_signal because it didn't support fd from
/proc/pid directory. So we must check kernel whether support pidfd_open because some linux
distribution backports pidfd_getfd but not backport pidfd_open.

Here we check whether the newfd set close-on-exce flag and use kcmp to check the two fds whether
point to the same open file instead of using fstat to check.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  2 +
 .../kernel/syscalls/pidfd_getfd/.gitignore    |  1 +
 .../kernel/syscalls/pidfd_getfd/Makefile      |  6 ++
 .../syscalls/pidfd_getfd/pidfd_getfd01.c      | 96 +++++++++++++++++++
 4 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/Makefile
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ce6f89f88..6155712cc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -951,6 +951,8 @@ pause03 pause03
 personality01 personality01
 personality02 personality02
 
+pidfd_getfd01 pidfd_getfd01
+
 pidfd_open01 pidfd_open01
 pidfd_open02 pidfd_open02
 pidfd_open03 pidfd_open03
diff --git a/testcases/kernel/syscalls/pidfd_getfd/.gitignore b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
new file mode 100644
index 000000000..c193ffee7
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
@@ -0,0 +1 @@
+pidfd_getfd01
diff --git a/testcases/kernel/syscalls/pidfd_getfd/Makefile b/testcases/kernel/syscalls/pidfd_getfd/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
new file mode 100644
index 000000000..f3f5132fe
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic pidfd_getfd() test:
+ *
+ * - the close-on-exec flag is set on the file descriptor returned by
+ *   pidfd_getfd
+ * - use kcmp to check whether a file descriptor idx1 in the process pid1
+ *   refers to the same open file description as file descriptor idx2 in
+ *   the process pid2
+ */
+
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/pidfd_getfd.h"
+#include "lapi/kcmp.h"
+#include "tst_safe_macros.h"
+
+#define TESTFILE "testfile"
+
+static int fds[2];
+
+static void do_child(void)
+{
+	int fd;
+
+	SAFE_CLOSE(fds[0]);
+	fd = SAFE_CREAT(TESTFILE, 0644);
+	SAFE_WRITE(1, fds[1], &fd, sizeof(fd));
+	TST_CHECKPOINT_WAIT(0);
+	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fds[1]);
+	exit(0);
+}
+
+static void run(void)
+{
+	int flag, pid, pidfd, targetfd, remotefd;
+
+	SAFE_PIPE(fds);
+	pid = SAFE_FORK();
+	if (!pid)
+		do_child();
+
+	SAFE_CLOSE(fds[1]);
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+
+	TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open(pid, 0)");
+	pidfd = TST_RET;
+	SAFE_READ(1, fds[0], &targetfd, sizeof(targetfd));
+	TST_EXP_FD_SILENT(pidfd_getfd(pidfd, targetfd, 0),
+		"pidfd_getfd(%d, %d , 0)", pidfd, targetfd);
+
+	remotefd = TST_RET;
+	flag = fcntl(remotefd, F_GETFD);
+	if (flag == -1)
+		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
+	if (!(flag & FD_CLOEXEC))
+		tst_res(TFAIL, "pidfd_getfd() didn't set close-on-exec flag");
+
+	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
+	if (TST_RET != 0)
+		tst_res(TFAIL, "pidfd_getfd() didn't get the same open file description");
+
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_CLOSE(remotefd);
+
+	tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
+	SAFE_CLOSE(pidfd);
+	SAFE_CLOSE(fds[0]);
+	tst_reap_children();
+}
+
+static void setup(void)
+{
+	pidfd_open_supported();
+	pidfd_getfd_supported();
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.test_all = run,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
