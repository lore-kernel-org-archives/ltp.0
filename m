Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1510C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 303DB3C8A20
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:28:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F37103C2242
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:28:04 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53B4B1400DA6
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:28:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380483; i=@fujitsu.com;
 bh=guizuOM7M52J3UnaOe0kFTYgtXezq5oHJ0qOVFn/dQA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=vWOEbc6HF2PlHstuNLqN63cTE0sA77kIYSjFqpIwFTvpIDoup2FFgjvwiw7L93+wy
 w78NzwM0DTWntNtEQ9K40cMC1oTysai7+8fy+DO5+JgA8RkNa0R/Vu+gtFJtyl0goY
 rv/cW4oE/jTOgWatSj6vvdRK2HNjD1XDKFc/J17GifVr2aYXaKGc7RTq+2WM9X6ykw
 F0F9gIQC3fbMI4baibcZckjyl8KW5vE+83HJQsp5+cb859Bc692xYo24kTFuohLloy
 AcW+3zE9kAmr0xlBEWpkS/NWoFeC0eGl3zEYV+CuJOjT1Oax0flfrWvsfjCBP99wHF
 I+g2eFypaLqZA==
Received: from [100.115.1.47] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.ess.symcld.net id 80/ED-13695-306F6B16;
 Mon, 13 Dec 2021 07:28:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRWlGSWpSXmKPExsViZ8ORqMv8bVu
 iwZ8DPBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aVdfeZC/4KVny+vJetgXETfxcjF4eQwFlG
 iRnzzrFDODuZJKa0vmKFcPYwSizZvIq5i5GTg01AU+JZ5wIwW0RAQqKj4S07iM0soC6xfNIvJ
 hBbWMBT4uW+VjCbRUBVYuOG62wgNi9QfOKWtWD1EgIKElMevgebwyngJfHuwn1GEFtIIEliQu
 tsJoh6QYmTM5+wQMyXkDj44gUzRK+ixKWOb4wQdoXErFltTBC2msTVc5uYJzAKzkLSPgtJ+wJ
 GplWMlklFmekZJbmJmTm6hgYGuoaGprrGuhZmeolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5
 yTkpenmpJZsYgUGcUswctoPxT+9PvUOMkhxMSqK83xi3JgrxJeWnVGYkFmfEF5XmpBYfYpTh4
 FCS4PX6si1RSLAoNT21Ii0zBxhRMGkJDh4lEd7VX4HSvMUFibnFmekQqVOMuhyXr89bxCzEkp
 eflyolzvsXZIYASFFGaR7cCFh0X2KUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzBsAMoUnM68
 EbtMroCOYgI5grNwMckRJIkJKqoHJc/dl/ahdE0z37UnXMb3klyN9uUa+nsV0ucd99pCOEyl/
 D2tkaVwWvZqR0rdkilfVhLwyp0uc+Uy5mS+u/m/9LV1iGX1zx7+wZXcL9gdWXBe9NDN67YWZp
 ycVHWedk3f90MRO68nvD/78XXeBd8KjArX8joh3UrI9e7nO1tV9OrLzQ+Uv71tqMu6VDZfecf
 x/9f3txawXq8yn3WtgvHxCNiV89Zdf5fr/d7J4Z8/pc7O5avKzgGG7leCORNXS1ccCDAPLni+
 0XB/VWL83UCc6Z/nFw1sOT29mLgyw/VZ93eB81cz/rf5H3y/afCU/1fvszPC13aerj15tuVK5
 ae95Z+tdzfzbb6z8Zb/m9WrOFCWW4oxEQy3mouJEAMWIv/9pAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-587.messagelabs.com!1639380482!213874!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13464 invoked from network); 13 Dec 2021 07:28:03 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-8.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:28:03 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id B9A7B10023D
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:28:02 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id AE466100239
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:28:02 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:27:46 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:54 +0800
Message-ID: <1639380414-24390-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/6] syscalls/quotactl07: Add quotactl_fd test
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
3.16. So use invalid type directly

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
