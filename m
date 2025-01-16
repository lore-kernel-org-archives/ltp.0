Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B503C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:19:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D10193C4D06
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:19:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E16C63C4D06
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:19:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E2A1140B6BC
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:19:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5854D1F796;
 Thu, 16 Jan 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42E2813332;
 Thu, 16 Jan 2025 11:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xjs9D0PriGdvAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 11:19:31 +0000
Date: Thu, 16 Jan 2025 12:19:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250116111925.GB679477@pevik>
References: <20250109150336.25235-1-chrubis@suse.cz>
 <20250109161851.GB355678@pevik> <Z4jqWbkdTsfVmfZL@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4jqWbkdTsfVmfZL@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5854D1F796
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_macros: Fix confusing safe_read() failure
 output
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

Hi Cyril,

> Hi!
> > > In the case that we read() less bytes than expected in the strict mode
> > > we used the same tst_brk() as for the case when read() fails. However
> > > for short reads the errno is in an udefined state and we possibly end up
> > > with confusing TBROK message. Andrea reported EACESS ernno in the TBROK
> > nit: s/ernno/errno/

> > > message on a short read() while developing tests.

> > Good catch!

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Pushed, thanks.

> > FYI safe_write() also has TERRNO in len_strict.

> > Kind regards,
> > Petr

> > +++ lib/safe_macros.c
> > @@ -554,7 +554,7 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),

> >  		if (len_strict == SAFE_WRITE_ALL) {
> >  			if ((size_t)rval != nbyte)
> > -				tst_brkm_(file, lineno, TBROK | TERRNO,
> > +				tst_brkm_(file, lineno, TBROK,
> >  					cleanup_fn, "short write(%d,%p,%zu) "
> >  					"return value %zd",
> >  					fildes, buf, nbyte, rval);

> I guess that we are missing check for invalid return value from write()
> as well and return in the rval == -1 branch, we probably need to add:

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index b224a5861..3d3e7c693 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -551,6 +551,14 @@ ssize_t safe_write(const char *file, const int lineno, void (cleanup_fn) (void),
>                         tst_brkm_(file, lineno, TBROK | TERRNO,
>                                 cleanup_fn, "write(%d,%p,%zu) failed",
>                                 fildes, buf, nbyte);
> +                       return rval;
> +               }
> +
> +               if (rval < 0) {
> +                       tst_brkm_(file, lineno, TBROK, cleanup_fn,
> +                                 "invalid write() return value %zi",
> +                                 rval);
> +                       return rval;
>                 }

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Please merge it directly (ideally with link to this discussion on lore).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
