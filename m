Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA55C7619A
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 02:59:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869A83CC7A3
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 04:59:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACF2B3C00D1
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 04:59:24 +0200 (CEST)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 925621A001A6
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 04:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1681268362; i=@fujitsu.com;
 bh=xDJrBXVjiYjoRdRUC2oVaXZarqCNGf6u837HIMThu1s=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=IBU6fzn1EZc0nJciOZfDpfqez0KwzFixzj2hAkJeJwWTJY8rbWTQYSYMcqOCI87Vp
 AgniRWULjHMMsuyNuonb7PtWBjlrVNvSap2I+/rGanDXAR+gitFmSbKTyDqGKijCla
 Cv/Gcl9y6mvrH4wpHSXNaEKc75ZFE99Nl+/P6LZoPPnzsqto8JPt6C5f2o1c0awGaQ
 PEXFKvdM35MNOEzqeN0VbNPxvZTZe7Za6V5NsrwAbbS515CSlKjyZgqQeSLWyFSh27
 H3E+jrOr2nJNBVlF5+IpajX73K321c4nl+He3mo++Qy1q/73HwNS+i+L7s3/B69t5c
 03j6JR9HrRLRA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRWlGSWpSXmKPExsViZ8MxSbdTziz
 F4M1mG4sV33cwOjB67Pu9jjWAMYo1My8pvyKBNWPzhJ+sBTv4KlbNfs/cwLiSu4uRi0NI4Cyj
 ROv+BlYI5wCTxPTbjWwQzl5Gic8z37B0MXJysAloSjzrXMAMYosISEh0NLxlB7GZBdQllk/6x
 QRiCwtESDxaMR8sziKgKrFh3SxWEJtXwFPiycaXYLaEgILElIfvmSHighInZz5hgZgjIXHwxQ
 tmiBolibbWK1D1FRKN0w8xQdhqElfPbWKewMg/C0n7LCTtCxiZVjGaFqcWlaUW6ZroJRVlpme
 U5CZm5uglVukm6qWW6panFpfoGukllhfrpRYX6xVX5ibnpOjlpZZsYgQGY0qx4rEdjP96/+od
 YpTkYFIS5S2aZZoixJeUn1KZkVicEV9UmpNafIhRhoNDSYL3sYxZipBgUWp6akVaZg4wMmDSE
 hw8SiK8aiBp3uKCxNzizHSI1ClGRSlxXltZoIQASCKjNA+uDRaNlxhlpYR5GRkYGIR4ClKLcj
 NLUOVfMYpzMCoJ896VBJrCk5lXAjf9FdBiJqDFJy1MQBaXJCKkpBqYmHWbn/YyN0fc47x+4Wn
 ns4KmHaFH6lQXeb2e67U2wNHhd1DbYecEvROZN27I5Yhx/d+6PuEwq4DCjh+nVBcs+pty9Fip
 g98E00ZpYa/yWQ0GHMetnTYdLXfY2/OX99eF39029x+68IbXia4TCV86l6Pnf+XhX1ld16Ye2
 ff/+b5zq1W6H+VyvuDuPCyv0iIld0JfWSPD+/7a1ekFK4VWy6UUPO2ck7zWd5HI++2/99lnZ8
 88yGGocOzrU6slJXy/K8+/vvAn5exRpxkpr5wdxcJ+TQ7OXuCcxTLV9PocnS61Kz4pkrOM57h
 bzRB+ssVi1qTA9C/zS4Xv2cpsmm8swFqlUxPyREx72hntk38NlViKMxINtZiLihMBaZQcEEED
 AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-548.messagelabs.com!1681268361!32453!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21042 invoked from network); 12 Apr 2023 02:59:21 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-9.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Apr 2023 02:59:21 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id AED83100465
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 03:59:21 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121
 [10.183.43.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A2867100441
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 03:59:21 +0100 (BST)
Received: from localhost.localdomain (10.167.215.131) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 12 Apr 2023 03:59:19 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 12 Apr 2023 10:59:01 +0800
Message-ID: <1681268342-24308-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.215.131]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RESEND 1/2] network/lib6/asapi_02: Fix
 T_WILLBLOCK/T_WILLPASS no FAIL/PASS bug
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

Currently, icmp6_ft will skip check between rv and expetec result when testing T_WILLBLOCK/T_WILLPASS case.

the result log as below:
asapi_02    1  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 20
asapi_02    2  TPASS  :  ICMP6_FILTER_SETPASS s 20 f 21
asapi_02    3  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 20
asapi_02    4  TPASS  :  ICMP6_FILTER_SETBLOCK s 20 f 21
asapi_02    5  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    6  TPASS  :  ICMP6_FILTER_PASSALL s 20
asapi_02    7  TPASS  :  ICMP6_FILTER_BLOCKALL s 20
asapi_02    8  TPASS  :  ICMP6_FILTER_BLOCKALL s 20

after removing the wrong else judgment, the result log as below:
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
 testcases/network/lib6/asapi_02.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/lib6/asapi_02.c b/testcases/network/lib6/asapi_02.c
index f9843346c..13b3b2b70 100644
--- a/testcases/network/lib6/asapi_02.c
+++ b/testcases/network/lib6/asapi_02.c
@@ -246,8 +246,6 @@ static void icmp6_ft(void)
 			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
 				continue;
 			rv = ic6_recv1(ftab[i].ft_tname, sall, sf);
-		} else {
-			rv = -1;
 		}
 
 		if (rv < 0)
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
