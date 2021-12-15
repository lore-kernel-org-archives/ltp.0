Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC46BC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:21:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 673653C8F5E
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:21:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9136C3C8CE5
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:52 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B34AE6011EB
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1639552851; i=@fujitsu.com;
 bh=Ogqm++6mf8LrY9jXzwFPIcx9lZn850mgfPQIes7hSxc=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=Fd2SUNIq3vTdAFdUUvj1cywgefUU5ds4p++Hz2lbF/kb2Dm/EO8GcBrp88DsBSl0J
 GTLZyRaKj/hLJFvNM/0eUlwZ1YBkALMgcPZujeynCftThN4oFklR8vfemXoQDwnXyA
 B1RAN5H6B2y18EtJMFfGyrY1i2iCS1bcIU1adD2Hs9VSWc7EXLdS4cfB3nBAEC3J5v
 CVSDWqebipeGpa/Ypp1NlYqbuL0sUrVnD4yU6OJGPo3bda+QXM8bliq5PHSCgU0/9N
 ZKN+Lq7oJlJdcVqOfqdzOUk9azZfS5ByZOfr1ezPaBEVk3QW5ZlyLSd4GdaHO6YPMU
 syMpx8Zmg9xhA==
Received: from [100.115.34.181] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-4.bemta.az-a.eu-west-2.aws.ess.symcld.net id 88/6E-23453-25799B16;
 Wed, 15 Dec 2021 07:20:50 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRWlGSWpSXmKPExsViZ8MxSTdo+s5
 EgwtflS1WfN/B6MDose/3OtYAxijWzLyk/IoE1oxPVyayFZzhqXjU8pK5gfEWVxcjJ4eQwFlG
 idVH9LoYuYDsnUwSHb1n2SCcPYwSnTe7WUCq2AQ0JZ51LmAGsUUEJCQ6Gt6yg9jMAuoSyyf9Y
 gKxhQUSJS73PwKrYRFQldizupMVxOYV8JDo7+kBsyUEFCSmPHwPVsMp4ClxAcoWAqr5MW0tG0
 S9oMTJmU9YIOZLSBx88YIZoldR4lLHN0YIu0Ji1qw2JghbTeLquU3MExgFZyFpn4WkfQEj0yp
 G66SizPSMktzEzBxdQwMDXUNDU11jIyDTRC+xSjdRL7VUtzy1uETXSC+xvFgvtbhYr7gyNzkn
 RS8vtWQTIzCMU4oVMnYwfl/5U+8QoyQHk5Io79vynYlCfEn5KZUZicUZ8UWlOanFhxhlODiUJ
 HhfTgTKCRalpqdWpGXmAGMKJi3BwaMkwntsKlCat7ggMbc4Mx0idYpRUUqcdytIQgAkkVGaB9
 cGi+NLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5bSYBTeHJzCuBm/4KaDETyOLc7SCLSxI
 RUlINTFUdPV0OtzdPOpX1/ZCz+OZPO/lj9n5mdf92sMe14uPbm6Llxzizrs5oEWj3Wfb8R8Kl
 Bqk2qyrp6hnzZ/FbNVYqzAncdlRMPG+ijUHM5Aj5y0cW900/s4Pr5i/xZ+sU333TFn2jY+Npf
 NvGOPOE8pq6GGZ2ha89j/L8Co7P35l502CPveL5Jf0l75n2RNyYLyR080Kakf2MA6scU4Ot97
 kdE7i39Tuftboxx9L8kJnf2KVKTm7Pjn2xRXOWihrnk6q3+e5xwrtfvtjJ8YtZYU3Igdr999h
 Z/nfazfR1mBR7UyPuwrrbUvMyt6Y7Nc4wu7/m89ynPALaiesjFk/8vsUjU6NwlVjHo9UN5Usf
 sSqxFGckGmoxFxUnAgASYjnBXgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-571.messagelabs.com!1639552850!106065!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21511 invoked from network); 15 Dec 2021 07:20:50 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-8.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 15 Dec 2021 07:20:50 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 416CD100440
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:50 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 34D661000FE
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 07:20:50 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 07:20:32 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 15 Dec 2021 15:20:49 +0800
Message-ID: <1639552849-2251-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/4] zram/zram01.sh: Use mem_used_total field
 instead of compr_data_size field
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
