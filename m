Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357F4E7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 06:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734331571; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qSeMUtJpU8fBBLDHS6rT7DbDR+/vn2zpv0m7D9vnZ7w=;
 b=LqXG2HvEGIRLA1iCs5QGmcqaBn28cJWjy2r2/R1lFlLlBiKbSFLBp6iIoElkJewK0pAT/
 ksuR+ZJonvCWle+oDq9yY4MX4i/jPLT7lPGJWX6GTi/bYBGzlGXerWD60uBoAGqVLT+9dOL
 MZ5tBDpgxWePmG1Auh4nTiFIzijc6WQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 909093E2A06
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 07:46:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1A353E1320
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 07:45:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34E011BC8492
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 07:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1734331552; x=1765867552;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aI/ZxXRq5qqMnmYxPIXIiGIQoxE7v921jpL5iGnrSTQ=;
 b=DIxRPEnpAGgGTwXR9OGml0SKycbJBpQ1UPEM2OOvXiJbRYcQjnAH7Aj5
 FI5Tbz/oHiUOkduKki5V1XzAruMJV+aO0+wC9rofw1JOIerCDBK4bkLE5
 1q4s+JwgQlAyRFJRBVurVvAEWuIrmoO61/imEIFhVXkpHhnuG1zm4JTkz
 g1/NXS0UwMTRPhsR3tTClLrSreXcm4j+p5Vp9//SbXmB60/Q3mOo2Gjjj
 AfDtU7q1KIq8Aa9ctT6tbkYsQGIKieSK9ry/DtJs9kIhswR1n+0RhsoSm
 9xQ3NSuKqQEdKEf4ZoGcgX5E/gyq6RIXaFdV+Q7WlBFFLPdwa+6UYkqqh Q==;
X-CSE-ConnectionGUID: 3h+h9J15TySCZO/Ht4YCyA==
X-CSE-MsgGUID: 7O0x6R2rRfCLUHV5QusIIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="163290264"
X-IronPort-AV: E=Sophos;i="6.12,237,1728918000"; d="scan'208";a="163290264"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 15:45:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C77AE852C
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:45:47 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AB9BD3F26
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:45:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E1AFF224606
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 15:45:46 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 202F71A000B;
 Mon, 16 Dec 2024 14:45:46 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 16 Dec 2024 14:45:26 +0800
Message-ID: <20241216064526.2891270-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28862.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28862.005
X-TMASE-Result: 10--4.955700-10.000000
X-TMASE-MatchedRID: FMY5IFaWNFChhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmOEENgsUAuYsdh
 SaRRgUR74vM1YF6AJbZhyT3WNjppUtAtbEEX0MxBxEHRux+uk8irEHfaj14ZyQca30uf/jvRdln
 MkAcJxIK6x7m8HB8AAkjYm/dW6C9nYeBUSAnD9CKbObtkXNzgwi2tDUhxbkptuP2uzsmvxU9kn+
 ZWe1sgHAd0ruCUrh2IhpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nanosleep01: Convert docs to docparse
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
 testcases/kernel/syscalls/nanosleep/nanosleep01.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/nanosleep/nanosleep01.c b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
index eaacb89fa..bd9ae0caa 100644
--- a/testcases/kernel/syscalls/nanosleep/nanosleep01.c
+++ b/testcases/kernel/syscalls/nanosleep/nanosleep01.c
@@ -5,10 +5,11 @@
  * Copyright (C) 2015-2017 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
- * Test Description:
- *  nanosleep() should return with value 0 and the process should be
- *  suspended for time specified by timespec structure.
+/*\
+ * [Description]
+ *
+ * Verify that nanosleep() should return with value 0 and the process should be
+ * suspended for time specified by timespec structure.
  */
 
 #include <errno.h>
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
