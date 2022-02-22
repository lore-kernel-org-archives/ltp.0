Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87455C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:45:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12F093CA199
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:45:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C48B43CA194
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:45:14 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18532200915
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519513; i=@fujitsu.com;
 bh=UywjusWYjH/ELX8EWN7k/TK3P5UREr09jEHvfYaAD9s=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=n6URefXVLSGOhjf8+wetwK7Cir5HrkTcLsmz91u+lFBqXYVhn3i/lS0dr2z1ElCwS
 la1nfGJgIoa0zwqrimoO+CK3cp4vdqZJgcnQF0yRArbGyuW1tQnKEnNjsy5ca1Zxql
 /hyySmHZakUUGBaW4OdU3+nZycF4we1oB2jewBRpI1iAabOLovu3Ef5vrGx0nnMPe8
 lLdyVhq7GYOIL29SF2AMh/bI/sLoZ2nii6DWplJHM2bzAtzZgatwZzxvs9uh1tXjoK
 dxOD8NQ238bXu8UuPDu27KM+pcmqeYUeK/Exjn6WzUFwa5qR/FssK2HgX0GFMTMl95
 05bWDdKXaKAQw==
Received: from [100.115.7.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 1E/63-12986-992A4126;
 Tue, 22 Feb 2022 08:45:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8ORqDtjkUi
 Swc2l2hYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8a35ia2gi6FisU7kxsYe6W7GLk4hATOMkqc
 n7yIHcLZySTx+PQTJghnD6PE0oadrF2MnBxsApoSzzoXMIPYIgISEh0Nb9lBbGYBdYnlk34xg
 djCAi4SU4+tZQOxWQRUJfa1XWUBsXkFPCQmH9wEFpcQUJCY8vA92BxOAU+JFX/vg80XAqq5cO
 s1VL2gxMmZT1gg5ktIHHzxghmiV1HiUsc3Rgi7QmLWrDYmCFtN4uq5TcwTGAVnIWmfhaR9ASP
 TKkarpKLM9IyS3MTMHF1DAwNdQ0NTXRNdI2NLvcQq3US91FLd8tTiEl1DvcTyYr3U4mK94src
 5JwUvbzUkk2MwCBOKWZ5v4Oxqe+n3iFGSQ4mJVHer1NEkoT4kvJTKjMSizPii0pzUosPMcpwc
 ChJ8C6dB5QTLEpNT61Iy8wBRhRMWoKDR0mEd8tsoDRvcUFibnFmOkTqFKOilDhv10KghABIIq
 M0D64NFsWXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnz/l4ANIUnM68EbvoroMVMQIunZAm
 BLC5JREhJNTD5T5zZfODq6/C9aXI+gf1LnLPmMT23Ep4ysSl83Qq9GCn+5Ortd48u6VydfPpm
 WYDnQ3cOwTBJiz13OxJE14jsV3BX+DDVVemPeadNa9j5VwFPn8ftPnr92Zrw1dv/mk1iqb5bv
 /DWmsfP3vibv/wa5DWn/PfTDIagxnP7NczWRrBz2e2Snf7z8C17BtHZ7sqr/KatFNXPnJCmqi
 f4lI15ktv+DObZT7f+mPhJ8c0HUc3g1EcXWRgtArSn/5JhdrRqf8kzSYVpotHVOr/zyqEL2vM
 zPWoX8saoX969QP7aT/Eznf8Fdil03nVsWxpivUZpomLf57WCcoFCUvue7L56dGnB7KYond+K
 qb/71lYpsRRnJBpqMRcVJwIAomavhV0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-591.messagelabs.com!1645519512!2820!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24676 invoked from network); 22 Feb 2022 08:45:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-23.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:45:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 34B55100199
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:45:12 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2807B10018E
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:45:12 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:44:55 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:45:14 +0800
Message-ID: <1645519514-2826-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645519514-2826-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645519514-2826-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 7/7] syscalls/pidfd_getfd02: Add basic error test
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/pidfd_getfd/.gitignore    |   1 +
 .../syscalls/pidfd_getfd/pidfd_getfd02.c      | 111 ++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 126c33fc1..b80786499 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -952,6 +952,7 @@ personality01 personality01
 personality02 personality02
 
 pidfd_getfd01 pidfd_getfd01
+pidfd_getfd02 pidfd_getfd02
 
 pidfd_open01 pidfd_open01
 pidfd_open02 pidfd_open02
diff --git a/testcases/kernel/syscalls/pidfd_getfd/.gitignore b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
index 9328942ac..8ef904202 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
@@ -1 +1,2 @@
 /pidfd_getfd01
+/pidfd_getfd02
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
new file mode 100644
index 000000000..805085cda
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the pidfd_open syscall.
+ *
+ * - EBADF pidfd is not a valid PID file descriptor
+ * - EBADF targetfd is not an open file descriptor in the process referred
+ *   to by pidfd
+ * - EINVAL flags is not 0
+ * - ESRCH the process referred to by pidfd does not exist (it has terminated
+ *   and been waited on))
+ * - EPERM the calling process doesn't have PTRACE_MODE_ATTACH_REALCREDS permissions
+ *   over the process referred to by pidfd
+ */
+
+#include <stdlib.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "tst_safe_pidfd.h"
+
+static int valid_pidfd = -1, invalid_pidfd = -1, pidfd = -1;
+static uid_t uid;
+
+static struct tcase {
+	char *name;
+	int *pidfd;
+	int targetfd;
+	int flags;
+	int exp_errno;
+} tcases[] = {
+	{"invalid pidfd", &invalid_pidfd, 0, 0, EBADF},
+	{"invalid targetfd", &valid_pidfd, -1, 0, EBADF},
+	{"invalid flags", &valid_pidfd, 0, 1, EINVAL},
+	{"the process referred to by pidfd doesn't exist", NULL, 0, 0, ESRCH},
+	{"lack of required permission", &valid_pidfd, 0, 0, EPERM},
+};
+
+static void setup(void)
+{
+	pidfd_open_supported();
+	pidfd_getfd_supported();
+
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid = pw->pw_uid;
+
+	valid_pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
+}
+
+static void cleanup(void)
+{
+	if (valid_pidfd > -1)
+		SAFE_CLOSE(valid_pidfd);
+	if (pidfd > -1)
+		SAFE_CLOSE(pidfd);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int pid;
+
+	if (tc->exp_errno == EPERM) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			SAFE_SETUID(uid);
+			TST_EXP_FAIL2(pidfd_getfd(valid_pidfd, tc->targetfd, tc->flags),
+				tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
+				valid_pidfd, tc->targetfd, tc->flags, tc->name);
+			TST_CHECKPOINT_WAKE(0);
+			exit(0);
+		}
+		TST_CHECKPOINT_WAIT(0);
+		SAFE_WAIT(NULL);
+		return;
+	} else if (tc->exp_errno == ESRCH) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			TST_CHECKPOINT_WAIT(0);
+			exit(0);
+		}
+		pidfd = SAFE_PIDFD_OPEN(pid, 0);
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_WAIT(NULL);
+		TST_EXP_FAIL2(pidfd_getfd(pidfd, tc->targetfd, tc->flags),
+			tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
+			pidfd, tc->targetfd, tc->flags, tc->name);
+		SAFE_CLOSE(pidfd);
+	} else	{
+		TST_EXP_FAIL2(pidfd_getfd(*tc->pidfd, tc->targetfd, tc->flags),
+			tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
+			*tc->pidfd, tc->targetfd, tc->flags, tc->name);
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
