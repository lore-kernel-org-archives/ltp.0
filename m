Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9712DC5472C
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 12:02:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A3273D1B57
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 14:02:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EC9A3D1B57
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:02:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DD86601426
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724673735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=80y5cucMKH0g00JBJ7SAAzHzRm3oKpmPjkSmskp1dAo=;
 b=bSR8VELqfuEqrZ3yJJhXTAzK2BUuC2OQggPBEWAJbNHU+EnYM88wdYwRP9dSuEJ98t3Q4Y
 qhuNsIYH4gZQ0nXCS3zj9sxlR/8Ws2xQjwnqMxtmtfOEgJqwgXtfwXw42BC4E5ZONECPBC
 0qtcSBTe2xVyImI663it7yjBqqo0yUk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-zt8Nsa3RP0WZbgjK17hOag-1; Mon,
 26 Aug 2024 08:02:14 -0400
X-MC-Unique: zt8Nsa3RP0WZbgjK17hOag-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E4671955BF2
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 12:02:13 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5861D1955E8C; Mon, 26 Aug 2024 12:02:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 26 Aug 2024 20:02:05 +0800
Message-ID: <20240826120205.5506-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl_loop06: no validate block size
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

Since commit 9423c653fe6110 ("loop: Don't bother validating blocksize") kernel
drop validating blocksize for both loop_configure and loop_set_block_size so
that set large block size succeeds.

Error log:
  12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
  13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
  ...
  18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
  19 ioctl_loop06.c:59:  TFAIL: Set block size succeed unexpectedly

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 317f693a0..4aacd284a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -23,6 +23,7 @@ static char dev_path[1024];
 static int dev_num, dev_fd, file_fd, attach_flag, loop_configure_sup = 1;
 static unsigned int invalid_value, half_value, unalign_value;
 static struct loop_config loopconfig;
+static int novalidate_blocksize = 0;
 
 static struct tcase {
 	unsigned int *setvalue;
@@ -74,6 +75,11 @@ static void run(unsigned int n)
 	struct tcase *tc = &tcases[n];
 
 	tst_res(TINFO, "%s", tc->message);
+	if ((*(tc->setvalue) == invalid_value) && novalidate_blocksize) {
+		tst_res(TCONF, "Kernel doesn't validate block size, skip invalid value test");
+		return;
+	}
+
 	if (tc->ioctl_flag == LOOP_SET_BLOCK_SIZE) {
 		if (!attach_flag) {
 			tst_attach_device(dev_path, "test.img");
@@ -126,6 +132,9 @@ static void setup(void)
 		return;
 	}
 	loopconfig.fd = file_fd;
+
+	if ((tst_kvercmp(6, 11, 0)) >= 0)
+		novalidate_blocksize = 1;
 }
 
 static void cleanup(void)
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
