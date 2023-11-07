Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB62C4332F
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 10:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 693323CC6C2
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 11:59:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6B933C5DFD
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 11:58:50 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BEC3D1BB9C2C
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 11:58:47 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="138855436"
X-IronPort-AV: E=Sophos;i="6.03,283,1694703600"; d="scan'208";a="138855436"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 19:58:46 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D753DD4F60
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:43 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 26BCCCFBC3
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A0ACD6BC57
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 306A61A0070;
 Tue,  7 Nov 2023 18:58:42 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  7 Nov 2023 05:58:35 -0500
Message-Id: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27982.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27982.006
X-TMASE-Result: 10--1.876900-10.000000
X-TMASE-MatchedRID: vWpUlhrjisaa/ReGzwcrzazGfgakLdjawTlc9CcHMZerwqxtE531VL6p
 xbTOjavyQZRAGYH4CAGe7hEhMUKGqLHTCfGFtKHg031Nfxfj2zMxVUWGXs3C8180IvgThXk8+OK
 z+Ut+SxLi8zVgXoAltr8hWd4lAsFlC24oEZ6SpSmcfuxsiY4QFJ11VEV/oAH2lQclsmwT3u+5O/
 SKLr93/qtn9YEgxZ7Ys9aUMoBF5jvjzcK3HWUTlhTy4dqZXQc9E2GdvXTUGyaYCK/nYz0ze5sNE
 GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] link05: Convert docs to docparse
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

The description of link05's test has no relevance to the test code,
I've changed the description.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/link/link05.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 95787ec24..f255bc13b 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -1,13 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *  AUTHOR		: Richard Logan
- *  CO-PILOT		: William Roske
+ * Authors: Richard Logan, William Roske
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2001-2023
  */
 
-/*
- * Test if link(2) fails with EMLINK.
+/*\
+ * [Description]
+ *
+ * Tests that link(2) succeeds with creating n links.
  */
 
 #include <stdio.h>
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
