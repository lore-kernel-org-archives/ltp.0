Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433C4C77B7F
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 09:57:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D6513CD77A
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 11:57:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B33C73C0189
 for <ltp@lists.linux.it>; Mon,  8 May 2023 11:57:44 +0200 (CEST)
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B56E2001A6
 for <ltp@lists.linux.it>; Mon,  8 May 2023 11:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1683539862; i=@fujitsu.com;
 bh=zxBlC0KPRs8Qt50mIz1E6anATi/gAJH0Vxo2P1Ya+HY=;
 h=From:To:Cc:Subject:Date:Message-Id;
 b=vnl3YxocXHxAGDnPpXugks9vaUmieCvpT4vX6c/qZNMnILfbjhh8f5caFf511iVW5
 zyY5QFnYLpOQm6xPIFPEa8FVUkWMIquTaSIEUcLjCCsLBF32e6oxAw7SjEWTVGUFnB
 aqwdBpXAkgxBUvQ0pPw276Gcg8QJ/Kn60Ulopc+2Xdz0192AvzgqpUcTyu3ZwhqwHj
 VPpIzfgsYk+Kd+8b+C2Uq5F4z/MaFowpb9NBIQlRAp7eMS7vqPgsbcrxdPpInlNfG7
 KeIO4BOw5XO3SVwZeauhFFBoQ0XXCNITLnUSIn6I4dZa9CV5woD2geMHuS73ARwA9e
 nPT6s9KIvtP+A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRWlGSWpSXmKPExsViZ8ORpDvteES
 KwYspLBYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8b+iTfYCl7oVLyb/JuxgfGwehcjF4eQwEZG
 iQN935kgnOlMEkvanrF1MXJysAloSjzrXMAMYosIiElc3/CKFcRmFlCX+Hr8EVhcWMBd4um7H
 2D1LAKqEq9vdzOB2LwCHhInOz+DxSUEFCSmPHzPDGGrSVw9t4l5AiPXAkaGVYxmxalFZalFus
 Z6SUWZ6RkluYmZOXqJVbqJeqmlunn5RSUZuoZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBXk4pTnb
 dwXhh51+9Q4ySHExKorymB8NShPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwtm2LSBESLEpNT61I
 y8wBBhxMWoKDR0mEV/YIUJq3uCAxtzgzHSJ1ilFRSpw37ChQQgAkkVGaB9cGC/JLjLJSwryMD
 AwMQjwFqUW5mSWo8q8YxTkYlYR5q0HG82TmlcBNfwW0mAlosf/lcJDFJYkIKakGpvnB622Yb0
 YeXKUTtSGs7PuLzzU7nuflHfvu+E70esUE85Wr90Xrap/8nSHm8TxFY+bJqs0F0TJ2pwNT9ng
 /lL8bITDXYeWGqVe/TeFU5jv3aUYev9b1hF0mhoEpxlclQsRCfnf1h79RZjjaoFYcWf7i5e3k
 BF6OtS/eH3DKDOV3ScydeP+7S137Bv4Vb4R2rxGOfMFaLzMjfOq6L1tvXLr3/Ne1hJyn81/Ex
 cd4J7VK1vlfddBwUWTvM1zml7512ryuVTbdEZPto5fG5l8qLE9mT3DZ7mi0YDn7pkkdNeycc7
 QeXerqdwtwKz18VnDj069PnQQ2tvIUeBnv0v2Y0TL3sXHOnkOBa8yqj7B/UGIpzkg01GIuKk4
 EANffZ3XtAgAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-5.tower-745.messagelabs.com!1683539861!490687!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 304 invoked from network); 8 May 2023 09:57:42 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
 by server-5.tower-745.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 8 May 2023 09:57:42 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 7AFE61C2;
 Mon,  8 May 2023 10:57:41 +0100 (BST)
Received: from localhost.localdomain (unknown [10.167.215.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9DFF21CF;
 Mon,  8 May 2023 10:57:40 +0100 (BST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: ltp@lists.linux.it
Date: Mon,  8 May 2023 17:57:35 +0800
Message-Id: <1683539855-9414-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] include/lapi: Move AT_* related macros to fcntl header
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
