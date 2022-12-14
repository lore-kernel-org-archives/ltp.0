Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D6C4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 10:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 321C93CBD1F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 11:45:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE5213CBD63
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:50 +0100 (CET)
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com
 [195.245.230.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BEB2260063B
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671014688; i=@fujitsu.com;
 bh=OoEAQe8z8B2DMzg+O0ctopCnZGQfmwXMxYFaQj+8Ln0=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lk5YwU/8XsGs5HLf307tbTAdRVVQZw2W7MGPMC0GCNFByBM9QDylI4DkcHVCxbI/w
 5LiFu1Sm2f73VLJvcYoLSL3OjHFyU6ov9xb4yYU+fDrpffpYMCG2AHk/kRFXUChkZx
 jbovgFbB3mZCtYzYk82lkNB3Hr1UrKa6KfzlSsySr9F0mbQKWyl+cRmKSZCQ++2ljI
 SVWvPoF9SLfdLSG0inq6jPr0m62IM/4qV7UKZUDhpdbVxRH8jt04crG9OTQ7cGcdVE
 ngh6zBZLPt+MLzEIMOrnveVZUG7xZwXciFZZ6c+NzbQW9CRQfluWVWNSQFM12QQNWg
 jAHIrVunP25dw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsViZ8ORqKuwcma
 ywYJDghYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bV7yvYCj5wVFxsv8DWwLifvYuRk0NI4Cyj
 xNnWxC5GLiD7AJPEqqPvmCGcPYwSmx9uYgWpYhPQlHjWuYAZxBYRkJDoaHgL1s0soC6xfNIvJ
 hBbWEBPYvKm/2wgNouAqsSCM8/AenkFPCS6/m4Hq5EQUJCY8vA92BxOAU+JzafWMUFc4SGx4d
 83Noh6QYmTM5+wQMyXkDj44gUzRK+ixKWOb4wQdoXErFltUDPVJK6e28Q8gVFwFpL2WUjaFzA
 yrWI0LU4tKkst0jXVSyrKTM8oyU3MzNFLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHL
 Sy3ZxAgM3ZRixrIdjN3L/ugdYpTkYFIS5TWqm5EsxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3z
 9KZyUKCRanpqRVpmTnAOIJJS3DwKInwXpkOlOYtLkjMLc5Mh0idYlSUEuddsBwoIQCSyCjNg2
 uDxe4lRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK890G282TmlcBNfwW0mAlocdTLqSCLSxI
 RUlINTJMMr5nOOtxx0PhNjM3ixeda9vz/ylkf36EtwRc09+zVOZ/L31dUrg0TsuNpFc5giCn6
 +uuyc/ax1NK6N+nnhDgz9wcoG6zMYwyeNzc1J+bu0xnKvw8nOpveu+5we8vZ/1fe2j5uyC8r7
 QxMCQ9e9eFWgb3+U5+P7B7ndvCsNby2n5VV3NdwKntwiei/ep/Fzhu3hnoJaVVdmufja1FSrW
 PIdbhjSSSXdX0lk5xH4jfp64LpEWypR2dMjVT11b9RVvKyvHTdzzMGuYGFh5YbPZ7nKfv9ca6
 EdADn3E07Jz5yPx4mb/n+pa3mfW2HSbeUSlf5ajat+vd1QuvsMwz8AV+kNCZo5JbqCnozfFJR
 YinOSDTUYi4qTgQAjBBjM1gDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-585.messagelabs.com!1671014688!95882!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13695 invoked from network); 14 Dec 2022 10:44:48 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-7.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Dec 2022 10:44:48 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id E30391001AE
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:47 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id D6C1C1001AD
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:47 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 14 Dec 2022 10:44:46 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Dec 2022 19:45:00 +0800
Message-ID: <1671018303-2079-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] doc/shell-test-api.txt
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

Update tst_kvcmp usage.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 73c9eff91..f35561e54 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -652,13 +652,15 @@ tst_kvcmp
 +++++++++
 
 This command compares the currently running kernel version given conditions
-with syntax similar to the shell test command.
+with syntax similar to the shell test command. Now, the oldest supported kernel
+version for ltp is 3.0, so we don't need this if comparing with very old version
+ie 2.6.8 .
 
 [source,sh]
 -------------------------------------------------------------------------------
-# Exit the test if kernel version is older or equal to 2.6.8
-if tst_kvcmp -le 2.6.8; then
-	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
+# Exit the test if kernel version is older or equal to 4.0.0
+if tst_kvcmp -le 4.0.0; then
+	tst_brk TCONF "Kernel newer than 4.0.0 is needed"
 fi
 
 # Exit the test if kernel is newer than 3.8 and older than 4.0.1
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
