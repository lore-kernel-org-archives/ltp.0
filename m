Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F654C433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DC423CA0E1
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:12:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB02B3CA0B0
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:12:01 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E91362013BD
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645179120; i=@fujitsu.com;
 bh=U9qLch1xUElGxa8RqAxt28CFaxo4+gXsSiUOL+J7unA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=JBbvAe7owHyNyG2e+xgHXQw2JxcyTQR3b3W5hVyBuh+bO/9TvX06e6k9wgrBKMfyI
 s5PBQWszbhaLhiD3ZvFihlzYoQYxEvxQyJT5TvGmYewZnQjFqxGTvUsXwZEq9fvLH0
 F8AkLHTfQLHXlrKUIbMoMXymIANyV/BGHD7nLyr5etKlKmU5i2RVkaWPiOvKXrM1/e
 4tC0yMxvqTHI5l6m59NVh0AtI+kPafqN4wnB9fbquXUoj+NuP2KFn0ACnaTohIqlFt
 zRyzvOwdpfO8aNKdo/a5MnywsRKCOG4uLBYeZAI6LPDda2wrxlOyfJPP7paPDuBTQm
 ZiMkTT+PnG7Ew==
Received: from [100.115.32.10] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 87/6C-12680-FE07F026;
 Fri, 18 Feb 2022 10:11:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRWlGSWpSXmKPExsViZ8MxRfd9AX+
 SwfuXqhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bGFuGCVxoVCz9fZ2tg7FTuYuTiEBJoYpJo
 vn2ZFcLZwyhxZHETUxcjJwebgKbEs84FzCC2iICEREfDW3YQm1lAXWL5pF9gNcICnhJtb76D2
 SwCqhKvjnxgBLF5BTwkOm8tYQGxJQQUJKY8fM8MEReUODnzCQvEHAmJgy9eMEPUKEpc6vjGCG
 FXSMya1cY0gZF3FpKWWUhaFjAyrWK0TirKTM8oyU3MzNE1NDDQNTQ01TU21TW0MNFLrNJN1Es
 t1S1PLS7RNdJLLC/WSy0u1iuuzE3OSdHLSy3ZxAgMspRi5R07GNtW/dQ7xCjJwaQkymuWxZ8k
 xJeUn1KZkVicEV9UmpNafIhRhoNDSYJ3Ux5QTrAoNT21Ii0zBxjwMGkJDh4lEd5pUUBp3uKCx
 NzizHSI1ClGRSlxXi1gnAgJgCQySvPg2mBRdolRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO
 +/fKApPJl5JXDTXwEtZgJafLmUD2RxSSJCSqqBqf7u64iTz9oXz+SVa67tUWucaHRkzaMrZdJ
 v1DNVeCeUHnKS/dEUurHHMeQpc17z583PPNIZI6x/GzEnb2gKe7JEleGKfvmLj2mKWw69K9HK
 l6+WzN49e58Ovxv3g4MxOX5NC+bVbLIQMXvJXV8Zb6mZdHLtjyc/i2ZUROmFfNnZwvOl/MoKh
 fYu7rnl/mvnPLzMUdD1NeZhLU/mLruU3ytSZZO2bF2f8nTW4qSHv6vvqJ7Oaw0NWsj6uk7fUl
 +taYJMwzquZ2KOy/S4P1+yqjp256d0L7t5t+C2i/v/bZys8PTf3JO29XuqZWL7quLtOTjWL9K
 qyD/24aeY7Jt30+0qOHZL/LMPznJYUSOtxFKckWioxVxUnAgAIVogaS0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-571.messagelabs.com!1645179119!85423!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24598 invoked from network); 18 Feb 2022 10:11:59 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-15.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 18 Feb 2022 10:11:59 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 21IABph9006872
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:11:59 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Fri, 18 Feb 2022 10:11:50 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 18 Feb 2022 18:12:11 +0800
Message-ID: <1645179132-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_getfd01: Add basic functional
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

The pidfd_getfd() system call allocates a new file descriptor in the calling process.
This new file descriptor is a duplicate of an existing file descriptor, targetfd, in
the process referred to by the PID file descriptor pidfd.

pidfd_getfd was introduced since kernel 5.6 and pidfd_open was introduced since kernel 5.3.
pidfd_getfd is not similar to pidfd_send_signal because it didn't support fd from
/proc/pid directory. So we must check kernel whether support pidfd_open because some linux
distribution backports pidfd_getfd but not backport pidfd_open.

Here we check whether the newfd set close-on-exce flag and use kcmp to check the two fds whether
point to the same open file instead of using fstat to check.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/pidfd_getfd/.gitignore    |   1 +
 .../kernel/syscalls/pidfd_getfd/Makefile      |   6 +
 .../syscalls/pidfd_getfd/pidfd_getfd01.c      | 118 ++++++++++++++++++
 4 files changed, 127 insertions(+)
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
index 000000000..a8d0c9143
--- /dev/null
+++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
@@ -0,0 +1,118 @@
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
+	TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open(pid, 0)");
+	pidfd = TST_RET;
+	SAFE_READ(1, fds[0], &targetfd, sizeof(targetfd));
+	TST_EXP_FD_SILENT(pidfd_getfd(pidfd, targetfd, 0),
+		"pidfd_getfd(%d, %d , 0)", pidfd, targetfd);
+
+	remotefd = TST_RET;
+	flag = SAFE_FCNTL(remotefd, F_GETFD);
+	if (!(flag & FD_CLOEXEC))
+		tst_res(TFAIL, "pidfd_getfd() didn't set close-on-exec flag");
+
+	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
+		goto free;
+	}
+	if (TST_RET < 0 || TST_RET > 3) {
+		tst_res(TFAIL, "kcmp invalid returns value(%d)", (int)TST_RET);
+		goto free;
+	}
+	if (TST_RET != 0) {
+		tst_res(TFAIL, "kcmp returns unexpected value(%d) instead of 0",
+				(int)TST_RET);
+		goto free;
+	}
+
+	tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
+
+free:
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
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
