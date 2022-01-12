Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EFDC433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 07:48:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10343C94C1
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 08:48:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F2163C12D0
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:48:08 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 093206008A1
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 08:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1641973685; i=@fujitsu.com;
 bh=D2U8xF2eQyk8OsMd2T6O/MtCIzEIAUTkUW5yg9rvsDo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=vLIj7wXm+z6dodnb2gnDycJsjJ/qvjz2cWrZVmBxivMO/vHKbUql3AVdejq10wiYC
 DUm5z+qcDUVwVFsZYiRdzwB9wxzJ/GRdmVuPLWG2gKvYw6jrHPrDDuOEvF0aaaguLm
 aC67arQuK10lozudOsSyJ7KQNE8iTAXQ9T70z0dktF3Yi/0RnrlJe+UDy0lCmKxYRu
 4zmD8cAfMecDVTdhfVz7CtH6bG59lGI9pCwRAXDVE7CQ9yB0/XnWy6q+dIEm8UKfgu
 Fz1xp7HOFeBZ56IaNka60MXxCffm73mUR6j+6aOO9E0PIy1IsjjD8jFEQ4Dpr9oZ+L
 T+gs6i6SXIDaQ==
Received: from [100.115.70.1] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-a.eu-central-1.aws.ess.symcld.net id 3E/E5-06990-5B78ED16;
 Wed, 12 Jan 2022 07:48:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsViZ8ORqLul/V6
 iwYfDZhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8a0i/0sBZvVKs5+ucLYwDhHsYuRi0NI4Cyj
 xLSVZ9ggnJ1MEhuOLWKEcPYwSrzvOcbSxcjJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSxgL9H9bytYDYuAqsTxV7sYQWxeAU+JhQ9PgcUlBBQkpjx8D2ZzCnhJHDh8DaxXCKhmb1
 8PE0S9oMTJmU9YIOZLSBx88QKqV1HiUsc3Rgi7QmLWrDYmCFtN4uq5TcwTGAVnIWmfhaR9ASP
 TKka7pKLM9IyS3MTMHF1DAwNdQ0NTXXNDXUNjY73EKt1EvdRS3eTUvJKiRKC0XmJ5sV5qcbFe
 cWVuck6KXl5qySZGYDinFLu37mC83PdT7xCjJAeTkijvrLZ7iUJ8SfkplRmJxRnxRaU5qcWHG
 GU4OJQkeO2agXKCRanpqRVpmTnA2IJJS3DwKInwZoO08hYXJOYWZ6ZDpE4xWnJcvj5vETNH86
 Tl25k5Xrf83MEsxJKXn5cqJc6bC9IgANKQUZoHNw4W/5cYZaWEeRkZGBiEeApSi3IzS1DlXzG
 KczAqCfN6gkzhycwrgdv6CuggJqCDkjlugxxUkoiQkmpgkuRuPlFv4mDYc6VvxtqUvTX2z790
 qa9REpfPrpil9Pohb9HTmjZNHt4FL//fvFCkGr/70oefm3Y8axSJsH6qZVeimyS/4WfhqdTE0
 MC2q6xPbed2K6ZsvvR3M4PpindrAlSLdk7ZsLxCpaz12E1mS93D119FuJfVTFhhyV91/kb8Ed
 aJ7GcOe6/OfGR7/KfhFxaWkPXW8/zenlw760WY5h4NZlWVIw8PtGi43li/UVzg+MapbdtfGm6
 xft6+zvXJa4uzu8P6M0PEn5lkqLLUaMRUqhXc/WPA0Xfx86b7C0+df1UscI+zdMr7dU7uBdPW
 zVY0mqHRunzOvSsL010Wfj2V0Nxyr9xQUrB/+7R9V5VYijMSDbWYi4oTAbVw7EV6AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-532.messagelabs.com!1641973684!78626!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28943 invoked from network); 12 Jan 2022 07:48:04 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-17.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Jan 2022 07:48:04 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 54685100188
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:48:04 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4682D100181
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:48:04 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 07:47:42 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 12 Jan 2022 15:48:10 +0800
Message-ID: <1641973691-22981-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/3] syscalls/quotactl07: Refactor this case
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

man-pages has error that Q_XQUOTARM was not introduced by kernel
3.16[1][2]. It only doesn't have owner handler so the flag spaces overlap
a bit[3].

Add a functional test for Q_XQUOTARM and check whether available block
is greater than before instead of a regression test for buggy 3.16 kernel
because it is about 8 year old. Functional test is more meaningful.

