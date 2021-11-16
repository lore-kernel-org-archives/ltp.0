Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EC5C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:56:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE8561BF9
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AE8561BF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EBE93C8736
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 08:56:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70C643C12D4
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:46 +0100 (CET)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF9522005D6
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 08:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637049343; i=@fujitsu.com;
 bh=W3XaQDYW3QDwM+4Rm/coFukpsZmkX7YoMCeZEAq284g=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=oXNCCthPsXU6jSt9o4xRYz+xeEwHfG4lPx3/rzSIkW9wtNgqMeU96G50i/LRxCh8k
 BjD1g/2A1kKAh+q0ZTJr/QMh6xfpvIr+8I5Waq9I3gnNSjFOWSv2Dbq2ZTj88dToCe
 7GR+ir9N7UUcIAjwenxbAAhW3R2pZklmRln0NGBK3NJMY2cqVaKC2V88oXUpCLqpB0
 BONijb897wgq4kqkMNexDSfOYGhUgV+I3igSTalMJ5UPajkKzD0bI9HWJ5cZaPEBrK
 4Vamg6FGJJlvWOfF+szkcJ7mdZTgOxv2L9XwNFYi8QWmE/uefFvU6aPqf4rJTh3hQv
 t75zP1EozR8Ow==
Received: from [100.112.195.167] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-a.eu-west-1.aws.symcld.net id A9/A0-02128-FF363916;
 Tue, 16 Nov 2021 07:55:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8MxSfd/8uR
 Eg94/7BYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8aTIytZCw7zVcyYtY2lgXEdTxcjF4eQwFlG
 idXf7rNAODuZJOZ8msAO4exhlGhbdwDI4eRgE9CUeNa5gBnEFhGQkOhoeAsWZxZQl1g+6RdTF
 yMHh7BApMThtRwgYRYBVYmv18+DlfAKeEose/GdFcSWEFCQmPLwPTNEXFDi5MwnLBBjJCQOvn
 jBDFGjKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmM/LOQtM9C0r6AkWkVo0VSUWZ6RkluYmaOrqG
 Bga6hoZGuoaUJEBvpJVbpJuqlluqWpxaX6BrqJZYX6xVX5ibnpOjlpZZsYgQGZErBoQM7GJe9
 +aB3iFGSg0lJlPea9uREIb6k/JTKjMTijPii0pzU4kOMMhwcShK8uYFAOcGi1PTUirTMHGB0w
 KQlOHiURHiXJgGleYsLEnOLM9MhUqcYFaXEeTNBEgIgiYzSPLg2WEReYpSVEuZlZGBgEOIpSC
 3KzSxBlX/FKM7BqCTMG5IINIUnM68EbvoroMVMQIvt7/WDLC5JREhJNTC57BTkbU7j/ZaqpaK
 5lWXGS20+kVOrK79vMHdaNnGnAsud+mr9/c+3XVY6E/jW98yyYw+mT4+M2qEyrWailJT8jX+f
 u/e4vPb12r+CSTt+hqfyY0emons3ZKPP350h2iHSaRSW99B/W23oqTkq4RH23qZORiqbuC/qm
 /TmZuf8PmX3tea3Rv3KSKF/y1de+28mddeqN/eqRG+T4VF/QeEFM90sl7FXzluWLpN5i39Dhc
 u5Wt7FJ+71Kl/dI+9jKvF5kaga8+TVMtr24TwPIg8z25Rpphw4aZAg87Bh08EG++tV5SrMYaK
 MApofOa9KVFdWFrDlljwxNNOrO9rhJmNrprWh1G/pwb/f18k5KLEUZyQaajEXFScCAOXwcrBD
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-267.messagelabs.com!1637049342!1144568!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23968 invoked from network); 16 Nov 2021 07:55:43 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-22.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 16 Nov 2021 07:55:43 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id AA36810046D
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9DDB410044C
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 07:55:42 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.24; Tue, 16 Nov 2021 07:55:20 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 16 Nov 2021 15:55:50 +0800
Message-ID: <1637049352-25731-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] syscalls/statx04: Skip STATX_ATTR_COMPRESSED
 flag when tesing xfs
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

Since STATX_ATTR_COMPRESSED flag are non-supported on xfs, we should skip
it and test three other flags.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index f8350ed2d..6881ce261 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -20,6 +20,9 @@
  * First directory has all flags set.
  * Second directory has no flags set.
  *
+ * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flags, so we only test
+ * three other flags.
+ *
  * Minimum kernel version required is 4.11.
  */
 
@@ -47,10 +50,12 @@ static void test_flagged(void)
 		tst_brk(TFAIL | TTERRNO,
 			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
 
-	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
-		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
-	else
-		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
+	if(strcmp(tst_device->fs_type, "xfs")) {
+		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
+			tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
+		else
+			tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
+	}
 
 	if (buf.stx_attributes & STATX_ATTR_APPEND)
 		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
@@ -135,7 +140,10 @@ static void caid_flags_setup(void)
 		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
 	}
 
-	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
+	if(!strcmp(tst_device->fs_type, "xfs"))
+		attr |= FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
+	else
+		attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
 
 	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
 	if (ret < 0) {
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
