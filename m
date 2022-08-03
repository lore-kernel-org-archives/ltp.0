Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5461C00140
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 02:24:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D6F63C92BD
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 04:24:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C26B53C2730
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 04:23:57 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 26DEF1A006B0
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 04:23:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1659493434; i=@fujitsu.com;
 bh=5yvv3FIhBSp/9XIZTa51qEgYjCkb6Dqa+/uP7MBIAjw=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=U+OAH5wpOqLtKLN3CSl0XznXuMSVDFLUeYgEoM3OBmYip3+QluVv+F9TSjFUoG8kC
 mX0KyzL8vyoyE32UWkp/TUIsm8W4If17E90OSuiMXMUBXTCLA1uriEP4M7+XlQ6hhr
 SIDtv0dT3E/W1hPrpO/3UpRBSZsSO3EL1yelkfW+w/gZXoK1/ax8G5tE7v7G6mMRRB
 s/WA9QCziEMtrGyvACRVOv7DVggt99Z1Bs32DnUbHeIAFXeyZ2O/Tlvv0BQzM56BDs
 ijUutn2Cwk7oZE8N3ufnUETItOGuvuoCLbhrQ5dAc5E51gOBH2LFt5IuFALxKqsV+m
 8ALVrHem2PrXQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsViZ8MxSdfyzss
 kg92LDCxeH/7EaLHi+w5Gi8N/j7NY/Lh1g8WBxWPTqk42j32/17F6rN9ylcXjzIIj7AEsUayZ
 eUn5FQmsGa+XrGAsaBaqWD4ltoGxk7+LkYtDSGALo0T3w+OMEM5yJolfP5cAOZxAzm5GiZubz
 UFsNgFNiWedC5hBbBEBCYmOhrfsIDazQJbE62mvWEFsYQEniZnT/oPZLAIqEivbTzGB2LwCHh
 IPF3aAxSUEFCSmPHzPDBEXlDg58wkLxBwJiYMvXjBD1ChKXOr4xghhV0i8PnwJKq4mcfXcJuY
 JjPyzkLTPQtK+gJFpFaNlUlFmekZJbmJmjq6hgYGuoaGprrGuhZleYpVuol5qqW55anGJrqFe
 YnmxXmpxsV5xZW5yTopeXmrJJkZgMKcUM4ftYPzT+1PvEKMkB5OSKG9Q1cskIb6k/JTKjMTij
 Pii0pzU4kOMMhwcShK8m28C5QSLUtNTK9Iyc4CRBZOW4OBREuGddxsozVtckJhbnJkOkTrFaM
 xx9cqVvcwcm/Z1HWAWYsnLz0uVEudtAykVACnNKM2DGwSL+EuMslLCvIwMDAxCPAWpRbmZJaj
 yrxjFORiVhHmZQKbwZOaVwO17BXQKE9ApOlwvQE4pSURISTUwpb1c9C/xzwmfvZOKfPf//Sac
 Y3bXz7XsyBUdw5fBM2bN5L150+HUzjr3bzGB9yby8v6YIm1390f3jk38Kn8Feu/cvDD7cq7S6
 /q/U2/ZJ7XmHzaydlqv5HTEKlCHJaM9x8OP7afg4tx5M0SUvnTkKq98uGbGoa/7shWur+zj/r
 6BM7R/KUvHFs2AzxxtK/vP7xW8v+lqxq+Yyj7mCb0+t7en9bp4cb/cGclz/ZTs2c+zmmdM1nl
 26+an6V6PWEOK3k/MUPk0ISK5+ZrNp6MO3/aZTNqeJFCicJXTJdR7ze2EtLPNJ2VP6YSw+FWV
 3WsS+n/y7D/v69LHK+wUjvj/Waj1eFHVjE0bziZvbO8+PUuJpTgj0VCLuag4EQAo2L65cwMAA
 A==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-20.tower-587.messagelabs.com!1659493433!172262!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7843 invoked from network); 3 Aug 2022 02:23:53 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-20.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 3 Aug 2022 02:23:53 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 649391000E9;
 Wed,  3 Aug 2022 03:23:53 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 567DB100077;
 Wed,  3 Aug 2022 03:23:53 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 03:23:50 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 3 Aug 2022 11:24:22 +0800
Message-ID: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] syscalls/creat09: Add umask test condition
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
Cc: brauner@kernel.org, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
this case has been merged into linux-next branch[1].

I will add acl and umask test[2] in xfstests because there is more suitable
to do this.

Here I just only add umask test condition simply.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220802&id=1639a49ccdce
[2]https://patchwork.kernel.org/project/fstests/list/?series=662984

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v1-v2:
1.update linux-next and xfstests url
2.use Ternary Operator instead of switch or if
 testcases/kernel/syscalls/creat/creat09.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index bed7bddb0..7077cbcff 100644
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
@@ -94,8 +104,11 @@ static void file_test(const char *name)
 		tst_res(TPASS, "%s: Setgid bit not set", name);
 }
 
-static void run(void)
+static void run(unsigned int n)
 {
+	umask(n ? S_IXGRP : 0);
+	tst_res(TINFO, "under umask(%s) situation", n ? "S_IXGRP" : "0");
+
 	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
 	SAFE_CLOSE(fd);
 	file_test(CREAT_FILE);
@@ -115,13 +128,14 @@ static void cleanup(void)
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
+	.tcnt = 2,
 	.skip_filesystems = (const char*[]) {
 		"exfat",
 		"ntfs",
@@ -132,6 +146,7 @@ static struct tst_test test = {
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
