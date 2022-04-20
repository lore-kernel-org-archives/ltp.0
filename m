Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939ADC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 11:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65BC73CA6CF
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 13:47:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48E2B3C12C4
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 13:47:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A22DE6002F9
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 13:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650455245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ggjCqXTubytBh0jDk9/PO4nBG1AnvU1xwfCpyewZ1JU=;
 b=ON9pUxMB+renMmlb0WpLtafuxvA3SZWibALSpiVH68TcPCbx77LL8ENWcTXkLoSlUU819f
 ae4WxTophCl4jkUhAUNNOPHAj31Co1WSqJCsV6mzsKdsS80lve7ui1DQZch1hw2FCV5DlU
 Y+ww+msQSlfZeYVb/d85riu6UCQf6LM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-l5DD4elqPr6fQKfQSmd3Aw-1; Wed, 20 Apr 2022 07:47:23 -0400
X-MC-Unique: l5DD4elqPr6fQKfQSmd3Aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EF2F80418C
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:47:23 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0147C28
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:47:22 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 20 Apr 2022 19:47:19 +0800
Message-Id: <20220420114720.1463473-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ioctl09: wait for udevd complete the uevent
 handling
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

This is quite necessary to wait for uevent handing settled before
checking the partition is taken effect.

  `udevadm monitor` listening from another terminal:

  KERNEL[447.077683] change   /devices/virtual/block/loop0 (block)
  KERNEL[447.077939] add      /devices/virtual/block/loop0/loop0p1 (block)
  KERNEL[447.077999] add      /devices/virtual/block/loop0/loop0p2 (block)
  UDEV  [447.081138] change   /devices/virtual/block/loop0 (block)
  UDEV  [447.083490] add      /devices/virtual/block/loop0/loop0p1 (block)
  UDEV  [447.086898] add      /devices/virtual/block/loop0/loop0p2 (block)

Which helps to get rid of such boring failures:

  ioctl09.c:44: TPASS: access /sys/block/loop0/loop0p1 succeeds
  ioctl09.c:52: TPASS: access /dev/loop0p1 succeeds
  ioctl09.c:47: TFAIL: access /sys/block/loop0/loop0p2 fails
  ioctl09.c:55: TFAIL: access /dev/loop0p2 fails

I manually confirmed those failures disappeared from a reproducible system
even with running 10000 times.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl09.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 9728ecb9c..533a4a5d0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -58,6 +58,10 @@ static void check_partition(int part_num, bool value)
 
 static void verify_ioctl(void)
 {
+	char cmd[BUFSIZ];
+
+	sprintf(cmd, "udevadm settle --exit-if-exists=%s", dev_path);
+
 	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
 					      "mklabel", "msdos", "mkpart",
 					      "primary", "ext4", "1M", "10M",
@@ -75,11 +79,13 @@ static void verify_ioctl(void)
 
 	loopinfo.lo_flags =  LO_FLAGS_PARTSCAN;
 	SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
+	tst_system(cmd);
 	check_partition(1, true);
 	check_partition(2, false);
 
 	change_partition(cmd_parted_new);
 	TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), TST_RETVAL_EQ0);
+	tst_system(cmd);
 	check_partition(1, true);
 	check_partition(2, true);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
