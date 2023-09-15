Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFABEE644D
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1D613CE6A1
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:37:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0440B3C91D7
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:36:52 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3916E200ACB
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:36:51 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="120584212"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="120584212"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:36:49 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B7AB3CD6E0
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:36:47 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com
 [192.51.207.12])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0620FD2168
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:36:47 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 35E638715F;
 Fri, 15 Sep 2023 18:36:46 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:36:27 +0800
Message-Id: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--6.845200-10.000000
X-TMASE-MatchedRID: oZ2BGVt09n3lWiNI/3lAD6k29rFswht+TJDl9FKHbrmY5nVpihxiw5Uh
 t+myr0XMUh5maKIJAx/mn3xyPJAJogMWCgdCzp+aGYJhRh6ssesfimmlcABuN8SiwizsgluQZFs
 e88ecrojiLXraR1F7boad3d4g0e7YkfRhdidsajMURSScn+QSXt0H8LFZNFG7bkV4e2xSge6x5X
 O8Er77ZfMsr3dTdCwLBXkebNmVXbH2ApC7AaTInh/BXqwE9HSW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
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

Looking at man renameat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 -
 include/lapi/renameat.h                       | 23 -------------------
 .../kernel/syscalls/renameat/renameat01.c     |  1 -
 3 files changed, 25 deletions(-)
 delete mode 100644 include/lapi/renameat.h

diff --git a/configure.ac b/configure.ac
index 662c4c058..30a6f56e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -135,7 +135,6 @@ AC_CHECK_FUNCS_ONCE([ \
     rand_r \
     readlinkat \
     recvmmsg \
-    renameat \
     renameat2 \
     sched_getcpu \
     sendmmsg \
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
