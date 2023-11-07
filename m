Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F502C4167D
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 10:59:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E667A3CE818
	for <ltp@archiver.kernel.org>; Tue,  7 Nov 2023 11:59:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F5153C5DFD
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 11:58:50 +0100 (CET)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com
 [207.54.90.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB647600C84
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 11:58:47 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="138818160"
X-IronPort-AV: E=Sophos;i="6.03,283,1694703600"; d="scan'208";a="138818160"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 19:58:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 342FECA245
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:44 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 37A3FD5D09
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C38CB200649DE
 for <ltp@lists.linux.it>; Tue,  7 Nov 2023 19:58:42 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.220.121])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 7202A1A0074;
 Tue,  7 Nov 2023 18:58:42 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  7 Nov 2023 05:58:36 -0500
Message-Id: <20231107105836.68108-2-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
References: <20231107105836.68108-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27982.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27982.006
X-TMASE-Result: 10--6.820100-10.000000
X-TMASE-MatchedRID: EriUbUlPOKMwRe7LbjTDMU7nLUqYrlslFIuBIWrdOeOU8ftiyKjZreCG
 89wh97wn+FyTwBk2ojyri0Mekz/9stPKvSkrFLVX5CghTisABMxZDdHiTk9OcJYaGUdeitddmZl
 av/V3rETi8zVgXoAltjX6XtdE9yLDC24oEZ6SpSkj80Za3RRg8NReImV9rZp8a0GP8xJSPBkvf3
 PnzCmuGY5Zaf1p9Ok/sMdb5aNbdZ0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] link08: Convert docs to docparse
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

update copyright, fix grammar

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/link/link08.c | 31 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index d3e33d077..9cc468f58 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -1,23 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014 Fujitsu Ltd.
+ * Copyright (c) Linux Test Project, 2014-2023
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
+ * Verify that,
+ *
+ * - link() fails with EPERM if the old path is a directory.
+ * - link() fails with EXDEV if the old path and the new path
+ *   are not on the same mounted file system(Linux permits
+ *   a file system to be mounted at multiple points, but link()
+ *   does not work across different mount points, even if the same
+ *   file system is mounted on both).
+ * - link() fails with EROFS if the file is on a read-only file system.
+ * - link() fails with ELOOP if too many symbolic links were encountered
+ *   in resolving path.
  */
+
 #include <errno.h>
 #include "tst_test.h"
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
