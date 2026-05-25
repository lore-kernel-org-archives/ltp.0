Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0D5CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:36:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46AED3E5294
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 13:36:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 220A03C5AE0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 13:36:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4D982002DF
 for <ltp@lists.linux.it>; Mon, 25 May 2026 13:36:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA56E6770D;
 Mon, 25 May 2026 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779708990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vvh9Yr65w02my8jd2OdlCLeGbVIJRTSPWPMssF3GRlY=;
 b=fTo3U2ngcva7Ag/99JW6ECLAqDLg79697+AkUEpJPO6LTzVPhouMG3C2jn7T8y6BEsthmr
 2FO4fg7girlKU8ZDZZudq3ej25wdPg/zCDCUhBgnUbVIrpyreMJAiFT0ojG+kR2GLMxUnp
 wQ1oXWAWQ7kDDn9NkORaAuQauobfdH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779708990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vvh9Yr65w02my8jd2OdlCLeGbVIJRTSPWPMssF3GRlY=;
 b=cCgTRUU+he0SWeIV8Xs+XqUk8Hyd/0cdnrDvGHRDOzEuEtuM0CCBDyWZ9xKXlYeqEkVVJI
 FBgvZiecRdt1AEDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BHx1EiIs;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TsCBtddA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779708989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vvh9Yr65w02my8jd2OdlCLeGbVIJRTSPWPMssF3GRlY=;
 b=BHx1EiIsTD5cPgHZ0QwtC8mBNl6KPdkwoA2dvkD4Gq/zCLurMpt/4cYWXkRdlRThPpq+0S
 Rb9kcwwR0PqzuMCiOOn/W2yds4xT7fYOJlQUtu+/XTLcKkRqoawwVIFm/nXC4V9UahkfLe
 Z/JnjQRi+3xdJveuBLQOIpX4PuIu3lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779708989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vvh9Yr65w02my8jd2OdlCLeGbVIJRTSPWPMssF3GRlY=;
 b=TsCBtddA+p2lThuI2KiytrYLo3rlFvc2Kl+TEmoeple3U0V0yl7rMPqi3nNIaxBqDkAyIe
 g0Ti7aZCzOw246Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B706A59C0B;
 Mon, 25 May 2026 11:36:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CtV1Kz00FGpNCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 25 May 2026 11:36:29 +0000
Date: Mon, 25 May 2026 13:36:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260525113628.GB181471@pevik>
References: <20260525073921.172426-1-pvorel@suse.cz>
 <ahQQEDozOrVesyQH@yuki.lan> <20260525094224.GA181471@pevik>
 <ahQvOj1-I9f7Y8OS@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahQvOj1-I9f7Y8OS@yuki.lan>
X-Rspamd-Queue-Id: EA56E6770D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] min_free_kbytes: TCONF on errno ENOMEM,
 add break
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

> Hi!
> > > This looks suspicious. If we fail with the fork here that probably means
> > > that the memory allocated by the previous iteration wasn't reclaimed
> > > fast enough. Was this on a second or third iteration (we do three
> > > iterations with different overcommit values)?

> > This is on one of my bare metal machines, first iteration:

> > min_free_kbytes.c:91: TINFO: Setting /proc/sys/vm/overcommit_memory to 2
> > min_free_kbytes.c:95: TINFO: Setting /proc/sys/vm/min_free_kbytes to 67584
> > min_free_kbytes.c:111: TBROK: fork: ENOMEM (12)
> > tst_test.c:1933: TINFO: Killed the leftover descendant processes

> With overcommit = 2 (never) this just means that memory on your machine
> has been all consumed[1]. It may make sense to TCONF on overcommit=2 but
> I'm not so sure the other two overcommit modes.

> [1] The available memory is counted as swap + 50% of RAM

Thanks for info. I set this patch as changes requested. I might send a patch
adding it only for overcommit = 2, but I consider sporadic TFAIL: MemFree <
min_free_kbytes we get as more important to fix.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
