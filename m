Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B859FEE644C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:37:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 658D53CE6A3
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:37:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A37B53C91D7
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:35 +0200 (CEST)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9CB61A0433B
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:34 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="133668277"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="133668277"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:37:34 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E975D29E1
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:31 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8DDF6D5D71
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id B28642FC89F8;
 Fri, 15 Sep 2023 18:37:29 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:37:10 +0800
Message-Id: <1694770631-9547-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--6.598200-10.000000
X-TMASE-MatchedRID: oZ2BGVt09n3lWiNI/3lAD6k29rFswht+CZa9cSpBObmkob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatQ719kpOO37PGYJhRh6ssesfimmlcABuN8SiwizsgluQ3Ff
 7+xvoE8G1h3Ci3ttLrXl1Omgm8char78SC5iivxwURSScn+QSXt0H8LFZNFG7bkV4e2xSge4/9e
 uk4jHZZ87/6D6t6w5xRLWs9Ij5tQYP0H6X/zHpSR/BXqwE9HSW
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] mkdirat: Remove mkdirat fallback definition
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

Looking at man mkdirat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 -
 include/lapi/mkdirat.h                        | 20 -------------------
 testcases/kernel/syscalls/mkdirat/mkdirat01.c |  1 -
 testcases/kernel/syscalls/mkdirat/mkdirat02.c |  1 -
 4 files changed, 23 deletions(-)
 delete mode 100644 include/lapi/mkdirat.h

diff --git a/configure.ac b/configure.ac
index ad216983a..4cada09ed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,7 +112,6 @@ AC_CHECK_FUNCS_ONCE([ \
     mallinfo \
     mallinfo2 \
     mallopt \
-    mkdirat \
     mknodat \
     modify_ldt \
     mount_setattr \
diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
deleted file mode 100644
index 72eb7f647..000000000
--- a/include/lapi/mkdirat.h
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
- */
-
-#ifndef LAPI_MKDIRAT_H__
-#define LAPI_MKDIRAT_H__
-
-#include "config.h"
-#include "lapi/syscalls.h"
-#include "lapi/fcntl.h"
-
-#ifndef HAVE_MKDIRAT
-static inline int mkdirat(int dirfd, const char *dirname, int mode)
-{
-	return tst_syscall(__NR_mkdirat, dirfd, dirname, mode);
-}
-#endif
-
-#endif /* LAPI_MKDIRAT_H__ */
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index a323ed5b3..ca536bdab 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -35,7 +35,6 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "lapi/mkdirat.h"
 #include "safe_macros.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index ebc0ed16b..2bd8fe9c0 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -11,7 +11,6 @@
 
 #define _GNU_SOURCE
 #include "tst_test.h"
-#include "lapi/mkdirat.h"
 
 #define MNT_POINT	"mntpoint"
 #define TEST_DIR	"mntpoint/test_dir"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
