Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ECAC021A0
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 21:46:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7774B3C99A0
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 22:46:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5643C995D
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:46:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BD4B5240374
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 22:46:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q64uKb272l+BNCdvE8NsPTFgu15F93xEYjCxhqlCh2g=;
 b=OgWn/ILj6ZriQ/OXp17eWzqGBAbsQ4RUylV5YLw92Z8Rw2S5oR5Z99efE/7/Tm0b6AKq0H
 N5HIHZwLbIcZap8SeA1ZwTi1NupGx+B2NiAKTZ305osnLw7EmBlIF5koqHhLyVwARgIiTP
 HTSvfFEkahtiXWoHDvbYEegpwoWwW/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-_ux_4YYpM1qCZDUwMe5CPw-1; Tue,
 11 Feb 2025 16:46:33 -0500
X-MC-Unique: _ux_4YYpM1qCZDUwMe5CPw-1
X-Mimecast-MFC-AGG-ID: _ux_4YYpM1qCZDUwMe5CPw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A94881800989
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:46:32 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.80.78])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AB601955F21
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 21:46:32 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 50C7A229DBA0; Tue, 11 Feb 2025 16:46:30 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 16:42:12 -0500
Message-ID: <20250211214627.152634-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rN3PNZMPxJg6Zd5CCjFwAsZgf5QoyRDFo7lcHUvsMx0_1739310393
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] tst_device: add support for overlayfs
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

[PATCH v2 1/3] lib/tst_device.c: factor out btrfs-specific logic from
[PATCH v2 2/3] lib/tst_device.c: check for BTRFS_SUPER_MAGIC instead
[PATCH v2 3/3] tst_find_backing_dev(): add support for overlayfs

---
Changes since v1:
- Remove dependency on libmount in patch 3.  Patches 1 and 2 are
  unchanged.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
