Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0154CDB482
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 06:35:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADB3A3CB0B8
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:35:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77C7F3C867C
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:10 +0200 (CEST)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D046B1001164
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:35:09 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="115259086"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; d="scan'208";a="115259086"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 15:35:07 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2EBB8DDC70
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:05 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 563FED947F
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id E1B4A6BC66
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 15:35:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9B4B01A0071;
 Tue, 17 Oct 2023 14:35:03 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue, 17 Oct 2023 14:34:51 +0800
Message-Id: <1697524491-4749-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1697524491-4749-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27940.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27940.005
X-TMASE-Result: 10--4.367000-10.000000
X-TMASE-MatchedRID: fwgrWm+rN+7NHx7Eti3qF3zmmMD/HXF+9LMB0hXFSegbIVTME6y/cG8q
 nFk+BWUX/9FzCWH6Yv2mKaU7uZLa5uBRuAss+FbmEXjPIvKd74BUENBIMyKD0d9zZd3pUn7K09D
 6Rw2zIrM2xy17I1v5+MLhuxAeSGkvk0XqNqzb6viIf3m0sUfx51n4Ir4HFD2Tbbi1bZH3/tAO6K
 /U9JNWfhBPzZigGafMMVObZjZKQv6MvS6YrcyiVL0dPFETpBAHF2jIWUnlRQxrP69Zr8TY06PFj
 JEFr+olwXCBO/GKkVqOhzOa6g8KrZUnBEgZglCJ423/22SHfMNX4F2lpDGzddXybub+x3sKNEMv
 QvujcOJ1RoGBYhvMYqKJTihUf+uq6MXkNbNMGdiAawnyie7cJB0m4Rm5hspVxSSu8i52URmXTt0
 OuyJi/IIuEVM/dBEMBtjAKW7+qHc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] mknodat: Remove mknodat fallback definition
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

According to man mknod(2), glibc wrapper for mknodat() was in glibc
2.4 (long time ago, the minimal glibc version we support is 2.17, see
doc/supported-kernel-libc-versions.txt). Therefore removed the fallback.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                                  |  1 -
 testcases/kernel/syscalls/mknodat/mknodat.h   | 35 -------------------
 testcases/kernel/syscalls/mknodat/mknodat01.c |  1 -
 testcases/kernel/syscalls/mknodat/mknodat02.c |  2 +-
 4 files changed, 1 insertion(+), 38 deletions(-)
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
index eda247fda..fdac5db15 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -37,7 +37,7 @@
 #include "test.h"
 #include "safe_macros.h"
 #include "lapi/fcntl.h"
-#include "mknodat.h"
+#include "lapi/syscalls.h"
 
 static void setup(void);
 static void cleanup(void);
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
