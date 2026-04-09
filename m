Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA77E9DE5F
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 07:54:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC0003E2A1F
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 09:54:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 664353CA491
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 09:53:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F301600636
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 09:53:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B04624EE22;
 Thu,  9 Apr 2026 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775721231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTPDM/X2BhpUoHtbtL4ZsWRu4glcsOBTiQs+fZsP6uM=;
 b=iPOZEVYMj8PajzC40EAdA+9rvdzvsEIRg+4clpdI2PaHWJpu6S1SBW7PcF/mOgzubUAQ88
 WMDIeEgNPFD0Pa34GpjEcslEjl5e0LRTVBHeN+pbklKJffNCnPWbD104SLkWYJ6ZuLwsIs
 ci5KdXZ6Jk+mu3eO2JBI3KBV6QXoEY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775721231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTPDM/X2BhpUoHtbtL4ZsWRu4glcsOBTiQs+fZsP6uM=;
 b=xIezhC+xx6GbSN7HAtjsTbUkjAMu/U/RLcNjEJvObEV0cvQBncFsOPOp4U5Nr8d8uqALAV
 NCewHs1MbfhxNmAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775721231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTPDM/X2BhpUoHtbtL4ZsWRu4glcsOBTiQs+fZsP6uM=;
 b=iPOZEVYMj8PajzC40EAdA+9rvdzvsEIRg+4clpdI2PaHWJpu6S1SBW7PcF/mOgzubUAQ88
 WMDIeEgNPFD0Pa34GpjEcslEjl5e0LRTVBHeN+pbklKJffNCnPWbD104SLkWYJ6ZuLwsIs
 ci5KdXZ6Jk+mu3eO2JBI3KBV6QXoEY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775721231;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTPDM/X2BhpUoHtbtL4ZsWRu4glcsOBTiQs+fZsP6uM=;
 b=xIezhC+xx6GbSN7HAtjsTbUkjAMu/U/RLcNjEJvObEV0cvQBncFsOPOp4U5Nr8d8uqALAV
 NCewHs1MbfhxNmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C2704A0B3;
 Thu,  9 Apr 2026 07:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gBwjIQ9b12njawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Apr 2026 07:53:51 +0000
Date: Thu, 9 Apr 2026 09:53:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Matthew R. Ochs" <mochs@nvidia.com>
Message-ID: <20260409075345.GC64002@pevik>
References: <20260408174406.1572520-1-mochs@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260408174406.1572520-1-mochs@nvidia.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Matthew,

> LTP mounts ntfs via ntfs-3g (FUSE) rather than the kernel ntfs3
> driver. ntfs-3g's ntfs_ioctl() returns EINVAL for any unhandled
> ioctl, including FS_IOC_FSSETXATTR, so file_setattr() returns
> EINVAL instead of the expected EOPNOTSUPP.

> Add "ntfs" to skip_filesystems for the same reason "fuse" is
> already skipped.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Good catch, thanks!

We did not notice, because we have ntfs3 blacklisted in openSUSE Tumbleweed:

cat /etc/modprobe.d/60-blacklist_fs-ntfs3.conf
# The ntfs3 file system is blacklisted by default because it isn't actively
# supported by SUSE.
blacklist ntfs3
# The filesystem can be un-blacklisted by running "modprobe ntfs3".
# See README.md in the suse-module-tools package for details.
install ntfs3 /usr/lib/module-init-tools/unblacklist ntfs3; /sbin/modprobe --ignore-install ntfs3

Therefore it works:
# ./file_attr05
...
tst_supported_fs_types.c:98: TINFO: Kernel supports ext2
tst_supported_fs_types.c:63: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:98: TINFO: Kernel supports ext3
tst_supported_fs_types.c:63: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:98: TINFO: Kernel supports ext4
tst_supported_fs_types.c:63: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:157: TINFO: Skipping xfs as requested by the test
tst_supported_fs_types.c:98: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:63: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:106: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:157: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:98: TINFO: Kernel supports exfat
tst_supported_fs_types.c:63: TINFO: mkfs.exfat does exist
tst_supported_fs_types.c:133: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:63: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:165: TINFO: Skipping FUSE based ntfs as requested by the test
...

But if I force ntfs, it really fails due using ntfs3:
# LTP_FORCE_SINGLE_FS_TYPE=ntfs ./file_attr05
...
tst_supported_fs_types.c:199: TINFO: WARNING: force testing only ntfs
tst_test.c:1997: TINFO: === Testing on ntfs ===
tst_test.c:1295: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1307: TINFO: Mounting /dev/loop0 to /tmp/LTP_filWegMd2/mntpoint fstyp=ntfs flags=0
tst_test.c:1307: TINFO: Trying FUSE...
file_attr05.c:23: TFAIL: file_setattr(AT_FDCWD, FILEPATH, attr_set, FILE_ATTR_SIZE_LATEST, 0) expected EOPNOTSUPP: EINVAL (22)

Other way is if I remove blacklist and manually run 'modprobe ntfs3'.

> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
>  testcases/kernel/syscalls/file_attr/file_attr05.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/file_attr/file_attr05.c b/testcases/kernel/syscalls/file_attr/file_attr05.c
> index 6c1471da33e7..85b6cafc5f17 100644
> --- a/testcases/kernel/syscalls/file_attr/file_attr05.c
> +++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
> @@ -49,6 +49,7 @@ static struct tst_test test = {
>  	.skip_filesystems = (const char *const []) {
>  		"xfs",
>  		"fuse", /* EINVAL is raised before EOPNOTSUPP */
> +		"ntfs", /* mounted via ntfs-3g (FUSE), returns EINVAL */
For me it'd work to replace "fuse" with "ntfs" (i.e. remove "fuse").
Does it work for you as well, or you need to have blacklisted both?

>  		"vfat", /* vfat is not implementing file_[set|get]attr */
Also it looks to me that vfat is working.

Kind regards,
Petr
>  		NULL,
>  	},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
