Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF8606A328
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wd5hj9dQ;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7D6O0c1Q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=T2IE5H7Y;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vVlOZU2H
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C65D33CF334
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 19:11:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3034A3CEFA4
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 19:11:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61A711A0035E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 19:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DCA581F7DF;
 Thu,  5 Nov 2026 18:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793902278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RT5HStQZE+J3SKgXfzlUiqYyEZkgrVQZhBegJAMpi8=;
 b=wd5hj9dQ2zC4VyMoO1zn4GIyBdZ09FFnDwNv7sz2MgvXYsz/2UUUdmOE2VsZiI/2gM02bR
 QJSfDbD/IK6J2x21iBKnu9za5XBEnmTH+Pty0colBVVG3TwKI5Q6wtXQ43QiWy+HtkgrOy
 iAlbG158IvvJkax/yGmxZG2jpE7eovY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793902278;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RT5HStQZE+J3SKgXfzlUiqYyEZkgrVQZhBegJAMpi8=;
 b=7D6O0c1Q+45zrLiHk2qo4g3zCZjzZnLgG7LHKxl7O/R5NbhR8T4Q7VOZlZE4FPGai0K22x
 P5+4RjWb5yHdO9Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T2IE5H7Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vVlOZU2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793902276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RT5HStQZE+J3SKgXfzlUiqYyEZkgrVQZhBegJAMpi8=;
 b=T2IE5H7YzZ38flzyvw61BEvEG/CcM1O5alh/QGPQ9tOtvTKKUMxM0YWUUo6MYvLYsIM07t
 ILhAOTA8I/Xo0v+LafvJWZkv+wK4YxTIb4vj961S1jxIAuj8zoaN6XFsY4ShWigBVnJtKa
 Q6q0chqmKbQ5ektobflqyXdDBYiAJW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793902276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4RT5HStQZE+J3SKgXfzlUiqYyEZkgrVQZhBegJAMpi8=;
 b=vVlOZU2HM1X//0yumixR5QoyLh2zpLxY/nZjMm99mgZPF9Eiy+tTWT6n1U7dW+nNGyYGxs
 UkqOdbW6Z1EvfPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5776F134F4;
 Thu,  5 Nov 2026 18:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EuxQB8TG7GozDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Nov 2026 18:11:16 +0000
Date: Thu, 5 Nov 2026 19:11:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Message-ID: <20261105181114.GA523231@pevik>
References: <P5I00QE--F-9@tuta.io>
 <CAOQ4uxhZL5Vk1NQ+Q4MW1f9kRLD0wWvAHZp-c8UwaESpyq+c-A@mail.gmail.com>
 <auoPxzIaqjk7qUma@yuki.lan> <20261103200333.GA154873@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261103200333.GA154873@pevik>
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[suse.cz,gmail.com,lists.linux.it,tuta.io];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.71
X-Spam-Level: 
X-Rspamd-Queue-Id: DCA581F7DF
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Move from staging to syscalls
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi all,

> > Hi!
> > > On the other hand, Petr, this is not a new feature, it is a real bug fix.
> > > Are we holding off on running tests on newly found bugs
> > > until those bugs are fixed upstream?

> > I do not think that we need to hold off tests for bugs. The rule we have
> > has been introduced since newly added kernel ABIs are subject to change
> > in the rc phases.

> Yes that's true, this is a different case. Anyway, if all distro users test with
> LTP releases (they are using master branch), I'm ok to merge before fix is
> merged and it's hash added to the test.

> We are using LTP master branch for testing SLES in development and openSUSE
> Tumbleweed, filtering these errors involves some work, but that's ok.

OK, v7.4-rc1 is out and Amir and Cyril pointed out this is a regression test for
a real (old) bug not a new feature.  I rebased the patch and merged.

Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
