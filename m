Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CA8EE49A3
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 05:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E08713CC66C
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 07:24:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0323C9947
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 07:24:16 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA18B6000BF
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 07:24:14 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="116873077"
X-IronPort-AV: E=Sophos;i="6.01,194,1684767600"; d="scan'208";a="116873077"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2023 14:24:10 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F1110DE628
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 14:24:08 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DA079D4BC4
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 14:24:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DFEE920076868;
 Wed, 23 Aug 2023 14:24:06 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 23 Aug 2023 13:24:02 +0800
Message-Id: <1692768242-5649-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27830.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27830.004
X-TMASE-Result: 10--16.734900-10.000000
X-TMASE-MatchedRID: HRm6PbbemxfIY6JevWs4vgPZZctd3P4B9LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmJ8eC2pVr1wb6/Elphzpf1LGYJhRh6ssesfimmlcABuNyfJTn+dmnFQszW
 bbhESzfd+CxzcGwLNWAGDTGLhNrAfxzpH9vijA/wqIkSpQVZGCF/d6ediod7Y+32SXw3QiFwOvq
 z8x19fG2qJ0+VpCAVgyYyeAPTbBZYXHLPN9+q8ed9JA2lmQRNUHhysWPN3OzibKItl61J/yfJvo
 cwUrWp7ijciq9xw8kW8QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/faccessat202: Add new testcase
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
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/faccessat2/.gitignore     |   1 +
 .../kernel/syscalls/faccessat2/faccessat202.c | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 testcases/kernel/syscalls/faccessat2/faccessat202.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 02768c236..7af2842f3 100644
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
index 000000000..e6cd1ec5e
--- /dev/null
+++ b/testcases/kernel/syscalls/faccessat2/faccessat202.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Copyright (c) Linux Test Project, 2003-2023
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
+ * - faccessat2() fails with ENOTDIR if pathname is relative path to a
+ *   file and dir_fd is file descriptor for this file.
+ * - faccessat2() fails with EACCES if flags is AT_EACCESS and not using
+ *   the effective user and group IDs.
+ *
+ * Minimum Linux version required is v5.8.
+ */
+
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/faccessat.h"
+
+#define TESTUSER        "nobody"
+#define TESTDIR         "faccessat2dir"
+#define RELPATH         "faccessat2dir/faccessat2file"
+
+static int fd;
+static int bad_fd = -1;
+static int atcwd_fd = AT_FDCWD;
+static char *bad_path;
+static char *rel_path;
+
+static struct passwd *ltpuser;
+
+static struct tcase {
+	int *fd;
+	char **filename;
+	int mode;
+	int flags;
+	int exp_errno;
+} tcases[] = {
+	{&atcwd_fd, &bad_path, R_OK, 0, EFAULT},
+	{&atcwd_fd, &rel_path, R_OK, -1, EINVAL},
+	{&atcwd_fd, &rel_path, -1, 0, EINVAL},
+	{&bad_fd, &rel_path, R_OK, 0, EBADF},
+	{&fd, &rel_path, R_OK, 0, ENOTDIR},
+	{&atcwd_fd, &rel_path, R_OK, AT_EACCESS, EACCES},
+};
+
+static void verify_faccessat2(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (tc->exp_errno == EACCES)
+		SAFE_SETEUID(ltpuser->pw_uid);
+
+	TST_EXP_FAIL(faccessat2(*tc->fd, *tc->filename, tc->mode, tc->flags),
+		     tc->exp_errno, "faccessat2()");
+
+	if (tc->exp_errno == EACCES)
+		SAFE_SETEUID(0);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(TESTDIR, 0666);
+	SAFE_TOUCH(RELPATH, 0444, NULL);
+
+	fd = SAFE_OPEN(RELPATH, O_RDONLY);
+	bad_path = tst_get_bad_addr(NULL);
+
+	ltpuser = SAFE_GETPWNAM(TESTUSER);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test = verify_faccessat2,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&rel_path, .str = RELPATH},
+		{},
+	},
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
