Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E04DC35FF1
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 11:59:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B1773CA6CC
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 12:59:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65C633CA6AF
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 12:59:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E71F10005DB
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 12:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741953539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OgqoEuxLMpvMgF2oLNvTwu01DZ/4nmJSF/zS4/PTru4=;
 b=YygN9L5TqnWSvvyQEFSYmH/zNzsSHHXkEmSRsPir3mIg+gVgVOFQb6Oqra/oy7J93O64Iz
 MRj1t+kv1qm50Zdgwg/QHBdjbk2rozdhZ2HV0SLtYboQFkmlIPGbvcse6RuhNCT8O7QB2A
 0bEtbM2j8DaF7vZPOaULukIYtqC8e3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-EmcUKPcoNiWlRiBAx30h9Q-1; Fri,
 14 Mar 2025 07:58:57 -0400
X-MC-Unique: EmcUKPcoNiWlRiBAx30h9Q-1
X-Mimecast-MFC-AGG-ID: EmcUKPcoNiWlRiBAx30h9Q_1741953536
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C941180882E; Fri, 14 Mar 2025 11:58:56 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFBCA1955BCB; Fri, 14 Mar 2025 11:58:53 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 14 Mar 2025 19:58:48 +0800
Message-ID: <20250314115848.173676-1-liwang@redhat.com>
In-Reply-To: <20250314023120.169820-1-liwang@redhat.com>
References: <20250314023120.169820-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GPzgl7Ogi7aIxZhaub1nhmqr_6kmPIQCxLGIDJB9Wuo_1741953536
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] ioctl_loop06: update loopback block size validation
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
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel commit 47dd6753 ("block/bdev: lift block size restrictions to 64k")
now supports block sizes larger than PAGE_SIZE, with a new upper limit of
BLK_MAX_BLOCK_SIZE (64K). But ioctl_loop06 still assumes that PAGE_SIZE is the
maximum allowed block size, causing failures on newer kernels(>= 6.14):

  ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
  ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
  ...
  ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
  ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly

This patch updates ioctl_loop06 to use BLK_MAX_BLOCK_SIZE instead of PAGE_SIZE
for block size validation.

And, dynamically sets bs based on BLK_MAX_BLOCK_SIZE, using 1024 bytes if it's
below 1MB or scaling it otherwise. Ensures tst_fill_file() writes efficiently
while maintaining compatibility across different kernel versions.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
---
 configure.ac                                  |  1 +
 include/lapi/blkdev.h                         | 19 +++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_loop06.c      | 12 ++++++++----
 3 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 include/lapi/blkdev.h

diff --git a/configure.ac b/configure.ac
index 0f2b6f332..5538d88d5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,7 @@ AC_CHECK_HEADERS_ONCE([ \
     emmintrin.h \
     ifaddrs.h \
     keyutils.h \
+    linux/blkdev.h \
     linux/can.h \
     linux/cgroupstats.h \
     linux/cryptouser.h \
diff --git a/include/lapi/blkdev.h b/include/lapi/blkdev.h
new file mode 100644
index 000000000..3ee058ce0
--- /dev/null
+++ b/include/lapi/blkdev.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Linux Test Project
+ *  Li Wang <liwang@redhat.com>
+ */
+
+#ifndef LAPI_BLKDEV_H__
+#define LAPI_BLKDEV_H__
+
+#ifdef HAVE_LINUX_BLKDEV_H
+#include <linux/blkdev.h>
+#endif
+
+/* Define BLK_MAX_BLOCK_SIZE for older kernels */
+#ifndef BLK_MAX_BLOCK_SIZE
+#define BLK_MAX_BLOCK_SIZE 0x00010000 /* 64K */
+#endif
+
+#endif /* LAPI_BLKDEV_H */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 573871bc1..35e9e79e9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -14,7 +14,9 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <stdlib.h>
+#include "lapi/blkdev.h"
 #include "lapi/loop.h"
+#include "tst_fs.h"
 #include "tst_test.h"
 
 static char dev_path[1024];
@@ -31,7 +33,7 @@ static struct tcase {
 	"Using LOOP_SET_BLOCK_SIZE with arg < 512"},
 
 	{&invalid_value, LOOP_SET_BLOCK_SIZE,
-	"Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE"},
+	"Using LOOP_SET_BLOCK_SIZE with arg > BLK_MAX_BLOCK_SIZE"},
 
 	{&unalign_value, LOOP_SET_BLOCK_SIZE,
 	"Using LOOP_SET_BLOCK_SIZE with arg != power_of_2"},
@@ -40,7 +42,7 @@ static struct tcase {
 	"Using LOOP_CONFIGURE with block_size < 512"},
 
 	{&invalid_value, LOOP_CONFIGURE,
-	"Using LOOP_CONFIGURE with block_size > PAGE_SIZE"},
+	"Using LOOP_CONFIGURE with block_size > BLK_MAX_BLOCK_SIZE"},
 
 	{&unalign_value, LOOP_CONFIGURE,
 	"Using LOOP_CONFIGURE with block_size != power_of_2"},
@@ -103,10 +105,12 @@ static void setup(void)
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
 
-	tst_fill_file("test.img", 0, 1024, 1024);
+	size_t bs = (BLK_MAX_BLOCK_SIZE < TST_MB) ? 1024 : 4 * BLK_MAX_BLOCK_SIZE / 1024;
+	tst_fill_file("test.img", 0, bs, 1024);
+
 	half_value = 256;
 	pg_size = getpagesize();
-	invalid_value = pg_size * 2 ;
+	invalid_value = BLK_MAX_BLOCK_SIZE * 2;
 	unalign_value = pg_size - 1;
 
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
