Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE72C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 07:03:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DD403C94D1
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 09:03:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CF0B3C0E6F
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 09:03:02 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B2451A00E0D
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 09:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1658732579; i=@fujitsu.com;
 bh=rS/iyaQgeznMkx2OapYfTZEDyps8j/MHxdkkPLuYZ1c=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=kQ7GgeMo6oz1hbIa2L4Xd5GgxcLID4uV1x//Dr9+srTP7heg2h2ZqlibpBXT6OAQC
 VySqDoyzkXjPcM3FC8lYa5ZcPSSgJXM0VNryLt302U9qNf9KwAO4cqCX3gQKELsRFR
 DT10+jFo5RkQ0JnGhtN7V7df0YlZI75porRQl0CxltUzCzJucweg9Z62HicPJb/BnS
 Vn7P4CaKV/wJktbLxgTXfWx8n6G94BXeSiZdnQIzas0CvNWSvyNwdfwFFeFQzaktr8
 5iELJiu1u7ba+isINqAoCZXIgi94z34ITr+QHw8mi+tFB8NCL4fJUkZ2cVkA8TvjHp
 NCYiJXPXX+9fA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRWlGSWpSXmKPExsViZ8OxWVfZ4V6
 SweIlUhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aEZVsZCxbxV2xu/MTSwNjB28XIxSEkcIpR
 Ysu8l0wQzl4miQczzrN0MXICOdsZJU5O1ASx2QS0Je70zGAEsUUEJCQ6Gt6yg9jMApoS964cB
 osLC1hLnLraBRZnEVCVePZgFRuIzSvgKvFrzhxWEFtCQEFiysP3zBBxQYmTM5+wQMyRkDj44g
 UzRI2ixNXTe6HqKyReH74EFVeTuHpuE/MERv5ZSNpnIWlfwMi0itEmqSgzPaMkNzEzR9fQwED
 X0NBU19JM19DYUC+xSjdRL7VUNy+/qCRDF8gvL9ZLLS7WK67MTc5J0ctLLdnECAzMlOKE5h2M
 9/b90jvEKMnBpCTKy6VzL0mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBK+OPVBOsCg1PbUiLTMHG
 CUwaQkOHiURXmmQNG9xQWJucWY6ROoUo6KUOK+BKVBCACSRUZoH1waLzEuMslLCvIwMDAxCPA
 WpRbmZJajyrxjFORiVhHljbIGm8GTmlcBNfwW0mAlo8SftOyCLSxIRUlINTFMuv88LcioTWV9
 9f7XrpgPyd38aTn0W9U99S0NH872mc0KPi5tyAs/ccxFdyKK6dFfHoW2JWd8X/zZQfTvxwNE/
 By/G3V5bd/rtCzNmwyNmneZG+yYeWPDswb4kfT9b98Df6d9fP32w97r653t+Xoy3LsX9EL0X4
 rpFtnrx1PuxEW4KNfGbTrxdcaum/FxWe+fl6Nf5Z66zb7nH9cAlPf7A8ZSo+6K/90QvbhGqnj
 QnorzFJEpvU6VwmlbAzqbklf8Clzfb5D+sqL+sH7x+lUXFgnCzPMFI8dKSJ+f6a36nq9/s+9F
 8cfWXjHJNqR2spTav1FrPrja6ypaabL/nakD9p3ciX56k3Es2Ezv3bqMSS3FGoqEWc1FxIgDQ
 RtZ3RwMAAA==
X-Env-Sender: liaohj.jy@fujitsu.com
X-Msg-Ref: server-12.tower-728.messagelabs.com!1658732579!31181!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5685 invoked from network); 25 Jul 2022 07:02:59 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-12.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Jul 2022 07:02:59 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id CAF98155
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:02:58 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id BDC41152
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 08:02:58 +0100 (BST)
Received: from rhel-server--7.5 (10.167.215.42) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 25 Jul 2022 08:02:56 +0100
From: Liao Huangjie <liaohj.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 25 Jul 2022 15:02:44 +0800
Message-ID: <1658732564-31728-1-git-send-email-liaohj.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.42]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/read05: Test read with zero count
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Huangjie Liao <liaohj.jy@fujitsu.com>

Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/read/.gitignore |  1 +
 testcases/kernel/syscalls/read/read05.c   | 44 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 testcases/kernel/syscalls/read/read05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 3847e8a..0bd47fc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1094,6 +1094,7 @@ read01 read01
 read02 read02
 read03 read03
 read04 read04
+read05 read05
 
 readahead01 readahead01
 readahead02 readahead02
diff --git a/testcases/kernel/syscalls/read/.gitignore b/testcases/kernel/syscalls/read/.gitignore
index e89c008..69d97b3 100644
--- a/testcases/kernel/syscalls/read/.gitignore
+++ b/testcases/kernel/syscalls/read/.gitignore
@@ -2,3 +2,4 @@
 /read02
 /read03
 /read04
+/read05
diff --git a/testcases/kernel/syscalls/read/read05.c b/testcases/kernel/syscalls/read/read05.c
new file mode 100644
index 0000000..83ac763
--- /dev/null
+++ b/testcases/kernel/syscalls/read/read05.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Huangjie Liao <liaohj.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * In the absence of any errors, a read() with a count of 0 returns zero.
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+
+#define SIZE 512
+
+static int fd;
+static char buf[SIZE];
+
+static void verify_read(void)
+{
+	TST_EXP_VAL(read(fd, buf, 0), 0);
+}
+
+static void setup(void)
+{
+	memset(buf, '*', SIZE);
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0700);
+	SAFE_WRITE(1, fd, buf, SIZE);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = verify_read,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
