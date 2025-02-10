Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C65C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739178662; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ckVRSUItMpnzojzlokgiOjVcwcB5N4hOWw2vG+edOss=;
 b=JhnMrtmg0LU8fam7JunYu6gY36J4fTLbiNFI5oei5SKLRdox49EtV5yu6HKGt3Kb+kH/W
 Dp+lw1BMLDkG8x9fkypR4X+P5YCKW6YvMpWI+EqkEk6FtrjvOnwyLmP1tR46uw2laDfKDI/
 f9m7r2bECOBDkKhz+L35vuSNBLRCUg0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD4B3C987F
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:11:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13E593C9875
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:10:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.253;
 helo=esa8.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com
 [139.138.61.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 971FB6320A9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739178639; x=1770714639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oWjMVMpBvbR1ZjPCiBn5cTns8UOK4PgCFse3VJ1rsyo=;
 b=ece7uXeviUAENLPvCjbmIqbJhcLwaXEvSLKPKyBkPcRIve6K5hnrWK4x
 RZ+UHBHZV+qEd/Gvi99bMMBUIGsT5mfubxTrH0WQ3FPsnM7ywjGRPuDgM
 hCbHzu/1NWF2nZVOiFxg6AKjMUgeOyaf/PhUG+2wt/VNuQFB3zetDlAbd
 rvyNU6X3qne/ZfpE3WZDGiQzRj+pAgVnGhEGaYBHqdOv2wVctqoX+ND8Z
 7TkgCteGoctF2SIAwJrcyMAj0UCg5BV3wEvDuUIgnmnMbMTik3O47ybGw
 srVPRaMR3as0Wde8krUQSDN6YN0Jt6ASFWmacFtIVIvJGNISqyze30AW9 A==;
X-CSE-ConnectionGUID: GuC5NNQaRR2LyJ0Kpk02fw==
X-CSE-MsgGUID: OX+vKKTLSwmXiCWmxmzKQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="177445328"
X-IronPort-AV: E=Sophos;i="6.13,274,1732546800"; d="scan'208";a="177445328"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 18:10:37 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F2AECB406E
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:10:35 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B1418D3F07
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 18:10:35 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3F5121A000B;
 Mon, 10 Feb 2025 17:10:35 +0800 (CST)
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 17:10:44 +0800
Message-ID: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] semctl08: Convert docs to docparse
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
 testcases/kernel/syscalls/ipc/semctl/semctl08.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
index 1878bd49d..0c6ad1d8f 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Cross verify the _high fields being set to 0 by the kernel.
  */
 #include "lapi/sembuf.h"
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
