Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0DBCDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 06:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87C33CD0FC
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:35:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E00013C8696
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:10 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FE481001165
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:10 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="115832196"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; d="scan'208";a="115832196"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 15:35:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 93FF7DDC6C
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:04 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CD1F5D947F
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 62A8B6BC66
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AE0A1A0071;
 Tue, 17 Oct 2023 14:35:03 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 17 Oct 2023 14:34:48 +0800
Message-Id: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27940.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27940.005
X-TMASE-Result: 10--6.272000-10.000000
X-TMASE-MatchedRID: TqGneUseB4/NHx7Eti3qF3zmmMD/HXF+9LMB0hXFSegbIVTME6y/cG8q
 nFk+BWUX/9FzCWH6Yv2mKaU7uZLa5uBRuAss+FbmEXjPIvKd74BUENBIMyKD0d9zZd3pUn7K09D
 6Rw2zIrO+c1YW/zYo9tvPj7f4VwI20FQxfjRHOzieAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
 5d3cxkNSAqwXSxSoYz7lB9nFc3dHtCLjgrTRXv/FIaFw7pvxi4s4foyet8Rzo=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] readlinkat: Remove readlinkat fallback
 definition
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

According to man readlink(2), glibc wrapper for readlinkat() was in glibc
2.4 (long time ago, the minimal glibc version we support is 2.17, see
doc/supported-kernel-libc-versions.txt). Therefore removed the fallback.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac              |  1 -
 include/lapi/readlinkat.h | 21 ---------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 include/lapi/readlinkat.h

diff --git a/configure.ac b/configure.ac
index 662c4c058..80943bdea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -133,7 +133,6 @@ AC_CHECK_FUNCS_ONCE([ \
     pwritev2 \
     quotactl_fd \
     rand_r \
-    readlinkat \
     recvmmsg \
     renameat \
     renameat2 \
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
deleted file mode 100644
index a680deeec..000000000
--- a/include/lapi/readlinkat.h
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- */
-
-#ifndef LAPI_READLINKAT_H__
-#define LAPI_READLINKAT_H__
-
-#include "config.h"
-#include "lapi/syscalls.h"
-#include "lapi/fcntl.h"
-
-#ifndef HAVE_READLINKAT
-static inline int readlinkat(int dirfd, const char *pathname,
-                             char *buf, size_t bufsiz)
-{
-	return tst_syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
-}
-#endif
-
-#endif /* LAPI_READLINKAT_H__ */
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
