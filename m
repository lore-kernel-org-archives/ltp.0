Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A98C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 07:58:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFE3B3CEB85
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 09:58:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 723083CCA74
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 09:58:03 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4D5120EB3D
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 09:58:01 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="117119549"
X-IronPort-AV: E=Sophos;i="6.03,255,1694703600"; d="scan'208";a="117119549"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 16:57:59 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 12F04D9DAC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:58 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 56113CF7E6
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E97896C836
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 16:57:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 96B1D1A0073;
 Fri, 27 Oct 2023 15:57:56 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 03:16:24 -0400
Message-Id: <20231027071624.51798-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231027071624.51798-1-xuyang2018.jy@fujitsu.com>
References: <20231027071624.51798-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27960.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27960.005
X-TMASE-Result: 10--5.758900-10.000000
X-TMASE-MatchedRID: 8Mx/Esjxkj+hhjsqgSuNbxF4zyLyne+AVBDQSDMig9EnyU5/nZpxUBpl
 bnRIZ6aE+FyTwBk2ojyri0Mekz/9slSaKReCNW2DngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
 Wy9W70AEgBwKKRHe+r+/QdcRZ/Fp7lwlu6rNMcKrLSTq2TzNTA87Qf1jmhjDWROi3JZHXkQY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] umount03: Convert doc to docparse
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
 testcases/kernel/syscalls/umount/umount03.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/umount/umount03.c b/testcases/kernel/syscalls/umount/umount03.c
index 1cef06fa1..498f03b69 100644
--- a/testcases/kernel/syscalls/umount/umount03.c
+++ b/testcases/kernel/syscalls/umount/umount03.c
@@ -1,9 +1,14 @@
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
- * Verify that umount(2) returns -1 and sets errno to  EPERM if the user
+ * Verify that umount(2) returns -1 and sets errno to EPERM if the user
  * is not the super-user.
  */
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
