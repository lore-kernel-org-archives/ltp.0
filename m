Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A5CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 13:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CD443CC911
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 15:01:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8D493CC7DC
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:00:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0058110007F3
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:00:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27977211A0;
 Mon, 18 Aug 2025 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755522044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGqSTLBo9DbFYNbkLIjpgTGwd1q1AYLpjZ2qKnyEz4Y=;
 b=xKdsCw6DfyADI5m1xD5KblXDrWhwtrxklODGBjI6WVerwZSdg39nO0f7kuiTDYfHMetGl2
 83Y80GH+nEvu+dOa+Q87kMSNvfynQpkh+JFDuLXJ+GDtw7GDaCGW4Xv0394wFHcPReduXv
 ldLAtRcvvmLM7S9hZtdns+DCZl3ow6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755522044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGqSTLBo9DbFYNbkLIjpgTGwd1q1AYLpjZ2qKnyEz4Y=;
 b=vMz2ZE8MKPX6TGjJ2POlMRW5Anwx7+bJHZqCKhjwiM6IRQGWgJ/BBX7RmDs8Edb06suBvf
 uPxZkJrBKUVHKpDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xKdsCw6D;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vMz2ZE8M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755522044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGqSTLBo9DbFYNbkLIjpgTGwd1q1AYLpjZ2qKnyEz4Y=;
 b=xKdsCw6DfyADI5m1xD5KblXDrWhwtrxklODGBjI6WVerwZSdg39nO0f7kuiTDYfHMetGl2
 83Y80GH+nEvu+dOa+Q87kMSNvfynQpkh+JFDuLXJ+GDtw7GDaCGW4Xv0394wFHcPReduXv
 ldLAtRcvvmLM7S9hZtdns+DCZl3ow6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755522044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGqSTLBo9DbFYNbkLIjpgTGwd1q1AYLpjZ2qKnyEz4Y=;
 b=vMz2ZE8MKPX6TGjJ2POlMRW5Anwx7+bJHZqCKhjwiM6IRQGWgJ/BBX7RmDs8Edb06suBvf
 uPxZkJrBKUVHKpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E84E713686;
 Mon, 18 Aug 2025 13:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Uq8sN/sjo2hLfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Aug 2025 13:00:43 +0000
Date: Mon, 18 Aug 2025 15:00:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <20250818130038.GA21418@pevik>
References: <20250814152659.1368713-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250814152659.1368713-1-florian.schmaus@codasip.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 27977211A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sigrelse01: Select signals based on
 SIGRTMIN/SIGRTMAX for musl compat
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
Cc: Pedro Falcato <pfalcato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Florian, Pedro,

> This avoids selecting signal 34 when the test is run using
> musl. Signal 34 is used internally by musl as SIGSYNCCALL.
> Consequently, musl's signal() will return with an error status and
> errno set to EINVAL when trying to setup a signal handler for signal
> 34, causing the sigrelse01 test to fail.

+1, now it works on both glibc and musl (and hopefully in the rest of libc).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Thanks to Pedro Falcato for suggesting using SIGRTMIN and SIGRTMAX for
> this check.

nit: @Florian instead of the above I'll add:
Suggested-by: Pedro Falcato <pfalcato@suse.de>

@Pedro Can I merge with your RBT?

Kind regards,
Petr
> ---

> Changes in v3:
>     - base check on SIGRTMIN / SIGRTMAX, as suggested by Pedro Falcato

>  testcases/kernel/syscalls/sigrelse/sigrelse01.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> index d1ed9d53a4dc..23c6758262bb 100644
> --- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> +++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
> @@ -739,8 +739,10 @@ int choose_sig(int sig)

>  	}

> -	return 1;
> +	if (sig < 32)
> +		return 1;

> +	return sig >= SIGRTMIN && sig <= SIGRTMAX;
>  }

>  void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
