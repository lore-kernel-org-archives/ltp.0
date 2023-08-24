Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEE1C3DA6F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:11:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ABDD3CC556
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 13:11:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6C5A3CB9B3
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:10:39 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B86351A00CDE
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:10:38 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="108759523"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; d="scan'208";a="108759523"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:10:35 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 230C2D29E5
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:10:30 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 574EFBCB66
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:10:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9B5072FC8ECB;
 Thu, 24 Aug 2023 20:10:28 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 19:10:23 +0800
Message-Id: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27832.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27832.007
X-TMASE-Result: 10--9.908100-10.000000
X-TMASE-MatchedRID: mJkk328f4R7yq/cli2hvDbnHu4BcYSmtlwT0XposETW+f7ap9DJaDb8F
 Hrw7frluNIBrw7gT13Qv/zJQ0aiPJlE/ARLVFdXaQQp1SVSsqYB9v5k7uQeUSAPHqiqIXxKGhWu
 Tnji2QNji8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSkj80Za3RRg8HH63hlWOVEScWM56Juha+4nY3
 +oiFI4o/mzI7eBx4l0zruA0Aqz72g=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/renameat: Remove renameat fallback
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/renameat.h                       | 23 -------------------
 .../kernel/syscalls/renameat/renameat01.c     |  1 -
 2 files changed, 24 deletions(-)
 delete mode 100644 include/lapi/renameat.h

diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
deleted file mode 100644
index abf4c1d6e..000000000
--- a/include/lapi/renameat.h
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) International Business Machines  Corp., 2007
- * Copyright (c) 2014 Fujitsu Ltd.
- */
-
-#ifndef LAPI_RENAMEAT_H__
-#define LAPI_RENAMEAT_H__
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_RENAMEAT)
-static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
-                           const char *newpath)
-{
-	return tst_syscall(__NR_renameat, olddirfd, oldpath, newdirfd,
-					newpath);
-}
-#endif
-
-#endif /* LAPI_RENAMEAT_H__ */
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 3de103563..c318a7971 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -50,7 +50,6 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "lapi/renameat.h"
 
 #define MNTPOINT "mntpoint"
 #define TESTDIR "testdir"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
