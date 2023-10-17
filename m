Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C5CDB483
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 06:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418713CD0F8
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:35:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE3A23C867C
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:10 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AA761001161
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:08 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="115832194"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; d="scan'208";a="115832194"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 15:35:07 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id B8DA9CD7E3
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E3305D500F
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 882AC200649E5
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 454BF1A0073;
 Tue, 17 Oct 2023 14:35:03 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 17 Oct 2023 14:34:49 +0800
Message-Id: <1697524491-4749-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27940.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27940.005
X-TMASE-Result: 10--5.344200-10.000000
X-TMASE-MatchedRID: g28vi0ST7T7NHx7Eti3qF3zmmMD/HXF+9LMB0hXFSegbIVTME6y/cP44
 pYPD16CLKqrQ7lLcMnwt/DPtuO0OwdzZGrP764sOTuctSpiuWyUUi4Ehat05499zZd3pUn7K09D
 6Rw2zIrNrOeSZZ/TP21ZMEB4qppf1n/RflakI9hw5ZRbFNAl0jxRli5ttSPYMu3gEBpQvABUl/m
 i29q85l/29Pl68xfi0o3liy8xdG7gGYZSobNY0w+ScxJMb2Uf4F2jIWUnlRQxShcWO/83xooVrk
 544tkDY4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vc4CVorMAHnUPZvqll0oTWr0Ds9VnyCNHV74y
 7FHSnuqga6OLxJXuIg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] fchownat: Remove fchownat fallback definition
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

According to man chown(2), glibc wrapper for fchownat() was in glibc
2.4 (long time ago, the minimal glibc version we support is 2.17, see
doc/supported-kernel-libc-versions.txt). Therefore removed the fallback.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
