Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E74CDB474
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 06:35:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DFAE3CD117
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:35:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04633C8689
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:10 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A037C1001163
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:09 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="115812769"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; d="scan'208";a="115812769"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 15:35:08 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B33FD9DA5
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:05 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 49A74D3F03
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B82C420077823
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6FF971A0074;
 Tue, 17 Oct 2023 14:35:03 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 17 Oct 2023 14:34:50 +0800
Message-Id: <1697524491-4749-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27940.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27940.005
X-TMASE-Result: 10--8.873000-10.000000
X-TMASE-MatchedRID: f47Txdg+jHbNHx7Eti3qF3zmmMD/HXF+9LMB0hXFSegbIVTME6y/cG8q
 nFk+BWUX/9FzCWH6Yv2mKaU7uZLa5uBRuAss+FbmEXjPIvKd74BUENBIMyKD0d9zZd3pUn7K09D
 6Rw2zIrO+c1YW/zYo9tvPj7f4VwI2h2Em++ruuH9rzsINdopFUqL87sABtxp0myiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1tPWjpfl+Gwd6wv9C0K+zb73MvrUfTCvne9u3Y+jzuYE7MXDPcPHjOQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] mkdirat: Remove mkdirat fallback definition
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

According to man mkdir(2), glibc wrapper for mkdirat() was in glibc
2.4 (long time ago, the minimal glibc version we support is 2.17, see
doc/supported-kernel-libc-versions.txt). Therefore removed the fallback.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
