Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1E8EE644C
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:38:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F11F63CE67B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:38:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385243CE6A8
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:37 +0200 (CEST)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16FA414088D0
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 11:37:35 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="111626701"
X-IronPort-AV: E=Sophos;i="6.02,148,1688396400"; d="scan'208";a="111626701"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 18:37:34 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DDEADE6AE
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:31 +0900 (JST)
Received: from aks-ab1.gw.nic.fujitsu.com (aks-ab1.gw.nic.fujitsu.com
 [192.51.207.11])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 30E86D5E20
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 18:37:30 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by aks-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A8822FC86A2;
 Fri, 15 Sep 2023 18:37:29 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Fri, 15 Sep 2023 17:37:09 +0800
Message-Id: <1694770631-9547-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27876.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27876.006
X-TMASE-Result: 10--5.212400-10.000000
X-TMASE-MatchedRID: 9cLxpQSnXiTlWiNI/3lAD6k29rFswht+TJDl9FKHbrmY5nVpihxiw5Uh
 t+myr0XMUh5maKIJAx/mn3xyPJAJogMWCgdCzp+aGYJhRh6ssesfimmlcABuN2PZr2NA6vZGzEB
 dkYlGYZRFFrjTpX9jDBP91RdGQH6y2DJQA8IHlR37IK6Q1+r9ntmhsJODizUsvnhgJqkfm0B9Jp
 pVNkb1K11W9WFbfQ57X1V6QVriY534q4fnJYkVIwzrPeIO/OIHczQnRrpmbEmbKItl61J/yZ+in
 TK0bC9eKrauXd3MZDWDG4IEHJUqudjdJsxFHzZj7GCxCmZWFcgu28IjqPKl+xyKYxgdxpPX
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] fchownat: Remove fchownat fallback definition
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

Looking at man fchownat, it was added into kernel 2.6.16 and since the
oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
.txt) we can as well completely drop this fallback definition.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 -
 testcases/kernel/syscalls/fchownat/fchownat.h | 37 -------------------
 .../kernel/syscalls/fchownat/fchownat01.c     |  1 -
 .../kernel/syscalls/fchownat/fchownat02.c     |  1 -
 4 files changed, 40 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/fchownat/fchownat.h

diff --git a/configure.ac b/configure.ac
index 80943bdea..ad216983a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -94,7 +94,6 @@ AC_CHECK_FUNCS_ONCE([ \
     execveat \
     faccessat2 \
     fallocate \
-    fchownat \
     fsconfig \
     fsmount \
     fsopen \
diff --git a/testcases/kernel/syscalls/fchownat/fchownat.h b/testcases/kernel/syscalls/fchownat/fchownat.h
deleted file mode 100644
index 927cf929a..000000000
--- a/testcases/kernel/syscalls/fchownat/fchownat.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
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
-#ifndef FCHOWNAT_H
-#define FCHOWNAT_H
-
-#include <sys/types.h>
-#include "config.h"
-#include "lapi/syscalls.h"
-
-
-#if !defined(HAVE_FCHOWNAT)
-static inline int fchownat(int dirfd, const char *filename, uid_t owner,
-		gid_t group, int flags)
-{
-	return tst_syscall(__NR_fchownat, dirfd, filename, owner, group, flags);
-}
-#endif
-
-
-#endif /* FCHOWNAT_H */
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 3b29f1e75..7771c111a 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -34,7 +34,6 @@
 
 #include "test.h"
 #include "safe_macros.h"
-#include "fchownat.h"
 #include "lapi/fcntl.h"
 
 #define TESTFILE	"testfile"
diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index c39b0a919..6dd1e024e 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -31,7 +31,6 @@
 #include <signal.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "fchownat.h"
 #include "lapi/fcntl.h"
 
 #define TESTFILE	"testfile"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
