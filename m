Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77C4C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 06:53:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7ABB3C9164
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 07:53:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DE4F3C8FDB
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:47 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E3EB1000A1B
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 07:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639983166; i=@fujitsu.com;
 bh=1e8/V5jEE4u/3JoydjloypNMov8rxwlTHlFwVva5+Ec=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=YGAVtqYOuG0RoZmRUq0rG3nfzg8ZGcR608B+LP2PD0n5rdr9UXYmCo0XQgoZmRmzD
 spI159MKpIyrntjUD5dWBsVcOS7yCrIRWHDelb1Lf50OER4Ej1PGAeQJMTIO6p64PM
 TUj1Eh7dJ8myEK2p3enVNCWCtX5W+e9p2S2fmj9mxZpErt7tvSYlRhL4BEqiVjJkH/
 FKtmtgBmRuPhar6TGeYZpFPrvLv9MWyqqvXc7+AdN1cTmvsrAHkUwkQE3gnKBJCLSb
 zlDpeXV8Oxbvx6tY82G/GUGl5znV1A8E48r2AUDML7VHPf/ThaS4godVgIu+8cQDdc
 FyymWgTSoHTnQ==
Received: from [100.115.69.209] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id AC/D4-24146-E3820C16;
 Mon, 20 Dec 2021 06:52:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsViZ8ORqGuncSD
 R4MwyTosV33cwOjB67Pu9jjWAMYo1My8pvyKBNWP39yuMBV95KlrmRjUw/ufqYuTiEBI4yyjx
 Zd5/FghnJ5PEhWXtzBDOHkaJP8fPsncxcnKwCWhKPOtcwAxiiwhISHQ0vAWLMwuoSyyf9IsJx
 BYWSJf4eXgLC4jNIqAq8bz7JJjNK+AhceDDeTBbQkBBYsrD90BzODg4BTwlJnyxAAkLAZV0zD
 zFDFEuKHFy5hMWiPESEgdfvGCGaFWUuNTxjRHCrpCYNauNCcJWk7h6bhPzBEbBWUjaZyFpX8D
 ItIrRNqkoMz2jJDcxM0fX0MBA19DQVNfMAkjpJVbpJuqlluomp+aVFCUCZfUSy4v1UouL9Yor
 c5NzUvTyUks2MQIDOaXYhXsH452+n3qHGCU5mJREeQW69yYK8SXlp1RmJBZnxBeV5qQWH2KU4
 eBQkuCVVz+QKCRYlJqeWpGWmQOMKpi0BAePkgivpxpQmre4IDG3ODMdInWKUZdj59F5i5iFWP
 Ly81KlxHk9QGYIgBRllObBjYBF+CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrz8IFN4MvN
 K4Da9AjqCCegIpfD9IEeUJCKkpBqYgpdPV1h2LaVvdU3YLf5fz/oyGHk2c+i+Ub81vzVRMG8d
 x+78GwaJXauUVhZI6nTulj1/cPX5a4LiVhPnOj36xXV6an7yhDOsYYlzNm066+pUbSEz0f10z
 apM8e2W79z9haIC+xQXVGwWVFrAuOMmy5qtPaFpC+4/E7ljeOzmd820pXYTtj6uidj0hrE0Q/
 TEPe8LM9vnHN2dl+a8r2LuWd1dVrlpPzr0Em/PFbnx59ySshwh4VeWXimXli+3SOdmPFC4Tey
 Om2OGcV34GhPupI87Nic0TwgM9OySioxI4HA65GM0fdtL0bbp+dKHOCzeuho+4C7/vnDx9Bip
 5ZPP7FEyD7vzti8sd4206eVEJZbijERDLeai4kQAYlkVzmsDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-528.messagelabs.com!1639983165!176971!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10515 invoked from network); 20 Dec 2021 06:52:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-21.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Dec 2021 06:52:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AEA7F1009FC
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A0C2310023E
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:52:45 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Mon, 20 Dec 2021 06:52:41 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 20 Dec 2021 14:52:22 +0800
Message-ID: <1639983142-2247-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639983142-2247-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/4] zram/zram01.sh: replacing data stored in this
 disk with allocated for this disk
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

Before ltp commit 4372f7a2156 ("Fix compression ratio calculation in zram01")[1], we
used free -m changes to calculate the compression ratio.

After the above patch, we used compr_data_size to calculate. kernel documentation[2] has
the following info:
orig_data_size: uncompressed size of data stored in this disk.
compr_data_size: compressed size of data stored in this disk
mem_used_total: the amount of memory allocated for this disk

We should calculate the compression ratio by used disk size divided into used mem size.
It can also avoid the situation that division by 0 as below:
zram01 7 TINFO: filling zram4 (it can take long time)
zram01 7 TPASS: zram4 was filled with '25568' KB
zram01 7 TINFO: compr_size 0
 /opt/ltp/testcases/bin/zram01.sh: line 131: 100 * 1024 * 25568 / 0: division by 0 (error token is "0")

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 5e13f387c..5b4c05434 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -125,8 +125,8 @@ zram_fill_fs()
 			continue
 		fi
 
-		local compr_size=`awk '{print $2}' "/sys/block/zram$i/mm_stat"`
-		local v=$((100 * 1024 * $b / $compr_size))
+		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		local v=$((100 * 1024 * $b / $mem_used_total))
 		local r=`echo "scale=2; $v / 100 " | bc`
 
 		if [ "$v" -lt 100 ]; then
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
