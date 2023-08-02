Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB6EB64DD
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 03:14:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11013CDD62
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 05:14:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABA953CD817
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 05:14:11 +0200 (CEST)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D79C51A0100F
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 05:14:10 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="105503059"
X-IronPort-AV: E=Sophos;i="6.01,248,1684767600"; d="scan'208";a="105503059"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 12:14:07 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BCA7AC53C3
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 12:14:05 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0048ABF498
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 12:14:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 032222FC047C;
 Wed,  2 Aug 2023 12:14:03 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed,  2 Aug 2023 11:13:54 +0800
Message-Id: <1690946036-27866-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27788.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27788.004
X-TMASE-Result: 10--3.872900-10.000000
X-TMASE-MatchedRID: QlNdUeMfyo6kemoEvXwmRU7nLUqYrlslFIuBIWrdOeOU8ftiyKjZra1W
 5jVjArJq5JycdpKDCe9/6kMd15bGDJLaPACgg26O194/5X9VfCwnsBRgUEfdppsoi2XrUn/J8m+
 hzBStansUGm4zriL0oQtuKBGekqUpnH7sbImOEBTq7kriHRHWwGLcAvzKuqAzzWyuNLM3GnTp+b
 rzr6zTeRZ10/XCFe2Foe/bVaFcQwKZMo52DS6h1VYr39lgY1KHJVX5TmcdH6vsfZ9V6Q6rCZgvU
 oiYqGrVm457vI8IG8B/Y4nFsBWAdD6Qrn3xh/cy
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] access01: Convert docs to docparse
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/access/access01.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index c9a076d..391c8d4 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -1,11 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *   AUTHOR		: William Roske
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: William Roske
  */
-/*
+
+/*\
+ * [Description]
+ *
  * Basic test for access(2) using F_OK, R_OK, W_OK and X_OK
  */
+
 #include <errno.h>
 #include <unistd.h>
 #include <sys/types.h>
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
