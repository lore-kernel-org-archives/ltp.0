Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B876DC02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 22:10:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5209F3C8F76
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 23:10:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DF683C8ED5
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2DEBD1BD50CB
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 23:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738620551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JUJivSwhgQFXh5t/oZ9XjF9XdI+8VqiBDr+myqg6P+c=;
 b=GOTIorrDubaoSskisk3o8C14pWcloXV5ECp8jaUC4NcgxgHtjReiAZQfleAv/fVUCr1w/S
 6LkiCvjnwWxSSzUIyxSR0VbMnJyOROOpiZ66O329dmO6P8hdIUzON86xZ8bXU/lSE0+32A
 2RoNzpO0bD1VUVzRwWvfFpkuJ/L78mI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-YPf3GvL0PWGv4SG1vfI0Ng-1; Mon,
 03 Feb 2025 17:09:10 -0500
X-MC-Unique: YPf3GvL0PWGv4SG1vfI0Ng-1
X-Mimecast-MFC-AGG-ID: YPf3GvL0PWGv4SG1vfI0Ng
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B0181801F1D
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:09:09 +0000 (UTC)
Received: from segfault.usersys.redhat.com (unknown [10.22.65.155])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 504AE1800268
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 22:09:09 +0000 (UTC)
Received: by segfault.usersys.redhat.com (Postfix, from userid 3734)
 id 72C0F24EA204; Mon,  3 Feb 2025 17:09:06 -0500 (EST)
From: Jeff Moyer <jmoyer@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  3 Feb 2025 17:05:57 -0500
Message-ID: <20250203220903.399544-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BrsX5XcQhvZXw0FIOUAAvGZvz72ZG9GeNnLYg4V42uc_1738620549
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] tst_device: add support for overlayfs
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
use that to determine which file system specific code to call.  Finally, I
added code to parse out the upper directory from the overlayfs mount options
using libmount.  libmount is part of util-linux, so it should be fairly
ubiquitous.  stat(2) is then called on the upper directory to get to the
underlying device node.

Review of the series is greatly appreciated.

Thanks in advance!
Jeff

[PATCH 1/3] lib/tst_device.c: factor out btrfs-specific logic from
[PATCH 2/3] lib/tst_device.c: check for BTRFS_SUPER_MAGIC instead of
[PATCH 3/3] lib/tst_device.c: add support for overlayfs


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
