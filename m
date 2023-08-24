Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A118DC3DA6F
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 11:10:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47C543CC4B8
	for <ltp@archiver.kernel.org>; Thu, 24 Aug 2023 13:10:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32FE93CB9B3
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:10:39 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A505B60154A
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 13:10:37 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="117572305"
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; d="scan'208";a="117572305"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2023 20:10:34 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7178E9FD86
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:10:30 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BF134D67A7
 for <ltp@lists.linux.it>; Thu, 24 Aug 2023 20:10:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 072402FC8ED4;
 Thu, 24 Aug 2023 20:10:28 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Thu, 24 Aug 2023 19:10:24 +0800
Message-Id: <1692875424-22449-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692875424-22449-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27832.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27832.007
X-TMASE-Result: 10--5.907300-10.000000
X-TMASE-MatchedRID: DSrurHRS2Lnyq/cli2hvDbnHu4BcYSmtlwT0XposETW+f7ap9DJaDb8F
 Hrw7frluNIBrw7gT13Qv/zJQ0aiPJlPlr5afWtNU7TovvZPhLcB1zSnwpu89bft9kl8N0Ihcj3d
 ZSyALReJZZO2km095FRza9vQBPvMp2FMcgddyBa+RgPzABkqxIJ+Z30eyNnRTS7NxD4SLUR2Fa5
 OeOLZA2OLzNWBegCW2wgn7iDBesS0gBwKKRHe+r9hCnU5/RzSOrTkKc723rYRW+praPy4gvmDZF
 y2yqLlJJRoxBwca3Zs=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/renameat2: Remove renameat2 fallback
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
 .../kernel/syscalls/renameat2/renameat2.h     | 35 -------------------
 .../kernel/syscalls/renameat2/renameat201.c   |  2 +-
 .../kernel/syscalls/renameat2/renameat202.c   |  2 +-
 3 files changed, 2 insertions(+), 37 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/renameat2/renameat2.h

diff --git a/testcases/kernel/syscalls/renameat2/renameat2.h b/testcases/kernel/syscalls/renameat2/renameat2.h
deleted file mode 100644
index c4688ed53..000000000
--- a/testcases/kernel/syscalls/renameat2/renameat2.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#ifndef RENAMEAT2_H
-#define RENAMEAT2_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_RENAMEAT2)
-int renameat2(int olddirfd, const char *oldpath, int newdirfd,
-				const char *newpath, unsigned int flags)
-{
-	return tst_syscall(__NR_renameat2, olddirfd, oldpath, newdirfd,
-						newpath, flags);
-}
-#endif
-
-#endif /* RENAMEAT2_H */
diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index 9832b1cdb..ff1747b8d 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -37,7 +37,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "renameat2.h"
+#include <errno.h>
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 0c1457022..ef3df3e91 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -26,7 +26,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "renameat2.h"
+#include <errno.h>
 
 #define TEST_DIR "test_dir/"
 #define TEST_DIR2 "test_dir2/"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
