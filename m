Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7DBC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:26:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52294610A0
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52294610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E66AB3C6AC5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 160593C67E1
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:33 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0702F100195F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337592; i=@fujitsu.com;
 bh=s68VOqgNiLn8mF0kYDsMU5FfjrgmZqvagtUBR5QiWX4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=PIqaFXEwu4Wj6n8bB+9myOGjMjfZ+VzcA6IGP0D3ZcbtvxgI7uDMKIT1fR3TiCzNy
 P1tTGmMxG85M63Fny/hCXk1kf55xAtEE5Of9+lUaTkv8rR7XStBiG+v9bk4Ke51i8B
 j4Ra57zNkazBk3obugf9u1pmMSfWUQ7xX/SgSkEqTYwowqW4FRvyl04QzYfSUa2nqj
 jgdkgrgbKMWuhrUsYCkbyqO0tu1Y9vOeJ0vaIegc7vtR7FTKGr6MfmdKlqeq+kDGZ/
 /0sXSh4kMaN5rVP0Jy9lvoGFd/ml8qcPXswtgg4F1NuX7ScdUL4B0E+F8k5Hj9JYY0
 sMQqzyGrxy5Ng==
Received: from [100.113.0.18] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-central-1.aws.symcld.net id 79/97-29929-87549716;
 Wed, 27 Oct 2021 12:26:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8ORqFvuWpl
 o8O+ElcWK7zsYHRg99v1exxrAGMWamZeUX5HAmvH04iPGgiaDiplnOtgaGA+qdzFycggJnGWU
 uP3Vv4uRC8jeySTR9Os3E0RiD6PElQUOIDabgKbEs84FzCC2iICEREfDW3YQm1lAXWL5pF9g9
 cICXhKNBy+zgtgsAqoSV/a/YQOxeQU8JKbOuAhWLyGgIDHl4XuwOZwCnhKTdi1ihdjlITHh+j
 NmiHpBiZMzn7BAzJeQOPjiBTNEr6LEpY5vjBB2hcSsWW1MELaaxNVzm5gnMArOQtI+C0n7Aka
 mVYyWSUWZ6RkluYmZObqGBga6hobGuoZA0lwvsUo3US+1VDc5Na+kKBEoq5dYXqxXXJmbnJOi
 l5dasokRGMAphYylOxinvfmgd4hRkoNJSZQ3QKcyUYgvKT+lMiOxOCO+qDQntfgQowwHh5IE7
 xlHoJxgUWp6akVaZg4wmmDSEhw8SiK8hiBp3uKCxNzizHSI1ClGRSlxXg4XoIQASCKjNA+uDR
 bBlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ89o7A03hycwrgZv+CmgxE9BiZqUKkMUliQg
 pqQYmW99OMX5dPRdn/wm/jN+xVCeeWcG9J/LSw8jq7fs/na5Q6n0Uw9qqYJeyyOdtpbl64vuJ
 T/pmB+te6tkz5+WDJWKKmipq0bx14SV/FS6dcE64c7i7sU/qzeE/GbyMDzLnvY8rXvXiq8CGT
 37a/UclloQ+e6wjZ2an+nTBKU3L9fkPHPXa4p3STwWeZDHZNWPVlmdfeua2SP5vjvCZw/B567
 cDtfFpr+0StPVSpjfPO903Z5HbK/NZ0g9mvDSIiOSfq/fvs/6raBvnDfeM3659vf663tm+qky
 2uj+7UiZtuq+25eJG5tbLazNrJlRPzbrV+aPqoMfE4s2u/t36sjPj8gUv/eKvP8+yecZDrQdP
 lViKMxINtZiLihMB3CM2FFsDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-228.messagelabs.com!1635337591!158538!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25228 invoked from network); 27 Oct 2021 12:26:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-17.tower-228.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:26:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6EDAB100248
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 62C55100236
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:26:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:26:21 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:25:58 +0800
Message-ID: <1635337569-4634-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337569-4634-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 02/13] syscalls/quotactl06: Also test with vfsv1
 format
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

Add a linux tag and fix docparse formatting.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl06.c     | 90 ++++++++++++-------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index a10d1ca07..76343adf9 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -1,41 +1,49 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
+ * Copyright (c) 2019-2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Tests basic error handling of the quotactl syscall with visible quota files
+ * (cover two formats, vfsv0 and vfsv1):
+ *
+ * - EACCES when cmd is Q_QUOTAON and addr existed but not a regular file
+ * - ENOENT when the file specified by special or addr does not exist
+ * - EBUSTY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed
+ * - EFAULT when addr or special is invalid
+ * - EINVAL when cmd or type is invalid
+ * - ENOTBLK when special is not a block device
+ * - ESRCH when no disk quota is found for the indicated user and quotas have not been
+ *   turned on for this fs
+ * - ESRCH when cmd is Q_QUOTAON, but the quota format was not found
+ * - ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or equal to id that
+ *   has an active quota
+ * - ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of the range allowed
+ *   by the quota format
+ * - EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) for the specified
+ *   operation
+ *
+ * For ERANGE error, the vfsv0 and vfsv1 format's maximum quota limit setting have been
+ * fixed since the following kernel patch:
+ *
+ *  commit 7e08da50cf706151f324349f9235ebd311226997
+ *  Author: Jan Kara <jack@suse.cz>
+ *  Date:   Wed Mar 4 14:42:02 2015 +0100
  *
