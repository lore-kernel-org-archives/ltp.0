Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9588C53219
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 08:28:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 884653E53E2
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 10:28:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A872D3C0E55
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 10:27:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 773ED600716
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 10:27:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9ED467D31E;
 Mon, 27 Jul 2026 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785140867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kq/oCWWd87tFg55XN9Vp+8CZaufFvLKwPiZpSlg3gz8=;
 b=Bij3IhJV68QwivLNiX+zPLJerkCuLlWwozIXE9Adu0Z/bs0vllgY0goWoTCldz057wYYRR
 Hfilt24wm/uMchDVABF9Uk/DVckhK6keHlfRHgiXxFlKGNNyYeVvGJdiRbzndMTYHnoVsD
 eiumveZdHu0Od7Cf9QIBv5j1Gbz7ttw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785140867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kq/oCWWd87tFg55XN9Vp+8CZaufFvLKwPiZpSlg3gz8=;
 b=ht901ZcYz6yiV54FLp2o525LtnYnUmpvOxa5xDaA59kTVQXAS68OArioC6HYbb6UJMkJRo
 wOYkuB0+84f73XCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z2nytlq+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0Y0Ftm/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785140863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kq/oCWWd87tFg55XN9Vp+8CZaufFvLKwPiZpSlg3gz8=;
 b=Z2nytlq+WasaFbmtRxWMI79dNdbZWu9G0ZT6Z3iUbi5TXKoeb8+o/8df2x9/5ykguonIOZ
 Rgz91s7SEczzqXXZJcBnig07d0HWdG0ggDCMG8Q3vqYaxzJHUWqtFgh8n45+jASAsxZjCq
 36677qD8hnsoFztoJX/Vn0FVBVTy1KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785140863;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kq/oCWWd87tFg55XN9Vp+8CZaufFvLKwPiZpSlg3gz8=;
 b=0Y0Ftm/Nti7eJXusu9o2+LExTK0Dy9GRBUWJTndpaCzb/DgmnwKoF6+AX2ECU8M4Htev1h
 fzzREIdiz6AFf9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 870AF779C2;
 Mon, 27 Jul 2026 08:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m5AHIH8WZ2oVYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jul 2026 08:27:43 +0000
Date: Mon, 27 Jul 2026 10:27:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Message-ID: <20260727082738.GB1010349@pevik>
References: <20260724095737.3631000-1-wakel@google.com>
 <20260724121114.GB983347@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260724121114.GB983347@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 9ED467D31E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: Detect EBADF behavior dynamically at
 runtime
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

Hi Wake Liu,

...
> > -	else
> > +		tst_res(TINFO, "Detected kernel with EBADF behavior for invalid mnt_ns_fd");
> > +	} else if (TST_ERR == EINVAL) {
> >  		kver = BEFORE_6_17_9;
> > +		tst_res(TINFO, "Detected kernel with EINVAL behavior for invalid mnt_ns_fd");
> > +	} else if (TST_ERR == ENOSYS) {
> > +		tst_brk(TCONF, "listmount() syscall not supported");
> This is IMHO not supported, because it's part of tst_syscall().

I'm sorry, I meant "not needed".

Kind regards,
Petr

> Other than this LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

> > +	} else {
> > +		tst_brk(TBROK | TTERRNO, "Unexpected error during probe");
> > +	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
