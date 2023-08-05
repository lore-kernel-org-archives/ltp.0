Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FE0EB64DD
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:09:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE13F3CE37F
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 06:09:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 919333CE373
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:28 +0200 (CEST)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B5A51400257
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 06:08:26 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="127160452"
X-IronPort-AV: E=Sophos;i="6.01,256,1684767600"; d="scan'208";a="127160452"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2023 13:08:26 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 32C8ADDC64
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:23 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 41D1BD88D3
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 13:08:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 618B8878F1;
 Sat,  5 Aug 2023 13:08:21 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Sat,  5 Aug 2023 12:08:00 +0800
Message-Id: <1691208482-5464-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27794.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27794.003
X-TMASE-Result: 10--16.735700-10.000000
X-TMASE-MatchedRID: 2wfub8HDRfPIY6JevWs4vgPZZctd3P4B9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmJ8eC2pVr1wb6/Elphzpf1LGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoSZv3k6Qk0BbPOERzC3KcqXlPpop9nq2f1ZNYSHk3Zr0aTYf9v9flol3m7FRTxl32QWWg
 76IlE/zJoi4Fk1Ww9PgDLqnrRlXrZ8nn9tnqel2JBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/faccessat202: Add new testcase
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

Check various errnos for faccessat2().

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/faccessat2/.gitignore     |  1 +
 .../kernel/syscalls/faccessat2/faccessat202.c | 90 +++++++++++++++++++
 3 files changed, 92 insertions(+)
 create mode 100644 testcases/kernel/syscalls/faccessat2/faccessat202.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 948c39030..9ccc1c7b6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -218,6 +218,7 @@ faccessat01 faccessat01
 
 #faccessat2 test cases
 faccessat201 faccessat201
+faccessat202 faccessat202
 
 #fallocate test cases
 fallocate01 fallocate01
diff --git a/testcases/kernel/syscalls/faccessat2/.gitignore b/testcases/kernel/syscalls/faccessat2/.gitignore
index 53f700bac..f58f045f4 100644
--- a/testcases/kernel/syscalls/faccessat2/.gitignore
+++ b/testcases/kernel/syscalls/faccessat2/.gitignore
@@ -1 +1,2 @@
 /faccessat201
+/faccessat202
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat202.c b/testcases/kernel/syscalls/faccessat2/faccessat202.c
new file mode 100644
index 000000000..061dcf8ce
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/faccessat202.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test basic error handling of faccessat2 syscall:
+ *
+ * - faccessat2() fails with EFAULT if pathname is a bad pathname point.
+ * - faccessat2() fails with EINVAL if flags is -1.
+ * - faccessat2() fails with EINVAL if mode is -1.
+ * - faccessat2() fails with EBADF if dirfd is -1.
+ * - faccessat2() fails with ENOTDIR if pathname is relative path to the
+ *   file and dir_fd is file descriptor for this file.
+ *
+ * Minimum Linux version required is v5.8.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/faccessat2.h"
+
+#define TESTDIR		"faccessat2dir"
+#define TESTFILE	"faccessat2dir/faccessat2file"
+
+static int fd = -1, bad_fd = -1;
+static int atcwd_fd = AT_FDCWD;
+static char *bad_path, *file_path;
+static struct passwd *ltpuser;
+
+static struct tcase {
+	int *fd;
+	char **filepath;
+	int mode;
+	int flags;
+	int exp_errno;
+} tcases[] = {
+	{&atcwd_fd, &bad_path, R_OK, 0, EFAULT},
+	{&atcwd_fd, &file_path, R_OK, -1, EINVAL},
+	{&atcwd_fd, &file_path, -1, 0, EINVAL},
+	{&bad_fd, &file_path, R_OK, 0, EBADF},
+	{&fd, &file_path, R_OK, 0, ENOTDIR},
+};
+
+static void verify_faccessat2(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filepath, tc->mode, tc->flags),
+		     tc->exp_errno);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR, 0666);
+	SAFE_TOUCH(TESTFILE, 0444, NULL);
+
+	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
+
+	bad_path = tst_get_bad_addr(NULL);
+	file_path = TESTFILE;
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = verify_faccessat2,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&bad_path, .size = sizeof(*bad_path)},
+		{&file_path, .size = sizeof(*file_path)},
+		{&ltpuser, .size = sizeof(ltpuser)},
+		{},
+	},
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
