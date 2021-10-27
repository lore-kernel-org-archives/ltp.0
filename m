Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6612CC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B8E60F9D
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18B8E60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAAD93C6A39
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:30:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62A123C67D8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:56 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6EAD31401753
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337795; i=@fujitsu.com;
 bh=0iSm2W7/4dwHhX3jBnWJIINwWokOyPyYHLNYq0hUdyA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=woQi9MVOiWeeMHvPCK7/MC06l/JEUYi/xfmlLs3xaKfEvmE6C5ySedS/of5Ytqj0r
 N4laAv4GuvqiuehFzE+riVqMv5ONPbSwXaTaJ9opM5xPKphQ37XMpHRFMiVBx0g1Ja
 ekCSFk32EGYgRL5l1WB17m6o+GWDsyoFnXW2Teuf/F8j9xjyvGWklNxZxTxtje7t20
 901YyCFmSQHkP0/D2RvykbgdW4A9C862cdWwdcEpdXpWoVmDsUZCUXsT9HOnXgAp6R
 EDAApiqDZqLlYtCpKCpJ7oFjh2/KY3bVX1CJgI80mDHpJFZJO3b4+RFR88JOHP/RwR
 w8onfNtb2OaEg==
Received: from [100.112.195.149] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 27/5F-30013-34649716;
 Wed, 27 Oct 2021 12:29:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8MxSdfZrTL
 R4Fw7l8WK7zsYHRg99v1exxrAGMWamZeUX5HAmrH32CvGglNCFfOPbWRqYPzI38XIxSEkcJZR
 YuKSFvYuRk4gZyeTxKnXlhCJPYwSS9d+ZQRJsAloSjzrXMAMYosISEh0NLwFa2AWUJdYPukXE
 4gtLOAtMatzOVg9i4CqxL0Dl4BqODh4BTwkXj/SAQlLCChITHn4HmwMp4CnRP+VU8wgJUJAJU
 0vS0DCvAKCEidnPmGBmC4hcfDFC2aIVkWJSx3fGCHsColZs9qYIGw1iavnNjFPYBSchaR9FpL
 2BYxMqxjNk4oy0zNKchMzc3QNDQx0DQ2NdA0tTXTNzPQSq3QT9VJLdctTi0t0DfUSy4v1iitz
 k3NS9PJSSzYxAkM3peCQ0w7G968/6B1ilORgUhLlDdCpTBTiS8pPqcxILM6ILyrNSS0+xCjDw
 aEkwZvpApQTLEpNT61Iy8wBxhFMWoKDR0mEN8cVKM1bXJCYW5yZDpE6xajLcfn6vEXMQix5+X
 mpUuK8yiBFAiBFGaV5cCNgMX2JUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBvFMgUnsy8Erh
 Nr4COYAI6glmpAuSIkkSElFQDk/ubcquUKce4J039l7Fw5vz0CSqvFbc3tvWkPs4zOSwjv9XX
 XqLkwKYneZ3lRfpe23lnNtx75KZesY6rvbLE8GfJO8Ul4t/m8mdr7L46dZ/4ovePfb/XuRjft
 k4/dz78hbhNUO/+2ZpRHfHi1vM/RmzUrvr2OXJiy+/NjO2H5C+k8ft3PklzCE7ctnGVovdHf7
 EuK/ul201a7yXJBLxh6lzxXllxHrtJxh6GyvPHJM4H/5Na86go0Nv2TxSLqfSXifJeewtuKct
 fnNY2pf2Q+zQpVr++g4wXL2z+XPfQrHTTvreTHeo4pj6J0Tl2W5DtufS7V+2Pn1j2fJozXcn8
 MdNjuQsq554wCzx4p6y2SYmlOCPRUIu5qDgRAMtzerxkAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-271.messagelabs.com!1635337794!2949461!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12562 invoked from network); 27 Oct 2021 12:29:55 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-10.tower-271.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:29:55 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9D1F210046B
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 8CF1B10044F
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:54 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:29:37 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:29:29 +0800
Message-ID: <1635337770-4889-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 12/13] syscalls/quotactl07: Add quotactl_fd test
 variant
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

Also man-pages has error that Q_XQUOTARM was not introduced by kernel
3.16. So use invalid type directly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl07.c     | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index 2992a6112..d29a56ee4 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -16,21 +16,22 @@
 #include <stdio.h>
 #include <sys/quota.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
 #define MNTPOINT    "mntpoint"
+#define TESTFILE MNTPOINT "/testfile"
+
+static int fd = -1;
 
-static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
-static unsigned int valid_type = XFS_USER_QUOTA;
 /* Include a valid quota type to avoid other EINVAL error */
 static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
 
 static void verify_quota(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
+	TEST(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
 	if (TST_ERR == EINVAL)
 		tst_res(TPASS, "Q_XQUOTARM has quota type check");
 	else
@@ -39,17 +40,19 @@ static void verify_quota(void)
 
 static void setup(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
+	quotactl_info();
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
+}
 
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
-	if (TST_ERR == EINVAL)
-		tst_brk(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_XFS_QUOTA",
@@ -60,6 +63,7 @@ static struct tst_test test = {
 	.dev_fs_type = "xfs",
 	.mnt_data = "usrquota",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "3dd4d40b4208"},
 		{}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
