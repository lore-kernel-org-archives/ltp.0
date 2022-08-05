Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74479C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 06:34:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E32763C9274
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 08:34:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 796E53C1BDC
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:34:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93A181400332
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 08:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659681251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAVyQVLr7sYQgBnKjv/qZ1+WBmmI6WacqH0YM62Wypw=;
 b=cSYlcf6zDaKNhS0NJxh22ZDe9EnODpeuWzEQlAsLNdM8tPLkjr+0ptDlwC61kS1GIh4ro+
 Zj6b5nBn0W7cxVuPrjthYL16Ufyk0GmzUVHZqmfc1sRdXzIf/lSZOY9Wxc3kuFUilN2toj
 TIhCMw9a/dui41NH+y/vFjs7fsIsyAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-Ow4nw6RyO_uL1Pxn4xNixg-1; Fri, 05 Aug 2022 02:34:08 -0400
X-MC-Unique: Ow4nw6RyO_uL1Pxn4xNixg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 89EB2802D1C;
 Fri,  5 Aug 2022 06:34:08 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5121C1415122;
 Fri,  5 Aug 2022 06:34:07 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  5 Aug 2022 14:34:01 +0800
Message-Id: <20220805063401.1647479-3-liwang@redhat.com>
In-Reply-To: <20220805063401.1647479-1-liwang@redhat.com>
References: <20220805063401.1647479-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] lapi/fsmount: resolve conflict in different
 header files
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The latest glibc added new wrappers (e.g. mount_setattr, fsopen) support
in sys/mount.h, which partly conflicts with linux/mount.h at the same time.

We need to make adjustments to header files to fix compiling error on
different platforms.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 configure.ac                                              | 1 +
 include/lapi/fs.h                                         | 6 ++++--
 include/lapi/fsmount.h                                    | 6 ++++--
 testcases/kernel/syscalls/fsconfig/fsconfig01.c           | 1 +
 testcases/kernel/syscalls/fsconfig/fsconfig02.c           | 1 +
 testcases/kernel/syscalls/fsmount/fsmount01.c             | 1 +
 testcases/kernel/syscalls/fsmount/fsmount02.c             | 1 +
 testcases/kernel/syscalls/fsopen/fsopen01.c               | 1 +
 testcases/kernel/syscalls/fsopen/fsopen02.c               | 1 +
 testcases/kernel/syscalls/fspick/fspick01.c               | 1 +
 testcases/kernel/syscalls/fspick/fspick02.c               | 1 +
 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c | 1 +
 testcases/kernel/syscalls/move_mount/move_mount01.c       | 1 +
 testcases/kernel/syscalls/move_mount/move_mount02.c       | 1 +
 testcases/kernel/syscalls/open_tree/open_tree01.c         | 1 +
 testcases/kernel/syscalls/open_tree/open_tree02.c         | 1 +
 16 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index d50ec1ea7..dbd53cab6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -113,6 +113,7 @@ AC_CHECK_FUNCS_ONCE([ \
     mkdirat \
     mknodat \
     modify_ldt \
+    mount_setattr \
     move_mount \
     name_to_handle_at \
     open_tree \
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 27b3a183c..84a168a67 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -6,8 +6,10 @@
  * Email: code@zilogic.com
  */
 
-#ifdef HAVE_LINUX_FS_H
-# include <linux/fs.h>
+#ifndef HAVE_MOUNT_SETATTR
+# ifdef HAVE_LINUX_FS_H
+#  include <linux/fs.h>
+# endif
 #endif
 
 #include <sys/user.h>
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index b11e7a7bd..9b1993580 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -12,8 +12,10 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#ifdef HAVE_LINUX_MOUNT_H
-# include <linux/mount.h>
+#ifndef HAVE_FSOPEN
+# ifdef HAVE_LINUX_MOUNT_H
+#  include <linux/mount.h>
+# endif
 #endif
 
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index a585daa6d..f1dc7d8da 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -5,6 +5,7 @@
  * Basic fsconfig() test which tries to configure and mount the filesystem as
  * well.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
index 272e25a6f..bbad6def6 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
@@ -4,6 +4,7 @@
  *
  * Basic fsconfig() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 5f755863f..1232b0914 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -6,6 +6,7 @@
  * Basic fsmount() test.
  */
 
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index a4f42dc18..91512b74a 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -4,6 +4,7 @@
  *
  * Basic fsmount() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index c2c719c96..332821cf0 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -5,6 +5,7 @@
  * Basic fsopen() test which tries to configure and mount the filesystem as
  * well.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fsopen/fsopen02.c b/testcases/kernel/syscalls/fsopen/fsopen02.c
index 3f287bf29..8c643b9a8 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen02.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen02.c
@@ -4,6 +4,7 @@
  *
  * Basic fsopen() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d3309a912..ae6cad6fb 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -4,6 +4,7 @@
  *
  * Basic fspick() test.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
index f9a3697c1..907b463b6 100644
--- a/testcases/kernel/syscalls/fspick/fspick02.c
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -4,6 +4,7 @@
  *
  * Basic fspick() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
index 83746b878..fcf491c33 100644
--- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
+++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
@@ -30,6 +30,7 @@
 #define _GNU_SOURCE
 
 #include <sys/statvfs.h>
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 #include "lapi/stat.h"
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
index 445e6197e..b65141a28 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount01.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -4,6 +4,7 @@
  *
  * Basic move_mount() test.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
index 45b1db4be..373c8c3ac 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount02.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -4,6 +4,7 @@
  *
  * Basic move_mount() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index 808d25665..6d2299449 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -4,6 +4,7 @@
  *
  * Basic open_tree() test.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index ddaa204f2..59a5a4ca2 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -4,6 +4,7 @@
  *
  * Basic open_tree() failure tests.
  */
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fsmount.h"
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
