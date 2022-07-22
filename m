Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B4C43334
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 09:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63CB93CA0F0
	for <ltp@archiver.kernel.org>; Fri, 22 Jul 2022 11:27:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 841D43C1BBF
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:27:29 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F4A81000A30
 for <ltp@lists.linux.it>; Fri, 22 Jul 2022 11:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1658482047; i=@fujitsu.com;
 bh=ZHYpgQLd1JU7jUhNSh0J2zUjJ1vvTtf5pBOFRORD/II=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=jzKJ78ojfI76z0Itup1UN6qUCeKJO7gT7g2E0j4DygQeMMqrF16IUGUMoM3wW2kU3
 WJd/Qhxq6r4eHlgXDuOTXYQgzes/mmDKZSskV897ASQtf4DeVcddyRFIRhowEmzkUL
 WF6fxJsw4hasdTKCeNFG9WogSOZpWwpFsP76Y0I6yhJcA8Co9Pw593xR3YENdCBrsy
 cx3DuePKHjCaPSmkgvZFk6MvFFEYTwM13JFUlW0imyzMiWVZmWcmN2HAySXZzTrgUS
 KHmM9zqmZ+Y2X2nNStzm73xZlkdpGwlBsEzc6msMSSnafYa9UHd0hbCCb2U6GBZpl9
 Gtlp6v9dLURXg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8MxSbcu91a
 Swf4z5havD39itFjxfQejxY9bN1gcmD02repk89j3ex2rx5kFR9gDmKNYM/OS8isSWDNe/ecq
 2CpUsXOaYQPjWv4uRi4OIYEtjBLvlr9mh3CWM0l8PXaSDcLZwyjx/vZ6IIeTg01AU+JZ5wJmE
 FtEQEKio+EtO4jNLBAgcfPpIrC4sICtRMPRKawgNouAqsSkU+2MIDavgIfE/lkvmUBsCQEFiS
 kP3zNDxAUlTs58wgIxR0Li4IsXzBA1ihKXOr4xQtgVEq8PX4KKq0lcPbeJeQIj/ywk7bOQtC9
 gZFrFaJ1UlJmeUZKbmJmja2hgoGtoaKprbKRraGSml1ilm6iXWqpbnlpcomukl1herJdaXKxX
 XJmbnJOil5dasokRGLwpxQp1Oxivrfypd4hRkoNJSZS3T/hWkhBfUn5KZUZicUZ8UWlOavEhR
 hkODiUJ3s+ZQDnBotT01Iq0zBxgJMGkJTh4lER41XOA0rzFBYm5xZnpEKlTjMYcV69c2cvMsW
 lf1wFmIZa8/LxUKXHeM9lApQIgpRmleXCDYBF+iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5I
 wrxHIQp7MvBK4fa+ATmECOsXc/AbIKSWJCCmpBiah5GbPhM3ifelbShlbwq5MiTF50PF2Beu6
 sGb17PNnGlbfbo/se/No7SQHuTOz1tXM3rmk3qf06YHow56iq19tC9mycEPoI8vvD318Z8ZLX
 Vn5SMuF8UeiREaYb9/PtW16GQ/8ri6R3fN6u+4DzgDWef7bSp5MdDjnylD7L8Zqn16Z06mSNO
 +Q/5eeu81lqbBYdWbOuvabRYE/RG/Lnq9ZbL6s6E7v+/OC+SYZ3ZJNrzZd/Vv3XMxBdK/qym7
 F8/dFUtILfbf9/Pbh/oZNcWtmc037vyvGSKv+SAnXlAD9Wv64bxPOMVdM2zVRhkNNfMmkp6/l
 UrKm/v+/jDPC/O7eH6bHf0z4zz3TI3qCmtsqJZbijERDLeai4kQAa2ITjWsDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-2.tower-565.messagelabs.com!1658482046!70496!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26576 invoked from network); 22 Jul 2022 09:27:26 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Jul 2022 09:27:26 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 98A991000C2;
 Fri, 22 Jul 2022 10:27:26 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 8B9D9100077;
 Fri, 22 Jul 2022 10:27:26 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 22 Jul 2022 10:27:23 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 22 Jul 2022 18:27:19 +0800
Message-ID: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] syscalls/creat09: Add umask condition
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
this case has been merged into Christian Brauner for-next branch[1].

I guess it will be merged into linux-next branch.

I will add acl and umask test[2][3] in xfstests because there is more suitable
to do this.

Here I just only add umask condition simply.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
[2]https://www.spinics.net/lists/fstests/msg19554.html
[3]https://www.spinics.net/lists/fstests/msg19555.html

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat09.c | 27 +++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index bed7bddb0..04bc98d11 100644
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
@@ -94,8 +104,19 @@ static void file_test(const char *name)
 		tst_res(TPASS, "%s: Setgid bit not set", name);
 }
 
-static void run(void)
+static void run(unsigned int n)
 {
+	switch (n) {
+	case 0:
+		umask(0);
+		tst_res(TINFO, "under umask(0) situation");
+		break;
+	case 1:
+		umask(S_IXGRP);
+		tst_res(TINFO, "under umask(S_IXGRP) situation");
+		break;
+	}
+
 	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
 	SAFE_CLOSE(fd);
 	file_test(CREAT_FILE);
@@ -115,13 +136,14 @@ static void cleanup(void)
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
@@ -132,6 +154,7 @@ static struct tst_test test = {
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
