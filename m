Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B25ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 07:12:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946DA3CABD5
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:11:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46FAC3CAAEF
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:46 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBD8C1401246
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 09:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1663139504; i=@fujitsu.com;
 bh=gJx8zQDvNQyneyaNvvFjBISaUiyHeUXtWphaeGbhRUA=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=D4dz4CfPA1SjsxyI3pjlfGzTtnHMN3OUW+OS2za7YoyBRVgYXzDk7Ka+kW8nfickY
 x4Yc+Wiug7OfhivQNKpq4ILT3Nlqafy8PLbJKGJbxkUpURe85s/j1KLXbkr6TL1Lu3
 dOqVkZ7617FGaHoDmN697qSWWPnm1f6MpgCsIWag5HCLAMEoQ5fhzWkQ+UIKj7DduH
 66dP364Zsi7UU3G37x0isfqbfoLayXSISp0C4X55bwV101JA/Q8gNEih9AG2YNeknv
 4gsYIqmElmfT9cCfDJIDgfGrWzSrifHbtegA/hYowP5mJO3JphDcNyPR+SM2/pdOei
 Nse66TOFAk4fA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsViZ8OxWXdDnWK
 ywcpZvBavD39itJj+4iibxYrvOxgdmD02repk89j3ex2rx5kFR9gDmKNYM/OS8isSWDP6f59h
 LLgjXNF76jd7A+MWgS5GLg4hgY2MEjs+HmSEcBYzSbx4848ZwtnDKHFh2g2gDCcHm4CmxLPOB
 cwgtoiAhERHw1t2EJtZIFDizLEOVhBbWMBJouPhCbA4i4CqxN9975lAbF4BD4n1f++A9UoIKE
 hMefieGSIuKHFy5hMWiDkSEgdfvICqUZS41PGNEcKukGicfogJwlaTuHpuE/MERv5ZSNpnIWl
 fwMi0itE2qSgzPaMkNzEzR9fQwEDX0NAUSBvrGpoY6SVW6SbqpZbq5uUXlWToGuollhfrpRYX
 6xVX5ibnpOjlpZZsYgQGcUpxet8Oxo37fukdYpTkYFIS5f3wVSFZiC8pP6UyI7E4I76oNCe1+
 BCjDAeHkgTvjlrFZCHBotT01Iq0zBxgRMGkJTh4lER4J+UDpXmLCxJzizPTIVKnGI05rl65sp
 eZY9O+rgPMQix5+XmpUuK8j6uBSgVASjNK8+AGwSL9EqOslDAvIwMDgxBPQWpRbmYJqvwrRnE
 ORiVh3ikg9/Bk5pXA7XsFdAoT0ClG1vIgp5QkIqSkGpimPDO84tLfcj4ljdF5v42n7sfLcgeq
 r//4t4fNov9jLh9HxpYn0804mj1STq5mvdTj7Vls/OZiaADjg9eXDCZGamuzOMz/m8oU5MDQ+
 fa5YoZWT23+fAfNaTN2dwUsY3go5B2f/5rJYxann9Gzv8GNAr9YXjSnb7+2P71bpjz70oTJ7W
 am960nH01iS7a8ejeIjfUok0yI4I+7YaeXPZmv+1vvCf+nVTJaR7tO3f9y3Gma8afTH1/Xf1t
 lwb+cY8HBkhzP7/Mv/gjkbgoznm5Q3HUls7hcwfzpa33D68ubV9g+4jZd/7+A2ceMW5lrc+Kj
 J98+5i3Z/Xb2FZtQ1dNHztp0/o01FVsnsFTuv7YSS3FGoqEWc1FxIgCADOO7bwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-732.messagelabs.com!1663139503!375384!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15263 invoked from network); 14 Sep 2022 07:11:44 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-4.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Sep 2022 07:11:44 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 9BEFF142;
 Wed, 14 Sep 2022 08:11:43 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 8E9CB7B;
 Wed, 14 Sep 2022 08:11:43 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 14 Sep 2022 08:11:41 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Sep 2022 16:12:20 +0800
Message-ID: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
