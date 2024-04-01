Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4838CD1284
	for <ltp@archiver.kernel.org>; Mon,  1 Apr 2024 03:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711941869; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=RRPyWtR1/Z5KjnhNgpEnPPz4k0C80fF2gwocNgZRJGM=;
 b=NfI0CTnSrO+KOhRCjI6uxIMZE8BODDTVqJyNM03+cm2rXR6dh3x9v1ml0Z3r03M6Zazm5
 B/iZuFTtDWJf7d8wTbc/3CcJ8Uh/2uh4Oy1K5y7cDADACzFqC8vFG5qcFaQ79JpChgB7YVG
 xUnFKD1/5n7JOKVVdQokBQj8QwoXt9c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384F13CB93A
	for <ltp@archiver.kernel.org>; Mon,  1 Apr 2024 05:24:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA8D63CB08E
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 05:24:07 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.139;
 helo=esa6.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEEF620004E
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 05:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711941847; x=1743477847;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KQ1QCXgJCpgIaQdtt0SGJfLi9qEXqEhGFOU916I5kxw=;
 b=Vq/5JPejw3QqArt4NtEbvYP3WGk/oEeMzmNCVivApK+YokMUaIZ2P5vw
 5MSawC9zBHvhnJ9WcQMbkfOMZTGgkjc9YRSQcMgRXdBvmfSshcvQK9LRe
 HvUhmN3zfp5EankwvzrP1MFiDCXy8W0G/hZNanZ4at1otxVHGQghLtubi
 cHwhG74OTAgTnpDthOShIdgh7m3Bk14qzzkgQK3dCVOK12h/h+6Yg4Z8s
 a1EqIMaDDMk9PPrUlwjVK3+DTH/ISwrmvOxiQlzvte5QwJQRuCeSMAi9n
 o9KrvIagx37h0Z0iBD5cmWkMXZdTFtyGNvRXjGOSt10hmRPantQRmYq+8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="156081773"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; d="scan'208";a="156081773"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 12:24:03 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B997105A1
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:24:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6946DC520A
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:23:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 026ED20074736
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:23:59 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9DA721A0002;
 Mon,  1 Apr 2024 11:23:58 +0800 (CST)
To: ltp@lists.linux.it
Date: Sun, 31 Mar 2024 22:49:48 -0400
Message-Id: <20240401024948.8703-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.004
X-TMASE-Result: 10--17.193400-10.000000
X-TMASE-MatchedRID: a3KJLn6RIiJSuJfEWZSQfB1kSRHxj+Z59LMB0hXFSeg6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatS01VXlcjcCUCtzGvPCy/m5SuvtBzlaEqFH3rkvzbWPM4Ib
 z3CH3vCeIuA1iha0SDkeDPyqIAshAuo7vrkTNm7UF7cpFXK76TRdoyFlJ5UUMWSYg69K24my/jz
 9RTmfNFGWdS71W+uwVMBbXb6klnc03KXWd30Ii3RRFJJyf5BJe3QfwsVk0UbslCGssfkpInQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlink: Add error tests for EPERM and EROFS
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
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/unlink/.gitignore |  1 +
 testcases/kernel/syscalls/unlink/unlink09.c | 86 +++++++++++++++++++++
 3 files changed, 88 insertions(+)
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
index 000000000..b7ff94ee6
--- /dev/null
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -0,0 +1,86 @@
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
+#include <errno.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
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
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{TEST_EPERM_IMMUTABLE, EPERM, "target file is immutable"},
+	{TEST_EPERM_APPEND_ONLY, EPERM, "target file is append-only"},
+	{TEST_EROFS, EROFS, "target file in read-only filesystem"},
+};
+
+static void setup(void)
+{
+	int attr;
+
+	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
+	ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_IMMUTABLE_FL;
+	ioctl(fd_immutable, FS_IOC_SETFLAGS, &attr);
+
+	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
+	ioctl(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_APPEND_FL;
+	ioctl(fd_append_only, FS_IOC_SETFLAGS, &attr);
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	ioctl(fd_immutable, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_immutable);
+
+	ioctl(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_APPEND_FL;
+	ioctl(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_append_only);
+}
+
+static void verify_unlink(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+
+	TST_EXP_FAIL(unlink(tc->filename), tc->expected_errno, "%s", tc->desc);
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
