Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A39C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:12:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6A53CA0CF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:12:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B805F3C9B46
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:12:01 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B457D2013BE
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645179120; i=@fujitsu.com;
 bh=8mtpDGjVoABXXLX983+dX0sa+XrZXCPKf3m8cKBoVeQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=O+EnxM+NS3Q6mj2pQ2q3oLZbxzCnMjgqg9RF+W+8ON8VfYYhi3LBAX3uQ5mhyeUAs
 PlO5K/MCjEhbjGmJGJiu/99wTx2qtMI0gcZEI/iFB9fU2QGVJemD0oHfWKj6+gSJ+F
 8JKzhyifH3LoqE7Rj7AOaoWz5OwFQ0tIwPoxl/JkKUKFaJV0uBORu6YdtRkC3Hv8iq
 9NPSAGaXdwNwjO5INAVt9jxeB7rDkrurulWC1yOeU2bkUrAqA5STvoL/UFM2WrSXCB
 K5dZ32nSxZTwAb69bYe+2a1vz3pY5qi3tDZuVWnD7PO/U3fo4yPV5VZocJXreP2Z/R
 SQGo6i0MeiI/w==
Received: from [100.115.69.174] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 1F/32-30582-0F07F026;
 Fri, 18 Feb 2022 10:12:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxRfd9AX+
 Swf/zBhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bTk64FL+UrljzsZ2xgbJbuYuTkEBJoYpL4
 3ZrexcgFZO9hlFj29jcrSIJNQFPiWecCZhBbREBCoqPhLTuIzSygLrF80i8mEFtYwEXi5OzjY
 DaLgKrEpF2LGEFsXgEPicXXz7OA2BICChJTHr4Hm8Mp4Clx5vUjRojFHhKrtyxjhqgXlDg58w
 kLxHwJiYMvXjBD9CpKXOr4xghhV0jMmtXGNIGRfxaSlllIWhYwMq1itE0qykzPKMlNzMzRNTQ
 w0DU0NNU1s9Q1N9FLrNJN1Est1U1OzSspSgTK6iWWF+ulFhfrFVfmJuek6OWllmxiBIZlSrGr
 1w7GI30/9Q4xSnIwKYnymmXxJwnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4N2UB5QTLEpNT61Iy
 8wBxghMWoKDR0mEd1oUUJq3uCAxtzgzHSJ1ilFRSpx3B0ifAEgiozQPrg0Wl5cYZaWEeRkZGB
 iEeApSi3IzS1DlXzGKczAqCfNeBpnCk5lXAjf9FdBiJqDFl0v5QBaXJCKkpBqYGBMvvFnBGpC
 sv+LXKiONqw+EJj2N1/vtJJtec6Xr3YW2JC3vqWvqH0/7qXt829S6D+yiRUG5PZl8Onzhxms3
 xM/pufxnC+cM1cTWUm6GpI+yKqvXPng1pYz1gHtV9/dPd9m7mfXZFxyvOPhSscdYnHOFc23Fw
 7XfCphYX8pJZFzYX2wQfE/hm6/EtIV/823PxHb9Y77//3ep772/39bO/hlUvq+vtHpJwLw3rF
 ePOQW++/k4RdD+atLCe0/PWCy5mW0f9fnw78bfTfMM2n7rfn2b9/Gy++Xpiee3KE7m1/2puiS
 d9U/Zs5/L1j5K/KKjsWT+hC0OyX1XusNMb/762/dt2zrRwyp1fKk+J5X+yyuxFGckGmoxFxUn
 AgC7Y8l0RgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-545.messagelabs.com!1645179119!4177!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30143 invoked from network); 18 Feb 2022 10:11:59 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-21.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Feb 2022 10:11:59 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21IABphA006872
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:11:59 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 10:11:57 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 18 Feb 2022 18:12:12 +0800
Message-ID: <1645179132-2247-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645179132-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645179132-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/pidfd_getfd02: Add basic error test
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
 .../syscalls/pidfd_getfd/pidfd_getfd02.c      | 104 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 6155712cc..436cc2a0a 100644
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
index 000000000..ef11de913
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
@@ -0,0 +1,104 @@
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
+ *   and been waited on)
+ * - EPERM the calling process doesn't have PTRACE_MODE_ATTACH_REALCREDS permissions
+ *   over the process referred to by pidfd
+ */
+
+#include <stdlib.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/pidfd_open.h"
+#include "lapi/pidfd_getfd.h"
+
+static int valid_pidfd, invalid_pidfd = -1;
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
+	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open");
+	if (!TST_PASS)
+		tst_brk(TFAIL | TTERRNO, "pidfd_open failed");
+	valid_pidfd = TST_RET;
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
+	} else if (tc->exp_errno == ESRCH) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			TST_CHECKPOINT_WAIT(0);
+			exit(0);
+		}
+		TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open");
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_WAIT(NULL);
+		TST_EXP_FAIL2(pidfd_getfd(TST_RET, tc->targetfd, tc->flags),
+			tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
+			(int)TST_RET, tc->targetfd, tc->flags, tc->name);
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
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
