Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B7C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:52:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2064561178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2064561178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048B13C08B2
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:52:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00B4D3C06DC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:37 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 13D2F14044CF
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455155; i=@fujitsu.com;
 bh=HH7s/4rcQx7vJOrLrHsXyWp+Rv5DX2ULdyeYE8R/w4s=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=PtNZFFVuRftoYcarg/cwikx0q9sCTdVTRI5YoETgFHTexY8DaxCaCO7qc1JHLR6Va
 YjLzgyJZBAQtznOEkiYEdnwOQsQwr53cbXQ5fWSxtozkvh8N92KUNpGK71fREDoGnG
 YmwsnDDURskHWGT39fc/bQTSN19jmFCBCrlmUiWuTDaZXqIJ5KECyme4DyAxbqxOul
 PqsSRDsD0EpvknYg1dmQ+UzNReAGBNMqYCf9KgjVP7J+hYERa98jKNWsVecJKPdRO7
 DgEbO22bYrbG93ggbb8AYxyGVXhHF6ypIe2XbY0JlIq6wSe+pX5uhyg1slsb3R/kfL
 /kIqIVNVe0b2A==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id C6/CA-30139-3F25A816;
 Tue, 09 Nov 2021 10:52:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRWlGSWpSXmKPExsViZ8MRovspqCv
 RoKlTx2LF9x2MDowe+36vYw1gjGLNzEvKr0hgzVjQI1/QZl6xo+c9SwPjF90uRk4OIYFGJonN
 S3K7GLmA7N2MEuveHmMCSbAJaEo861zADGKLCEhIdDS8ZQexmQXUJZZP+gVWIyzgJXF0aR9Yn
 EVAReJKw2JWEJtXwEPiyptbYLaEgILElIfvmSHighInZz5hgZgjIXHwxQtmiBpFiUsd3xgh7A
 qJWbPamCYw8s5C0jILScsCRqZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6ZrqGFmZ6iVW6SXqppbr
 JqXklRYlAWb3E8mK94src5JwUvbzUkk2MwPBKKWTbtYPx8+sPeocYJTmYlER5L4t1JQrxJeWn
 VGYkFmfEF5XmpBYfYpTh4FCS4E3wB8oJFqWmp1akZeYAQx0mLcHBoyTCq+cDlOYtLkjMLc5Mh
 0idYlSUEudtDARKCIAkMkrz4Npg8XWJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvJcgUns
 y8Erjpr4AWMwEtPvilHWRxSSJCSqqBiU1NZvocgWMvrnHETzrx4tyOKafm/0654sTtUMYf2J+
 dcGetj8qM2R9u616aOEPtcdFJD+mXfi85m1RmvUpqeXlvqsn3GfM41zbP7jtwxuUNu4Rz4SUn
 l78eNzgSluz/+KxOP1ByuvGFa4pTHq7fuuBR39Xu+iuzI12dmNdWh1ju7tY+I909S/rJErns3
 atlLfd8bVALrX860T9rbcg99VUm/oI/ptyPbPAyDFQ9d+Hq6e2W3zVnOER/KEs4vPMal8oxh0
 t798fwzNfw+xi7aPvieiPOV8wp4leDI7Lu3v5WmfJHyvnh+qgqdeWuaUc9tp5/zD/rcOWuq9d
 OXfAyPv819bBLTpSSp9tVY6GWzA9KLMUZiYZazEXFiQAhdXAOKgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-248.messagelabs.com!1636455154!449538!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12457 invoked from network); 9 Nov 2021 10:52:34 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-15.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:52:34 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1A9AqQnb028555
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Tue, 9 Nov 2021 10:52:34 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:52:24 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:52:36 +0800
Message-ID: <1636455161-8278-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/12] syscalls/quotactl01: Also test with vfsv1
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

Since usrquota and groupquota supports visible quota files
with two formats(vfsv0 and vfsv1) on ext4, so add a test variants to
test it.

Also fix docparse formatting and move some code to lapi/quotactl.h or
quotactl_var.h for reuse.

Remove useless geteuid.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/quotactl.h                       |  9 +++
 .../kernel/syscalls/quotactl/quotactl01.c     | 78 +++++++++----------
 .../syscalls/quotactl/quotactl_fmt_var.h      | 22 ++++++
 3 files changed, 70 insertions(+), 39 deletions(-)
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h

diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
index c1ec9d6e1..8e0315d03 100644
--- a/include/lapi/quotactl.h
+++ b/include/lapi/quotactl.h
@@ -8,6 +8,7 @@
 #ifndef LAPI_QUOTACTL_H__
 #define LAPI_QUOTACTL_H__
 
+#include "config.h"
 #include <sys/quota.h>
 
 #ifdef HAVE_STRUCT_IF_NEXTDQBLK
