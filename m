Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85469C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 07:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2EB3C9AEA
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 09:57:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E5A73C0595
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 09:56:59 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA0F5140032C
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 09:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1648454216; i=@fujitsu.com;
 bh=UTPfBuzK95h4BuzAkariqrqRczomHEkZjsMNkfL9bIk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=qoV/iltS0qESKI5RPLFmOK5xUSvvgF56OWuupXema1t5xfaWLXHF+7DLbDuVmoozx
 M4w3oF8nnX4GwyfMnwzkLbZE+ss3f4TzhmMwhhG9k8pblr5Cn6pYoJKOQ/uVAvld9P
 Gen5+RpjRkFC5Ije71wBwcEL49LmU1C0xep0bb23ACgQXp++mzntqmyQHAI4SLTqHn
 wgCwDAlajEu8kF1AC+U9aZOvEOfn763mMaNHJATWJMnJYtkBQQhXyDzZMAFTJ5UTmE
 uH3RcTR9k1ldrXvwSZbvYEgtlbSaAmygmUiowqaqNyWp93k3iS7LB+J/O69udrmlTj
 PLOFLko5rdjpA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRWlGSWpSXmKPExsViZ8MxRdcjyzH
 J4PQ2AYsV33cwWvy4dYPFgclj3+91rB5nFhxhD2CKYs3MS8qvSGDNOH3lMGvBEs6KRVu+szYw
 3mXvYuTkEBJ4zSjx+11mFyMXkL2fUeL51VfMIAk2AQ2Ja4/bwWwRAXmJvROawWxmAT+JZXums
 4HYwgIBEif/XAUbxCKgKjFn4QWwOK+Aq8TF6wdZQGwJAQWJKQ/fg/VyCmhLtLX0MEEs1pKYvv
 coVL2gxMmZT1gg5ktIHHzxghmiV1Fi/96NjBB2hcSMGdvYJjDyz0LSMgtJywJGplWMlklFmek
 ZJbmJmTm6hgYGuoaGprrGuhZmeolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZsY
 gUGaUswctoPxT+9PvUOMkhxMSqK8aiUOSUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeE+nOyYJC
 RalpqdWpGXmACMGJi3BwaMkwvsSJM1bXJCYW5yZDpE6xagoJc7rmQGUEABJZJTmwbXBovQSo6
 yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe3DSgKTyZeSVw018BLWYCWrz2nS3I4pJEhJRUA1P
 tgi39cVOXMhxKnSEX7rHZwfPaU8HGKaV8fos0pDyv+Zx7FiPGee2mreQOjqkevhe+1qVbC9S7
 sD/7XPm9zFOnU196si1j8FfPXVeYnXxfqCl89ih/xfxK98vEYp7wiAm6modVuDe5asuf0Nors
 36O779DBQefB6ne3CE04XN49f+lrxa8zT9pfURgf89W6/+RF+XVprBxdjgLp2zwzP3EJh+l5h
 l9UuTGZcFbJwrE7GJjmg+u4nfce8f06iu/j1wZPA0rHkb2HVI8yHMpIuJS06IFCkcnZb+Y8D9
 R3jMrxq1t8b3bAje929fZWqt3zRf9nBAQ78wSZlspufKMzKK0juuL3TZyeEu2Lq24rMRSnJFo
 qMVcVJwIAEPZkTZNAwAA
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-17.tower-591.messagelabs.com!1648454215!153166!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5942 invoked from network); 28 Mar 2022 07:56:56 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
 by server-17.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 28 Mar 2022 07:56:56 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
 by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 22S7ufXx030104
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
 Mon, 28 Mar 2022 08:56:48 +0100
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 08:56:39 +0100
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <xuyang2018.jy@fujitsu.com>
Date: Mon, 28 Mar 2022 15:56:12 -0400
Message-ID: <1648497372-9371-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <62414819.2010802@fujitsu.com>
References: <62414819.2010802@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/umount2_02: use umount2 directly instead of
 TEST macro
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is no need to use TEST macro in umount2_retry(),
because we have used it in TST_EXP_FAIL and TST_EXP_PASS macro.

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/umount2/umount2_02.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 4c3b30e..b23f37b 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -53,12 +53,12 @@ static struct tcase {
 
 static int umount2_retry(const char *target, int flags)
 {
-	int i;
+	int i, ret;
 
 	for (i = 0; i < 50; i++) {
-		TEST(umount2(target, flags));
-		if (TST_RET == 0 || TST_ERR != EBUSY)
-			return TST_RET;
+		ret = umount2(target, flags);
+		if (ret == 0 || errno != EBUSY)
+			return ret;
 
 		tst_res(TINFO, "umount('%s', %i) failed with EBUSY, try %2i...",
 			target, flags, i);
@@ -69,7 +69,7 @@ static int umount2_retry(const char *target, int flags)
 	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
 		target, flags);
 
-	TST_ERR = EBUSY;
+	errno = EBUSY;
 	return -1;
 }
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
