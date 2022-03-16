Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A154C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 03:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 755903C9351
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 04:32:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08DAF3C1B7F
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 04:32:40 +0100 (CET)
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id E2BD51000A10
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 04:32:37 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3ALmr9S6hpnHRQpMVV5B/8A4KxX161WxIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVRx2FLWWqBbqmMazDzctt1OYyz80oB6sPUy9VgHQNsrXw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14MVQpJW2R?=
 =?us-ascii?q?l1xZ/2KmvU1XQRaEj1lIOtN/7qvzX2X6JbJkR2ZLCexqxlpJARsVWECwc5zHXl?=
 =?us-ascii?q?m8f0DNCtLahGFmvLwwa7TYuxlnNgiKo/nO54UunhI1izCALAtRpWra73U4sVV2?=
 =?us-ascii?q?B8rm9tDW/3MD/f1wxIHgA/oOkUJYwlITsll2rrAu5U2SBUAwHr9mEb9yzG7INR?=
 =?us-ascii?q?N7YXQ?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADECtUqNC7yq2OcBcTjOjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfU1SL39qynAppQmPHPP5Ar5O0tQ/OxoWpPwIk80nKQdieJ6UItKNzOGhI?=
 =?us-ascii?q?LHFu5fBPPZsl/d8jPFh5Zg/JYlY65jE8fxEFQ/qc775TOzG9EmzMLvytHPuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcQbUjEp703Ls/mxOQPWQQct+gBmQIG8zKp9?=
 =?us-ascii?q?jwnprgZhIcQz4LgTP+6g+V1A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; d="scan'208";a="122687745"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 16 Mar 2022 11:32:36 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
 by cn.fujitsu.com (Postfix) with ESMTP id D86814D16FC7;
 Wed, 16 Mar 2022 11:32:32 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 11:32:32 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 11:32:32 +0800
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <pvorel@suse.cz>
Date: Wed, 16 Mar 2022 11:32:26 +0800
Message-ID: <1647401546-2898-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: D86814D16FC7.A6966
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@fujitsu.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/quotactl: Remove
 tst_require_quota_support
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
Cc: ltp@lists.linux.it, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since we have check quota support on ext4/xfs by using needs_drivers or
needs_kconfigs, we don't need this api any more.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_fs.h                              | 15 ---------
 lib/tst_supported_fs_types.c                  | 32 -------------------
 .../kernel/syscalls/quotactl/quotactl01.c     |  2 --
 .../kernel/syscalls/quotactl/quotactl04.c     | 25 ++-------------
 .../kernel/syscalls/quotactl/quotactl06.c     |  2 --
 5 files changed, 2 insertions(+), 74 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 3bab9da8b..bc6692bd4 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -197,21 +197,6 @@ const char **tst_get_supported_fs_types(const char *const *skiplist);
  */
 int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 
-/*
- * Check whether device supports FS quotas. Negative return value means that
- * quotas appear to be broken.
- */
-int tst_check_quota_support(const char *device, int format, char *quotafile);
-
-/*
- * Check for quota support and terminate the test with appropriate exit status
- * if quotas are not supported or broken.
- */
-#define tst_require_quota_support(dev, fmt, qfile) \
-	tst_require_quota_support_(__FILE__, __LINE__, (dev), (fmt), (qfile))
-void tst_require_quota_support_(const char *file, const int lineno,
-	const char *device, int format, char *quotafile);
-
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
  */
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 23e5ce877..9726d193a 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -173,35 +173,3 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 
 	return fs_types;
 }
-
-int tst_check_quota_support(const char *device, int format, char *quotafile)
-{
-	const long ret = quotactl(QCMD(Q_QUOTAON, USRQUOTA), device, format,
-				  quotafile);
-
-	/* Not supported */
-
-	if (ret == -1 && errno == ESRCH)
-		return 0;
-
-	/* Broken */
-	if (ret)
-		return -1;
-
-	quotactl(QCMD(Q_QUOTAOFF, USRQUOTA), device, 0, 0);
-	return 1;
-}
-
-void tst_require_quota_support_(const char *file, const int lineno,
-	const char *device, int format, char *quotafile)
-{
-	int status = tst_check_quota_support(device, format, quotafile);
-
-	if (!status) {
-		tst_brk_(file, lineno, TCONF,
-			"Kernel or device does not support FS quotas");
-	}
-
-	if (status < 0)
-		tst_brk_(file, lineno, TBROK|TERRNO, "FS quotas are broken");
-}
diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
index 63f6e9181..c14228e35 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl01.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
@@ -166,8 +166,6 @@ static void setup(void)
 	if (access(GRPPATH, F_OK) == -1)
 		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
 
-	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
-
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
 		test_id, (void *) &res_ndq));
 	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 3eb6e4a34..a57e6be60 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -96,35 +96,14 @@ static struct tcase {
 
 };
 
-static void do_mount(const char *source, const char *target,
-	const char *filesystemtype, unsigned long mountflags,
-	const void *data)
-{
-	TEST(mount(source, target, filesystemtype, mountflags, data));
-
-	if (TST_RET == -1 && TST_ERR == ESRCH)
-		tst_brk(TCONF, "Kernel or device does not support FS quotas");
-
-	if (TST_RET == -1) {
-		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
-			source, target, filesystemtype, mountflags, data);
-	}
-
-	if (TST_RET) {
-		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
-			source, target, filesystemtype, mountflags, data);
-	}
-
-	mount_flag = 1;
-}
-
 static void setup(void)
 {
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 
 	quotactl_info();
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
-	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	mount_flag = 1;
 	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 
 	TEST(do_quotactl(fd, QCMD(Q_GETNEXTQUOTA, PRJQUOTA), tst_device->dev,
diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index feb475022..ae8d7faca 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -189,8 +189,6 @@ static void setup(void)
 	if (access(USRPATH, F_OK) == -1)
 		tst_brk(TBROK | TERRNO, "user quotafile didn't exist");
 
-	tst_require_quota_support(tst_device->dev, fmt_id, usrpath);
-
 	SAFE_MKDIR(TESTDIR1, 0666);
 
 	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
-- 
2.23.0




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
