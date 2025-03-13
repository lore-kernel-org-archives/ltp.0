Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D6DC282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:25:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F68F3CA4F1
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:25:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B3B3CA4D2
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:24:59 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6DDB610007CD
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:24:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741857896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PsVAmhqiUWFuB2ziQ0ITzO7uKtxYAF5g4Ro38aj8mak=;
 b=a8xevz0Wbmo+ac1kIXKBCZrHmwOgmi0bM+wl7bJ0tj0I0+m4Buv8vdkAFiLLKi4edQTQ3Z
 o6TmJnmxwGT73A8/2D6ZaJdtggePGMX9aCnHLScCSmaqGLEHIT1ZysD6iCGIrtOaECWMGn
 yjiznFm/JpNANxNJFqA7Br6sjMcZ3ds=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-orCeVLcBON6Xeyzj4ccdxQ-1; Thu,
 13 Mar 2025 05:24:54 -0400
X-MC-Unique: orCeVLcBON6Xeyzj4ccdxQ-1
X-Mimecast-MFC-AGG-ID: orCeVLcBON6Xeyzj4ccdxQ_1741857893
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E7C19560BD; Thu, 13 Mar 2025 09:24:53 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A50CB19373D7; Thu, 13 Mar 2025 09:24:49 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 13 Mar 2025 17:24:45 +0800
Message-ID: <20250313092445.164616-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YV8vlDVynU2owIwjUUz4oVpKkWZDDnQOCqeP9LW69P0_1741857893
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_loop06: update loopback block size validation
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

And, we give up the test size between (PAGE_SIZE, BLK_MAX_BLOCK_SIZE) even on
old kernels becase it makes no sense.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 573871bc1..238a7c6f5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -17,6 +17,8 @@
 #include "lapi/loop.h"
 #include "tst_test.h"
 
+#define BLK_MAX_BLOCK_SIZE 0x00010000 /* SZ_64K */
+
 static char dev_path[1024];
 static int dev_num, dev_fd, file_fd, attach_flag, loop_configure_sup = 1;
 static unsigned int invalid_value, half_value, unalign_value;
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
@@ -106,7 +108,7 @@ static void setup(void)
 	tst_fill_file("test.img", 0, 1024, 1024);
 	half_value = 256;
 	pg_size = getpagesize();
-	invalid_value = pg_size * 2 ;
+	invalid_value = BLK_MAX_BLOCK_SIZE + 1;
 	unalign_value = pg_size - 1;
 
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
