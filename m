Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D3CDB47E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 02:56:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1E4D3CEF49
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 04:56:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44F83C02B2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:56:13 +0200 (CEST)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2CBF60082D
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:56:12 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="136501927"
X-IronPort-AV: E=Sophos;i="6.03,236,1694703600"; d="scan'208";a="136501927"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 11:56:10 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CF60FDDC64
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id F3BF9D5B3A
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 95DDC20074711
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 11:56:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 534741A0073;
 Thu, 19 Oct 2023 10:56:06 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 19 Oct 2023 10:55:52 +0800
Message-Id: <1697684152-29747-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27944.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27944.004
X-TMASE-Result: 10--14.980700-10.000000
X-TMASE-MatchedRID: iX1jgSPyW0MKK0r2G9VU7gPZZctd3P4BCZa9cSpBObm+f7ap9DJaDb8F
 Hrw7frluX2TxVGxWCcEafQZfvyaD9NbNQByfRPHgSs47mbT7SATzWEMQjooUzQhVq5YmQAlEvmK
 TdxbGqLK3KNQyDMLBzQT09/zQvuDS6qQbIJUDcq2/QNwZdfw3FaTYf9v9flol3m7FRTxl32QWWg
 76IlE/zJoi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2DsAVzN+Ov/sOTc8iexQZlZG6dseshtxyKDjy
 vOwj362RR2rpdl2nCS6Tml5J9ZEGg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls/fchmodat02: Move errnos check to
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
 .../kernel/syscalls/fchmodat/fchmodat02.c     | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchmodat/fchmodat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 1851752cf..8c62dc309 100644
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
index 000000000..3539753b8
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat02.c
@@ -0,0 +1,85 @@
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
+ * - fchmodat() fails with ENOTDIR if dir_fd is file descriptor
+ *   to the file and pathname is relative path of the file.
+ * - fchmodat() fails with EBADF if dir_fd is invalid.
+ * - fchmodat() fails with EFAULT if pathname points outside
+ *   the accessible address space.
+ * - fchmodat() fails with ENAMETOOLONG if path is too long.
+ * - fchmodat() fails with ENOENT if pathname does not exist.
+ * - fchmodat() fails with EINVAL if flag is invalid.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include "tst_test.h"
+
+#define TESTFILE        "fchmodatfile"
+
+static int file_fd;
+static int bad_fd = -1;
+static char path[PATH_MAX + 2];
+static char *long_path = path;
+static int fd_atcwd = AT_FDCWD;
+static char *bad_path;
+static char *test_path;
+static char *empty_path;
+
+static struct tcase {
+	int *fd;
+	char **filenames;
+	int flag;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{&file_fd, &test_path, 0, ENOTDIR, "fd pointing to file"},
+	{&bad_fd, &test_path, 0, EBADF, "invalid fd"},
+	{&file_fd, &bad_path, 0, EFAULT, "invalid address"},
+	{&file_fd, &long_path, 0, ENAMETOOLONG, "pathname too long"},
+	{&file_fd, &empty_path, 0, ENOENT, "path is empty"},
+	{&fd_atcwd, &test_path, -1, EINVAL, "invalid flag"},
+};
+
+static void verify_fchmodat(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(fchmodat(*tc->fd, *tc->filenames, 0600, tc->flag),
+		     tc->exp_errno, "fchmodat() with %s", tc->desc);
+}
+
+static void setup(void)
+{
+	file_fd = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR, 0600);
+
+	bad_path = tst_get_bad_addr(NULL);
+
+	memset(path, 'a', PATH_MAX + 2);
+}
+
+static void cleanup(void)
+{
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_fchmodat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&test_path, .str = TESTFILE},
+		{&empty_path, .str = ""},
+		{},
+	},
+	.needs_tmpdir = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
