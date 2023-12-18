Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A22C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:16:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA17A3CB299
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:16:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8160C3CACE7
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:16:33 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E64C060011C
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:16:32 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="143773077"
X-IronPort-AV: E=Sophos;i="6.04,284,1695654000"; d="scan'208";a="143773077"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 17:16:31 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BA152E0401
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:28 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F497D5E91
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 884D3202CAA4E
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 17:16:27 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3F1641A006F;
 Mon, 18 Dec 2023 16:16:27 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 18 Dec 2023 01:21:29 -0500
Message-Id: <20231218062129.130236-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
References: <20231218062129.130236-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28064.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28064.005
X-TMASE-Result: 10--3.967800-10.000000
X-TMASE-MatchedRID: v71phiYrRiGhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrlcGuTueJkNItno
 quRwHY3Bi1QzF8xBpkXLmbje3yGzqlxxDx5qbkR9FEUknJ/kEl5q8/xv2Um1avoLR4+zsDTtB00
 /kkeBTwC5btQ5LU4P+ulH3GBMmErZEYvadqlssWK9jalmCPsPIGyXxKB0VMnPGVReE3/zNggelH
 a7KKLmnU/zrLAqSDDwHz9KYf72QduGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] gettimeofday02: Convert docs to docparse
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/gettimeofday/gettimeofday02.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
index 7c462cc29..fcd027df5 100644
--- a/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
+++ b/testcases/kernel/syscalls/gettimeofday/gettimeofday02.c
@@ -4,13 +4,12 @@
  * Copyright (C) 2017 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
+/*\
  * DESCRIPTION
- *	Check if gettimeofday is monotonous
+ * Check if gettimeofday is monotonous during 10s
  *
- * ALGORITHM
- *	Call gettimeofday() to get a t1 (fist value)
- *	call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
+ * - Call gettimeofday() to get a t1 (fist value)
+ * - Call it again to get t2, see if t2 < t1, set t2 = t1, repeat for 10 sec
  */
 
 #include <stdint.h>
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
