Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE4C87FD2
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 06:40:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD223C900A
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 08:40:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66BC13C8FFC
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:39:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAE7E10007EF
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:39:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E48D01F7F7;
 Thu,  7 Aug 2025 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0tjV72QnlYyWcqQQ7nsmggYhqCavqY1y7WxHZIYx6Y=;
 b=pT92xkGpHdHZJLlZ+tXrGQ9CGsZUZlu3GinXRKU9YT2sx0aNTcPnK+gzZYmY8S3gOUgW1E
 9LQgRlBNXB9EmvQIXNj+YtRg1zbo9Va9JnGkCD8maARHRcH4jAEv8BnAeMJ1HRyA5HWVgu
 ui15GeJ4DXTZp0cpnafXkzqSpGw45Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0tjV72QnlYyWcqQQ7nsmggYhqCavqY1y7WxHZIYx6Y=;
 b=Mja7L85uWsu61x75U98drHJ9SiflTPRfvAIAPABr3RzCGYY2VRstn+eHLb9Pp6VTEJl8gu
 mocowvr/hQXBb2Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DurMLdd0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0by92y1+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754548772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0tjV72QnlYyWcqQQ7nsmggYhqCavqY1y7WxHZIYx6Y=;
 b=DurMLdd0RcD2TFb9SvHQGbM8HGu0gD0bSKx7tk6x1mNt6agS6cNX75OfqDf+Mu+yu6oS6E
 FDx/jp9/szJvh2Z5WzZ/NtDj8e3whkHY5m6UukcIB62/wvLIKCX8O4vEEYlYNhmacwk2Oy
 cZgv9XiFGrlKHWjob0zowHXRMWkOb1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754548772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0tjV72QnlYyWcqQQ7nsmggYhqCavqY1y7WxHZIYx6Y=;
 b=0by92y1+wArBEGzP+FcKJ3QyXKlSaaYjizym3viRWPzQLaBJkj9I+4FRXiX/PQwI9fmktJ
 DirrD+1D8OV9MvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACAD6136DC;
 Thu,  7 Aug 2025 06:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QoIGKSRKlGgnCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 07 Aug 2025 06:39:32 +0000
Date: Thu, 7 Aug 2025 08:39:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250807063916.GA349310@pevik>
References: <20250630122719.12948-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630122719.12948-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: E48D01F7F7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: Fix mountflags handling for FUSE
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

Hi all,

> - abort tests on FUSE when particular mount flag is not implemented
> - implement MS_RDONLY for FUSE
> - enable statmount02 that failed previously because of missing MS_RDONLY
I would personally split the change but understand why you want to keep it
together (it's related) and I'm ok with it. Anyway, it's important that you
remember to enable it.

> Reported-by: Signed-off-by: Jan Polensky <japo@linux.ibm.com>
very nit: I haven't seen joining tags on single line. That will break stat
scripts. And that might be the reason why Jan was noc Cc when sending with git
send-email.

Maybe change before merge:
Reported-by: Jan Polensky <japo@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>

or to:
Reported-by: Jan Polensky <japo@linux.ibm.com>
Co-developed-by: Jan Polensky <japo@linux.ibm.com>

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/safe_macros.c                                 | 13 +++++++++++--
>  testcases/kernel/syscalls/statmount/statmount02.c |  1 -
>  2 files changed, 11 insertions(+), 3 deletions(-)

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 6946cc5bc..726c9ae8e 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -942,10 +942,19 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	 */
>  	if (possibly_fuse(filesystemtype)) {
>  		char buf[1024];
> +		const char *mount_ro = "";
> +
> +		if (mountflags & MS_RDONLY)
> +			mount_ro = "-o ro";

Your version is slightly better than Jan's as it avoids duplicity.
Let's merge this one. Maybe add

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +		if (mountflags & (~MS_RDONLY)) {
> +			tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +			          "FUSE mount flag(s) not implemented!");
> +		}

>  		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> -		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> -			filesystemtype, source, target);
> +		snprintf(buf, sizeof(buf), "mount.%s %s '%s' '%s'",
> +			filesystemtype, mount_ro, source, target);

>  		rval = tst_system(buf);
>  		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
> diff --git a/testcases/kernel/syscalls/statmount/statmount02.c b/testcases/kernel/syscalls/statmount/statmount02.c
> index 07f877e04..f322fe930 100644
> --- a/testcases/kernel/syscalls/statmount/statmount02.c
> +++ b/testcases/kernel/syscalls/statmount/statmount02.c
> @@ -68,7 +68,6 @@ static struct tst_test test = {
>  	.format_device = 1,
>  	.all_filesystems = 1,
>  	.skip_filesystems = (const char *const []) {
> -		"fuse",
>  		"btrfs",
>  		NULL
>  	},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
