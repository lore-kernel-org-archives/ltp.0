Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB45C433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 07:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C46073C8E7E
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00A6D3C8C4D
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:53:37 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AF7A1001291
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638345215; i=@fujitsu.com;
 bh=ZQMfhEQkGwLqYcvMg969uUEn4U2FPphpdMA6KtK3lm0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=XxzHB/oL1lSdBKmeLLB75ld/u2VTvCq0HUz0SP3rcFQrE7bKkJG4qDtsXghVzRyYH
 cPsfSajLY/ctcGPlSpKq390A8ltgtBBZmdHUgVJJRdh3tjzqxHc8rQFBPLWZDfgejx
 6ZxrpXnc5XsGOe+gpRc1maFLMgd1LPjZeSiDluqBar/ZCmgp2B6geMyBaLpwau5ScL
 UIORK6+H4OdTmbIk4gcpWCD8zSJzmvrYruAP7txudCBw1BmECOjl4Wbx6L5SKW6+Fn
 +Ejdq37aXc0YTv9Jl41j/R+vrucgQB63htBfMtQeWN+YJjMNiYQQvoRiNd1Xq5+HZL
 P/jQzPT97yOCA==
Received: from [100.115.0.49] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.ess.symcld.net id 0A/5F-12056-FF927A16;
 Wed, 01 Dec 2021 07:53:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8MRovtPc3m
 iwbaZFhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bhwxMZC5YJV5z78Z2pgXGFQBcjF4eQQCOT
 xPz+L+wQzm5GiaeXvjJ2MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6xQRiCws4S/x8c
 4wFxGYRUJHYOWcPWJxXwENi8okFbCC2hICCxJSH74HmcHBwCnhKnL5dCWIKAZU0vZKFqBaUOD
 nzCQvEdAmJgy9eMEN0Kkpc6vjGCGFXSMya1cY0gZF/FpKWWUhaFjAyrWK0SirKTM8oyU3MzNE
 1NDDQNTQ01TXQNTIx1kus0k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECAzIlGKG
 zzsYF/T91DvEKMnBpCTK+4h5eaIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV4HNaCcYFFqempFW
 mYOMDpg0hIcPEoivHzACBHiLS5IzC3OTIdInWJUlBLnlQVJCIAkMkrz4NpgEXmJUVZKmJeRgY
 FBiKcgtSg3swRV/hWjOAejkjCvLcgUnsy8Erjpr4AWMwEtfrt0McjikkSElFQDk39AKX918I1
 5anJPQnbf3CWfnLXAi680L+NOzIf3JsoLd725/OVMz1+mllXWGz//u5ltKtJxTa9Cl+2CZcar
 v5NaXpR9/P1n6oby3TyvG9zXbaq9eE5Q8L3Wi+Yl14RuLmh+nnX+YNgivwnP3sx8dutM7C8T7
 42Zm2btFjjU6nuFsfmr/4SizF3z5Luilkv5G+yrD5kZufWst2/T9M45PJ8WFWU3hlyM0BeVrT
 YxfRyb1VuYmn2/PFs/Z4qyxntNIbO8RzplEaHeCa6hyxqlH535dZ8z6mVv99FbchySGV8aetq
 N+KbkrZgjqcP3J36BtWuplfATWafHaolnznI+qImv3vbv2+LS1Od3p+r2KbEUZyQaajEXFScC
 AOEP3NxDAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-15.tower-587.messagelabs.com!1638345214!63624!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6739 invoked from network); 1 Dec 2021 07:53:34 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
 by server-15.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 1 Dec 2021 07:53:34 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 1B17rLbU024965
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Wed, 1 Dec 2021 07:53:34 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 1 Dec 2021 07:53:26 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 1 Dec 2021 15:53:28 +0800
Message-ID: <1638345208-2186-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1638345208-2186-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] testcase: make use of needs_cmd version parser
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 11 +----------
 testcases/kernel/syscalls/statx/statx05.c       | 13 ++-----------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index dab61cf4d..62c94d596 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -121,18 +121,9 @@ static void do_mount(const char *source, const char *target,
 
 static void setup(void)
 {
-	FILE *f;
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
-	int rc, major, minor, patch;
 
 	test_id = geteuid();
-	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
-	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
-	if (rc != 3)
-		tst_res(TWARN, "Unable parse version number");
-	else if (major * 10000 + minor * 100 + patch < 14300)
-		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for quota,project option, test skipped");
-	pclose(f);
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
 }
@@ -184,7 +175,7 @@ static struct tst_test test = {
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
 	.needs_cmds = (const char *[]) {
-		"mkfs.ext4",
+		"mkfs.ext4 >= 1.43.0",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index a948a30b0..6b9a1db59 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -85,18 +85,9 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	FILE *f;
 	char opt_bsize[32];
 	const char *const fs_opts[] = {"-O encrypt", opt_bsize, NULL};
-	int ret, rc, major, minor, patch;
-
-	f = SAFE_POPEN("mkfs.ext4 -V 2>&1", "r");
-	rc = fscanf(f, "mke2fs %d.%d.%d", &major, &minor, &patch);
-	if (rc != 3)
-		tst_res(TWARN, "Unable parse version number");
-	else if (major * 10000 + minor * 100 + patch < 14300)
-		tst_brk(TCONF, "Test needs mkfs.ext4 >= 1.43 for encrypt option, test skipped");
-	pclose(f);
+	int ret;
 
 	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
 
@@ -129,7 +120,7 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {
-		"mkfs.ext4",
+		"mkfs.ext4 >= 1.43.0",
 		"e4crypt",
 		NULL
 	}
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
