Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A36C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:27:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD4E23C88EB
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:27:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06E533C2242
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:27:10 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6428A6005C4
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639380429; i=@fujitsu.com;
 bh=IKA1U55eRctZk7Z1OhAMGtuO8IyzcNE1yaLPaXYbduk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=BqSlemiO/rNmiManRJ6Urg1gggIxECymGwAYliqnrvgtRlvBUUU72j685G21u3YeA
 oiHt6fVmo8TvgAQINnVC0pMRtRhFVwMoFrj/+wuTw2/srERqpRLe10KgjfXfB5evAy
 VKwrKAK2FMcvf732KB1bvkS37+XEFC31ia+9a6AL4n5Qa2S2hnP+j/+tBPxX3cdhSM
 tH+ZgxIf/kCWqShuqzo/cyvEnyq6WcX31xiwLe5qxuOZgVMdaVOsFSyRJXtSffIypF
 095yK7Jt3Dq0va3pM/Oi1eQi5VcgoYuUp3zpCZ5XGbpEr/55KwZwV/WNgZD8Kc9QqR
 t06zudyfBlBJA==
Received: from [100.115.0.27] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id 42/12-10124-DC5F6B16;
 Mon, 13 Dec 2021 07:27:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8ORqHv267Z
 Eg4M7mSxWfN/B6MDose/3OtYAxijWzLyk/IoE1ozGTT2MBYf5KtqWvWFqYNzJ08XIxSEkcJZR
 YsXMIywQzk4miWsbH7JCOHsYJT5cvsvWxcjJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSzgKdH1awdYnEVAVaJ10TkWEJsXKP7x9E6wXgkBBYkpD9+D2ZwCXhLvLtxnBLGFBJIkJr
 TOZoKoF5Q4OfMJC8R8CYmDL15A9SpKXOr4xghhV0jMmtXGBGGrSVw9t4l5AqPgLCTts5C0L2B
 kWsVolVSUmZ5RkpuYmaNraGCga2hoqmuoa2RorpdYpZuol1qqW55aXKJrqJdYXqyXWlysV1yZ
 m5yTopeXWrKJERjGKcWMN3cwtvb91DvEKMnBpCTK+41xa6IQX1J+SmVGYnFGfFFpTmrxIUYZD
 g4lCV6vL9sShQSLUtNTK9Iyc4AxBZOW4OBREuF1BUnzFhck5hZnpkOkTjEqSonzZoEkBEASGa
 V5cG2wOL7EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg3AGQKT2ZeCdz0V0CLmYAWM1ZuBll
 ckoiQkmpg8qoPe7r99OJ4Vd3C3l6WzuDdjRwLd7HYLVi6xutpcnyXT7vB8QfbUjOOXBHOjri1
 3pxDff2z2px1sza+3uFv2SHMe5hDgn3Xe42If8eFTVdbbQg9NOfF0wDOFcfWPOQWZSj8ul//3
 gTrSVftlzZMElv1/wc3zyerLE1tz7pLD3MTo8rnvN/oXHUi6Jus2/UDE9NXbvrxozDu7kbOgM
 tpYfVOq41S/lvGnL2RfjV1roLUz39xtx0qY4p1c8sXymgt9jzoUiUW27snnIUn9cHn22J+YWE
 6yww//zNZX7OiRZhxJ8OqiLkr1tc1sU56uINlk8oqYdUfm8oObNRxUY1a4rqt1PWhUegDs+ir
 xaUqSizFGYmGWsxFxYkAAR2kx14DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-585.messagelabs.com!1639380428!163207!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28077 invoked from network); 13 Dec 2021 07:27:09 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-10.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Dec 2021 07:27:09 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 89D58100248
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:27:08 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 7ECDE10023B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 07:27:08 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 13 Dec 2021 07:26:48 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 13 Dec 2021 15:26:52 +0800
Message-ID: <1639380414-24390-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YY0o7jAxgIHvmczq@yuki>
 <1639380414-24390-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/6] syscalls/quotactl04: Add quotactl_fd test
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
 testcases/kernel/syscalls/quotactl/quotactl04.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index cc107a7e4..44273c35d 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -27,10 +27,10 @@
 #include <sys/stat.h>
 #include <sys/mount.h>
 #include "tst_test.h"
-#include "lapi/quotactl.h"
+#include "quotactl_syscall_var.h"
 
 #define FMTID QFMT_VFS_V1
-#define MNTPOINT	"mntpoint"
+
 static int32_t fmt_id = FMTID;
 static int test_id, mount_flag;
 static struct dqblk set_dq = {
@@ -121,13 +121,16 @@ static void setup(void)
 {
 	const char *const fs_opts[] = {"-I 256", "-O quota,project", NULL};
 
-	test_id = geteuid();
+	quotactl_info();
 	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
 	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
+	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);
 }
 
 static void cleanup(void)
 {
+	if (fd > -1)
+		SAFE_CLOSE(fd);
 	if (mount_flag && tst_umount(MNTPOINT))
 		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
 }
@@ -142,7 +145,7 @@ static void verify_quota(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
+	TEST(do_quotactl(fd, tc->cmd, tst_device->dev, *tc->id, tc->addr));
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "quotactl failed to %s", tc->des);
 		return;
@@ -172,6 +175,7 @@ static struct tst_test test = {
 	.needs_device = 1,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
+	.test_variants = QUOTACTL_SYSCALL_VARIANTS,
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4 >= 1.43.0",
 		NULL
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