@@ -75,4 +76,12 @@ struct fs_quota_statv {
 # define Q_GETNEXTQUOTA 0x800009 /* get disk limits and usage >= ID */
 #endif
 
+#ifndef QFMT_VFS_V0
+# define QFMT_VFS_V0 2
+#endif
+
+#ifndef QFMT_VFS_V1
+# define QFMT_VFS_V1 4
+#endif
+
 #endif /* LAPI_QUOTACTL_H__ */
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 56146b595..1e0f5da70 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -1,57 +1,47 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Crackerjack Project., 2007
- * Copyright (c) 2016-2019 FUJITSU LIMITED. All rights reserved
+ * Copyright (c) 2016-2021 FUJITSU LIMITED. All rights reserved
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ * This testcases checks that quotactl(2) on ext4 filesystem succeeds to:
  *
- * This testcase checks the basic flag of quotactl(2) for non-XFS filesystems:
- * 1) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for user.
- * 2) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *    for user.
- * 3) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *    for user.
- * 4) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *    flag for user.
- * 5) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *    flag for user.
- * 6) quotactl(2) succeeds to get quota format with Q_GETFMT flag for user.
- * 7) quotactl(2) succeeds to update quota usages with Q_SYNC flag for user.
- * 8) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *    ID with Q_GETNEXTQUOTA flag for user.
- * 9) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for user.
- * 10) quotactl(2) succeeds to turn on quota with Q_QUOTAON flag for group.
- * 11) quotactl(2) succeeds to set disk quota limits with Q_SETQUOTA flag
- *     for group.
- * 12) quotactl(2) succeeds to get disk quota limits with Q_GETQUOTA flag
- *     for group.
- * 13) quotactl(2) succeeds to set information about quotafile with Q_SETINFO
- *     flag for group.
- * 14) quotactl(2) succeeds to get information about quotafile with Q_GETINFO
- *     flag for group.
- * 15) quotactl(2) succeeds to get quota format with Q_GETFMT flag for group.
- * 16) quotactl(2) succeeds to update quota usages with Q_SYNC flag for group.
- * 17) quotactl(2) succeeds to get disk quota limit greater than or equal to
- *     ID with Q_GETNEXTQUOTA flag for group.
- * 18) quotactl(2) succeeds to turn off quota with Q_QUOTAOFF flag for group.
+ * - turn on quota with Q_QUOTAON flag for user
+ * - set disk quota limits with Q_SETQUOTA flag for user
+ * - get disk quota limits with Q_GETQUOTA flag for user
+ * - set information about quotafile with Q_SETINFO flag for user
+ * - get information about quotafile with Q_GETINFO flag for user
+ * - get quota format with Q_GETFMT flag for user
+ * - update quota usages with Q_SYNC flag for user
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for user
+ * - turn off quota with Q_QUOTAOFF flag for user
+ * - turn on quota with Q_QUOTAON flag for group
+ * - set disk quota limits with Q_SETQUOTA flag for group
+ * - get disk quota limits with Q_GETQUOTA flag for group
+ * - set information about quotafile with Q_SETINFO flag for group
+ * - get information about quotafile with Q_GETINFO flag for group
+ * - get quota format with Q_GETFMT flag for group
+ * - update quota usages with Q_SYNC flag for group
+ * - get disk quota limit greater than or equal to ID with Q_GETNEXTQUOTA flag for group
+ * - turn off quota with Q_QUOTAOFF flag for group
  */
 
-#include "config.h"
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
 #include <stdio.h>
-#include "lapi/quotactl.h"
 #include "tst_test.h"
+#include "quotactl_fmt_var.h"
 
-#ifndef QFMT_VFS_V0
-# define QFMT_VFS_V0	2
-#endif
 #define USRPATH MNTPOINT "/aquota.user"
 #define GRPPATH MNTPOINT "/aquota.group"
-#define FMTID	QFMT_VFS_V0
 #define MNTPOINT	"mntpoint"
 
-static int32_t fmt_id = FMTID;
+static int32_t fmt_id;
 static int test_id;
 static char usrpath[] = USRPATH;
 static char grppath[] = GRPPATH;
@@ -163,11 +153,13 @@ static struct tcase {
 
 static void setup(void)
 {
-	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
+	const struct quotactl_fmt_variant *var = &fmt_variants[tst_variant];
+	const char *const cmd[] = {"quotacheck", "-ugF", var->fmt_name, MNTPOINT, NULL};
 
+	tst_res(TINFO, "quotactl() with %s format", var->fmt_name);
 	SAFE_CMD(cmd, NULL, NULL);
+	fmt_id = var->fmt_id;
 
-	test_id = geteuid();
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "user quotafile didn't exist");
 
@@ -182,6 +174,12 @@ static void setup(void)
 		getnextquota_nsup = 1;
 }
 
+static void cleanup(void)
+{
+	SAFE_UNLINK(USRPATH);
+	SAFE_UNLINK(GRPPATH);
+}
+
 static void verify_quota(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -231,4 +229,6 @@ static struct tst_test test = {
 		NULL
 	},
 	.setup = setup,
+	.cleanup = cleanup,
+	.test_variants = QUOTACTL_FMT_VARIANTS,
 };
diff --git a/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
new file mode 100644
index 000000000..cb9fa4625
--- /dev/null
+++ b/testcases/kernel/syscalls/quotactl/quotactl_fmt_var.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LTP_QUOTACTL_FMT_VAR_H
+#define LTP_QUOTACTL_FMT_VAR_H
+
+#include "lapi/quotactl.h"
+
+#define QUOTACTL_FMT_VARIANTS 2
+
+static struct quotactl_fmt_variant {
+	int32_t fmt_id;
+	const char *fmt_name;
+} fmt_variants[] = {
+	{.fmt_id = QFMT_VFS_V0, .fmt_name = "vfsv0"},
+	{.fmt_id = QFMT_VFS_V1, .fmt_name = "vfsv1"}
+};
+
+#endif /* LAPI_QUOTACTL_FMT_VAR_H__ */
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
