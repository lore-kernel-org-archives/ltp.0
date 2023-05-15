Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A1AC7EE22
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 07:12:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A893CD4D9
	for <ltp@archiver.kernel.org>; Mon, 15 May 2023 09:12:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 371073CB399
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:37 +0200 (CEST)
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com
 [139.138.37.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3EFFE1000364
 for <ltp@lists.linux.it>; Mon, 15 May 2023 09:11:35 +0200 (CEST)
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="96161832"
X-IronPort-AV: E=Sophos;i="5.99,275,1677510000"; d="scan'208";a="96161832"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 16:11:33 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D4EDBDAE0B
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:31 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 218E5D9684
 for <ltp@lists.linux.it>; Mon, 15 May 2023 16:11:31 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 80BF530C41B;
 Mon, 15 May 2023 16:11:28 +0900 (JST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon, 15 May 2023 15:11:15 +0800
Message-Id: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27626.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27626.005
X-TMASE-Result: 10--10.883500-10.000000
X-TMASE-MatchedRID: s7S5NEjjqbIlVaqTQ2WNXAPZZctd3P4B9LMB0hXFSeg6FHRWx2FGsL8F
 Hrw7frluExqOGx2ANwDP3SmNGQQp6aeib5Lo7aoE5JzEkxvZR/h9v5k7uQeUSEz5vzLEGq8D1mC
 Eto57x1hwPkS7ze2lNW9yZj3aufb5HxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwOuZOpJeStO6P/o
 v8U7qJOBIQNaMX9o9CeJiF+HRhiaN9cvcpygJLoQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/6] include/lapi: Move AT_* related macros to
 fcntl header
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

These AT* macro is belong to fcntl.h instead of stat.h.
So move them.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/fcntl.h                          | 32 +++++++++++++----
 include/lapi/stat.h                           | 36 -------------------
 .../syscalls/mount_setattr/mount_setattr01.c  |  2 +-
 testcases/kernel/syscalls/statx/statx01.c     |  1 +
 testcases/kernel/syscalls/statx/statx02.c     |  1 +
 testcases/kernel/syscalls/statx/statx05.c     |  1 +
 testcases/kernel/syscalls/statx/statx07.c     |  1 +
 testcases/kernel/syscalls/statx/statx08.c     |  1 +
 testcases/kernel/syscalls/statx/statx09.c     |  1 +
 9 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index f17220737..8fc92c521 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -87,20 +87,40 @@
 # define AT_FDCWD -100
 #endif
 
+#ifndef AT_SYMLINK_NOFOLLOW
+# define AT_SYMLINK_NOFOLLOW 	0x100
+#endif
+
+#ifndef AT_REMOVEDIR
+# define AT_REMOVEDIR 		0x200
+#endif
+
 #ifndef AT_SYMLINK_FOLLOW
-# define AT_SYMLINK_FOLLOW 0x400
+# define AT_SYMLINK_FOLLOW	0x400
 #endif
 
-#ifndef AT_SYMLINK_NOFOLLOW
-# define AT_SYMLINK_NOFOLLOW 0x100
+#ifndef AT_NO_AUTOMOUNT
+# define AT_NO_AUTOMOUNT	0x800
 #endif
 
 #ifndef AT_EMPTY_PATH
-# define AT_EMPTY_PATH 0x1000
+# define AT_EMPTY_PATH		0x1000
 #endif
 
-#ifndef AT_REMOVEDIR
-# define AT_REMOVEDIR 0x200
+#ifndef AT_STATX_SYNC_AS_STAT
+# define AT_STATX_SYNC_AS_STAT	0x0000
+#endif
+
+#ifndef AT_STATX_FORCE_SYNC
+# define AT_STATX_FORCE_SYNC	0x2000
+#endif
+
+#ifndef AT_STATX_DONT_SYNC
+# define AT_STATX_DONT_SYNC	0x4000
+#endif
+
+#ifndef AT_STATX_SYNC_TYPE
+# define AT_STATX_SYNC_TYPE	0x6000
 #endif
 
 #ifndef O_NOATIME
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index ce1f2b678..590ccd111 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -227,40 +227,4 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
-#ifndef AT_SYMLINK_NOFOLLOW
-# define AT_SYMLINK_NOFOLLOW	0x100
-#endif
-
-#ifndef AT_REMOVEDIR
-# define AT_REMOVEDIR		0x200
-#endif
-
-#ifndef AT_SYMLINK_FOLLOW
-# define AT_SYMLINK_FOLLOW	0x400
-#endif
-
-#ifndef AT_NO_AUTOMOUNT
-# define AT_NO_AUTOMOUNT	0x800
-#endif
-
-#ifndef AT_EMPTY_PATH
-# define AT_EMPTY_PATH		0x1000
-#endif
-
-#ifndef AT_STATX_SYNC_TYPE
-# define AT_STATX_SYNC_TYPE	0x6000
-#endif
-
-#ifndef AT_STATX_SYNC_AS_STAT
-# define AT_STATX_SYNC_AS_STAT	0x0000
-#endif
-
-#ifndef AT_STATX_FORCE_SYNC
-# define AT_STATX_FORCE_SYNC	0x2000
-#endif
-
-#ifndef AT_STATX_DONT_SYNC
-# define AT_STATX_DONT_SYNC	0x4000
-#endif
-
 #endif /* LAPI_STAT_H__ */
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index 83746b878..616ec5341 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -32,7 +32,7 @@
 #include <sys/statvfs.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
-#include "lapi/stat.h"
+#include "lapi/fcntl.h"
 
 #define MNTPOINT        "mntpoint"
 #define OT_MNTPOINT     "ot_mntpoint"
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 68f56549f..f9c2748d2 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -33,6 +33,7 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 #include "tst_safe_stdio.h"
 #include <string.h>
 #include <inttypes.h>
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
index a8e868d7a..5ed80894d 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -28,6 +28,7 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 
 #define TESTFILE "test_temp"
 #define LINK_FILE "test_temp_ln"
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index f62dadd5c..9781b3e70 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -27,6 +27,7 @@
 #include "tst_test.h"
 #include "lapi/fs.h"
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 
 #define MNTPOINT "mnt_point"
 #define TESTDIR_FLAGGED MNTPOINT"/test_dir1"
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index b13c11f72..f688b1b0f 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -39,6 +39,7 @@
 #include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 
 #define MODE(X) (X & (~S_IFMT))
 #define FLAG_NAME(x) .flag = x, .flag_name = #x
diff --git a/testcases/kernel/syscalls/statx/statx08.c b/testcases/kernel/syscalls/statx/statx08.c
index 10b1ca460..64b36986d 100644
--- a/testcases/kernel/syscalls/statx/statx08.c
+++ b/testcases/kernel/syscalls/statx/statx08.c
@@ -26,6 +26,7 @@
 #include "lapi/fs.h"
 #include <stdlib.h>
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 
 #define MOUNT_POINT "mntpoint"
 #define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index aea329e08..c03d2c91e 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -24,6 +24,7 @@
 #include "lapi/fs.h"
 #include "lapi/fsverity.h"
 #include "lapi/stat.h"
+#include "lapi/fcntl.h"
 #include <inttypes.h>
 
 #define MNTPOINT "mnt_point"
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
