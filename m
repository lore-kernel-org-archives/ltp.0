Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F2EB64DD
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:09:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C1513CE387
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:09:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 594FB3CE390
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:26 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9D3BE10008F5
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:24 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="115396622"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="115396622"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 842D97FB69
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:20 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A9610D9467
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id BE549878F1;
 Sat,  5 Aug 2023 13:08:18 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:07:58 +0800
Message-Id: <1691208482-5464-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--8.450700-10.000000
X-TMASE-MatchedRID: XtCve4MvQMKwQEC6hpSor6zGfgakLdjaCZa9cSpBObm+f7ap9DJaDb8F
 Hrw7frluRK4fQsyK1poxfzRy6Vohea/Elphzpf1LGYJhRh6ssesfimmlcABuN8SiwizsgluQTzA
 mqaqCd4B+CxzcGwLNWIkrinmMF3EW1Yo2Yq2e9TVVXhlmZsTdjI5UafLmrvaGuru1Fdc/nkajxY
 yRBa/qJcFwgTvxipFajoczmuoPCq1IG2aetfpgiTTqttA4ao52OfCVoIeeJgDFG2Sxgg0wsOKtv
 9xXmeH7
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls/faccessat02: Move errnos check to
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

Check various errnos for faccessat().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/faccessat/.gitignore      |  1 +
 .../kernel/syscalls/faccessat/faccessat02.c   | 68 +++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 testcases/kernel/syscalls/faccessat/faccessat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1028e45fc..1aed336ee 100644
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
index 000000000..8e148dce0
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat/faccessat02.c
@@ -0,0 +1,68 @@
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
+#include "lapi/fcntl.h"
+#include "lapi/faccessat.h"
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
+		     tc->exp_errno, "faccessat(%d, TESTFILE, R_OK, 0)", *tc->fd);
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