Since kernel commit 40b52225e ("xfs: remove support for disabling quota
accounting on a mounted file system")[4] was introduced, if we want to
disable quota account feature before Q_XQUOTARM, we must need to remount
with noquota like xfs maintainer does in xfstests xfs/220 [5].

So, change this by mount with usrquota and remount with noquota to create
a test environment that superblock has quota data but quota feature not running.

We also add quotactl_fd test variant for this test.

[1]https://github.com/alejandro-colomar/man-pages/commit/38bccbcf4f51c5370a1060e6a80b90d68b0dcdc8
[2]https://github.com/alejandro-colomar/man-pages/commit/26f3978f04a1aeeb5397a5facebaef40a341afb6
[3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9da93f9b7c
[4]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=40b52225e58
[5]https://patchwork.kernel.org/project/fstests/patch/20220105195352.GM656707@magnolia/

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 .../kernel/syscalls/quotactl/quotactl07.c     | 58 +++++++++++++------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
index 2992a6112..2427ef682 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl07.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
@@ -7,7 +7,9 @@
 /*\
  * [Description]
  *
- * This is a regresstion test for kernel commit 3dd4d40b4208
+ * This is not only a functional test but also a error test for Q_XQUOTARM.
+ *
+ * It is a regresstion test for kernel commit 3dd4d40b4208
  * ("xfs: Sanity check flags of Q_XQUOTARM call").
  */
 
@@ -15,51 +17,71 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/quota.h>
+#include <sys/statvfs.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #ifdef HAVE_XFS_XQM_H
 # include <xfs/xqm.h>
 
-#define MNTPOINT    "mntpoint"
-
-static uint32_t qflag_acct = XFS_QUOTA_UDQ_ACCT;
-static unsigned int valid_type = XFS_USER_QUOTA;
 /* Include a valid quota type to avoid other EINVAL error */
 static unsigned int invalid_type = XFS_GROUP_QUOTA << 1 | XFS_USER_QUOTA;
+static unsigned int valid_type = XFS_USER_QUOTA;
+static int mount_flag;
 
 static void verify_quota(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&invalid_type));
-	if (TST_ERR == EINVAL)
-		tst_res(TPASS, "Q_XQUOTARM has quota type check");
+	struct statfs before, after;
+
+	SAFE_STATFS(MNTPOINT, &before);
+	TST_EXP_PASS(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
+			(void *)&valid_type), "do_quotactl(Q_XQUOTARM,valid_type)");
+	SAFE_STATFS(MNTPOINT, &after);
+	if (before.f_bavail <= after.f_bavail)
+		tst_res(TPASS, "Q_XQUOTARM to free space, delta(%lu)", after.f_bavail - before.f_bavail);
 	else
-		tst_res(TFAIL, "Q_XQUOTARM doesn't have quota type check");
+		tst_res(TFAIL, "Q_XQUOTARM to free space, delta(-%lu)", before.f_bavail - after.f_bavail);
+
+	TST_EXP_FAIL(do_quotactl(fd, QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0,
+			(void *)&invalid_type), EINVAL, "do_quotactl(Q_XQUOTARM, invalid_type)");
 }
 
 static void setup(void)
 {
-	TEST(quotactl(QCMD(Q_XQUOTAOFF, USRQUOTA), tst_device->dev, 0, (void *)&qflag_acct));
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "quotactl with Q_XQUOTAOFF failed");
+	quotactl_info();
+
+	/* ensure superblock has quota data, but not running */
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "usrquota");
+	mount_flag = 1;
+	SAFE_UMOUNT(MNTPOINT);
+	mount_flag = 0;
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noquota");
+	mount_flag = 1;
 
-	TEST(quotactl(QCMD(Q_XQUOTARM, USRQUOTA), tst_device->dev, 0, (void *)&valid_type));
-	if (TST_ERR == EINVAL)
-		tst_brk(TCONF, "current system doesn't support Q_XQUOTARM, skip it");
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+}
+
+static void cleanup(void)
+{
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+	if (mount_flag && tst_umount(MNTPOINT))
+		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_XFS_QUOTA",
 		NULL
 	},
 	.test_all = verify_quota,
-	.mount_device = 1,
+	.format_device = 1,
 	.dev_fs_type = "xfs",
-	.mnt_data = "usrquota",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "3dd4d40b4208"},
 		{}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
