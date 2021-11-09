Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B964FC433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C7461054
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43C7461054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B18443C0889
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:52:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F9143C06DC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:37 +0100 (CET)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28CF014052D5
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455155; i=@fujitsu.com;
 bh=X5FSiFYVsKpcAx6hLzL2a/Cnuhg1yecwE0sQpM6grkQ=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Capk/sayxSJKHpVNL5tEBGTFJQpEGZLidwqUd2SiUEIIo6B/htmLkcuIP4mHwI6WJ
 lQtfhsWxU2PnDQvfxb26ITPxx3ahe8AbyAuqvOEH8zM4WDMtrkbYbBQ/qdwmB13ZF4
 wWtJh1NL/bZZ/63Xurqil+jhnIdpne0NRSkA0BdGhB2HiDHFb74gxna9OiAJyM8itY
 9RCTmJ4lJCi81qmOWKSreL88FRAAVLN/Z7t4Crd0cr7sZmU2QOKF6KZD1yPmfAc+Tj
 mdqJa1tgPTW6Z6N+T1ZQcMv3WV/BbNuewYfC0gV+5sOnDNTi2q97HxN9LZsmXi0UkV
 twkT7ahtmZFXA==
Received: from [100.112.193.107] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 1E/FC-19641-3F25A816;
 Tue, 09 Nov 2021 10:52:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsViZ8MRovspqCv
 RYMdpHYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWN341zGggMGFV2/jzE2MH5V72Lk4hASaGSS
 eDX9HEsXIyeQs5tRYv0xCRCbTUBT4lnnAmYQW0RAQqKj4S07iM0soC6xfNIvJhBbWMBLYu3Dy
 2A1LAIqEm+nLWUEsXkFPCSm7DnLCmJLCChITHn4HqiGg4NTwFPi70dXiFUeEjuef4YqF5Q4Of
 MJC8R4CYmDL14wQ7QqSlzq+MYIYVdIzJrVxjSBkX8WkpZZSFoWMDKtYjRPKspMzyjJTczM0TU
 0MNA1NDTSNbQ01TUx00us0k3USy3VLU8tLtE11EssL9YrrsxNzknRy0st2cQIDMWUgsN6Oxgn
 vPmgd4hRkoNJSZT3slhXohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3gR/oJxgUWp6akVaZg4wL
 mDSEhw8SiK8ej5Aad7igsTc4sx0iNQpRkUpcd7GQKCEAEgiozQPrg0Wi5cYZaWEeRkZGBiEeA
 pSi3IzS1DlXzGKczAqCfNWgkzhycwrgZv+CmgxE9Dig1/aQRaXJCKkpBqYimuEDjGH7tgvtNd
 izoVbJupdzHX6Sff4Tx2z1UsoYGF5ruaQFjwt44HBAfNEuSzdSy9dyrN4q1/lR/rUW9//HMz6
 K1+Oy+p4tr36FP79kudLBN2yZ3yJ/Ht+mt7GkO9PLe9Mcet2bxU4UeH3Y79jxR+94ij9p1Gpd
 VETsra6FTXvD4qNCf38N7M1uvznbp6C9PM/03+12ar8VP+lePDFpNiAUDnNMC0Rz6Mz4svEPd
 3/sj/U5s/fv+rKdcELt87J1H45c/mbtTT7g2VFts92M7k7/Lh+1L4+8MCazK7MhKlBj6+kK0Y
 +qlBvVzU3XnFrboDv46bl+QH/M3UNbjRcKPnzOPq+X9TsUovJ1UosxRmJhlrMRcWJAEfIag1A
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-265.messagelabs.com!1636455154!76699!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28410 invoked from network); 9 Nov 2021 10:52:34 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-5.tower-265.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:52:34 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1A9AqQne028555
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 9 Nov 2021 10:52:34 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:52:31 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:52:37 +0800
Message-ID: <1636455161-8278-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 02/12] syscalls/quotactl06: Also test with vfsv1
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

Also remove useless geteuid.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl06.c     | 89 ++++++++++++-------
 1 file changed, 56 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index a10d1ca07..21a86ad1e 100644
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
@@ -150,10 +158,15 @@ static void verify_quotactl(unsigned int n)
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-uF", "vfsv0", MNTPOINT, NULL};
 	unsigned int i;
+	const struct quotactl_fmt_variant *var = &fmt_variants[tst_variant];
+	const char *const cmd[] = {"quotacheck", "-ugF", var->fmt_name, MNTPOINT, NULL};
 
+	tst_res(TINFO, "quotactl() with %s format", var->fmt_name);
 	SAFE_CMD(cmd, NULL, NULL);
+	fmt_id = var->fmt_id;
+	/* vfsv0 block limit 2^42, vfsv1 block limit 2^63 - 1 */
+	set_dqmax.dqb_bsoftlimit = tst_variant ? 0x20000000000000 : 0x100000000;
 
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
@@ -161,8 +174,6 @@ static void setup(void)
 	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
 
 	SAFE_MKDIR(TESTDIR1, 0666);
-	test_id = geteuid();
-	test_invalid = test_id + 1;
 
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *) &res_ndq));
@@ -175,8 +186,15 @@ static void setup(void)
 	}
 }
 
+static void cleanup(void)
+{
+	SAFE_UNLINK(USRPATH);
+	SAFE_RMDIR(TESTDIR1);
+}
+
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_QFMT_V2",
 		NULL
@@ -192,4 +210,9 @@ static struct tst_test test = {
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
