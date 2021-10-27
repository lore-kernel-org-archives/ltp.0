Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B9C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514B360F5A
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 514B360F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3B03C6AA8
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 14:29:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 822423C004E
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:36 +0200 (CEST)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0DDC71000354
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 14:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1635337775; i=@fujitsu.com;
 bh=a0YllPTGmcVVnmd4x1JC2cvdPWXTc5M9VB6g+eIXgF4=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=jze7Tk+lTeOBhplAPU7KPVBj9Px3I2O5FLyJ4PNLNgvczEkOgq4I/ddLtuuhrxTT1
 hXR7KMxRDzp5GdlZFpMqD9WhLRc3Xc50Fk8BaFZvUq7F5Y4EYYntV+v3IspuRqteeE
 tnrwyXeHEP6EAXY1e/iH6N9vhN0IPuelAmZQpn0m8/nkk+pZHyEeK6MN93bfKNcQVH
 qatXnseSGiDmBgWLfdXEP6FxSLTiOGX78LUmHbEJYtMv76i2pKM7E83JZBxD5ZW7Oi
 7iWjOtwHQETmALU+1NC/e/dLRgyg9icQmwdXF0Hq1pWeXf4YYN6jtSFNyT0xz1spLi
 3QWXWngOjxcrQ==
Received: from [100.112.195.149] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-west-1.aws.symcld.net id AB/88-17143-F2649716;
 Wed, 27 Oct 2021 12:29:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRWlGSWpSXmKPExsViZ8MxVVfPrTL
 R4NdaPYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP1hQ/sBYsEK159PcPYwHibr4uRi0NIoIVJ
 4uvtOawQzh5Gidt3rzJ3MXJysAloSjzrXABmiwhISHQ0vGUHsZkF1CWWT/rFBGILC3hLNC34D
 mRzcLAIqEoc6GAECfMKeEhMaDoHVi4hoCAx5eF7Zoi4oMTJmU9YIMZISBx88YIZokZR4lLHN0
 YIu0Ji1qw2pgmMvLOQtMxC0rKAkWkVo3lSUWZ6RkluYmaOrqGBga6hoZGuoaWJrpmZXmKVbqJ
 eaqlueWpxia6hXmJ5sV5xZW5yTopeXmrJJkZgcKUUHHLawfj+9Qe9Q4ySHExKorwBOpWJQnxJ
 +SmVGYnFGfFFpTmpxYcYZTg4lCR4M12AcoJFqempFWmZOcBAh0lLcPAoifDmuAKleYsLEnOLM
 9MhUqcYFaXEeZVBEgIgiYzSPLg2WHRdYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMGwUyhS
 czrwRu+iugxUxAi5mVKkAWlyQipKQamELF9DdeON1kpX31pL3NAuHf99yzb7z63/mQ7ZFInO0
 3RvO/TcF7Lp3Y3PZ15p66NI2UEyF9jh8yo8rEL0+9VGVuFTIhY3Ws9PL07C/VHEpnK89Kdjy5
 fjRdVsXyx4Np//lZv7/MmMhTe0Y7J3BmkNuy35qG3NapUk2VV4UYi9zXTHf3+lg370xEdoTeu
 SdmERGiM5y3Jf9wKt1m2LpZSDd06s3dha52YscPiCSqSu4prZwqWvs3MLpfv3L7dMXtj22fNm
 0q8lV3Xq4cLndiR/OV+yyCnRPei0u86/iU37vlyS/ubU235xzT/uG0J9SDPfVXu8m1vdM+Nu3
 pXq4/L3bj0mV3ij89Xt9+RPxUjRJLcUaioRZzUXEiAKtOvFQpAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-267.messagelabs.com!1635337774!1299247!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19477 invoked from network); 27 Oct 2021 12:29:34 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
 by server-7.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 27 Oct 2021 12:29:34 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 19RCTY9j028283
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 13:29:34 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Wed, 27 Oct 2021 13:29:32 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 27 Oct 2021 20:29:27 +0800
Message-ID: <1635337770-4889-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/13] syscalls/quotactl04: Add quotactl_fd test
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

Also remove useless geteuid.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index f34050716..4dc68c2ae 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -29,12 +29,14 @@
 #include <sys/mount.h>
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #define FMTID QFMT_VFS_V1
 #define MNTPOINT	"mntpoint"
+#define TESTFILE	MNTPOINT "/testfile"
+
 static int32_t fmt_id = FMTID;
-static int test_id, mount_flag;
+static int test_id, mount_flag, fd = -1;
 static struct dqblk set_dq = {
 	.dqb_bsoftlimit = 100,
 	.dqb_valid = QIF_BLIMITS
@@ -125,7 +127,7 @@ static void setup(void)
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 	int rc, major, minor, patch;
 
-	test_id = geteuid();
+	quotactl_info();
 	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
 	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
 	if (rc != 3)
@@ -135,10 +137,13 @@ static void setup(void)
 	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0666);
 }
 
 static void cleanup(void)
 {
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 	if (mount_flag && tst_umount(MNTPOINT))
 		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
@@ -153,7 +158,7 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
 		return;
@@ -183,6 +188,7 @@ static struct tst_test test = {
 	.needs_device = 1,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4",
 		NULL
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
