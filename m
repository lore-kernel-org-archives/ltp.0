Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E173FEE644C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:38:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E4943CE6F4
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:38:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84C683CB20B
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:36 +0200 (CEST)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90BD86000F2
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:35 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="120584288"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="120584288"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:37:33 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C3D51E8526
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:31 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 020C2C4A16
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:31 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 18B2B2FC84EB;
 Fri, 15 Sep 2023 18:37:30 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:37:11 +0800
Message-Id: <1694770631-9547-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--4.604200-10.000000
X-TMASE-MatchedRID: 9cLxpQSnXiTlWiNI/3lAD6k29rFswht+CZa9cSpBObmkob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatQ719kpOO37PGYJhRh6ssesYH39vFLryE+PI2XWbKwsOOJs
 RJjxHyGJAw4kSqNMMAIfMrh7F+bybTgY7kyERCi2q6D28gDZY4NMB70WyBtjHF37G3EfwWzGoJ9
 4iUSxxTozMbWCcXJJOr8qg4mThTB9XDwaouY0y7qqHmm/V4M/P37jcLTY9yESbKItl61J/yZ+in
 TK0bC9eKrauXd3MZDWekdWKLl/MQXEhiWUGbgmi3BvLJyToIIzFPSMyl27wAaFY2IWdGDXy1/7P
 ITEP+7HFdA3F6JNBxwOuLhE2NJk5KGWfT+PMxpGAcjH79gRLW1PJnXL2yNYdkuo847l05tDEzMy
 Amsz+FHoWLWlXcsZv
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] mknodat: Remove mknodat fallback definition
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

Looking at man mknodat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 -
 testcases/kernel/syscalls/mknodat/mknodat.h   | 35 -------------------
 testcases/kernel/syscalls/mknodat/mknodat01.c |  1 -
 testcases/kernel/syscalls/mknodat/mknodat02.c |  4 +--
 4 files changed, 1 insertion(+), 40 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/mknodat/mknodat.h

diff --git a/configure.ac b/configure.ac
index 4cada09ed..ee14504bb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -112,7 +112,6 @@ AC_CHECK_FUNCS_ONCE([ \
     mallinfo \
     mallinfo2 \
     mallopt \
-    mknodat \
     modify_ldt \
     mount_setattr \
     move_mount \
diff --git a/testcases/kernel/syscalls/mknodat/mknodat.h b/testcases/kernel/syscalls/mknodat/mknodat.h
deleted file mode 100644
index 8f3a1f007..000000000
--- a/testcases/kernel/syscalls/mknodat/mknodat.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2007
- * Copyright (c) 2014 Fujitsu Ltd.
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU Library General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- *
- */
-
-#ifndef MKNODAT_H
-#define MKNODAT_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-#if !defined(HAVE_MKNODAT)
-int mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
-{
-	return tst_syscall(__NR_mknodat, dirfd, filename, mode, dev);
-}
-#endif
-
-#endif /* MKNODAT_H */
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 6500ca362..3be0a4f87 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -35,7 +35,6 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "mknodat.h"
 
 #define PATHNAME "mknodattestdir"
 
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index eda247fda..d2ba6d942 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -37,7 +37,6 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "mknodat.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -157,8 +156,7 @@ static void mknodat_verify(struct test_case_t *tc)
 			 strerror(tc->exp_errno));
 	}
 
-	if (TEST_ERRNO == 0 &&
-	    tst_syscall(__NR_unlinkat, fd, pathname, 0) < 0) {
+	if (TEST_ERRNO == 0 && unlinkat(fd, pathname, 0) < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup, "unlinkat(%d, %s) "
 			 "failed.", fd, pathname);
 	}
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
