Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8061DC4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 01:59:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B9243C89F3
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 02:59:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8D23C1B40
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 02:59:47 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B85E78FFE70
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 02:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1668995985; i=@fujitsu.com;
 bh=RVYDrRO3h9U0TOBWaHpi6e9QfMXU99R+W+1Q407INew=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=bbsfCLImokn/Jo093xfxQ2VsYMDMXJoKDTzXeT94Og9pZ8HXT0bU1ULmm6MViRbab
 RMkHSr/2V/onlKQuqBTqC0dFc7rS/BxkIK8i0PXMpqpVW1LK6r2kKP7ZZrbmi21/rG
 5vUKinwo+QZvKEb3eQeYLZdqVPSLyJAXIxwm/zBRRnklxlt5asXOksA7P5OnI/3Yyq
 OhF9EKJOc6QOqvP0/c38E2aNPSnULvPc6R6U0vbH0DPnpcaQQBJAPKICxbmdkBhQeY
 sLNnCPQGUgHuBVd6qcje2x36i20OtpjiXpSPndcbH7b4zBYYs48eCxOh8aG5F5g6yI
 Sn3UvyYvueepA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRWlGSWpSXmKPExsViZ8MxSXfi7ap
 kgzc2Fiu+72B0YPTY93sdawBjFGtmXlJ+RQJrxpV7L9kKDnFXvL/VytrAuI2ri5GLQ0jgLKPE
 suu/GCGcA0wSV+6sYYZw9jBKLLjdxtTFyMnBJqAp8axzATOILSIgIdHR8JYdxGYWUJdYPukXW
 I2wQLTEjyUtjCA2i4CqxP6+BSwgNq+Ah8TD93fBeiUEFCSmPHzPDBEXlDg58wkLxBwJiYMvXk
 DVKEpc6vjGCGFXSMyaBXGDhICaxNVzm5gnMPLPQtI+C0n7AkamVYymxalFZalFuuZ6SUWZ6Rk
 luYmZOXqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIGhmFKsarGDcf2yP3qH
 GCU5mJREefe2lycL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuD1v1iVLCRYlJqeWpGWmQOMC5i0B
 AePkgivyn6gNG9xQWJucWY6ROoUozHH+Z379zJzTJ39bz+zEEtefl6qlDjvqetApQIgpRmleX
 CDYPF6iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwr8INoCk8mXklcPteAZ3CBHSKmgXYKSW
 JCCmpBib/nZsYk36srvcRnPSGS2mCuUPnqeIZWff+Pgz7LyShnOfW9m3bPHnD8F7Nh/8XpHwS
 2lDG+8rsbpn1jdhTJ5WkPhg8vf3Equzxksx+Xe2PxVoGq+KvRt6qC0qQOKuxmW+7gPin54KLn
 j+oZjplsufahTWVV1N4avdK3DUp1lNVPbhyyYa6WX+UZ6nVhgWJZzKe9JOc67+nsFJ7jnmrjd
 Wv8vp291NvTmu53bO/5pDEdiKI4yBHiYVvb076FQ9mJrHw7/WXmC1FbimfDj7dl3h5wX7W3X2
 rNl4VeB4xZ5rC4om33E2mxhmfX/tnxi1Ns5c/036VWf/7vXZejwGLX/psrnNcM5hYj7S/3FkR
 eV2JpTgj0VCLuag4EQC5TSW9UgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-548.messagelabs.com!1668995984!188384!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5167 invoked from network); 21 Nov 2022 01:59:45 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-10.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 21 Nov 2022 01:59:45 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B5F681039E3
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 01:59:44 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A919E1039DA
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 01:59:44 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 21 Nov 2022 01:59:43 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 21 Nov 2022 11:00:35 +0800
Message-ID: <1668999635-2018-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/setfsuid: Use SETFSUID instead of setfsuid
 to check 32bit syscall
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
 testcases/kernel/syscalls/setfsuid/setfsuid01.c | 4 ++--
 testcases/kernel/syscalls/setfsuid/setfsuid03.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid01.c b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
index 0cbf101ee..9805e38b6 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid01.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid01.c
@@ -34,8 +34,8 @@ static void run(void)
 	UID16_CHECK(uid, setfsuid);
 
 	SAFE_SETEUID(0);
-	TST_EXP_VAL(setfsuid(nobody_uid), uid, "setfsuid(%d)", nobody_uid);
-	TST_EXP_VAL(setfsuid(-1), nobody_uid);
+	TST_EXP_VAL(SETFSUID(nobody_uid), uid, "setfsuid(%d)", nobody_uid);
+	TST_EXP_VAL(SETFSUID(-1), nobody_uid);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid03.c b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
index 02698f7cf..ee06e9376 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid03.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid03.c
@@ -36,8 +36,8 @@ static void run(void)
 	SAFE_SETEUID(nobody_uid);
 	UID16_CHECK(ruid, setfsuid);
 
-	TST_EXP_VAL_SILENT(setfsuid(ruid), nobody_uid);
-	TST_EXP_VAL(setfsuid(-1), ruid, "setfsuid(fsuid) by non-root user:");
+	TST_EXP_VAL_SILENT(SETFSUID(ruid), nobody_uid);
+	TST_EXP_VAL(SETFSUID(-1), ruid, "setfsuid(fsuid) by non-root user:");
 }
 
 static struct tst_test test = {
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
