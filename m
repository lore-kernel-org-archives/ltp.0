Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD53CD5BCF
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 06:58:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E58513E2390
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 08:58:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F048D3C73EE
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:57:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 896F06008CD
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:57:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B37A875DDC;
 Tue, 26 May 2026 06:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779778673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xq5YjYC6Sm5RVI8HtozYd0enhEehXBE57BisfQ1Cbx8=;
 b=Lh7mD3ymrxlIlHGPJFlYRLJNXqDHVUy0scM5/vzHHNLBln+OMijKDIfYp5wrlqc2JE/unw
 UKfa1MtPhEHB1TcRtIEb9mEAHwUkjFMDn96bPZOb2KDSOY4hFS1/f5zuNd6z2h5uRQg+GD
 tUX54v6vvRcHoaWnaL8rzWlNkqtKDGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779778673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xq5YjYC6Sm5RVI8HtozYd0enhEehXBE57BisfQ1Cbx8=;
 b=yvEKvlNkemU86/S5yvsrjRRTFGe7dhKtRBRh6ehlAw3XMNqUn3rcqRXihcSWwAiE8SNQzs
 eRLZMe3F0cm4/TAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779778673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xq5YjYC6Sm5RVI8HtozYd0enhEehXBE57BisfQ1Cbx8=;
 b=Lh7mD3ymrxlIlHGPJFlYRLJNXqDHVUy0scM5/vzHHNLBln+OMijKDIfYp5wrlqc2JE/unw
 UKfa1MtPhEHB1TcRtIEb9mEAHwUkjFMDn96bPZOb2KDSOY4hFS1/f5zuNd6z2h5uRQg+GD
 tUX54v6vvRcHoaWnaL8rzWlNkqtKDGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779778673;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xq5YjYC6Sm5RVI8HtozYd0enhEehXBE57BisfQ1Cbx8=;
 b=yvEKvlNkemU86/S5yvsrjRRTFGe7dhKtRBRh6ehlAw3XMNqUn3rcqRXihcSWwAiE8SNQzs
 eRLZMe3F0cm4/TAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E35F5A094;
 Tue, 26 May 2026 06:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K16WIXFEFWpRaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 06:57:53 +0000
Date: Tue, 26 May 2026 08:57:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260526065752.GA144912@pevik>
References: <20260525190127.397779-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260525190127.397779-1-avinesh.kumar@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] zram01: Specify filesystem type explicitly in
 mount
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

Hi Avinesh,

> util-linux 2.42 converts "ntfs" to "ntfs3" during auto-detection,
> causing mount failures on systems with CONFIG_NTFS3_FS disabled
> even when ntfs-3g is available.

I see from release notes [1]:

	The NTFS mount type (kernel FS driver) can be changed by the compile option
	--with-ntfs-mounttype=, the default is ntfs3.

As you already found I guess it started as PR#3618 [2] but later got
fixed/changed as PR#3872 [3] (previous attempt was PR#3807 [4]).

[1] https://github.com/util-linux/util-linux/blob/master/Documentation/releases/v2.42-ReleaseNotes
[2] https://github.com/util-linux/util-linux/pull/3618
[3] https://github.com/util-linux/util-linux/pull/3872
[4] https://github.com/util-linux/util-linux/pull/3807

> tst_supported_fs_types.c:141: TINFO: FUSE does support ntfs
> tst_supported_fs_types.c:67: TINFO: mkfs.ntfs does exist
> tst_supported_fs_types.c:137: TINFO: Filesystem ntfs3 is not supported
> ...
> ...
> zram01 6 TINFO: mount /dev/zram7
> mount: /tmp/LTP_zram01.YG3YHQhMER/zram7: unknown filesystem type 'ntfs3'.
>        dmesg(1) may have more information after failed mount system call.
> zram01 6 TBROK: mount /dev/zram7 zram7 failed

> Fix by specifying -t option with the filesystem type that LTP
> verified as supported, avoiding auto-detection.

I guess there is nothing to be fixed in our lib/tst_supported_fs_types.c
(or even testcases/lib/tst_supported_fs.c which uses it) and there is no other
test using TST_ALL_FILESYSTEMS=1 which would need it.

Thanks for fixing this!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/kernel/device-drivers/zram/zram01.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 793f6603c..4b7f2a753 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -94,13 +94,15 @@ zram_makefs()

>  zram_mount()
>  {
> -	local i
> +	local i=$dev_start
> +	local fs

> -	for i in $(seq $dev_start $dev_end); do
> -		tst_res TINFO "mount /dev/zram$i"
> +	for fs in $zram_filesystems; do
> +		tst_res TINFO "mount /dev/zram$i ($fs)"
>  		mkdir zram$i
> -		ROD mount /dev/zram$i zram$i
> +		ROD mount -t "$fs" /dev/zram$i zram$i
>  		dev_mounted=$i
> +		i=$((i + 1))
>  	done

>  	tst_res TPASS "mount of zram device(s) succeeded"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
