Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D82C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 07:58:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40B1B3CCA83
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 09:58:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F8BE3CCA76
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 09:58:03 +0200 (CEST)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B299F1036E27
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 09:58:01 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="137849332"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; d="scan'208";a="137849332"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 16:57:59 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D76EED29E5
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0E2D3D949B
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A93802005018F
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 53C651A0070;
 Fri, 27 Oct 2023 15:57:56 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 03:16:23 -0400
Message-Id: <20231027071624.51798-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.005
X-TMASE-Result: 10--5.669000-10.000000
X-TMASE-MatchedRID: /CzucCovGFKhhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxUBpl
 bnRIZ6aE+FyTwBk2ojyri0Mekz/9ssOMOMSaAsE9xDiakrJ+SpkRKrbwgeEU4lyqn5M9p8suo8W
 MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbtuRXh7bFKB7onwYrudhbbmyJlmHfSWq9ZTK9
 q3rpte5Nn54CyhK6KEaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] umount01: Convert doc to docparse
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
 testcases/kernel/syscalls/umount/umount01.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/umount/umount01.c b/testcases/kernel/syscalls/umount/umount01.c
index d05296dce..596d98a13 100644
--- a/testcases/kernel/syscalls/umount/umount01.c
+++ b/testcases/kernel/syscalls/umount/umount01.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2002-2023
  * Author: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
+ */
+
+/*\
+ * [Description]
  *
- * Phase I test for the umount(2) system call.
- * It is intended to provide a limited exposure of the system call.
+ * Check the basic functionality of the umount(2) system call.
  */
 
 #include <errno.h>
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
