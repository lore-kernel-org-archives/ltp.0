Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A23C636B6
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 20:35:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4D1D3D06B2
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 21:35:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 003CD3CAEC3
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:34:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EAD2600640
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:34:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 631923E8C5;
 Sun, 22 Feb 2026 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771792493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0vSPwWY4q3833Y9AmNYJzL9zrfNN2i/mYAsipw139M=;
 b=F9LWmkw3f4MEfkQL0Jvs/J19TE0gEtx5k53V6+Xon8XCzrfKX7sYLQwSoLl6NOjOWnLY9G
 +FoW/jmcEjam3pAjMqJWIluSVhmQOi2sQLzBAM0KHPeuuHDnUct7v3cQUneHdAXL0QWhr9
 8gzJuScnaIFoTb16J0dm2tujgrs5d/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771792493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0vSPwWY4q3833Y9AmNYJzL9zrfNN2i/mYAsipw139M=;
 b=KYwYgjPvy+dib67U6MyKS5l9CN/rikIufxvgH3bOIoDIr2s4MlQhCSD8m1LVcPBfYyQkdT
 /LmxQtB3YceRcIAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F9LWmkw3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KYwYgjPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771792493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0vSPwWY4q3833Y9AmNYJzL9zrfNN2i/mYAsipw139M=;
 b=F9LWmkw3f4MEfkQL0Jvs/J19TE0gEtx5k53V6+Xon8XCzrfKX7sYLQwSoLl6NOjOWnLY9G
 +FoW/jmcEjam3pAjMqJWIluSVhmQOi2sQLzBAM0KHPeuuHDnUct7v3cQUneHdAXL0QWhr9
 8gzJuScnaIFoTb16J0dm2tujgrs5d/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771792493;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g0vSPwWY4q3833Y9AmNYJzL9zrfNN2i/mYAsipw139M=;
 b=KYwYgjPvy+dib67U6MyKS5l9CN/rikIufxvgH3bOIoDIr2s4MlQhCSD8m1LVcPBfYyQkdT
 /LmxQtB3YceRcIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 623223EA68;
 Sun, 22 Feb 2026 20:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ipuoDGxom2lFGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 22 Feb 2026 20:34:52 +0000
Date: Sun, 22 Feb 2026 21:34:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20260222203442.GB417048@pevik>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260221135338.26236-2-sebastian.chlad@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 631923E8C5
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

[ Cc Martin and Cyril ]

> nfs_lib.sh checked key server_side prerequisites on the system under test.
> In 2_host setup this incorrectly required server_side tools on lhost.
> This patch keep netns behavior unchanged, but in true 2-host mode run
> server-side checks on rhost via tst_rhost_run().

First, thank you for fixing 2 host side setup.

> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 22 +++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 1ac8bd657..e52f96a5a 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -45,7 +45,7 @@ TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
>  TST_MOUNT_DEVICE=1
>  TST_FORMAT_DEVICE=1
>  TST_NEEDS_ROOT=1
> -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount mount.nfs"

>  TST_SETUP="${TST_SETUP:-nfs_setup}"
>  TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
>  TST_NEEDS_DRIVERS="nfsd"
> @@ -186,10 +186,24 @@ nfs_setup()
>  		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
>  	fi

> +	if tst_net_use_netns; then
> +		tst_cmd_available exportfs || tst_brk TCONF "'exportfs' not found"
You would here use tst_require_cmds exportfs, but ...

> +	else
> +		tst_rhost_run -c "command -v exportfs >/dev/null" || tst_brk TCONF "'exportfs' not found on rhost"
> +	fi

... if you remove exportfs from TST_NEEDS_CMDS you can use the same code for
both netns and 2 based setup (tst_rhost_run should work well on netns).

I was thinking about having a special variable for checking rhost only, but
given that tst_test.sh is now also deprecated, we will have to solve this in
shell loader.

> +
>  	if tst_cmd_available pgrep; then
> -		for i in rpc.mountd rpc.statd; do
> -			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
> -		done
> +		if tst_net_use_netns; then
> +			tst_res TINFO "checking rpc.mountd/rpc.statd on lhost (netns mode)"
> +			for i in rpc.mountd rpc.statd; do
> +				pgrep $i > /dev/null || tst_brk TCONF "$i not running"
> +			done
> +		else
> +			tst_res TINFO "checking rpc.mountd/rpc.statd on rhost (2-host mode)"
> +			for i in rpc.mountd rpc.statd; do
> +				tst_rhost_run -c "pgrep $i > /dev/null" || tst_brk TCONF "$i not running on rhost"
> +			done
> +		fi

And here of course as well use tst_rhost_run for both.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
