Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7782BC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 10:05:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663303CA08D
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 11:05:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176B13CA0A3
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:05:16 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21B40100128A
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 11:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645005915; i=@fujitsu.com;
 bh=jkrr0IEk20hCZV3/TlJ6cUdG1FN9lF55zZbOOVA4stM=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=ns44yjXQaSnPYFMr9kHD8Ag8iBHGy6xI40olYV/+aJMwEnJjnytk6Vu2FWSQA9IPZ
 UOwC9Qt7u6Z1Gn6SMPNkT3Ptuvw9VnprLJBDkoSrjcpvuEkeAS+sjPwbayrK1IGt1i
 0n3GjB5NrjgeOrgHPm74zdjypGAisJwU7XxrgIxp6vRtXnHzbNU2y81wV+w4wIFmAh
 bMS6uV5X+9zcv6tYm9m3TPZg8qkQkiRREFrR1ee/uTYHK6c0r5ABtj8wHL49LF3bbR
 qNDV51OO3Enj9rh45nt1ZcUhlg30FD+nRpoSyspNhsFIsKLaVYmM60qh/V0zSJhRVG
 SjsjHEG35Q0kg==
Received: from [100.115.7.114] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.ess.symcld.net id 54/AB-12986-B5CCC026;
 Wed, 16 Feb 2022 10:05:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8MxSTfqDE+
 SQdNKc4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNePh/huMBTfkKs6sfsjcwNgq1cXIxSEkcJZR
 4uqss8wQzk4mia1zFzJ1MXICOXsYJSY/iwGx2QQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9A
 qrn4BAWcJSY1R8KEmYRUJXYfPY5C4jNK+Ah8e3ZYbBWCQEFiSkP34PZnAKeEs29n1ghVnlI/L
 u0ihWiXlDi5MwnLBDjJSQOvngB1asocanjGyOEXSExa1YbE4StJnH13CbmCYyCs5C0z0LSvoC
 RaRWjZVJRZnpGSW5iZo6uoYGBrqGhqa6hrqmlXmKVbqJeaqlueWpxia6hXmJ5sV5qcbFecWVu
 ck6KXl5qySZGYACnFDNa72Ds6Pupd4hRkoNJSZTXahVPkhBfUn5KZUZicUZ8UWlOavEhRhkOD
 iUJ3vy9QDnBotT01Iq0zBxgNMGkJTh4lER4pU8CpXmLCxJzizPTIVKnGBWlxHltTgMlBEASGa
 V5cG2wCL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZjXA2QKT2ZeCdz0V0CLmYAWKzZygSw
 uSURISTUwcUlzzgmtui1wz3rq0fY4Vh6JpaZ/ZpZfmTH5iNt7t2l2nyxj3m+cfeYCi+X7jQnn
 fWbEiAhwvrrH/9WA7+lUxs3rbzZ99CxRsLf7rPijelXi7x9NTt6Ks0Iu7U3bd7V53YOWSw1Py
 39tlGyTKlikWWRqs4cpInx74Q5TlesG6//tOd3QIp3XWLh6lsJh31P6bXsbG4VfKB39cWa60/
 Ht2d9btv9jf3Kvd2JlzI1vNyY9vVqsfv9cjvKByZ9Y5B+c3WdX9OfHMuWfT+a+snw3J32vWfx
 ctlU/3xutLOmrF2p7e/wT/71wv2WZd83/v2q4s5D/TuWPLk/7gF+nTpqc0ohId3i1rexw25pl
 yRdOOUcpsRRnJBpqMRcVJwIAUw0ZL1sDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-587.messagelabs.com!1645005914!9149!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12163 invoked from network); 16 Feb 2022 10:05:14 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Feb 2022 10:05:14 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 58A6E100452
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:05:14 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4BA6E10032A
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 10:05:14 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Wed, 16 Feb 2022 10:04:40 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 16 Feb 2022 18:04:28 +0800
Message-ID: <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/pidfd_getfd/.gitignore    |   1 +
 .../syscalls/pidfd_getfd/pidfd_getfd02.c      | 108 ++++++++++++++++++
 3 files changed, 110 insertions(+)
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
index c193ffee7..f944adc6f 100644
--- a/testcases/kernel/syscalls/pidfd_getfd/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
@@ -1 +1,2 @@
 pidfd_getfd01
+pidfd_getfd02
diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
new file mode 100644
index 000000000..e4f5a1467
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
@@ -0,0 +1,108 @@
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
+ * - ESRCH the process referred to by pidfd does not exist(it has terminated and
+ *   been waited on))
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
+static int valid_pidfd, expire_pidfd, invalid_pidfd = -1;
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
+	{"the process referred to by pidfd doesn't exist", &expire_pidfd, 0, 0, ESRCH},
+	{"lack of required permission", &valid_pidfd, 0, 0, EPERM},
+};
+
+static void setup(void)
+{
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	uid = pw->pw_uid;
+
+	pidfd_open_supported();
+	pidfd_getfd_supported();
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
+	switch (tc->exp_errno) {
+	case EPERM:
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
+	break;
+	case ESRCH:
+		pid = SAFE_FORK();
+		if (!pid) {
+			TST_CHECKPOINT_WAIT(0);
+			exit(0);
+		}
+		TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open");
+		*tc->pidfd = TST_RET;
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_WAIT(NULL);
+	break;
+	default:
+	break;
+	};
+
+	TST_EXP_FAIL2(pidfd_getfd(*tc->pidfd, tc->targetfd, tc->flags),
+		tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
+		*tc->pidfd, tc->targetfd, tc->flags, tc->name);
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
