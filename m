Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157B2C54E4A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 09:17:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1FD3CE97E
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 10:17:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0013CD842
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 10:16:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA420601A32
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 10:16:44 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD40E5FD5C;
 Fri,  8 Mar 2024 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709889398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YntvfZHyYeL+PUC/R8nI0sz0FzRQnqsfxogONjtu74Q=;
 b=qC4ghGmrn4J8J9P0SmUVVVwBPjtC3B7Ovfd/kaSGJtmcMRUdy8xY4Xbw79VzsZ1e4iGGDd
 5f3ZW/gUtlnjhggqOXwFY8nqWT8BZjpy2i8FoSJCJh78m+pl9vs/ijY7fN0/ztPvqeg2Og
 rwgjDL7uJqIC2aRTIOEfRMEIwoxiYdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709889398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YntvfZHyYeL+PUC/R8nI0sz0FzRQnqsfxogONjtu74Q=;
 b=M7LKaVRxaSJ0JiiMkF1UF1EilXr/oAfbMt92X32AQdfPOt2nXca45w4l/Dv06dXTjIi5ho
 xZNfR1y+lKSRRtAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709889397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YntvfZHyYeL+PUC/R8nI0sz0FzRQnqsfxogONjtu74Q=;
 b=GHF/FNB3wQio1t0cW+vKRt11QgPdo05ec2gF26Q/uywyC6l9cYfuFHJQxh1pjEzUCg4xjK
 5ZguuNh0FJwsP7BH8K9kCKM1e4XKlcWC+dn6CRjNt+OsgJ93rk+TVnO09sLZEolxhI0YIi
 2Hws0ieSo57JpDArDUIgD6jRtNUZzdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709889397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YntvfZHyYeL+PUC/R8nI0sz0FzRQnqsfxogONjtu74Q=;
 b=nd7s6Io8KesfzuRWAY869mBtxC4xQdWpwZx/eJn/nqv24Q5yl8/7Pixjm96sFbDXx16TRe
 Ebgb/fo2ELKww+AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 80C5A1391D;
 Fri,  8 Mar 2024 09:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 00f6HHXX6mViNgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 08 Mar 2024 09:16:37 +0000
Date: Fri, 8 Mar 2024 10:16:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240308091635.GA261752@pevik>
References: <20240306104609.17141-1-wegao@suse.com>
 <20240308083220.19332-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308083220.19332-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="GHF/FNB3";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nd7s6Io8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: AD40E5FD5C
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] safe_macros.c: set umask to 0 within safe_mount
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

Hi Wei, all,

> When system's default umask is 0077, this will trigger following issues:
> chdir01.c:100: TFAIL: nobody: chdir("subdir") returned unexpected value -1: EACCES (13)

> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>

> ---
>  doc/C-Test-API.asciidoc | 4 +++-
>  lib/safe_macros.c       | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)

> diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
> index 08a76c403..81067b12b 100644
> --- a/doc/C-Test-API.asciidoc
> +++ b/doc/C-Test-API.asciidoc
> @@ -2460,7 +2460,9 @@ with 'open()' or 'creat()' etc, the mode specified as the last parameter *is
>  not* the mode the file is created with. The mode depends on current 'umask()'
>  settings which may clear some of the bits. If your test depends on specific
>  file permissions you need either to change umask to 0 or 'chmod()' the file
> -afterwards or use 'SAFE_TOUCH()' that does the 'chmod()' for you.
> +afterwards or use 'SAFE_TOUCH()' that does the 'chmod()' for you. SAFE_MOUNT
s/SAFE_MOUNT/'SAFE_MOUNT()'/

> +also does similar action such as setting umask(0) and then restoring the
> +original value.

I'm not sure about the wording. Maybe:

Temporarily clearing umask with 'umask(0)' is done before mounting in
'SAFE_MOUNT()' and before creating a new subdir in the cgroup in 'cgroup_dir_mk()'.

(based on my patch
https://lore.kernel.org/ltp/20240307232511.228396-1-pvorel@suse.cz/).

It could be changed before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>  2.2 access()
>  ~~~~~~~~~~~~
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 951e1b064..109268587 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -913,7 +913,10 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	 * the kernel's NTFS driver doesn't have proper write support.
>  	 */
>  	if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
> +		mode_t old_umask = umask(0);
> +
>  		rval = mount(source, target, filesystemtype, mountflags, data);
> +		umask(old_umask);
>  		if (!rval)
>  			return 0;
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
