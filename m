Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FF5C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:45:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAFC83CA1A9
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:45:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01F763CA190
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:44:54 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4031C200917
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519493; i=@fujitsu.com;
 bh=yim/9uHxDDRnEZA+Y49l3SLQmmsySIxyj2gkrzCbJtI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=AMM7R7IBh1FCxTYOfr5apo00fAVgdkII/VUSq7QGHn2100m2OC/XaQz/sOKxxovWu
 SVB8ems5NgY5XN0A9PiCZXpfDhFeI3xL0gJ2+clSo2LRhp/8o4OpkFtCHBvRq2tCzU
 iiGK+9DoWX+o+qs9syg+lWiV9kqf6QcC5IAX6DIRJDSANYtoDLyLD8adZM1b9zFCUF
 E4127tWvI1S2Byft8wvHljJx5PjwRuGCuxFYcFRp10/3mpOqO8nuDX8awDjS/cFxLZ
 DArlZZ/avGj26NrHx0GZiRQp+fMy64Rz4Lo1doUlykDkEa5HH6u0gnS/BiBHxsDjom
 iTt32DsJF1xkw==
Received: from [100.115.69.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id D6/10-30582-582A4126;
 Tue, 22 Feb 2022 08:44:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxSbd1kUi
 SwYbLHBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bpNoeC7aoVPYfusTYwLlXoYuTiEBI4yygx
 8e5ONghnJ5PEtulHmSCcPYwS/Rf2A2U4OdgENCWedS5gBrFFBCQkOhresoPYzALqEssn/WICs
 YUFPCUaf19i7GLk4GARUJVYfCUQxOQV8JA4etEJpEJCQEFiysP3YFN4BQQlTs58wgIxRULi4I
 sXzBA1ihKXOr4xQtgVErNmtTFB2GoSV89tYp7AyD8LSfssJO0LGJlWMdomFWWmZ5TkJmbm6Bo
 aGOgaGprqmlkAKb3EKt1EvdRS3eTUvJKiRKCsXmJ5sV5qcbFecWVuck6KXl5qySZGYFimFLtw
 72C80/dT7xCjJAeTkijv1ykiSUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeJfOA8oJFqWmp1akZ
 eYAYwQmLcHBoyTCu2U2UJq3uCAxtzgzHSJ1ilFRSpy3ayFQQgAkkVGaB9cGi8tLjLJSwryMDA
 wMQjwFqUW5mSWo8q8YxTkYlYR5fy8AmsKTmVcCN/0V0GImoMVTsoRAFpckIqSkGpimHJWVetR
 bPO+uYZiBhbMP+2GJyRc27rL7Ot1MYPfklPwZKpeeOmSEGEkdDGhtmGK0tUlyr2Q17yTTm4lB
 T56sdDqavv9p02Ft51M3rt41UbaMl97nXHhrq9jJRdn7JCbzv119RZjlievhGZt3TdUs3Cf5m
 X1q7Ku0P+lCUcpFhiyaCT0h/NPLPEpevwn6JXMlzaVA8rMQ300PxXtOCqUzJrJpXHprqf0v9f
 uM3IXNBXPWSBwU7HG+O/eyjoj0xvTCR7r3GW2erl7GkrPadM9+Yf6zx52vuz6++qKGUeq7sci
 Ns28NbTQro3dcy9woyDW5WSNyvoqiy1XZh4avTAo3fXbn/rNIlTVKO+tTeZISS3FGoqEWc1Fx
 IgCux9D4RgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-532.messagelabs.com!1645519492!2827!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20941 invoked from network); 22 Feb 2022 08:44:53 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-9.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:44:53 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A542B1000F6
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:44:52 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 7D761100451
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:44:52 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:44:50 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:45:13 +0800
Message-ID: <1645519514-2826-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/7] syscalls/pidfd_getfd01: Add basic functional
 test
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

The pidfd_getfd() system call allocates a new file descriptor in the calling
process. This new file descriptor is a duplicate of an existing file descriptor,
targetfd, in the process referred to by the PID file descriptor pidfd.

pidfd_getfd was introduced since kernel 5.6 and pidfd_open was introduced since
kernel 5.3. pidfd_getfd is not similar to pidfd_send_signal because it didn't
support fd from /proc/pid directory. So we must check kernel whether support
pidfd_open because some linux distribution backports pidfd_getfd but not
backport pidfd_open.

Here we check whether the newfd set close-on-exce flag and use kcmp to check
the two fds whether point to the same open file instead of using fstat to check.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/pidfd_getfd/.gitignore    |   1 +
 .../kernel/syscalls/pidfd_getfd/Makefile      |   6 ++
 .../syscalls/pidfd_getfd/pidfd_getfd01.c      | 101 ++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/.gitignore
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/Makefile
 create mode 100644 testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index bc2e5f46a..126c33fc1 100644
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
index 000000000..9328942ac
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
@@ -0,0 +1 @@
+/pidfd_getfd01
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
index 000000000..8b5c6ea0d
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -0,0 +1,101 @@
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
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/kcmp.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_pidfd.h"
+
+#define TESTFILE "testfile"
+
+static int fds[2] = {-1, -1};
+static int pidfd = -1;
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
+	int flag, pid, targetfd, remotefd;
+
+	SAFE_PIPE(fds);
+	pid = SAFE_FORK();
+	if (!pid)
+		do_child();
+
+	SAFE_CLOSE(fds[1]);
+	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
+
+	pidfd = SAFE_PIDFD_OPEN(pid, 0);
+	SAFE_READ(1, fds[0], &targetfd, sizeof(targetfd));
+	TST_EXP_FD_SILENT(pidfd_getfd(pidfd, targetfd, 0),
+		"pidfd_getfd(%d, %d , 0)", pidfd, targetfd);
+
+	remotefd = TST_RET;
+	flag = SAFE_FCNTL(remotefd, F_GETFD);
+	if (!(flag & FD_CLOEXEC))
+		tst_res(TFAIL, "pidfd_getfd() didn't set close-on-exec flag");
+
+	TST_EXP_VAL_SILENT(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd), 0);
+
+	tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
+
+	TST_CHECKPOINT_WAKE(0);
+	SAFE_CLOSE(remotefd);
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
+static void cleanup(void)
+{
+	if (fds[0] > -1)
+		SAFE_CLOSE(fds[0]);
+	if (fds[1] > -1)
+		SAFE_CLOSE(fds[1]);
+	if (pidfd > -1)
+		SAFE_CLOSE(pidfd);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
