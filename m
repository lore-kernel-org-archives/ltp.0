Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E581CD6E5B
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:55:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E1CC3CD503
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 12:55:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D136A3C88F3
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 12:55:23 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3DB95140126C
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 12:55:22 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="115131664"
X-IronPort-AV: E=Sophos;i="6.03,214,1694703600"; d="scan'208";a="115131664"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 19:55:20 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CB43E7E100
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B7E3D88B2
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A1F11200649D6
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 19:55:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 2ACE01A006F;
 Wed, 11 Oct 2023 18:55:17 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:55:09 +0800
Message-Id: <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27928.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27928.006
X-TMASE-Result: 10--8.222900-10.000000
X-TMASE-MatchedRID: v71phiYrRiGhhjsqgSuNbxF4zyLyne+ATJDl9FKHbrmOEENgsUAuYpGH
 Z85Onc+2n92kMT5ikLc3hH9FVqz6aATsy5Ctk/ajngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIfiA
 qrjYtFiQX/yIf9khEf4j5Bz+/F3OrZLSHLe1MfzO4DTHFsNnden7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] link08: Convert docs to docparse
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
 testcases/kernel/syscalls/link/link08.c | 30 +++++++++++++------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index d3e33d077..b3bffb31e 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -3,21 +3,23 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  */
-/*
- * Test Description:
- *  Verify that,
- *   1. link() fails with -1 return value and sets errno to EPERM
- *      if oldpath is a directory.
- *   2. link() fails with -1 return value and sets errno to EXDEV
- *      if oldpath and newpath are not on the same mounted file system( Linux
- *      permits a file system to be mounted at multiple points, but link()
- *      does not work across different mount points, even if the same
- *      file system is mounted on both. ).
- *   3. link() fails with -1 return value and sets errno to EROFS
- *      if the file is on a read-only file system.
- *   4. link() fails with -1 return value and sets errno to ELOOP
- *      if too many symbolic links were encountered in resolving path.
+
+/*\
+ * [Description]
+ *
+ * - link() fails with -1 return value and sets errno to EPERM
+ *   if oldpath is a directory.
+ * - link() fails with -1 return value and sets errno to EXDEV
+ *   if oldpath and newpath are not on the same mounted file system( Linux
+ *   permits a file system to be mounted at multiple points, but link()
+ *   does not work across different mount points, even if the same
+ *   file system is mounted on both. ).
+ * - link() fails with -1 return value and sets errno to EROFS
+ *   if the file is on a read-only file system.
+ * - link() fails with -1 return value and sets errno to ELOOP
+ *   if too many symbolic links were encountered in resolving path.
  */
+
 #include <errno.h>
 #include "tst_test.h"
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
