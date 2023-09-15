Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B027FEE644B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:37:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24F973CE6CB
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:37:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7933C91D7
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:35 +0200 (CEST)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0DC7F14088C1
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:34 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="120062081"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="120062081"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:37:32 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 86697E8520
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:30 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C7A57D67BF
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id CD8322FC84EB;
 Fri, 15 Sep 2023 18:37:28 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:37:08 +0800
Message-Id: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--3.997200-10.000000
X-TMASE-MatchedRID: zB9INLamWmDlWiNI/3lAD6k29rFswht+CZa9cSpBObmkob0Y35+HFI3c
 eRXYSJoDIvrftAIhWmLy9zcRSkKatQ719kpOO37PGYJhRh6ssesfimmlcABuN8SiwizsgluQ3Ff
 7+xvoE8E0Ud/DTXbN04Ay6p60ZV62yA7duzCw6dLdB/CxWTRRu+rAZ8KTspSzFRAwrM8g3Wc6Ay
 UgKhBXazpCWadpbaSQWNBhTCVa2BwI39QJ5zTPKFgzF9RetWxsrYp896LkFBdguBiRRzeQeoSmP
 B/BHMjhiB6mlDKe1V7S/yytHeCN9GXv4CQeNUk7G6qTOwq/n71+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] readlinkat: Remove readlinkat fallback definition
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

Looking at man readlinkat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

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
