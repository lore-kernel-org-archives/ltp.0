Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3E8C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 03:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 601853C79E7
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 04:21:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 582AC3C2FE8
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 04:21:29 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B20151A01456
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 04:21:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639020087; i=@fujitsu.com;
 bh=Xxk8w2mR+TdootXMvFz2VQBBXwbOmfXc3pSGWWNClls=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=puPn2SN5Js3yqigMgtJniulEgTy/B3wfThMpysfa5792/bogxDxRFUyilBTaWPN2v
 fRpOTxMnr036J58vm5x9sje5BofIsSLWsIi8N8mv7yVkM9WoWcQn7N+th1NEDt23R5
 NbxQzMptgddez4Vo/ngQfPPna60IUrJGOIH7VjWnEyJAHBZjZfBgqO84gmaJKvJkjg
 xrDm0SbFMTMmqzosA2ONOrBTpfgL86Nm9BuL8IEHlGrB6ENgcDae/2l/Ul6wTpDbHk
 Yho/Bj9MM1x+DeNkT81Cw0gMsPF20BrD4allQg+J+jOg1u4GtJdZWPxmEH/PMecGiG
 wKiFWj8cF410w==
Received: from [100.115.34.229] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 7E/1A-16537-73671B16;
 Thu, 09 Dec 2021 03:21:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsViZ8ORqGtetjH
 RYMkEAYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePHkelsBZeEK952HGBpYLwg0MXIxSEkcJZR
 YuLW9WwQzk4miZ1986Gc3YwS99afYuli5ORgE9CUeNa5gBnEFhGQkOhoeMsOYjMLqEssn/SLC
 cQWFnCV+DR1BVg9i4CKxOmjv8HqeQU8JHbOeQoWlxBQkJjy8D1YnFPAU2LPtj9gcSGBJImjdy
 exQdQLSpyc+YQFYr6ExMEXL5ghehUlLnV8Y4SwKyRmzWpjgrDVJK6e28Q8gVFwFpL2WUjaFzA
 yrWK0TirKTM8oyU3MzNE1NDDQNTQ01TU20zU0t9BLrNJN1Est1S1PLS7RNdJLLC/WSy0u1iuu
 zE3OSdHLSy3ZxAgM5JRilU07GH9c+qZ3iFGSg0lJlJeVc2OiEF9SfkplRmJxRnxRaU5q8SFGG
 Q4OJQlegxKgnGBRanpqRVpmDjCqYNISHDxKIryiIGne4oLE3OLMdIjUKUZFKXHeFyAJAZBERm
 keXBsski8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuYNKQWawpOZVwI3/RXQYiagxc4t60E
 WlyQipKQamCxZOhhF0k4ruzouellnHLlxQUrnGq0VpxPW/N+k6rdjfs2sm2ffSZw6usrrgMhe
 3pfxx+8lmTxlzecyrXO7ueC7/4kvr4PeZBzlmd6384+h3hvLKfcn21nw3FVQ6Ep+3p26o+P/j
 APvfjhUVf49LMTjs++D0gGNGXuau0Vd83M05roL70jM7tRhutau9G3WLa6Wy2ceJ17+4eG/a3
 WR9uVZM1KydrqwW4dcqy2bc7P3t8WP/U3vLgYpMxS3lKwLK1N9andcX1TmtIEV48Vjt/azZi3
 li3FnZtzpaxI11+zhf+4nQZ2X0mPUQuaetLiykstXzcL2/5RL3iF9aRums8Wozauv+Bqa7aNl
 v/jvGyWW4oxEQy3mouJEAPP6ZGRfAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-571.messagelabs.com!1639020087!28718!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31248 invoked from network); 9 Dec 2021 03:21:27 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 9 Dec 2021 03:21:27 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id E2CBE100249
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 03:21:26 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id D7119100244
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 03:21:26 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 9 Dec 2021 03:21:03 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 9 Dec 2021 11:21:08 +0800
Message-ID: <1639020068-2198-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YbDl7YtVZvYXPxwp@pevik>
 <1639020068-2198-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] testcase: make use of needs_cmd version check
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
index 86bd3ace1..bdee98c22 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -87,18 +87,9 @@ static void run(unsigned int i)
 
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
 
@@ -132,7 +123,7 @@ static struct tst_test test = {
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
