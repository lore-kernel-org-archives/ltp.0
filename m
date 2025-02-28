Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5AEC282D0
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 17:46:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62F753C9E2C
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 18:46:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56A6F3C19ED
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:45:57 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA0722187BE
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 18:45:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C40431F38F;
 Fri, 28 Feb 2025 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740764755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5u1ZkcgC7tFn0SLGcJeF78gN7MRfR4GYXHQ2js8nxs=;
 b=j2Vzi9PBD2wArXDxX5myz/+hlfEWZ/hOWd8LLd1y9dZtFIFHoFXuY8ZyWnTVisTA/NqURq
 Q8kSxVOFSmboU9UGeTABTl4nIyeYgkJYffgH/b6EbvHEqUbEwbCHJUDcEk54yFLLwHTt+n
 g6DtGG2X1gqof9XVPXPuqFoAdFllOEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740764755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5u1ZkcgC7tFn0SLGcJeF78gN7MRfR4GYXHQ2js8nxs=;
 b=6RZHUYYQGsifdteG6ric9PCGFkdbWYJ7KrG/j5kUG9ECw17RWpU1zTeA9YQjtLR6L5Z59B
 hC/L5scxC9Q6sSCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j2Vzi9PB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6RZHUYYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740764755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5u1ZkcgC7tFn0SLGcJeF78gN7MRfR4GYXHQ2js8nxs=;
 b=j2Vzi9PBD2wArXDxX5myz/+hlfEWZ/hOWd8LLd1y9dZtFIFHoFXuY8ZyWnTVisTA/NqURq
 Q8kSxVOFSmboU9UGeTABTl4nIyeYgkJYffgH/b6EbvHEqUbEwbCHJUDcEk54yFLLwHTt+n
 g6DtGG2X1gqof9XVPXPuqFoAdFllOEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740764755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o5u1ZkcgC7tFn0SLGcJeF78gN7MRfR4GYXHQ2js8nxs=;
 b=6RZHUYYQGsifdteG6ric9PCGFkdbWYJ7KrG/j5kUG9ECw17RWpU1zTeA9YQjtLR6L5Z59B
 hC/L5scxC9Q6sSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DE141344A;
 Fri, 28 Feb 2025 17:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z/BSIFP2wWfVdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 17:45:55 +0000
Date: Fri, 28 Feb 2025 18:45:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250228174554.GB3278043@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250228172439.3276777-4-pvorel@suse.cz>
X-Rspamd-Queue-Id: C40431F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_loader.sh:url,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 3/5] shell: Move shell code into functions
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
> index 91fac89fd6..33c73dfb41 100755
> --- a/testcases/lib/tests/shell_loader_all_filesystems.sh
> +++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
> @@ -14,16 +14,22 @@

>  . tst_loader.sh

> -tst_res TINFO "In shell"
> +tst_test()
> +{
> +	local mntpath=$(realpath ltp_mntpoint)

And this is failing on old dash on Ubuntu Bionic:
https://github.com/pevik/ltp/actions/runs/13593238811/job/38004161850
I need to separate local declaration from adding value.

Kind regards,
Petr

*** Running 'shell_loader_all_filesystems.sh' (exp: TPASS) ***
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_tstr4SvTK as tmpdir (overlayfs filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1905: TINFO: LTP version: 20250130
tst_test.c:1909: TINFO: Tested kernel: 6.8.0-1021-azure #25-Ubuntu SMP Wed Jan 15 20:45:09 UTC 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.8.0-1021-azure'
tst_test.c:1729: TINFO: Overall timeout per run is 0h 00m 30s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:58: TINFO: mkfs.xfs does not exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:58: TINFO: mkfs.btrfs does not exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:58: TINFO: mkfs.vfat does not exist
tst_supported_fs_types.c:128: TINFO: Filesystem exfat is not supported
tst_supported_fs_types.c:128: TINFO: Filesystem ntfs is not supported
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1838: TINFO: === Testing on ext2 ===
tst_test.c:1175: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.1 (24-Mar-2018)
tst_test.c:1188: TINFO: Mounting /dev/loop0 to /tmp/LTP_tstr4SvTK/ltp_mntpoint fstyp=ext2 flags=0
/__w/ltp/ltp/testcases/lib/tst_exec.sh: 18: local: /tmp/LTP_tstr4SvTK/ltp_mntpoint: bad variable name
tst_test.c:1564: TBROK: Test haven't reported results!

> +	local mounted=$(grep $mntpath /proc/mounts)
> +	local device path

> -mntpath=$(realpath ltp_mntpoint)
> -mounted=$(grep $mntpath /proc/mounts)
> +	tst_res TINFO "In shell"

> -if [ -n "$mounted" ]; then
> -	device=$(echo $mounted |cut -d' ' -f 1)
> -	path=$(echo $mounted |cut -d' ' -f 2)
> +	if [ -n "$mounted" ]; then
> +		device=$(echo $mounted |cut -d' ' -f 1)
> +		path=$(echo $mounted |cut -d' ' -f 2)

> -	tst_res TPASS "$device mounted at $path"
> -else
> -	tst_res TFAIL "Device not mounted!"
> -fi
> +		tst_res TPASS "$device mounted at $path"
> +	else
> +		tst_res TFAIL "Device not mounted!"
> +	fi
> +}
> +
> +tst_test

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
