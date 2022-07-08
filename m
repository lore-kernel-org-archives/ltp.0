Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4D2C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 01:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB7A73CA304
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 03:57:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AAD13CA2C1
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:56:55 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2AC702003A8
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 03:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1657245413; i=@fujitsu.com;
 bh=AwoZlN4HWZ3WLyc2Yazbd8eg7Q8NQr0j6VtPK3gFRpo=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=HHL4aPddurFx63YJCac6AgtQ7EalaQ2JhymPjaFa7y9brArS7USUgO6TkVtQCqXVW
 /RThkF5TzT5NkekSF1JfjcPchxabvmq2tDcPVdMXSi7FTEouvJrkjNlgKxumRfjd4h
 1t/Uwx7AkpnD+jd4hvQDAQSzAlF0hGCgV6ftpBo+TFqtGtMC07D7VLeUzeG6yEOoH5
 8fsDgg3bhTQbF0AqHdeIhKUCo8Ok0tSuR130P5Y+4Gw3V5VOinEzTPWPXENNuQJvMA
 NbZ/SCUYBV/mR6hx+UgOzuIzL9K/uDr0r4optxQx3dS+dlx25/Usm3MDgE8TQdAUNe
 cdXEwgaKfaxAw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8ORqPuk73i
 SQXu2xYrvOxgdGD32/V7HGsAYxZqZl5RfkcCacWmpd0Efa8W7ng3MDYz7WLoYuTiEBM4ySkw4
 /4Sxi5ETyDnAJLFvUSREYjejxJGj58ESbAKaEs86FzCD2CICEhIdDW/ZQWxmAXWJ5ZN+MYHYw
 gK+En/PLgWLswioSGzasR8szivgKbHv2U6wORICChJTHr5nhogLSpyc+YQFYo6ExMEXL5ghah
 QlLnV8g6qvkHh9+BJUXE3i6rlNzBMY+WchaZ+FpH0BI9MqRuukosz0jJLcxMwcXUMDA11DQ1N
 dYwsgZaiXWKWbqJdaqlueWlyia6SXWF6sl1pcrFdcmZuck6KXl1qyiREYkinFavk7GP+u/Kl3
 iFGSg0lJlDen6XiSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQleLWCQCwkWpaanVqRl5gDjAyYtw
 cGjJMLL0giU5i0uSMwtzkyHSJ1iVJQS57UB6RMASWSU5sG1wWLyEqOslDAvIwMDgxBPQWpRbm
 YJqvwrRnEORiVhXpNuoCk8mXklcNNfAS1mAlq8LP8IyOKSRISUVAPTBP0rjPETlWtd3W8nLD5
 SueDct+erhZ9kvlkrFP+L/97zLWz7XBpnGf3sLnzyl+nvqiu7zlSUHzh8NuviSa83l3aU5Ip0
 2jOXervHNs278lU2KHPlzzsVE6/oWcdpa3D1ab0/G8CyZfPbmWc0DzJ7Xdm6JWvSij2xQXe/1
 dV2xva6fLWcOmvblP6krhczc3412XpU7jtyKmrLr5PVs+8w6H7bb9w7ef2EfWdYa/Knrw0Ld9
 fWFVW4lrOJZXGDgY/iiYefJux5OEGrn/0V61fDzO6yD6/3lq2c9HZLRGZrnOq7A5wz9QwaFmw
 OcOqeP0HH+7pQ1ZsPlxilhLZabEmZ4hVYFCmvvJfJ+vKr+apmYkosxRmJhlrMRcWJANQOtyBE
 AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-18.tower-548.messagelabs.com!1657245411!38425!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23391 invoked from network); 8 Jul 2022 01:56:52 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-18.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 8 Jul 2022 01:56:52 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id B4AC6100192
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 02:56:51 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A6928100043
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 02:56:51 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 8 Jul 2022 02:56:49 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 8 Jul 2022 10:57:42 +0800
Message-ID: <1657249062-15678-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] mountns04: Use needs_tmpdir instead of
 needs_checkpoints
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

We don't use TST_CHECKPOINT_* api, so using needs_tmpdir is enough.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/containers/mountns/mountns04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
index 46937ddcd..fc392f1a7 100644
--- a/testcases/kernel/containers/mountns/mountns04.c
+++ b/testcases/kernel/containers/mountns/mountns04.c
@@ -60,5 +60,5 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 	.needs_root = 1,
-	.needs_checkpoints = 1,
+	.needs_tmpdir = 1,
 };
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
