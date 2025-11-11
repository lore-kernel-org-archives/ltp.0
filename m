Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24311CCFA18
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 16:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 911303CF68D
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 17:03:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A5EF3CF65A
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 17:03:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 89ED4600A1B
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 17:03:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0883021AB1;
 Tue, 11 Nov 2025 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762877006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yYqhqA3KwgFqZpIzevRPIaiOCAgpkFiswiJsGiXxzQ=;
 b=fT/zB05ZJDfpxVYzBxAOFPm0Mw54M0bEUOSL3LD5UFNafC7OsIvWxE/Sq0EQB3/uaPXPTc
 Q58+o2I8rNvfKP3c3Ha1XqgTS5WC6HhZsuzQe39LtN4ZXjv1wxKZDAr0pJQqSaAQbWEv5p
 VVa5wHEVZssxbAtI/qCBM002nIWnlHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762877006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yYqhqA3KwgFqZpIzevRPIaiOCAgpkFiswiJsGiXxzQ=;
 b=fY7RRiaU+JixDs7XUApC0OsjgVunfkKPLW4J2KzBCQHls4Bn7c8LjVpKHCv06+ru/Yq8LY
 uRRSdyXlNHXYYXAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fT/zB05Z";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fY7RRiaU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762877006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yYqhqA3KwgFqZpIzevRPIaiOCAgpkFiswiJsGiXxzQ=;
 b=fT/zB05ZJDfpxVYzBxAOFPm0Mw54M0bEUOSL3LD5UFNafC7OsIvWxE/Sq0EQB3/uaPXPTc
 Q58+o2I8rNvfKP3c3Ha1XqgTS5WC6HhZsuzQe39LtN4ZXjv1wxKZDAr0pJQqSaAQbWEv5p
 VVa5wHEVZssxbAtI/qCBM002nIWnlHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762877006;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yYqhqA3KwgFqZpIzevRPIaiOCAgpkFiswiJsGiXxzQ=;
 b=fY7RRiaU+JixDs7XUApC0OsjgVunfkKPLW4J2KzBCQHls4Bn7c8LjVpKHCv06+ru/Yq8LY
 uRRSdyXlNHXYYXAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B6014A36;
 Tue, 11 Nov 2025 16:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1K/JL01eE2kKewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 16:03:25 +0000
Date: Tue, 11 Nov 2025 17:03:24 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Avinesh Kumar <akumar@suse.de>, Li Wang <liwang@redhat.com>,
 Michal Hocko <mhocko@suse.com>
Message-ID: <20251111160324.GD61698@pevik>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-4-pvorel@suse.cz>
 <aRM09edcL-6OyfPk@yuki.lan> <20251111155848.GC61698@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251111155848.GC61698@pevik>
X-Rspamd-Queue-Id: 0883021AB1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] swapon03: Try to swapon() as many files
 until it fails
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

> Hi Cyril,

> > Hi!
> > >  	is_swap_supported(TEST_FILE);
> > > +
> > > +	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
> > > +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > > +	*swapfiles = 0;
> > > +
> > >  	setup_swap();
> > >  }

> > >  static void cleanup(void)
> > >  {
> > > -	clean_swap();
> > > +	if (swapfiles) {
> > > +		clean_swap();
> > > +		SAFE_MUNMAP(swapfiles, sizeof(*swapfiles));
> > > +	}
> > >  }

> First, thank you for your review!

> > This gets complicated for no good reason since we run the setup code in the
> > child.

> If swapfiles is not mapped for some reason (can happen or "*swapfiles = 0" is
> not run (that should not happen), then using *swapfiles leads to segfault.

... but I'm not happy with the resulting code either. Therefore I'll send
another version where I cleanup unneeded fork() leftover from previous
implementation as you suggested [1]. That will simplify test a bit
(and mmap() will not be needed).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/aRM0Z-IlZSLdB5ho@yuki.lan/


> *swapfiles is being used not only in SAFE_MUNMAP() here in cleanup(), but
> also in clean_swap().

> Also, this saves trying to deactivate swap files if they weren't activated.

> And, unless "swapon03: Remove grep dependency" (the last commit) is accepted,
> there is a corner case I found during debugging:

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
