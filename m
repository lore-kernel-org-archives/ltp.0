Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F7FC77B70
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 02:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2EC13CC8E0
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 04:44:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42F63CA84C
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 04:43:54 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6561D6001AE
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 04:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1681267432; i=@fujitsu.com;
 bh=lodcYKHHXKJRCxF9onbIxPXUdiLFxKi7dW4evdc/fes=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=jxj/25jFBswjgIYGytW/BmB3kAFDi3n9lGjKcJLDEaMgylB9HEx5fgURpyC2UCNP6
 shmxSxZGyPyGr8vrQVM5bsdTh7miTQX8H2yZwd+yPM7f3r/Mw4SHRexlgsX2He3cQY
 jMCqurgYQ9PgUsFKvKbkzw05dx+HkIYu+bRt/Xo2I5WQUs24woz9eB/AjRKe0Rlj4O
 9gBCqZilZJnFzI4PRt4ZckWF5sYA5Bhv+i4lsH42YmqOqz4EbgCc+K29djrtp3nKpN
 kSgoAsBoO3ePglVEJTXj2fAjt7aCIVH3xzHH8FSwkr+YYkBqPP1TkUintGqznuYzPr
 4WU/dDHW61uoQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsViZ8MxSfe5lFm
 Kwa1dchYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bNszvYC+7wVyy9PpGpgXENTxcjF4eQwFlG
 iZ23ljBBOAeYJCb9P8wI4exllPjVepq1i5GTg01AU+JZ5wJmEFtEQEKio+EtO4jNLKAusXzSL
 yYQW1ggXOLW3F2MIDaLgKrE3sW3wWp4BTwlfrxczgZiSwgoSEx5+J4ZIi4ocXLmExaIORISB1
 +8YIaoUZJoa73CCmFXSDROP8QEYatJXD23iXkCI/8sJO2zkLQvYGRaxWhWnFpUllqka6KXVJS
 ZnlGSm5iZo5dYpZuol1qqm5dfVJKha6iXWF6sl1pcrFdcmZuck6KXl1qyiREYjinFCWk7GFv7
 /uodYpTkYFIS5S2aZZoixJeUn1KZkVicEV9UmpNafIhRhoNDSYJ3tYRZipBgUWp6akVaZg4wN
 mDSEhw8SiK8v4SA0rzFBYm5xZnpEKlTjIpS4rxvJYESAiCJjNI8uDZYPF5ilJUS5mVkYGAQ4i
 lILcrNLEGVf8UozsGoJMx7F2QKT2ZeCdz0V0CLmYAWn7QwAVlckoiQkmpgKu1XTNN/YTfF2L6
 cZ/6G1BxZ7uMVImucf/bc4Mov7704XU1q5sKTNesuad3uLuts3V2ZuibThSn6ye4Du92DJv8/
 em7zi3s5rtdbNv4xL9d5z9WeN3E15/n8QqUwrjfPtTn/NO5wEd895dTDL08KF7LN57ykP2+T4
 LL3Hxc5l68yyrUxNr8RZmSlce9/LIvdviMJR05Ev5i299bDNQqTTtrF7d+x+ZFZSmDzW+Hcpx
 k84nti1TkFLgZEOsz401Y5dT7vpJ+ev/7teiZ+IiN0hmFM+gfnpjsBVvPOMLPJTWM4eWj5pEd
 imwK2t4e3Kn27q7Zv/iS33fvnmwZe3vPimYGq8i/riYaqbTbWvE97+JVYijMSDbWYi4oTAXEs
 O+VCAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-732.messagelabs.com!1681267431!52754!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4417 invoked from network); 12 Apr 2023 02:43:51 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-7.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Apr 2023 02:43:51 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 0019B1000FB
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 03:43:50 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E6E8B10033D
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 03:43:50 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 12 Apr 2023 03:43:49 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 12 Apr 2023 10:43:28 +0800
Message-ID: <1681267409-24122-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] network/lib6/asapi_02: Fix T_WILLBLOCK/T_WILLPASS
 no FAIL/PASS bug
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

Currently, icmp6_ft will skip check between rv and expetec result
when testing T_WILLBLOCK/T_WILLPASS case.

the result log as below:
asapi_02    1  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 20
asapi_02    2  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 21
asapi_02    3  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 20
asapi_02    4  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 21
asapi_02    5  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    6  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    7  TPASS  :  ICMP6_FILTER_BLOCKALL s 20
asapi_02    8  TPASS  :  ICMP6_FILTER_BLOCKALL s 20

after removing the wrong else and useless rv judgment, the result
log as below:
asapi_02    1  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 20
asapi_02    2  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 21
asapi_02    3  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 20
asapi_02    4  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 21
asapi_02    5  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    6  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    7  TPASS  :  ICMP6_FILTER_BLOCKALL s 20
asapi_02    8  TPASS  :  ICMP6_FILTER_BLOCKALL s 20
asapi_02    9  TPASS  :  ICMP6_FILTER_WILLBLOCK s 20 f 21
asapi_02   10  TPASS  :  ICMP6_FILTER_WILLBLOCK s 20 f 20
asapi_02   11  TPASS  :  ICMP6_FILTER_WILLPASS s 20 f 21
asapi_02   12  TPASS  :  ICMP6_FILTER_WILLPASS s 22 f 22

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/network/lib6/asapi_02.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/network/lib6/asapi_02.c b/testcases/network/lib6/asapi_02.c
index f9843346c..3b4405197 100644
--- a/testcases/network/lib6/asapi_02.c
+++ b/testcases/network/lib6/asapi_02.c
@@ -246,12 +246,8 @@ static void icmp6_ft(void)
 			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
 				continue;
 			rv = ic6_recv1(ftab[i].ft_tname, sall, sf);
-		} else {
-			rv = -1;
 		}
 
-		if (rv < 0)
-			continue;
 		if (rv != ftab[i].ft_expected)
 			tst_resm(TFAIL, "%s: rv %d != expected %d",
 				 ftab[i].ft_tname, rv, ftab[i].ft_expected);
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
