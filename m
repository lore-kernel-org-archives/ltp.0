Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68975C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 18:31:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0EC3C9443
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 19:31:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E8343C793B
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 19:31:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 849551400998
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 19:31:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5116E21112;
 Thu, 17 Mar 2022 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647541896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qV7iYbL2qzuDgzCR/SmcSjFkiJxCBW69zQUYQ+f6uUE=;
 b=1iDxLtS6lMSi+vbo3yKpG7I/j+6NAchQP9vzhk2qsaTHr0BDrU6XcW6fBBqIcg6Pn1XKJ0
 fgusMqeujwhGcgJIj8Jo6Dx//cuf34Bxwe79IF7ScqMskOorGSk06rGzHAYR8Q4A1hkiG0
 4wJZJ1ABP7kxoU5NU0UNDGzqEaa6ovQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647541896;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qV7iYbL2qzuDgzCR/SmcSjFkiJxCBW69zQUYQ+f6uUE=;
 b=5n7AKMJMeeiWJH3ylyH+cz+W9uNxdK+Genhpu24IFj0CHA92spKW9rU/lri+XYkM4zZJU9
 nP+PjivV8Dht8xAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EEC6132BE;
 Thu, 17 Mar 2022 18:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tetmBYh+M2LuIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Mar 2022 18:31:36 +0000
Date: Thu, 17 Mar 2022 19:31:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YjN+hsHidEX0ivoX@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] quotactl0{2,3,5,7}.c dependency problems on older kernels
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, martin.doucha@suse.com,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

actually quotactl0{2,3,5,7}.c and quotactl03.c fail on only on v4.5:

tst_kconfig.c:82: TINFO: Parsing kernel config '/.config'
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:996: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
[  271.093416] XFS (loop0): Superblock has unknown read-only compatible features (0x4) enabled.
[  271.096902] XFS (loop0): Attempted to mount read-only compatible filesystem read-write.
[  271.100128] XFS (loop0): Filesystem can only be safely mounted read only.
[  271.101852] XFS (loop0): SB validate failed with error -22.
tst_test.c:1010: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d6a0) failed: EINVAL (22)

Tested on config:
grep -e QUOTA -e QFMT /.config
CONFIG_XFS_QUOTA=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y

But not work either on v4.10:
[  299.235456] XFS (loop0): EXPERIMENTAL reflink feature enabled. Use at your own risk!
[  299.239463] XFS (loop0): Mounting V5 Filesystem
[  299.240950] XFS (loop0): Log size 1368 blocks too small, minimum size is 1580 blocks
[  299.243357] XFS (loop0): AAIEEE! Log failed size checks. Abort!
[  299.245183] XFS (loop0): log mount failed
quotactl07.c:58: TBROK: mount(/dev/loop0, mntpoint, xfs, 0, 0x41d054) failed: EINVAL (22)

(the same config)

Tests use:

all:
.mntpoint = MNTPOINT,

quotactl02.c
.mnt_data = "usrquota,grpquota",

quotactl03.c
.mnt_data = "usrquota",

quotactl05.c
.mnt_data = "prjquota"

quotactl07.c does no specific .mnt_data.
but had .mnt_data = "usrquota" till recently - removed in
eb1cd3e922 ("syscalls/quotactl07: Refactor this case")

I guess newer kernel is needed.
But checking usrquota for XFS it has "always" been there - added in
a67d7c5f5d25 ("[XFS] Move platform specific mount option parse out of core XFS code")
in v2.6.25-rc1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
