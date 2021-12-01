Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5970C433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 03:15:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143413C8BDB
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 04:15:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE4763C1810
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 04:15:16 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B760600FA5
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 04:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1638328514; i=@fujitsu.com;
 bh=KndQ9jsj8fD1E+iZb8aipURRdG0Pgoo17/Ccv60BITs=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=d5JAuvPC2q36+Avv4DTLpL7Sx/AfTxKcED1+JM8tyx0aK4snxVkvfopLrwJwAu2iK
 vQpnRMEk9PlkYdmrajuwLrltd/dO9LGgIQ2eIl5YD7leqQ3xfiiOzhNie7uStdIUlQ
 dToh0UH78w3SZyxfTalzqWzXFqe0GkZWkzxHpeW9nkE/AIq/G0d9QcjjtYxGjCsafC
 nGRBrgDfyG8cwUwuctSQKFjnm4FI1xGIwNJNPaIdKXNE5IjPMijxSaUKAjzZlr50qP
 gXFdX5nGZjYXYMCI81FgDK8ndxueky1tcrROTDJB/VoEenA0AkgUI5jK8ikfQHMZJh
 4ta+1apm7PpCg==
Received: from [100.113.7.129] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 0C/27-30139-2C8E6A16;
 Wed, 01 Dec 2021 03:15:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxSffgi2W
 JBlu7eCxWfN/B6MDose/3OtYAxijWzLyk/IoE1owFnZcYC57zVyyb9IOxgXEFbxcjF4eQwFlG
 iZWXNjNBODuZJCacOsgM4exmlHj7fg5jFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 0wgtrBAkMTSa+vZQGwWARWJRy+fgNm8Ah4S1++uAKuXEFCQmPLwPTNEXFDi5MwnLBBzJCQOvn
 jBDFGjKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmM/LOQtM9C0r6AkWkVo0VSUWZ6RkluYmaOrqG
 Bga6hobGuGZCll1ilm6SXWqqbnJpXUpQIlNRLLC/WK67MTc5J0ctLLdnECAzJlEI2rh2MT19/
 0DvEKMnBpCTKm7liWaIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV7NZ0A5waLU9NSKtMwcYHzAp
 CU4eJREeLOeAqV5iwsSc4sz0yFSpxgVpcR5rz0HSgiAJDJK8+DaYDF5iVFWSpiXkYGBQYinIL
 UoN7MEVf4VozgHo5IwbzXIFJ7MvBK46a+AFjMBLX67dDHI4pJEhJRUA1OiZ4N2m+rRcNNv5Yo
 miZzH2E+WH2up5YuavOOFU6m9bO5MJueCivmXfB4rHzx/fEZx0dKFu07syZgzicNPSa5DV0lN
 UnPHzcJPn8NYNZX4vvh81NCqOb9U+BIre+M7e2GJR3f3b2vxWbP8gcKk9zJbdLK5/CvdF6WYc
 z26fDM5rP4bx3ZD80mswsGH9ocv3GQffa9P81iz9Y0v9mu2c35ZPEuQecvpP3HdEiY/1ryU2r
 A24/yOFy9Y8sO9GTJ/BomekHNW6Ul7WHM9OY09NOqP9NcDM1a+1BHfsi9Zp+P9xVeSb/ZvnnD
 cf/vCgz8anJ0akvYqsl6u9fmTz9vGcuLOm9MlXw+yF4nrP9mQ1qbEUpyRaKjFXFScCABlhXQ8
 RAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-238.messagelabs.com!1638328512!589953!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26423 invoked from network); 1 Dec 2021 03:15:13 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-8.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 1 Dec 2021 03:15:13 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A57F11000F6
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 03:15:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 993161000EE
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 03:15:13 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 1 Dec 2021 03:15:00 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 1 Dec 2021 11:15:11 +0800
Message-ID: <1638328511-2534-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statx05, 07: Move e4crypt,
 exportfs to tst_test structure
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

Also remove duplicated e4crypt metadata info in statx05 description.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx05.c | 9 ++-------
 testcases/kernel/syscalls/statx/statx07.c | 6 ++++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index a3184e7e3..a948a30b0 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -10,8 +10,6 @@
  * Test statx syscall with STATX_ATTR_ENCRYPTED flag, setting a key is required
  * for the file to be encrypted by the filesystem.
  *
- * e4crypt is used to set the encrypt flag (currently supported only by ext4).
- *
  * Two directories are tested.
  * First directory has all flags set.
  * Second directory has no flags set.
@@ -110,11 +108,7 @@ static void setup(void)
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
 	ret = tst_system("echo qwery | e4crypt add_key "TESTDIR_FLAGGED);
-
-	if (WEXITSTATUS(ret) == 127)
-		tst_brk(TCONF, "e4crypt not installed!");
-
-	if (WEXITSTATUS(ret))
+	if (ret)
 		tst_brk(TCONF, "e4crypt failed (CONFIG_EXT4_ENCRYPTION not set?)");
 }
 
@@ -136,6 +130,7 @@ static struct tst_test test = {
 	.dev_fs_type = "ext4",
 	.needs_cmds = (const char *[]) {
 		"mkfs.ext4",
+		"e4crypt",
 		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 89de0c487..e1ae36a35 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -135,8 +135,6 @@ static void setup(void)
 	exported = 1;
 
 	ret = tst_system(cmd);
-	if (WEXITSTATUS(ret) == 127)
-		tst_brk(TCONF | TST_ERR, "%s not found", cmd);
 	if (ret)
 		tst_brk(TBROK | TST_ERR, "failed to exportfs");
 
@@ -172,4 +170,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.dev_fs_type = "nfs",
 	.needs_root = 1,
+	.needs_cmds = (const char *[]) {
+		"exportfs",
+		NULL
+	}
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
