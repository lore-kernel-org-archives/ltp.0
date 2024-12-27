Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7FCE7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 07:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515A33E4DA5
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 08:32:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88FC23E2683
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 08:32:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 86B6C647098
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 08:32:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A497336D3;
 Fri, 27 Dec 2024 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735284754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB+t0Xr2LRJ5Yrxs/1TCIdGq33HmTd3Rar0EweO1QYA=;
 b=HMJCTySWaNMjcY0RoB4aJTEXQ6v64+f8t2AXVm4tsZyyv0lKPx1Zd3F+N8iGD9tXPdP3FH
 mFMCkn7XuiMPvtoAtOBNm9MKEkw0IajoWwzUXC7SQnEo/M9DWb1pGpiNgaG0BAFhcP6/Px
 ydYUR1hAUcbx8j+bdJ4mkQCGvwFk6S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735284754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB+t0Xr2LRJ5Yrxs/1TCIdGq33HmTd3Rar0EweO1QYA=;
 b=Ms90do+gyuy9VJ1GqubWao1MWT735DmXE/Ck6wGvS7g91zTh85HxMvDYvlndLSc8TuDFDP
 Ai4LTQah1OhWJHBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735284754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB+t0Xr2LRJ5Yrxs/1TCIdGq33HmTd3Rar0EweO1QYA=;
 b=HMJCTySWaNMjcY0RoB4aJTEXQ6v64+f8t2AXVm4tsZyyv0lKPx1Zd3F+N8iGD9tXPdP3FH
 mFMCkn7XuiMPvtoAtOBNm9MKEkw0IajoWwzUXC7SQnEo/M9DWb1pGpiNgaG0BAFhcP6/Px
 ydYUR1hAUcbx8j+bdJ4mkQCGvwFk6S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735284754;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eB+t0Xr2LRJ5Yrxs/1TCIdGq33HmTd3Rar0EweO1QYA=;
 b=Ms90do+gyuy9VJ1GqubWao1MWT735DmXE/Ck6wGvS7g91zTh85HxMvDYvlndLSc8TuDFDP
 Ai4LTQah1OhWJHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 747EC13985;
 Fri, 27 Dec 2024 07:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tct1GxJYbmcxLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 07:32:34 +0000
Date: Fri, 27 Dec 2024 08:32:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241227073229.GA290415@pevik>
References: <20241218190029.15015-1-chrubis@suse.cz>
 <20241218190029.15015-9-chrubis@suse.cz>
 <20241219141656.GC115746@pevik> <Z2Qs8IOAEerQb9SY@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z2Qs8IOAEerQb9SY@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/9] metadata: metaparse: Add a few pre-defined
 macros
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
> > > +/* pre-defined macros that makes the output cleaner. */
> > > +static const struct macro {
> > > +	char *from;
> > > +	char *to;
> > > +} internal_macros[] = {
> > > +	{"TST_CG_V2", "2"},
> > > +	{"TST_CG_V1", "1"},
> > > +	{"TST_KB", "1024"},
> > > +	{"TST_MB", "1048576"},
> > > +	{"TST_GB", "1073741824"},
> > I guess we need a number for calculation (e.g. 1 * TST_GB)
> > Otherwise 1 GB would be more readable than a big number.

> The metadata are supposed to be read by a computer, so indeed the number
> is better. I guess that we can convert it to something more sensible in
> the perl script that generates the html pages.

+1 makes sense, I'll try to have look on it once it's merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
