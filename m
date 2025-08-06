Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4264EC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 07:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754466286; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jC2xvLtHl43VEzaV8umGNhASX4HXey5Br62pQI6yG1M=;
 b=K+DVdWnBGiUQoBRdU3tjyNze1PRSIm3JtSp0AvmecZWR7i8oCDLx2vpVaCoRxxGRcAbFS
 MCURwWi3gVBVeCnTxCWeSjC4gvwS25cqx0GCTDwJ6BNGKrYTdtX5QBQzIzJnY0vM9Ilj8Op
 bWSZT6PWwFOc9I96Dysq+KfSuNmT4ps=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272613C1B32
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 09:44:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A967D3C06BC
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 09:44:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BE146008C0
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 09:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754466258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxf1rpc/pAuMB3JMsAgBQ7oezyrXbnXhNZ9xwxBDsdo=;
 b=X1mBz2AOV25Nb7oEE5+1sj1fCi5gcWBPH+6+Id/KkNuolvhWFDiaGllY2lpQMelo1hR1RW
 AxyVzKSzCq9HRdK3UgZssVyUHQnDGuak44VSXyo5CyUSLE9ph5rjSIw0D1QsFKa68EZ8/r
 f2kyXo1focaR3fLmxxk+H6d+n1XCg/g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-wjc8_rH0MGu_PInZwdVRVw-1; Wed,
 06 Aug 2025 03:44:12 -0400
X-MC-Unique: wjc8_rH0MGu_PInZwdVRVw-1
X-Mimecast-MFC-AGG-ID: wjc8_rH0MGu_PInZwdVRVw_1754466251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEF9A1956086; Wed,  6 Aug 2025 07:44:10 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A64373000198; Wed,  6 Aug 2025 07:44:08 +0000 (UTC)
To: ltp@lists.linux.it,
	rafael.tinoco@linaro.org,
	chrubis@suse.cz
Date: Wed,  6 Aug 2025 15:44:05 +0800
Message-ID: <20250806074405.14890-1-liwang@redhat.com>
In-Reply-To: <20190102131913.GA26215@rei.lan>
References: <20190102131913.GA26215@rei.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l6pfeBG6hViKWPBxRaW-3pWdoiTk5BQrar1LCVpInBk_1754466251
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_umount: Retry open() after umount to handle
 delayed device release
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

Currently, tst_umount() in lib/tst_device.c tries to repeatedly umount()
a mount point, with a retry loop if it gets EBUSY. However, after umount()
reports success, devices (especially loop devices) can still be held open
by another process or kernel, delaying their actual release. This can lead
to race conditions when the next operation tries to reuse the device like
mkfs.ext3 error:

  ==== setxattr01 ====
  command: setxattr01
  tst_test.c:1953: TINFO: LTP version: 20250530
  ...
  tst_supported_fs_types.c:48: TINFO: mkfs is not needed for tmpfs
  tst_test.c:1888: TINFO: === Testing on ext2 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
  mke2fs 1.47.1 (20-May-2024)
  tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_setd24dAf/mntpoint fstyp=ext2 flags=0
  ...
  setxattr01.c:174: TPASS: setxattr(2) failed: ERANGE (34)
  setxattr01.c:174: TPASS: setxattr(2) failed: EFAULT (14)
  tst_test.c:1888: TINFO: === Testing on ext3 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)

  /dev/loop0 is apparently in use by the system; will not make a filesystem here!
  tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

  ==== close_range01 ====
  command: close_range01
  tst_test.c:1953: TINFO: LTP version: 20250530
  ...
  tst_test.c:1888: TINFO: === Testing on ext2 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
  mke2fs 1.47.1 (20-May-2024)
  tst_test.c:1229: TINFO: Mounting /dev/loop0 to /tmp/LTP_cloXeXI39/mnt fstyp=ext2 flags=0
  ...
  close_range01.c:188: TPASS: No kernel taints
  tst_test.c:1888: TINFO: === Testing on ext3 ===
  tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts='' mke2fs 1.47.1 (20-May-2024)

  /dev/loop0 is apparently in use by the system; will not make a filesystem here!
  tst_test.c:1217: TBROK: mkfs.ext3 failed with exit code 1

This patch improves robustness by, after a successful umount(), attempting to
open() the device in O_RDWR mode and retrying if open() fails with EBUSY,
similar to how umount() is retried. This ensures that tst_umount() only returns
success after the device is truly available for reuse, reducing race conditions
in rapid test cycles.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/tst_device.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 6d1abf065..7f0a4f8a4 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -397,14 +397,37 @@ int tst_clear_device(const char *dev)
 
 int tst_umount(const char *path)
 {
-	int err, ret, i;
+	int err, ret, i, j;
 
 	for (i = 0; i < 50; i++) {
 		ret = umount(path);
 		err = errno;
 
-		if (!ret)
+		if (!ret) {
+			/* After successful umount, check device open busy */
+			for (j = 0; j < 50; j++) {
+				int fd = open(path, O_RDWR);
+				if (fd >= 0) {
+					close(fd);
+					break;
+				}
+				if (errno == EBUSY) {
+					tst_resm(TINFO, "open('%s') got EBUSY after umount, retry %d...",
+						path, j+1);
+					usleep(100000);
+					continue;
+				}
+				break;
+			}
+			if (j == 50) {
+				tst_resm(TWARN, "Device '%s' is still busy after %d open retries",
+					path, 10);
+				errno = EBUSY;
+				return -1;
+			}
+
 			return 0;
+		}
 
 		if (err != EBUSY) {
 			tst_resm(TWARN, "umount('%s') failed with %s",
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
