Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63ACC77B73
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 09:45:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 910D03CD38D
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 11:45:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 080B33CB0E7
 for <ltp@lists.linux.it>; Mon, 22 May 2023 11:45:08 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 037041400967
 for <ltp@lists.linux.it>; Mon, 22 May 2023 11:45:07 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="105202912"
X-IronPort-AV: E=Sophos;i="6.00,184,1681138800"; d="scan'208";a="105202912"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 18:45:05 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 614A1DB390
 for <ltp@lists.linux.it>; Mon, 22 May 2023 18:45:03 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com
 [192.51.206.12])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 967C8CFBC2
 for <ltp@lists.linux.it>; Mon, 22 May 2023 18:45:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id CC6B5234011D;
 Mon, 22 May 2023 18:45:01 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 22 May 2023 17:44:02 +0800
Message-Id: <1684748642-6373-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27642.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27642.006
X-TMASE-Result: 10--17.403400-10.000000
X-TMASE-MatchedRID: GQw6Xh/XS6XdsvR3yreVDazGfgakLdjaSuH+GfgmQGc6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatUMs9ucSNhdqCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDpu91RWVjlmQxBNI9kTkfyBZNYSHk3Zr0Ui8rgutezVpRjFo+SLq2Gq/jz
 9RTmfNFGlLidO65FEMcVGXNGTKHf7QVDF+NEc7OJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyOk/y
 0w7JiZo
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx12: Add basic test for
 STATX_ATTR_MOUNT_ROOT flag
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

This flag was introduced since kernel 5.10 and was used to indicates
whether the path or fd refers to the root of a mount or not.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/stat.h                        |   4 +
 runtest/syscalls                           |   1 +
 testcases/kernel/syscalls/statx/.gitignore |   1 +
 testcases/kernel/syscalls/statx/statx12.c  | 101 +++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statx/statx12.c

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index c7e6fdac0..3606c9eb0 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -221,6 +221,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_AUTOMOUNT	0x00001000
 #endif
 
+#ifndef STATX_ATTR_MOUNT_ROOT
+# define STATX_ATTR_MOUNT_ROOT	0x00002000
+#endif
+
 #ifndef STATX_ATTR_VERITY
 # define STATX_ATTR_VERITY	0x00100000
 #endif
diff --git a/runtest/syscalls b/runtest/syscalls
index e5ad2c2f9..0c1993421 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1767,6 +1767,7 @@ statx08 statx08
 statx09 statx09
 statx10 statx10
 statx11 statx11
+statx12 statx12
 
 membarrier01 membarrier01
 
diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
index 48ac4078b..f6a423eed 100644
--- a/testcases/kernel/syscalls/statx/.gitignore
+++ b/testcases/kernel/syscalls/statx/.gitignore
@@ -9,3 +9,4 @@
 /statx09
 /statx10
 /statx11
+/statx12
diff --git a/testcases/kernel/syscalls/statx/statx12.c b/testcases/kernel/syscalls/statx/statx12.c
new file mode 100644
index 000000000..ae6bbb1e2
--- /dev/null
+++ b/testcases/kernel/syscalls/statx/statx12.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * It is a basic test for STATX_ATTR_MOUNT_ROOT flag.
+ *
+ * This flag indicates whether the path or fd refers to the root of a mount
+ * or not.
+ *
+ * Minimum Linux version required is v5.10.
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include "tst_test.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mntpoint"
+#define TESTFILE MNTPOINT"/testfile"
+
+static int dir_fd = -1, file_fd = -1;
+
+static struct tcase {
+	const char *path;
+	int mnt_root;
+	int flag;
+	int *fd;
+} tcases[] = {
+	{MNTPOINT, 1, 1, &dir_fd},
+	{MNTPOINT, 1, 0, &dir_fd},
+	{TESTFILE, 0, 1, &file_fd},
+	{TESTFILE, 0, 0, &file_fd}
+};
+
+static void verify_statx(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct statx buf;
+
+	if (tc->flag) {
+		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by path",
+				tc->path);
+
+		TST_EXP_PASS_SILENT(statx(AT_FDCWD, tc->path, 0, 0, &buf),
+			"statx(AT_FDCWD, %s, 0, 0, &buf)", tc->path);
+	} else {
+		tst_res(TINFO, "Testing %s with STATX_ATTR_MOUNT_ROOT by fd",
+				tc->path);
+		TST_EXP_PASS_SILENT(statx(*tc->fd, "", AT_EMPTY_PATH, 0, &buf),
+			"statx(%d, "", 0, 0, &buf)", *tc->fd);
+	}
+
+	if (!(buf.stx_attributes_mask & STATX_ATTR_MOUNT_ROOT)) {
+		tst_res(TCONF, "Filesystem does not support STATX_ATTR_MOUNT_ROOT");
+		return;
+	}
+
+	if (buf.stx_attributes & STATX_ATTR_MOUNT_ROOT) {
+		tst_res(tc->mnt_root ? TPASS : TFAIL,
+			"STATX_ATTR_MOUNT_ROOT flag is set");
+	} else {
+		tst_res(tc->mnt_root ? TFAIL : TPASS,
+			"STATX_ATTR_MOUNT_ROOT flag is not set");
+	}
+}
+
+static void setup(void)
+{
+	SAFE_CREAT(TESTFILE, 0755);
+	dir_fd = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
+	file_fd = SAFE_OPEN(TESTFILE, O_RDWR);
+}
+
+static void cleanup(void)
+{
+	if (dir_fd > -1)
+		SAFE_CLOSE(dir_fd);
+	if (file_fd > -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.test = verify_statx,
+	.setup = setup,
+	.cleanup = cleanup,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.tcnt = ARRAY_SIZE(tcases)
+};
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
