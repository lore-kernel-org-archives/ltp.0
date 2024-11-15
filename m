Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF96CD6DDD9
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 07:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731654030; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=bg0a+ORhw6/38ndzuwKeJOOxCoXOF0fChL95MSAvwkQ=;
 b=nIT89yuWu51i+LTrnSKcXZ6q/69o1GdkFx3CVjHWlJyRksDVkxAqrzZxoXKhBi/Dhpv+O
 oBjk92D1p8Y2tBr1uOuWhlN3TeO9uM+iTgpJaW/zO4WoTYcY93WkKNOefFKVWHdBCMYYE/C
 SvhvEi1OI8sLevGPzoTrR2ojq30MIGg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50D3C3D748C
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 08:00:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 047EA3D7481
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 08:00:07 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36219103875F
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 08:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1731654008; x=1763190008;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=x8znNSY/5YoL+vi9EWWl8ZEiVnhtLiCoZUcs5jYgkl4=;
 b=i0/WDPXVsq03+78+5kyjdU5hm1kI9NYbq1QL3gBeKSGb0lr4eCFgNTWd
 kiEqifgAaX1DRRsnGWxLEaiXlSwUswd4/ufaZodPRNP2bg45pXukwJ9fP
 2g2qt3ZHb2s1Br5XIjkcsQruSjgsu1XRT2YarDQv74qLiFhI4iFjxHoUk
 4EZUdlSwdLhOvcDkbsf5k3VdbKPSc05t4Tj+qExdXzXaa6tT3KkCMqpND
 8IwtCeBMMK67YwKODdHsnMSM4FtV9B2NGDB/O5gQtDcCsi9pLrTmujBMJ
 426REmTJFCwFobZTncsLHucIRx4WwTPikmG5fAZPaUP5R0P/mQqKCVVrq w==;
X-CSE-ConnectionGUID: Tsq067qjQOa0J4pl2DDKEw==
X-CSE-MsgGUID: XP8kd6MBRT2bqhyxCl63Xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="160001311"
X-IronPort-AV: E=Sophos;i="6.12,156,1728918000"; d="scan'208";a="160001311"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2024 16:00:04 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C9547D6EAA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:00:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 56E3FADF15
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:00:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D2285401AE
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 16:00:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 550EB1A000B;
 Fri, 15 Nov 2024 15:00:00 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 14:58:52 +0800
Message-ID: <20241115065852.133277-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28798.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28798.005
X-TMASE-Result: 10--7.896100-10.000000
X-TMASE-MatchedRID: QlNdUeMfyo6hhjsqgSuNbxF4zyLyne+ATJDl9FKHbrlcGuTueJkNIpXt
 W55mbY7syJuqVufLonjdMSs2eAqjrc9/UOQDuaCp5p1ddw6V4Rv/1JLsM3tGxpsoi2XrUn/J8m+
 hzBStantdY+ZoWiLIm9934/rDAK3zhG2qikEpQGUO1I8Nidc51T0HnhwZFdqCah5O+W0Cz08zt2
 RikbT0dwk1rld01l6Q
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] preadv201: Convert docs to docparse
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
 testcases/kernel/syscalls/preadv2/preadv201.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv201.c b/testcases/kernel/syscalls/preadv2/preadv201.c
index 50f5a2e01..8e5d1b9c7 100644
--- a/testcases/kernel/syscalls/preadv2/preadv201.c
+++ b/testcases/kernel/syscalls/preadv2/preadv201.c
@@ -4,15 +4,17 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-/*
- * Description:
- * Testcase to check the basic functionality of the preadv2(2).
- * 1) If the file offset argument is not -1, preadv2() should succeed
- *    in reading the expected content of data and the file offset is
- *    not changed after reading.
- * 2) If the file offset argument is -1, preadv2() should succeed in
- *    reading the expected content of data and the current file offset
- *    is used and changed after reading.
+/*\
+ * [Description]
+ *
+ * Verify the basic functionality of the preadv2(2).
+ *
+ * 1. If the file offset argument is not -1, preadv2() should succeed
+ * in reading the expected content of data and the file offset is not
+ * changed after reading.
+ * 2. If the file offset argument is -1, preadv2() should succeed in
+ * reading the expected content of data and the current file offset
+ * is used and changed after reading.
  */
 
 #define _GNU_SOURCE
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
