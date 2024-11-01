Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA9E674BF
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 09:34:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DD4E3CD0A4
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:34:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCFC43CD090
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:33:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 536B11435AF1
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:33:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE26B1FD09;
 Fri,  1 Nov 2024 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730453630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XwwwRGeLG4HFrhXTh8amMXbRvXQzWTt+0OQzXopXtw=;
 b=zCe9NFJe9FnyUuzX1KQpRk/txUpga54FMD3xqdfBxFbgGO+kLEQKO7hdOYj3bjkGIvHu8w
 uCi1KIkYut+PMsXn+KZfgooJr23BEHQf3EgevA0W/RUZfT7Tb8aIyLSfc6HlfTQJ6TD2PN
 ajXu/BZnueqsrpy1EV11ZivhFz2tZ2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730453630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XwwwRGeLG4HFrhXTh8amMXbRvXQzWTt+0OQzXopXtw=;
 b=r2jJsjIykqVC82yZTX12NhR8k4g7+Tq4WxuRWsooLq6a3PjN4PNOf2z3NFGxoALb4pim8Z
 FQ1i1dxnavPTHMAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zCe9NFJe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r2jJsjIy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730453630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XwwwRGeLG4HFrhXTh8amMXbRvXQzWTt+0OQzXopXtw=;
 b=zCe9NFJe9FnyUuzX1KQpRk/txUpga54FMD3xqdfBxFbgGO+kLEQKO7hdOYj3bjkGIvHu8w
 uCi1KIkYut+PMsXn+KZfgooJr23BEHQf3EgevA0W/RUZfT7Tb8aIyLSfc6HlfTQJ6TD2PN
 ajXu/BZnueqsrpy1EV11ZivhFz2tZ2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730453630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XwwwRGeLG4HFrhXTh8amMXbRvXQzWTt+0OQzXopXtw=;
 b=r2jJsjIykqVC82yZTX12NhR8k4g7+Tq4WxuRWsooLq6a3PjN4PNOf2z3NFGxoALb4pim8Z
 FQ1i1dxnavPTHMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A92AC136D9;
 Fri,  1 Nov 2024 09:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id grYCKX6gJGfOPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 01 Nov 2024 09:33:50 +0000
Date: Fri, 1 Nov 2024 10:33:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZySgf_RyPfZUXCXD@yuki.lan>
References: <20240927101813.12643-1-chrubis@suse.cz>
 <2748318.lGaqSPkdTl@localhost> <20241015161950.GA35679@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241015161950.GA35679@pevik>
X-Rspamd-Queue-Id: BE26B1FD09
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include: Better documentation for TFAIL and TBROK\
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> nit: there is trailing "\" in the test subject.

I know, fixed.

> > > diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
> > > index 806940e0d..a79428fa2 100644
> > > --- a/include/tst_res_flags.h
> > > +++ b/include/tst_res_flags.h
> > > @@ -9,11 +9,26 @@
> > >  /**
> > >   * enum tst_res_flags - Test result reporting flags.
> > >   *
> > > - * @TPASS: Reports a single success.
> > > - * @TFAIL: Reports a single failure.
> > > - * @TBROK: Reports a single breakage.
> > > + * @TPASS: Reports a single success. Successes increment passed counter and
> > > + *         show up in the test results.
> > > + *
> > > + * @TFAIL: Reports a single failure. Failures increment failure counter and
> > > + *         show up in the test results. A failure occurs when test assertion
> > > + *         is broken.
> > > + *
> > > + * @TBROK: Reports a single breakage. Breakages increment breakage counter and
> > > + *         show up in the test results. Breakages are reported in cases where a
> > > + *         test couldn't be executed due to an unexpected failure when we were
> nit: maybe use passive form? "when we were setting the test environment" =>
> "during the test setup" or "during setting the test environment"?

That is indeed better, thanks.

> > > + *         setting the test environment. The TBROK status is mostly used
> > > + *         with tst_brk() which exit the test immediatelly. The difference
> > s/immediatelly/immediately 
> 
> +1

Fixed as well.

> > > + *         between TBROK and TCONF is that TCONF is used in cases where
> > > + *         optional functionality is missing while TBROK is used in cases where
> > > + *         something that is supposed to work is broken unexpectedly.
> nit (not really sure): "that" => "which"
> 
> > > + *
> > >   * @TWARN: Reports a single warning. Warnings increment a warning counter and
> > > - *         show up in test results.
> > > + *         show up in test results. Warnings are somewhere in the middle between
> > > + *         TBROK and TCONF. Warnings usually appear when something that is
> nit (not really sure): "that" => "which"

AFAIK both can work here, so I kept the original.

Thanks a lot everyone for the reviews, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
