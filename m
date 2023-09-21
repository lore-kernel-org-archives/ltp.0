Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3449CD4954
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 05:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06833CDE99
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 07:23:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 317B63CA31F
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 07:22:40 +0200 (CEST)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0FC61000D46
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 07:22:39 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="132975073"
X-IronPort-AV: E=Sophos;i="6.03,164,1694703600"; d="scan'208";a="132975073"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 14:22:38 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C5E9BDB3C1
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:22:34 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 149AACF7C3
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 14:22:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id AE267883C1;
 Thu, 21 Sep 2023 14:22:32 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 21 Sep 2023 13:22:28 +0800
Message-Id: <1695273748-4607-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27888.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27888.005
X-TMASE-Result: 10--10.950700-10.000000
X-TMASE-MatchedRID: WNLpxaprp4IKK0r2G9VU7gPZZctd3P4BCZa9cSpBObm+f7ap9DJaDb8F
 Hrw7frluX2TxVGxWCcEafQZfvyaD9NbNQByfRPHgSs47mbT7SATzWEMQjooUzQhVq5YmQAlEvmK
 TdxbGqLK3KNQyDMLBzRqKuTwtGvmtFxyzzffqvHnfSQNpZkETVB4crFjzdzs4myiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1kMa8cqelyIMOw7UpSt4jXNRUVWGK+nuPhfe7P7kB95adfcqjy4H5ZQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
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

Check errnos for fchmodat().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchmodat/.gitignore |  1 +
 .../kernel/syscalls/fchmodat/fchmodat02.c     | 66 +++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchmodat/fchmodat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..5a6b4a64d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -259,6 +259,7 @@ fchmod06 fchmod06
 
 #fchmodat test cases
 fchmodat01 fchmodat01
+fchmodat02 fchmodat02
 
 fchown01 fchown01
 fchown01_16 fchown01_16
diff --git a/testcases/kernel/syscalls/fchmodat/.gitignore b/testcases/kernel/syscalls/fchmodat/.gitignore
index a9508bc5a..09d5c47d5 100644
--- a/testcases/kernel/syscalls/fchmodat/.gitignore
+++ b/testcases/kernel/syscalls/fchmodat/.gitignore
@@ -1 +1,2 @@
 /fchmodat01
+/fchmodat02
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat02.c b/testcases/kernel/syscalls/fchmodat/fchmodat02.c
new file mode 100644
index 000000000..ad8e2aaf7
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat02.c
@@ -0,0 +1,66 @@
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
+ * - fchmodat() fails with ENOTDIR if dir_fd is file descriptor to the file
+ *   and pathname is relative path of the file.
+ *
+ * - fchmodat() fails with EBADF if dir_fd is invalid.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+
+#define TESTDIR         "fchmodatdir"
+#define TESTFILE        "fchmodatfile"
+#define FILEPATH        "fchmodatdir/fchmodatfile"
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
+static void verify_fchmodat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(fchmodat(*tc->fd, TESTFILE, 0600, 0),
+		     tc->exp_errno, "fchmodat(%d, %s, 0600, 0)", *tc->fd, TESTFILE);
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
+	.test = verify_fchmodat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
