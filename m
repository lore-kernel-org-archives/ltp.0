Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A3BC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 11:52:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325C63C19F4
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:52:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00D5F3C0E9E
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:52:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BF3E920096D
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:52:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E387221268;
 Tue,  5 Aug 2025 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754394732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMHDrNhLlMqkPYfql83Fl2q2KoJ2AIBZ/BCxOyUIfDQ=;
 b=Dx3BmPwqWB8UyWYwJ1qd39r+woeAxulBeOogpnCUqnRnsBoKGcEkY1sg2eZNk4p2xfu1BU
 mqONAm6qp26J/6tgtQDzrolsP67/F/Z43/PaF4+K3NeIecy/nbP6S6zz9FTFH0x8ci69QY
 g28DZZa1HVuANSBIwCl/IHl+8/uJ0ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754394732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMHDrNhLlMqkPYfql83Fl2q2KoJ2AIBZ/BCxOyUIfDQ=;
 b=zYINgt4BOKe1thaG51S4ufKQ1a3uLmUhf25jfZXHM+JPZLjBSAgHqPfArL8FynVLe8fI20
 rnjg6y6sLqUD1kCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IiLBR01p;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=W6VtdBww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754394730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMHDrNhLlMqkPYfql83Fl2q2KoJ2AIBZ/BCxOyUIfDQ=;
 b=IiLBR01p1zHVUW5RQXQhgpMad65lRpFuuLLVl2nAriSYJxSLKd/tQ8tCZtMS12G8tcXDNo
 d/+OMQA7tpYHgaykKSH+Rf50RJ6aeO/HxrLslaYksHZztRiUTDEi/m+Xyb/jhm4uHUsqn5
 3SroJSeaDbCteoIUTi8h36W8D6Q4SwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754394730;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMHDrNhLlMqkPYfql83Fl2q2KoJ2AIBZ/BCxOyUIfDQ=;
 b=W6VtdBwwSkcdPHZ5cvtlqEhNLF2RZd6qEsrjvUsvc/7wj5sN3P1VvGDia7ftRMRezIWJkF
 Bc4xsZqCFKOoEAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26A5213A55;
 Tue,  5 Aug 2025 11:52:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K0VyAGrwkWhnegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 05 Aug 2025 11:52:10 +0000
Date: Tue, 5 Aug 2025 13:52:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20250805115208.GA272913@pevik>
References: <20250729132731.57978-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250729132731.57978-1-japo@linux.ibm.com>
X-Rspamd-Queue-Id: E387221268
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] safe_macros.c: Fix missing ro flag for
 FUSE mounts
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The test incorrectly assumes that FUSE mounts are read-only, but the mount
> command does not explicitly set the read-only flag. As a result, the test fails
> when checking `sb_flags` against `MS_RDONLY`.

@Cyril actually v3 is the final version to have a look.

Kind regards,
Petr

> Old behavior:

>     sudo LTP_SINGLE_FS_TYPE=ntfs strace -e trace=mount,statmount -o log.log -s 128 -f ./statmount02
>     ...
>     statmount02.c:47: TFAIL: st_mount->sb_flags (0) != MS_RDONLY (1)
>     ...

> Relevant log excerpt:

>     3890601 mount("/dev/zero", "/tmp/mountBDSEqk", "ntfs", 0, NULL) = -1 ENOTBLK (Block device required)
>     3890608 mount("/dev/loop0", "/tmp/LTP_staTPRruR/mntpoint", "fuseblk", 0, "allow_other,blksize=4096,fd=4,rootmode=40000,user_id=0,group_id=0") = 0
>     3890607 statmount({size=24, mnt_id=0x80010957, param=STATMOUNT_SB_BASIC}, {size=512, mask=STATMOUNT_SB_BASIC, sb_dev_major=7, sb_dev_minor=0, sb_magic=FUSE_SUPER_MAGIC, sb_flags=0}, 512, 0) = 0

> Reviewed-by: Avinesh Kumar <akumar@suse.de>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
> Change since v1 (Thanks Cyril & thanks for the ping):
> * Removed restriction for NTFS.
> Change since v2 (Thanks Avinesh):
> * Changed commit title from: "Fix missing ro flag for FUSE NTFS mounts"

>  lib/safe_macros.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index d52b55ab70fe..25fad4b7cae0 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -945,10 +945,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	tst_resm_(file, lineno, TINFO, "tst_is_fuse: %d", tst_is_fuse(source));
>  	if (possibly_fuse(filesystemtype)) {
>  		char buf[1024];
> +		const char* mount_fmt;

>  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> -			filesystemtype, source, target);
> +		if (mountflags == MS_RDONLY)
> +			mount_fmt = "mount.%s -o ro '%s' '%s'";
> +		else
> +			mount_fmt = "mount.%s '%s' '%s'";
> +		snprintf(buf, sizeof(buf), mount_fmt, filesystemtype,
> +				source, target);

>  		rval = tst_system(buf);
>  	tst_resm_(file, lineno, TINFO, "tst_is_fuse: %d", tst_is_fuse(source));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
