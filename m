Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D02C021AB
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 21:51:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C56323C9BFE
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 22:51:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F293C093B
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 22:50:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A01AB101D633
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 22:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739829050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=c3B2SXmYY4rVbru3n8z0r/9zTRGUhutNmfwcYTn0jQQ=;
 b=Vb5iV8V2IoOJzNLH6CgNmDQV2HdXT8V/KQLtitj2fhju+/SG8+N/i8XMAsAHwBkP61PKhi
 6chAcInxfz8dMaeCggg9BlayYiEUcYtfx6b5xOXQdk4BNuMp5+B4iMb+qwIoo0wj/4++Xi
 QQ/L6/ZWh267Na98aVFM+2oKJfMXz4k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-ScQQM1AxPWqKn-H8KRXvkg-1; Mon,
 17 Feb 2025 16:50:49 -0500
X-MC-Unique: ScQQM1AxPWqKn-H8KRXvkg-1
X-Mimecast-MFC-AGG-ID: ScQQM1AxPWqKn-H8KRXvkg_1739829048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5292F18EB2C3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 21:50:48 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.64.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1162A19560A3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 21:50:47 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 8A22E22AF2C7; Mon, 17 Feb 2025 16:50:45 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 16:46:26 -0500
Message-ID: <20250217215038.177250-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KmkstShvk3t0ME9qfEGQ78ft0Jt0LB4PytmGLD1BaJw_1739829048
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] tst_device: add support for overlayfs
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

When running ltp-aiodio on an overlay file system, the following error
occurs:

tst_tmpdir.c:316: TINFO: Using /mnt/fstests/TEST_DIR/ovl-mnt/ltp-hSHEHy5M0s/LTP_aio4q4GMW as tmpdir (overlayfs filesystem)
tst_test.c:1888: TINFO: LTP version: 20220121-2271-g91a10df22
tst_test.c:1892: TINFO: Tested kernel: vendor kernel
tst_test.c:1723: TINFO: Timeout per run is 0h 40m 00s
aiocp.c:211: TINFO: Maximum AIO blocks: 65536
tst_device.c:551: TINFO: Use BTRFS specific strategy
tst_device.c:569: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)

The issue is that stat(2) on an overlayfs mount point will return a
major device number of 0.  The code assumes this is btrfs, and tries
to issue a btrfs-specific ioctl.  When that fails, the final message is
printed that suggests this might be tmpfs.

I modified the code to use statfs(2) to get the file system type, and
use that to determine which file system specific code to call.
Finally, I added code to parse out the upper directory from the
overlayfs mount options using a combination of /proc/self/mountinfo
and /proc/self/mounts, as explained in patch 3.  stat(2) is then
called on the upper directory to get to the underlying device node.

I tested this on xfs, btrfs, a btrfs subvolume and overlayfs.  Review
of the series is greatly appreciated.

Thanks in advance!
Jeff

[PATCH v3 1/3] lib/tst_device.c: factor out btrfs-specific logic from
[PATCH v3 2/3] lib/tst_device.c: check for BTRFS_SUPER_MAGIC instead
[PATCH v3 3/3] tst_find_backing_dev(): add support for overlayfs
---
Changes since v2:
- Address review comments from Petr:
  - Use test-defined magic numbers
  - #include statfs.h instead of vfs.h.
  - Don't split long strings across lines
- Add Reviewed-by tag for patch 1.

Changes since v1:
- Remove dependency on libmount in patch 3.  Patches 1 and 2 are
  unchanged.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
