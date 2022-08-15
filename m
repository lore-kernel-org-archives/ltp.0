Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C0C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 08:26:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D72DC3C9737
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 10:26:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73DFD3C010A
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:26:34 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 51A5B600072
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 10:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1660551992; i=@fujitsu.com;
 bh=gJx8zQDvNQyneyaNvvFjBISaUiyHeUXtWphaeGbhRUA=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=bejTiHucvigw+0wcZ6gBMwAv0M0VIR17SQJp/fRcMpb0/7YiJWvG2Pwrss5V0oAbW
 FBFDkNle1X6OQpwvaAHhbCOusOuRMmQzaAqc8fpn+bvxwFZBpQie/wFpM4Tzu8Y6Oe
 lzxUPk/6Nj4wOzmnwwJ/9GUEyBm6CaxdvQRU/kCq8M7HqEVVA6+E/jgMrImscRq+Ke
 boNe4F1s8M7Xw73zStRiO1uVALgzAE4KlRmUt62RA3ngQUC80329wvOtfoGwqarnLH
 nSPo6Dn+5tis09iQf9zNAYgCkGwS9LeMt/FoUmfGZAWjqlQ7GEgJRWWbd6OWF9ysyO
 bO1GfV//6wHjA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsViZ8ORqGvO/Cv
 J4NIMVYvXhz8xWqz4voPR4tmRVUwWP27dYHFg8di0qpPNY9/vdaweZxYcYQ9gjmLNzEvKr0hg
 zej/fYax4I5wRe+p3+wNjFsEuhi5OIQEtjBKXL14jg3CWc4ksevJQVYIZw+jxLT3O1i6GDk52
 AQ0JZ51LmAGsUUEJCQ6Gt6ydzFycDALJEs0fXEECQsLOEk071nKCGKzCKhK3Lg6lxXE5hXwkH
 h8fjZYq4SAgsSUh+/BbE4Ba4kfm7eyg9hCAlYS+xf9YYaoF5Q4OfMJ2FpmoFUHX7yA6lWUuNT
 xjRHCrpB4ffgSVFxN4uq5TcwTGAVnIWmfhaR9ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0NTXWNd
 Q0tLvcQq3US91FLd8tTiEl1DvcTyYr3U4mK94src5JwUvbzUkk2MwLBPKWY+voNxSt9PvUOMk
 hxMSqK81y7+TBLiS8pPqcxILM6ILyrNSS0+xCjDwaEkwfuJ4VeSkGBRanpqRVpmDjAGYdISHD
 xKIrwZv4BaeYsLEnOLM9MhUqcYjTmuXrmyl5lj076uA8xCLHn5ealS4rw/QCYJgJRmlObBDYK
 lhkuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHmtmICm8GTmlcDtewV0ChPQKXp3v4OcUpKI
 kJJqYEqb+Tuj52pOsOWME+6bYw7fteTnY9uyiiHVgOFUoP9nJ9XLyeLmMy5U9NS/2PJQdOsNH
 z3zpJpL30LOJC5YdXhJ3Ktp7jv1Ag+/bXwVOHGpSKm0o3PuxsyZducust/rWCVv57CZc7Xc8w
 /565OOcF/8cGP9OqU3qd/9bL4mxmzuSlu62Nov9ZSecOX5QEaDr9l2SZOrm6pag0vK3Rs49+m
 38tS9Unt61Djo69m6w2UMLOVvS4SqKk6WpN3s1l5+zLjL6viRW4sVDvN8PGjMs9JjiqXRmQuP
 mFx7jqvNcbu95Idok8ZX1YPXEmyO7WIMX7jQt4KLdf0M0w/z7c/2O8w3uulntWxR24WPS5QU/
 yqxFGckGmoxFxUnAgAfYp4NiAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-3.tower-587.messagelabs.com!1660551991!834257!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20182 invoked from network); 15 Aug 2022 08:26:31 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-3.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Aug 2022 08:26:31 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3622A100192;
 Mon, 15 Aug 2022 09:26:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2A020100043;
 Mon, 15 Aug 2022 09:26:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 15 Aug 2022 09:26:28 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 15 Aug 2022 17:27:06 +0800
Message-ID: <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
References: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] syscalls/creat09: Add umask test condition
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
Cc: brauner@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
this case has been merged into 6.0-rc1 kernel[1].

I will add acl and umask test[2] in xfstests because there is more suitable
to do this.

Here I just only add umask test condition simply.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1639a49c
[2]https://patchwork.kernel.org/project/fstests/list/?series=662984

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat09.c | 30 +++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index bed7bddb0..d583cceca 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -28,6 +28,16 @@
  *  Date:   Fri Jan 22 16:48:18 2021 -0800
  *
  *  xfs: fix up non-directory creation in SGID directories
+ *
+ * When use acl or umask, it still has bug.
+ *
+ * Fixed in:
+ *
+ *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
+ *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ *  Date:   Thu July 14 14:11:27 2022 +0800
+ *
+ *  fs: move S_ISGID stripping into the vfs_*() helpers
  */
 
 #include <stdlib.h>
@@ -47,6 +57,14 @@
 static gid_t free_gid;
 static int fd = -1;
 
+static struct tcase {
+	const char *msg;
+	int mask;
+} tcases[] = {
+	{"under umask(0) situation", 0},
+	{"under umask(S_IXGRP) situation", S_IXGRP}
+};
+
 static void setup(void)
 {
 	struct stat buf;
@@ -94,8 +112,14 @@ static void file_test(const char *name)
 		tst_res(TPASS, "%s: Setgid bit not set", name);
 }
 
-static void run(void)
+static void run(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
+
+	umask(tc->mask);
+	tst_res(TINFO, "Testing setgid behaviour when creating file %s",
+			tc->msg);
+
 	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
 	SAFE_CLOSE(fd);
 	file_test(CREAT_FILE);
@@ -115,13 +139,14 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.test_all = run,
+	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
+	.tcnt = ARRAY_SIZE(tcases),
 	.skip_filesystems = (const char*[]) {
 		"exfat",
 		"ntfs",
@@ -132,6 +157,7 @@ static struct tst_test test = {
 		{"linux-git", "0fa3ecd87848"},
 		{"CVE", "2018-13405"},
 		{"linux-git", "01ea173e103e"},
+		{"linux-git", "1639a49ccdce"},
 		{}
 	},
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
