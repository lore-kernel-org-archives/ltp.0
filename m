Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4539CCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755008259; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=GKDv1XyiLaIOGkP5or6XEjc+zXZdb89gmbsGYPtsZhc=;
 b=Ez2BBdKX8mUpjzGos9WDNeY43fHUDqqTazIsFfSxFhJg4oVE5S1KYtt9+kEnT7Le5y5OY
 AhthwFWYt7SlqHBLRGujvYSRg/ZOX9V1TSbLnlUwycTYznl8QVRChIG1VIRnc6fan1yhgAK
 hTJrUJEfyIteCXJ/9HrRHxcvDGIaCzs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0E803CB6C3
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 16:17:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 192F63CAD84
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 16:17:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B196600625
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 16:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755008236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=opUshD1VNb2uy654yvNORvOpXQo46XRVCJIcdubY6Lw=;
 b=TdlJB69a7TiDZ/rf8BZcJKOP2Gb/VIixLJFSCZVQepvn//QGILqUw05BmReQOpaV4yfKj8
 VRVFYzOWZbV9g2GuLj+Nk/bSblVKI8oOkLnptjFFm3X5/odYwdLMIVdEcRsTP4qrqnmWhs
 nadxXt7X7P0rlDBtY9kP8/YSj/ncz8k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-hIKs78l1MqmMaDxp-7AzuA-1; Tue,
 12 Aug 2025 10:17:14 -0400
X-MC-Unique: hIKs78l1MqmMaDxp-7AzuA-1
X-Mimecast-MFC-AGG-ID: hIKs78l1MqmMaDxp-7AzuA_1755008233
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86A60180035D; Tue, 12 Aug 2025 14:17:13 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99DAD180028A; Tue, 12 Aug 2025 14:17:11 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 12 Aug 2025 22:17:09 +0800
Message-ID: <20250812141709.33540-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IZ4pK5WeHVOAZlYP9VF0yWlSH3B1CS50zBGX5YB341M_1755008233
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_mkfs: print short hint when mkfs fails in
 device busy
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
Cc: rafael.tinoco@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

During daily CI testing of LTP, we were intermittently getting EBUSY (in many
testcases) when mkfs the /dev/loop0 device. It seemed that userspace was
reopening the block device immediately after unmounting it. Debugging with
bpftrace revealed that the udisks2 daemon was the culprit (probing the block
device on every change). As this was outside the scope of the LTP code, we
added a printout suggesting that testers stop the udisk2 service when
encountering this failure during testing.

  ==== setxattr01 ====
  tst_test.c:1888: TINFO: === Testing on ext2 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
  tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_setd24dAf/mntpoint fstyp=ext2 flags=0
  ...
  setxattr01.c:174: TPASS: setxattr(2) failed: EFAULT (14)
  tst_test.c:1888: TINFO: === Testing on ext3 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
  /dev/loop0 is apparently in use by the system; will not make a filesystem here!
  tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

  ==== close_range01 ====
  tst_test.c:1888: TINFO: === Testing on ext2 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
  tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_cloXeXI39/mnt fstyp=ext2 flags=0
  ...
  close_range01.c:188: TPASS: No kernel taints
  tst_test.c:1888: TINFO: === Testing on ext3 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)
  /dev/loop0 is apparently in use by the system; will not make a filesystem here!
  tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

Running bpftrace in a separate terminal and also with ./close_range01
simultaneously to get the output shows that another daemon (udisksd) is
probing the block device on every change.

  # bpftrace -e 'tracepoint:syscalls:sys_enter_openat /str(args->filename)=="/dev/loop0"/ \
      { printf("%s pid=%d flags=0x%x %s\n", comm, pid, args->flags, str(args->filename)); }'
  Attaching 1 probe...
  close_range01 pid=298948 flags=0x2 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  close_range01 pid=298948 flags=0x0 /dev/loop0
  systemd-udevd pid=702 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x280000 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x280000 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0
  close_range01 pid=298948 flags=0x241 /dev/loop0
  systemd-udevd pid=702 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x80 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x80800 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x0 /dev/loop0
  mkfs.ext2 pid=298969 flags=0x82 /dev/loop0
  (udev-worker) pid=298949 flags=0x280000 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0
  systemd-udevd pid=702 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0
  (udev-worker) pid=298949 flags=0x280000 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0
  udisksd pid=87323 flags=0x0 /dev/loop0        <--------
  close_range01 pid=298948 flags=0x241 /dev/loop0
  systemd-udevd pid=702 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  (udev-worker) pid=298949 flags=0x288000 /dev/loop0
  mkfs.ext3 pid=298977 flags=0x80 /dev/loop0
  mkfs.ext3 pid=298977 flags=0x0 /dev/loop0
  mkfs.ext3 pid=298977 flags=0x0 /dev/loop0
  ...

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_mkfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 736324f04..dfec06a21 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -107,6 +107,10 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 			"%s not found in $PATH", mkfs);
 	break;
 	default:
+		tst_resm_(file, lineno, TWARN,
+			"Check if mkfs failed with the (loop) device busy. "
+			"Background probing (e.g., udisks2) can cause this. \n"
+			"Consider temporarily stopping udisks2 during the test.");
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			"%s failed with exit code %i", mkfs, ret);
 	}
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
