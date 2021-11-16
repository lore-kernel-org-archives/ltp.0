Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDCC433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:55:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1861BF9
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1C1861BF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3418E3C87BB
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:55:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2D03C12D4
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:45 +0100 (CET)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B32541000F7B
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637049343; i=@fujitsu.com;
 bh=VRckQBFp2K749iplHGsgwUYDaI24cvGGZGV8L7UkXFk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=sgtyoqYHp/3sUw7ASZyhjPMEwiZYIRNDplJdPhxHdzTf2Y9cGgv1wtpHZaywARRJk
 aZKXjajlKD6BX1lDS1skNO/34sGHIuXACOlscZcKTMDH6pjeeUEGIRZk+Lkf1Njf7A
 /d4dnu7naa2+92tDq731QfMDXReaYb+PFI/3cs+3//VnQYSn3cjWdztMCYt+Mm+8PS
 3ZrJeycYUbPJsZgiVWyTIpbbDqlI81Hu1Xwmor/oXIshHCZeQdw2Cdq99fHpJnrLjR
 kSlQIfoev8cfxybz643d5rTE926LBNu1Elr19eabr+FphcggUD3HQ1YTRxHq68/znT
 Q70nQj7uN/JxA==
Received: from [100.113.7.62] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-central-1.aws.symcld.net id E3/66-01506-FF363916;
 Tue, 16 Nov 2021 07:55:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRWlGSWpSXmKPExsViZ8MxSfd/8uR
 Eg+VveSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oyHf1ezFDRJVixeOJOlgXGtSBcjF4eQwFlG
 iRW77zNCODuZJO6vX8AG4exhlHjx7xNLFyMnB5uApsSzzgXMILaIgIRER8NbdhCbWUBdYvmkX
 0wgtrBAhMTLhldsIDaLgKrEg4/zGUFsXgFPidWrp7CC2BICChJTHr4Hm8Mp4CVxcO8XsBohoJ
 qeQ1fYIeoFJU7OfMICMV9C4uCLF8wQvYoSlzq+MULYFRKzZrUxQdhqElfPbWKewCg4C0n7LCT
 tCxiZVjFaJhVlpmeU5CZm5ugaGhjoGhoa65rqGhkY6iVW6SbppZbqJqfmlRQlAmX1EsuL9Yor
 c5NzUvTyUks2MQKDOKWQ9eQOxklvPugdYpTkYFIS5b2mPTlRiC8pP6UyI7E4I76oNCe1+BCjD
 AeHkgRvbiBQTrAoNT21Ii0zBxhRMGkJDh4lEd6lSUBp3uKCxNzizHSI1ClGRSlx3kyQhABIIq
 M0D64NFsWXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzhiQCTeHJzCuBm/4KaDET0GL7e/0
 gi0sSEVJSDUyWQfvLfp4W96qwWFJ+bmtBxdHjqmkOsftL7xs+DmTc26cWkbvJ3+D0kQ2O+8NO
 XlTujZM8L/I3n+/kbbEKdfGjBmpbwuRSvtz990C2RVGfL+ppd+6VJcHTSz8eUrJccmJWPOuGf
 fdKQq7+WsDab9rwzjDj2Y/Xf4Tc3+us//RoRU6J8+lfPnasx38cWS3P4nqHX+3Xu6prm1mbA7
 k+zzwUv/6dxATev2k3P+yfJXDsxt7H+xb0T9K7pOR198/K3VP++G/cu2DeXYltL774Fq45bbm
 BdcfcFTJeE32VPSftOLbbXHGJ54zQVr0ztvoTp375xCoX9LXBdNLNjvrfDQod7R2rZngebS7U
 6bC4u13UWYmlOCPRUIu5qDgRAMqZvEJdAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-248.messagelabs.com!1637049342!966782!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7295 invoked from network); 16 Nov 2021 07:55:43 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-248.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Nov 2021 07:55:43 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id ADA42100470
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A0D02100456
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 16 Nov 2021 07:55:23 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 16 Nov 2021 15:55:51 +0800
Message-ID: <1637049352-25731-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] syscalls/statx04: remove btrfs kernel version
 and add linux tags
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

Also add docparse formatting.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 54 +++++++++++++++++------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 6881ce261..a51891311 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -4,25 +4,50 @@
  * Email: code@zilogic.com
  */
 
-/*
- * Test statx
+/*\
+ * [Description]
  *
  * This code tests if the attributes field of statx received expected value.
  * File set with following flags by using SAFE_IOCTL:
- * 1) STATX_ATTR_COMPRESSED - The file is compressed by the filesystem.
- * 2) STATX_ATTR_IMMUTABLE - The file cannot be modified.
- * 3) STATX_ATTR_APPEND - The file can only be opened in append mode for
- *                        writing.
- * 4) STATX_ATTR_NODUMP - File is not a candidate for backup when a backup
+ *
+ * - STATX_ATTR_COMPRESSED: The file is compressed by the filesystem.
+ * - STATX_ATTR_IMMUTABLE: The file cannot be modified.
+ * - STATX_ATTR_APPEND: The file can only be opened in append mode for writing.
+ * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
  *                        program such as dump(8) is run.
  *
  * Two directories are tested.
- * First directory has all flags set.
- * Second directory has no flags set.
+ * First directory has all flags set. Second directory has no flags set.
  *
- * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flags, so we only test
+ * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
  * three other flags.
  *
+ * ext2, ext4, btrfs and xfs support statx syscall since the following commit
+ *
+ *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
+ *  Author: yangerkun <yangerkun@huawei.com>
+ *  Date:   Mon Feb 18 09:07:02 2019 +0800
+ *
+ *  ext2: support statx syscall
+ *
+ *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
+ *  Author: David Howells <dhowells@redhat.com>
+ *  Date:   Fri Mar 31 18:31:56 2017 +0100
+ *
+ *  ext4: Add statx support
+ *
+ *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
+ *  Author: Yonghong Song <yhs@fb.com>
+ *  Date:   Fri May 12 15:07:43 2017 -0700
+ *
+ *  Btrfs: add statx support
+ *
+ *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
+ *  Author: Darrick J. Wong <darrick.wong@oracle.com>
+ *  Date:   Fri Mar 31 18:32:03 2017 +0100
+ *
+ *  xfs: report crtime and attribute flags to statx
+ *
  * Minimum kernel version required is 4.11.
  */
 
@@ -160,9 +185,6 @@ static void setup(void)
 	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
-	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
-		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
-
 	caid_flags_setup();
 }
 
@@ -190,4 +212,10 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_POINT,
 	.min_kver = "4.11",
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "93bc420ed41d"},
+		{"linux-git", "99652ea56a41"},
+		{"linux-git", "04a87e347282"},
+		{"linux-git", "5f955f26f3d4"},
+	},
 };
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
