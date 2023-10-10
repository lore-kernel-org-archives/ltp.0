Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B67CD68ED
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 05:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C563C8932
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 07:28:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22AAE3C2DA4
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 07:28:48 +0200 (CEST)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4F39E60024B
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 07:28:47 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="134933293"
X-IronPort-AV: E=Sophos;i="6.03,211,1694703600"; d="scan'208";a="134933293"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2023 14:28:45 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 27BC9C3F81
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:43 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B90CCFBA2
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:42 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0872120077820
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 14:28:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B8EAA1A0074;
 Tue, 10 Oct 2023 13:28:41 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 10 Oct 2023 13:28:29 +0800
Message-Id: <1696915709-6304-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27926.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27926.005
X-TMASE-Result: 10--12.223700-10.000000
X-TMASE-MatchedRID: P0y1Pz0bU7kKK0r2G9VU7gPZZctd3P4BCZa9cSpBObm+f7ap9DJaDb8F
 Hrw7frluX2TxVGxWCcGSOPRL2u2F4Smyf2R1E4xpGYJhRh6ssesfimmlcABuN8SiwizsgluQTzA
 mqaqCd4B+CxzcGwLNWIkrinmMF3EWCo1+PMDjC96628cXbnOhT5Ry1HDTPOXaR6RHdVK85hXZ/6
 HCEey99eLzNWBegCW2wgn7iDBesS0gBwKKRHe+r1e07U3hxgAEFz9nlPpuzU07Km6u9fWkqL2KQ
 EFlSk8rbZEmn9xbDvw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] syscalls/fchownat03: Move errnos check to
 fchownat03
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

Check errnos for fchownat().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 testcases/kernel/syscalls/fchownat/.gitignore |  1 +
 .../kernel/syscalls/fchownat/fchownat03.c     | 76 +++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..fbbab829f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -274,6 +274,7 @@ fchown05_16 fchown05_16
 #fchownat test case
 fchownat01 fchownat01
 fchownat02 fchownat02
+fchownat03 fchownat03
 
 fcntl01 fcntl01
 fcntl01_64 fcntl01_64
diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
index 35c00345b..60fac7e69 100644
--- a/testcases/kernel/syscalls/fchownat/.gitignore
+++ b/testcases/kernel/syscalls/fchownat/.gitignore
@@ -1,2 +1,3 @@
 /fchownat01
 /fchownat02
+/fchownat03
diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
new file mode 100644
index 000000000..56b090895
--- /dev/null
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2003-2023
+ * AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * - fchownat() fails with ENOTDIR  if dir_fd is file descriptor to the file
+ *   and pathname is relative path of the file.
+ *
+ * - fchownat() fails with EBADF if dir_fd is invalid.
+ *
+ * - fchownat() fails with EINVAL if flag is invalid.
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+#define TESTFILE	"testfile"
+
+static int dir_fd, fd;
+static int no_fd = -1;
+static char *testfile;
+
+static struct tcase {
+	int *fds;
+	char **filenames;
+	int flag;
+	int exp_errno;
+} tcases[] = {
+	{&fd, &testfile, 0, ENOTDIR},
+	{&no_fd, &testfile, 0, EBADF},
+	{&dir_fd, &testfile, -1, EINVAL},
+};
+
+static void setup(void)
+{
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+
+	fd = SAFE_OPEN("testfile2", O_CREAT | O_RDWR, 0600);
+}
+
+static void fchownat_verify(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
+	     tc->flag), tc->exp_errno, "fchownat(%d, %s, %d, %d, %d)",
+	     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		close(fd);
+
+	if (dir_fd > -1)
+		close(dir_fd);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = fchownat_verify,
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&testfile, .str = TESTFILE},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
