Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B382EE4996
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 11:36:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6B4B3CC809
	for <ltp@archiver.kernel.org>; Mon, 21 Aug 2023 13:36:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F5EE3CC7E5
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:36:30 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6259960042A
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 13:36:28 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="108207155"
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; d="scan'208";a="108207155"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 20:36:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AA9FD7FB99
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 20:36:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9224ED946A
 for <ltp@lists.linux.it>; Mon, 21 Aug 2023 20:36:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F09A21D175;
 Mon, 21 Aug 2023 20:36:23 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 21 Aug 2023 19:35:55 +0800
Message-Id: <1692617755-32627-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692617755-32627-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692617755-32627-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27826.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27826.007
X-TMASE-Result: 10--8.450700-10.000000
X-TMASE-MatchedRID: XtCve4MvQMKwQEC6hpSor6zGfgakLdjaCZa9cSpBObm+f7ap9DJaDb8F
 Hrw7frluRK4fQsyK1poxfzRy6Vohea/Elphzpf1LGYJhRh6ssesfimmlcABuN8SiwizsgluQTzA
 mqaqCd4B+CxzcGwLNWIkrinmMF3EW1Yo2Yq2e9TVVXhlmZsTdjI5UafLmrvaGuru1Fdc/nkajxY
 yRBa/qJcFwgTvxipFajoczmuoPCq2yfWBthBnttFr9BQeRwDuHTt1s+rG8anPwWmeNPx8kDaeUb
 9Yh441U
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/faccessat02: Move errnos check to
 faccessat02
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check errnos for faccessat().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/faccessat/.gitignore      |  1 +
 .../kernel/syscalls/faccessat/faccessat02.c   | 67 +++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 testcases/kernel/syscalls/faccessat/faccessat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 119710d63..7f30d87ca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -215,6 +215,7 @@ exit_group01 exit_group01
 
 #faccessat test cases
 faccessat01 faccessat01
+faccessat02 faccessat02
 
 #fallocate test cases
 fallocate01 fallocate01
diff --git a/testcases/kernel/syscalls/faccessat/.gitignore b/testcases/kernel/syscalls/faccessat/.gitignore
index 9551ab97e..276caca45 100644
--- a/testcases/kernel/syscalls/faccessat/.gitignore
+++ b/testcases/kernel/syscalls/faccessat/.gitignore
@@ -1 +1,2 @@
 /faccessat01
+/faccessat02
diff --git a/testcases/kernel/syscalls/faccessat/faccessat02.c b/testcases/kernel/syscalls/faccessat/faccessat02.c
new file mode 100644
index 000000000..1add695c1
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat/faccessat02.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * - faccessat() fails with ENOTDIR if dir_fd is file descriptor to the file
+ *   and pathname is relative path of the file.
+ *
+ * - faccessat() fails with EBADF if dir_fd is invalid.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+
+#define TESTDIR         "faccessatdir"
+#define TESTFILE        "faccessatfile"
+#define FILEPATH        "faccessatdir/faccessatfile"
+
+static int dir_fd, file_fd;
+static int bad_fd = -1;
+
+static struct tcase {
+	int *fd;
+	int exp_errno;
+} tcases[] = {
+	{&file_fd, ENOTDIR},
+	{&bad_fd, EBADF},
+};
+
+static void verify_faccessat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(faccessat(*tc->fd, TESTFILE, R_OK, 0),
+		     tc->exp_errno, "faccessat(%d, TESTFILE, R_OK, 0)",
+		     *tc->fd);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR, 0700);
+	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
+	file_fd = SAFE_OPEN(FILEPATH, O_CREAT | O_RDWR, 0600);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
+
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_faccessat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
