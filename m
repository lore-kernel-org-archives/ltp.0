Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68392EB64DD
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 03:14:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACDE3CDB70
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 05:14:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E72A3CDBE0
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 05:14:14 +0200 (CEST)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FEE81A0100F
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 05:14:14 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="105503068"
X-IronPort-AV: E=Sophos;i="6.01,248,1684767600"; d="scan'208";a="105503068"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 12:14:13 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F06FD29E8
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 12:14:11 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 40E04E4AD4
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 12:14:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5DD762FC047C;
 Wed,  2 Aug 2023 12:14:09 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Wed,  2 Aug 2023 11:13:56 +0800
Message-Id: <1690946036-27866-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690946036-27866-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1690946036-27866-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27788.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27788.004
X-TMASE-Result: 10--7.797700-10.000000
X-TMASE-MatchedRID: nRYjnRMpeiCkemoEvXwmRU7nLUqYrlslFIuBIWrdOePfUZT83lbkEFI3
 NifDbduL+FyTwBk2ojwmQEk7DkLChqklC9pYur2SSs47mbT7SASOVGny5q72hr5TVqwOzxj8RtU
 L4XifTnvV4q36S0NEz3TXQSc8erBKoDlDgS6jzLSeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
 quNi0WJNy5+03ZUSGj/jTMxnBO+D74hh1TpxreSc6tNiNrg0IWftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] access04: Convert docs to docparse
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
 testcases/kernel/syscalls/access/access04.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index 2d6dd70..f02f384 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -2,26 +2,27 @@
 /*
  * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2013 Fujitsu Ltd.
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Ported to LTP: Wayne Boyer
+ * 11/2013 Ported by Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
+ * 11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
  */
 
-/*
- * Verify that,
- *  1) access() fails with -1 return value and sets errno to EINVAL
- *     if the specified access mode argument is invalid.
- *  2) access() fails with -1 return value and sets errno to ENOENT
- *     if the specified file doesn't exist (or pathname is NULL).
- *  3) access() fails with -1 return value and sets errno to ENAMETOOLONG
- *     if the pathname size is > PATH_MAX characters.
- *  4) access() fails with -1 return value and sets errno to ENOTDIR
- *     if a component used as a directory in pathname is not a directory.
- *  5) access() fails with -1 return value and sets errno to ELOOP
- *     if too many symbolic links were encountered in resolving pathname.
- *  6) access() fails with -1 return value and sets errno to EROFS
- *     if write permission was requested for files on a read-only file system.
+/*\
+ * [Description]
  *
- * Ported to LTP: Wayne Boyer
- *  11/2013 Ported by Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
- *  11/2016 Modified by Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+ * 1. access() fails with -1 return value and sets errno to EINVAL
+ *    if the specified access mode argument is invalid.
+ * 2. access() fails with -1 return value and sets errno to ENOENT
+ *    if the specified file doesn't exist (or pathname is NULL).
+ * 3. access() fails with -1 return value and sets errno to ENAMETOOLONG
+ *    if the pathname size is > PATH_MAX characters.
+ * 4. access() fails with -1 return value and sets errno to ENOTDIR
+ *    if a component used as a directory in pathname is not a directory.
+ * 5. access() fails with -1 return value and sets errno to ELOOP
+ *    if too many symbolic links were encountered in resolving pathname.
+ * 6. access() fails with -1 return value and sets errno to EROFS
+ *    if write permission was requested for files on a read-only file system.
  */
 
 #include <errno.h>
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
