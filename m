Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E09CD128A
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712816670; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ldyEpOoMM3vcN73CLIWvbs6Kn5ZkonuJxYCjf1BrLNI=;
 b=hGhDQIy0fH4JXdQvzsiRV6roBjVBrSwahFy7dpCiXQz69t7wX1kR1w50qB3M4/bA8sWR4
 25FqqdoPOSnOIkfUmtu2vDPPLJzaQaxE0LDvDesTVic10h2g2s0qcSE3Gi+Bek22b5bow7c
 EbYUngKzzLa6IN9dATxIc9OfkORomZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E8D93CF7CD
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 08:24:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 601D53C0640
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 08:24:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC30660565F
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 08:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1712816647; x=1744352647;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c+gIq1svx51PgYTW6LSHamJEH2EXrfnSEhCiLYCIt+Y=;
 b=jnL2UGaLLX292kbx7tVJCBmelXm1KQen0YOaM7DyFDIeh5dGdD/jWZyB
 i1lsSzc68IEBEfj0LjXmxJzf4pCzd3ViSGq/h31tq9ZPuRht3hov9I3fj
 /YMzAniNu/42/OvCUQpEc7YULMKxG2+5dsmA3evk06rMSq1aL/HmR9rXl
 wV5xzcsgdV539B7EyZWlVB6eApBRwrukzJKWUESyjqR2At6jqW4ye50s0
 ZsoEFlDuZ9ywmts2znzlS+vqatTHPVls/4kvC/DHkFeYuO4RhNyOl36TA
 Ukco/xMJm09McW7OGXXQcDbxuUqj09GBC1/bJgnLd8kZ5ezE7DUGR7suI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="142867695"
X-IronPort-AV: E=Sophos;i="6.07,192,1708354800"; d="scan'208";a="142867695"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 15:24:03 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B88DF127CCF
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 15:24:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 062B5D3F39
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 15:24:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D8596B5F4
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 15:24:00 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 394CD1A000B;
 Thu, 11 Apr 2024 14:24:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 01:49:40 -0400
Message-Id: <20240411054940.17859-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28312.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28312.003
X-TMASE-Result: 10--18.097400-10.000000
X-TMASE-MatchedRID: GQw6Xh/XS6VSuJfEWZSQfB1kSRHxj+Z59LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatS01VXlcjcCUCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDkeDPyqIAshAuo7vrkTNm7UF7cpFXK76TRdoyFlJ5UUMcfnL37UR/joYnR
 Q/QDMQFaVhoFhOJKHxS8AxUE03d7D9u77cJ0N/QJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyOk/y
 0w7JiZo
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] unlink: Add error tests for EPERM and EROFS
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for unlink(), when errno is EPERM or EROFS.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/unlink/.gitignore |   1 +
 testcases/kernel/syscalls/unlink/unlink09.c | 102 ++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unlink/unlink09.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4ed2b5602..b99ce7170 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1651,6 +1651,7 @@ unlink01 symlink01 -T unlink01
 unlink05 unlink05
 unlink07 unlink07
 unlink08 unlink08
+unlink09 unlink09
 
 #unlinkat test cases
 unlinkat01 unlinkat01
diff --git a/testcases/kernel/syscalls/unlink/.gitignore b/testcases/kernel/syscalls/unlink/.gitignore
index 2e783580d..6038cc29d 100644
--- a/testcases/kernel/syscalls/unlink/.gitignore
+++ b/testcases/kernel/syscalls/unlink/.gitignore
@@ -1,3 +1,4 @@
 /unlink05
 /unlink07
 /unlink08
+/unlink09
diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
new file mode 100644
index 000000000..3ab478e50
--- /dev/null
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that unlink(2) fails with
+ *
+ * - EPERM when target file is marked as immutable or append-only
+ * - EROFS when target file is on a read-only filesystem.
+ */
+
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define TEST_EPERM_IMMUTABLE "test_eperm_immutable"
+#define TEST_EPERM_APPEND_ONLY "test_eperm_append_only"
+#define DIR_EROFS "erofs"
+#define TEST_EROFS "erofs/test_erofs"
+
+static int fd_immutable;
+static int fd_append_only;
+
+static struct test_case_t {
+	char *filename;
+	int *fd;
+	int flag;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{TEST_EPERM_IMMUTABLE, &fd_immutable, FS_IMMUTABLE_FL, EPERM,
+		"target file is immutable"},
+	{TEST_EPERM_APPEND_ONLY, &fd_append_only, FS_APPEND_FL, EPERM,
+		"target file is append-only"},
+	{TEST_EROFS, NULL, 0, EROFS, "target file in read-only filesystem"},
+};
+
+static void setup(void)
+{
+	int attr;
+
+	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
+	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_IMMUTABLE_FL;
+	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
+
+	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
+	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_APPEND_FL;
+	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_immutable);
+
+	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_APPEND_FL;
+	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_append_only);
+}
+
+static void verify_unlink(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	int attr;
+
+	TST_EXP_FAIL(unlink(tc->filename), tc->expected_errno, "%s", tc->desc);
+
+	/* If unlink() suceeded unexpectedly, test file should be retored. */
+	if (!TST_RET) {
+		if (tc->fd) {
+			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
+			if (tc->flag) {
+				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
+				attr |= tc->flag;
+				SAFE_IOCTL(*(tc->fd), FS_IOC_SETFLAGS, &attr);
+			}
+		} else {
+			SAFE_TOUCH(tc->filename, 0600, 0);
+		}
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+	.test = verify_unlink,
+	.needs_rofs = 1,
+	.mntpoint = DIR_EROFS,
+	.needs_root = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
