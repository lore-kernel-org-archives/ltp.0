Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB2FC35FF3
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742543591; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qlDM3i4GSzShg5GjautiAWSfvi0ky7l3gNEDNf43qZY=;
 b=IdgI9y4WdwCAqA+JizNKyGEh/db2VGadMmIFRa0FA9Ln7cybxIMo4Gh1IvAqnylr5Bt8z
 rNUhgbMLsUqMjmWsi2AN3I1UlbTjUso3mfOIeZB+/Kx73z3wE+Ed4VXaQA4PyXi6l4z6poH
 QpLsNGW86Cr8tJmYt2mR/Jt4QkNFFA4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CB073CAECB
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 08:53:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 692E93CACF3
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 08:52:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4A5A20023A
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 08:52:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742543566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GQwZelcKKW2NWyOR2UpdUz8Xs8FjC0sVVODP+Dz74Cw=;
 b=TI2p87ae3bCvdkGgrE1T8vl3dlAjoTqEyyGyoZwEYoyh0yf3ubMYT27N/ZxDc5M1eGrxIs
 ok5tVheCxLFlRNa/0lqHyIo9WD1YuMbXo4Movme/C2fTXl4WpQDjts6/DDISsy6tPC7jto
 Rz2UKvepNDF0EYPkI+ZRTv8aXvUl0P4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-IBoiCSsKP0WsXK-z3wet1A-1; Fri,
 21 Mar 2025 03:52:43 -0400
X-MC-Unique: IBoiCSsKP0WsXK-z3wet1A-1
X-Mimecast-MFC-AGG-ID: IBoiCSsKP0WsXK-z3wet1A_1742543562
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 028DF19373D7; Fri, 21 Mar 2025 07:52:42 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E3E119560AF; Fri, 21 Mar 2025 07:52:39 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 21 Mar 2025 15:52:34 +0800
Message-ID: <20250321075234.1829966-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 71o49P0CtqdZCByI639oYh8Zz3lvfbNKfiEkcja24bo_1742543562
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test: Add TCONF when no required filesystems are
 available
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, when no required filesystems (filesystem[i].type) are available,
the test silently does nothing, leading to a misleading test summary.

This patch adds a check to issue TCONF when no valid filesystems are found,
ensuring clearer test results.

  # ./ioctl_ficlone03
  tst_buffers.c:57: TINFO: Test is using guarded buffers
  tst_tmpdir.c:317: TINFO: Using /tmp/LTP_iocSKLS9l as tmpdir (tmpfs filesystem)
  tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
  tst_test.c:1900: TINFO: LTP version: 20250130-166-g17960d952
  tst_test.c:1904: TINFO: Tested kernel: 4.5.0-00002-g22bd332f11d4 #162 SMP Thu Mar 20 18:00:10 CET 2025 x86_64
  tst_kconfig.c:88: TINFO: Parsing kernel config '/.config'
  tst_test.c:1724: TINFO: Overall timeout per run is 0h 00m 31s
  tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
  tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
  tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
  tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
  tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
  tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
  tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
  tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
  tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
  tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
  tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs

  Summary:
  passed   0
  failed   0
  broken   0
  skipped  0
  warnings 0

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 3823ea109..9a23cd4a0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1855,6 +1855,7 @@ static int run_tcases_per_fs(void)
 {
 	int ret = 0;
 	unsigned int i;
+	bool found_valid_fs = false;
 	const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
 
 	if (!filesystems[0])
@@ -1866,6 +1867,7 @@ static int run_tcases_per_fs(void)
 		if (!fs)
 			continue;
 
+		found_valid_fs = true;
 		ret = run_tcase_on_fs(fs, filesystems[i]);
 
 		if (ret == TCONF)
@@ -1877,6 +1879,9 @@ static int run_tcases_per_fs(void)
 		do_exit(ret);
 	}
 
+	if (!found_valid_fs)
+		tst_brk(TCONF, "No required filesystems are available");
+
 	return ret;
 }
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
