Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3690ECAAD1
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 03:56:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7820F3CA8B0
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 05:56:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D4E3CA070
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 05:56:44 +0200 (CEST)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA3EE1000654
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 05:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1662004602; i=@fujitsu.com;
 bh=q/dRLf6z6seorrDYAq3BchWQ/yLk51u5P4IEIctla0Q=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=YbzRNXjTjYjTP4VvAwi2vNw8zdHPTuXSEzGvNmTckewoZZgyJgvWC2Q0/3VjULgVJ
 zy0Qg6mmQHHzQC0xVSmBRkOMw+s1RR26EV78GsTC3UiAN0y6nPHAN73mWaRpZdCEDZ
 Xut8mre0fo7A5cyRFeQXqv8CZjgV5W3MZsPsXUtxe/HyNIGuRyjlyHF8YD3SRR0nol
 +r0Egq+rSbHr7sJerXgE63UzkNI4dntcj2O9v0dZq1UrplqrVhP7P8Jrjex9KJhwff
 WcrK7H0Cqq3Loq5m3RShwfwMBL5sTliUJBKjkO/OGQb9Ou6keKZlT8awEkjNqNH/J3
 faMYrieQkw1ug==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRWlGSWpSXmKPExsViZ8OxWbdKVyD
 ZYL21xYrvOxgdGD32/V7HGsAYxZqZl5RfkcCaMWnuKcaCr2wVZyafY2pgfM/axcjFISRwklHi
 9IVmKGcvk8SZF2+gnD2MEss6twI5nBxsApoSzzoXMIPYIgISEh0Nb9lBbGYBdYnlk34xgdjCA
 g4S3xufsoHYLAIqEi/OHAazeQU8JN6dmw5WLyGgIDHl4XtmiLigxMmZT1gg5khIHHzxghmiRl
 HiUsc3Rgi7UqL1wy8WCFtN4uq5TcwTGPlnIWmfhaR9ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0N
 TXSBpZKyXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREYlCnFDNU7GP/3/tQ7
 xCjJwaQkytuvI5AsxJeUn1KZkVicEV9UmpNafIhRhoNDSYJ3hTZQTrAoNT21Ii0zBxghMGkJD
 h4lEV43kDRvcUFibnFmOkTqFKOilDivCchMAZBERmkeXBssKi8xykoJ8zIyMDAI8RSkFuVmlq
 DKv2IU52BUEuaNBJnCk5lXAjf9FdBiJqDF02fygywuSURISTUwhXnUnzjHFpyd8+afD+9xT7f
 wm8FPEg2v8LGXsLz9mNbx1zy/SMrsDKvUhOV3Mo/cUKvPkY//xPhye8SGl8dOqk25I3HxywmL
 UBaDcPYVogvunlZI28b7+urGyTfbYo585HFuT63cwcwmcvfpev+bpbKPFsg7HhGUZbtRncDIc
 bHqpl2E1Tlni49T9q6TcxddVRl44ZPSLRNtgfrULY+Pbg4vuLpi/5UDlf9unBGcI+4a+JTZQf
 TMgoSpde9+8rEFb7jqozuxP5pDfeuy7x23ZB9/40u9rPrWeJeWe2lTSPw83/VN4o9/Kzuu+HJ
 n/jLxg2veFPes8/plKe+jHOHteeTDy7Qq28/LtZZttDtRr8RSnJFoqMVcVJwIAGVsMZ9FAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-587.messagelabs.com!1662004601!703940!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21411 invoked from network); 1 Sep 2022 03:56:41 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
 by server-10.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 1 Sep 2022 03:56:41 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 9F8FB7B
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 04:56:41 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223
 [10.182.185.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 9396073
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 04:56:41 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 1 Sep 2022 04:56:39 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Thu, 1 Sep 2022 12:57:29 +0800
Message-ID: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] README: Add missing configure in openposix step
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

Since 8071ba7("openposix: Setup autoconf and fix installation layout")
, we need to use configure firstly.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 README.md | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index d45d1ee44..d0ca5f4d4 100644
--- a/README.md
+++ b/README.md
@@ -79,11 +79,13 @@ $ cd ../commands/foo
 $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
 ```
 
-Open Posix Testsuite has it's own build system which needs Makefiles to be
-generated first, then compilation should work in subdirectories as well.
+Open Posix Testsuite has it's own configure and build system which needs
+Makefiles to be generated first, then compilation should work in subdirectories
+as well.
 
 ```
 $ cd testcases/open_posix_testsuite/
+$ ./configure
 $ make generate-makefiles
 $ cd conformance/interfaces/foo
 $ make
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
