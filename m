Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C999C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:57:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01E861178
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F01E861178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 814D23C093A
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:57:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D798F3C04C2
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:56:41 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16200141CE88
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1636455400; i=@fujitsu.com;
 bh=GTJLdBdzMFycruBhH99e1Ug3gj9CaY1DgXchgFaWneg=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=nQqJOLXRZm6sYsW4tMEyfVhersRB5rc4UczIQUlPJcRzrSfZO7v7BDDmLaJZ3Gy3i
 q49xVV4Zmt6rF+IuwFXwHt2QNKMDscTJLNU7z6Ge8KoD8kVrjdv0nfAPPKOrMvTOlo
 4DlKvWlsFY4QkMvt67jvMdYIblqaE321AjYBFKKN35I9dh2GYYCpjH/yPtuQzLiepq
 eZ0r4FoLLll8isM0Xwoswf8DoF6zW4d8Hr2Mo5QY61eB7SEMg5B12PvMqu9kGzs+Hi
 tz8eY87FGgn4a+9lHH+gR7dTMjDAm2E/eZuPrHC+0/tz0d0BfZQc05AGhft4M7AwEP
 PF7GSMdkugf4A==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 5C/50-01506-8E35A816;
 Tue, 09 Nov 2021 10:56:40 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8MxSfdFcFe
 iwYy7jBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aMUy+YCv4JVmye1MPcwLiZv4uRi0NI4Cyj
 xNtNu9kgnJ1MEht/3GaEcHYzSkzd0snUxcjJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 1ANB4ewgLfEvL81IGEWARWJP1OXsICEeQU8JPb1GoCEJQQUJKY8fM8MEuYU8JRYdaUcJCwEVL
 H2bSPYcF4BQYmTM5+wQAyXkDj44gUzRKuixKWOb4wQdoXErFltTBC2msTVc5uYJzAKzkLSPgt
 J+wJGplWMlklFmekZJbmJmTm6hgYGuoaGxrpmuoYWZnqJVbpJeqmlusmpeSVFiUBZvcTyYr3i
 ytzknBS9vNSSTYzA8E0pZNu1g/Hz6w96hxglOZiURHkvi3UlCvEl5adUZiQWZ8QXleakFh9il
 OHgUJLgTfAHygkWpaanVqRl5gBjCSYtwcGjJMKr5wOU5i0uSMwtzkyHSJ1i1OW4fH3eImYhlr
 z8vFQpcd6UIKAiAZCijNI8uBGwuL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZj3UyDQFJ7
 MvBK4Ta+AjmACOuLgl3aQI0oSEVJSDUzOZnHtLEmhSw5cjNjVVJF75nVtzKxuzbg1LvUdl55c
 2f6sWfY159k9daLa5fKbBQoeXN5id2WSkeMu7/xwU7nOsIAt0/jKDDgfT7nzyMF26u058lZT2
 z9KvP/2xVl+zX22v6qnW2fc2OnxqvVia8H8js76NYcaXzdPfs901GlBXv9swbd5TMwV15kn68
 wPXe1QxlGc9OjlowNPhI5pak/h4pjP8v2pmb5h6fyH7PLHsubuKZxQd/en50onHaOVe16bT5v
 7pLDh2qM3Sovdha7tKVk0s6bxaFLeizbVu5dO1ZnefbQveo7Eho6/b5dvLzrQdzxcKyJgK+NJ
 YS8uqV9NhcknrPef4/9svf3MZktNJZbijERDLeai4kQA7QyLJ2YDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-248.messagelabs.com!1636455399!394843!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2281 invoked from network); 9 Nov 2021 10:56:40 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-10.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Nov 2021 10:56:40 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 899EC10046D
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:56:39 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 7CC5D100456
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:56:39 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 9 Nov 2021 10:56:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 9 Nov 2021 18:56:36 +0800
Message-ID: <1636455396-8508-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1636455396-8508-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1636455396-8508-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 12/12] syscalls/quotactl07: Add quotactl_fd test
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
 .../kernel/syscalls/quotactl/quotactl07.c     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index 2992a6112..6e2079e0f 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -16,21 +16,18 @@
 #include <stdio.h>
 #include <sys/quota.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT    "mntpoint"
 
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
@@ -39,17 +36,19 @@ static void verify_quota(void)
 
 static void setup(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
+	quotactl_info();
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
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
@@ -60,6 +59,7 @@ static struct tst_test test = {
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