- * Tests basic error handling of the quotactl syscall.
- * 1) quotactl fails with EACCES when cmd is Q_QUOTAON and addr
- * existed but not a regular file.
- * 2) quotaclt fails with ENOENT when the file specified by special
- * or addr does not exist.
- * 3) quotactl fails with EBUSTY when  cmd is Q_QUOTAON and another
- * Q_QUOTAON had already been performed.
- * 4) quotactl fails with EFAULT when addr or special is invalid.
- * 5) quotactl fails with EINVAL when cmd or type is invalid.
- * 6) quotactl fails with ENOTBLK when special is not a block device.
- * 7) quotactl fails with ESRCH when no disk quota is found for the
- * indicated user and quotas have not been turned on for this fs.
- * 8) quotactl fails with ESRCH when cmd is Q_QUOTAON, but the quota
- * format was not found.
- * 9) quotactl fails with ESRCH when cmd is Q_GETNEXTQUOTA, but there
- * is no ID greater than or equal to id that has an active quota.
- * 10) quotactl fails with ERANGE when cmd is Q_SETQUOTA, but the
- * specified limits are out of the range allowed by the quota format.
- * 11) quotactl fails with EPERM when the caller lacked the required
- * privilege (CAP_SYS_ADMIN) for the specified operation.
+ *  quota: Fix maximum quota limit settings
  */
 
 #include <errno.h>
 #include <sys/quota.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_fmt_var.h"
 #include "tst_capability.h"
 
 #define OPTION_INVALID 999
-#define QFMT_VFS_V0     2
 #define USRPATH MNTPOINT "/aquota.user"
-#define FMTID QFMT_VFS_V0
-
 #define MNTPOINT "mntpoint"
 #define TESTDIR1 MNTPOINT "/testdir1"
 #define TESTDIR2 MNTPOINT "/testdir2"
@@ -43,9 +51,9 @@
 static char usrpath[] = USRPATH;
 static char testdir1[] = TESTDIR1;
 static char testdir2[] = TESTDIR2;
-static int32_t fmt_id = FMTID;
+static int32_t fmt_id;
 static int32_t fmt_invalid = 999;
-static int test_invalid;
+static int test_invalid = 1;
 static int test_id;
 static int getnextquota_nsup;
 
@@ -105,7 +113,7 @@ static void verify_quotactl(unsigned int n)
 
 	if (tc->on_flag) {
 		TEST(quotactl(QCMD(Q_QUOTAON, USRQUOTA), tst_device->dev,
-			FMTID, usrpath));
+			fmt_id, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAON returned %ld", TST_RET);
@@ -135,7 +143,7 @@ static void verify_quotactl(unsigned int n)
 
 	if (quota_on) {
 		TEST(quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), tst_device->dev,
-			FMTID, usrpath));
+			fmt_id, usrpath));
 		if (TST_RET == -1)
 			tst_brk(TBROK,
 				"quotactl with Q_QUOTAOFF returned %ld", TST_RET);
@@ -150,19 +158,22 @@ static void verify_quotactl(unsigned int n)
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
 	unsigned int i;
+	const char *const cmd[] = {"quotacheck", "-ugF", fmt_variants[tst_variant].fmt_name, MNTPOINT, NULL};
 
+	tst_res(TINFO, "quotactl() with %s format", fmt_variants[tst_variant].fmt_name);
 	SAFE_CMD(cmd, NULL, NULL);
+	fmt_id = fmt_variants[tst_variant].fmt_id;
+	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
+	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
 
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
 
 	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
 
-	SAFE_MKDIR(TESTDIR1, 0666);
-	test_id = geteuid();
-	test_invalid = test_id + 1;
+	if (access(TESTDIR1, F_OK) == -1 && errno == ENOENT)
+		SAFE_MKDIR(TESTDIR1, 0666);
 
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *) &res_ndq));
@@ -175,8 +186,14 @@ static void setup(void)
 	}
 }
 
+static void cleanup(void)
+{
+	SAFE_UNLINK(USRPATH);
+}
+
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_QFMT_V2",
 		NULL
@@ -192,4 +209,9 @@ static struct tst_test test = {
 		NULL
 	},
 	.needs_root = 1,
+	.test_variants = QUOTACTL_FMT_VARIANTS,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "7e08da50cf70"},
+		{}
+	}
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
