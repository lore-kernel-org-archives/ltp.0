Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF41AC3DA4A
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724061698; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=vqLsbrNoqCGcMV0t86ExuThHr9GdkE/dRZA4C0yxG0g=;
 b=LmxQfdGSPmpCwRW9u0/+Vfjykvx6s6sMppqhZkDIaUzwLx4agrv8aKQs/NYv32+k8WUTo
 woeXXCdkZYQRPfeUbbSkCrGpLbqeYiujlbSr1vf5n5gZPS8ulbJv8ZJD/y75cIVxH+bwDWf
 IcN0rQbXJnH8zAVS/dzAxFM1fe332yE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25EB3D3208
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 12:01:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 707BC3C01D4
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 12:01:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.48;
 helo=esa2.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5572A600BD1
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 12:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1724061677; x=1755597677;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G/dQqQNmBw2jh8RljYYmXRX49IUKBDUTDnNsTTUqY8s=;
 b=UxjmMa8KB1iDwvgiND4TstGKWRxLr/UuKiMztXQCd2bNwoEr+FJ2azm4
 QGL53acXWzHum6SVOlgVbGquPGVbh5oOhBjLWNtPYyvLytRUxvP3LMKwo
 Dk/BCovxuLlJ2FNAp685IZmrBNmLt8FBDFe3TyL0RR0xQHAvm8mYSckzx
 0MVPquATZ/jMVGNJ76ZEAuyMQeAAQMQAnmCJRv1TuQTOB4dRXMzojxiKj
 KXUv09Hbo6hy/FJRVVCyQPt1zr5zHBieiT1kGyaokGGjKqYAM2NoZ4K0J
 aZTqoFsoqXEmha8B3llYmaK5P13XjpKitEa6WRjxRI+ybnW1YoEMaYXaC A==;
X-CSE-ConnectionGUID: 8pSjmGtgTzanEkqH1wWKfw==
X-CSE-MsgGUID: 8r4XG/GjSwiBQBRnHP4t3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="171019947"
X-IronPort-AV: E=Sophos;i="6.10,158,1719846000"; d="scan'208";a="171019947"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 19:01:15 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E275B2F649
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 19:01:12 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 373F8D5046
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 19:01:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A6FC8C56F
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 19:01:11 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.182])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2219C1A000A;
 Mon, 19 Aug 2024 18:01:11 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 19 Aug 2024 18:02:56 +0800
Message-ID: <20240819100256.2252942-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28604.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28604.005
X-TMASE-Result: 10--4.793800-10.000000
X-TMASE-MatchedRID: 60gbRApQc+uhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmOEENgsUAuYhDO
 9b78NniRGtPsII7bpSEhTdlTCAnun6+/EguYor8cFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
 zmuoPCq0wzQKLmEDacj15aY3sV6MkgIf+Pvp1N4DQTH2Q5ZvNFeI3zQLWs78br52L3Pnp8jG7pu
 CVAUrYjLNd/SlAN0GD15qP6uEMorQVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
 gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] readlink01: Convert docs to docparse
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/readlink/readlink01.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 389ba1fee..8165547d4 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -4,10 +4,12 @@
  * Ported to LTP: Wayne Boyer
  */
 
-/*
- * Test Description :
- *   Testcase to check the basic functionality of the readlink(2),
- *   readlink() will succeed to read the contents of the symbolic link.
+/*\
+ * [Description]
+ *
+ * Tests basic functionality of readlink(2).
+ *
+ * - readlink() will succeed to read the contents of the symbolic link
  */
 
 #include <pwd.h>
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
