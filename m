Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B26C67861
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 17:58:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 919693CEF25
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 19:58:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4D13CE3F3
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 19:58:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D27F0140A7CD
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 19:58:24 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56AF32124C;
 Fri,  5 Apr 2024 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712339903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgmfINjfa0KREBaovfqpaMqRxtQTedJK919Mb+133ZU=;
 b=GgOYeJ8wXg8XqaEt+2FrATwBqhdms22w+Z5f7h2Vk5+9p5nnc7oGQfH3hbJIrk6IKa1jC3
 skE8YsT3gnst4H3Pe6k+xac3XHQppCKpa/bFW2YF070FD0ObA/h96CBFqb8ZhLEht0yhai
 DuBwTsdhRKAHybFVh2iYPMLUJw9VFzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712339903;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgmfINjfa0KREBaovfqpaMqRxtQTedJK919Mb+133ZU=;
 b=/vvEt1F93lSaH7eYAxuxaa6/W9qw/I8OrTvy4HazVvqxd2FLP6cJSixYvmJxNQdSIHGGVr
 a5OJwaXK0tb2prCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L5MQGtbK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FtaUcMDj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712339902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgmfINjfa0KREBaovfqpaMqRxtQTedJK919Mb+133ZU=;
 b=L5MQGtbKHFjUPU4KSNJfqpMzVXWaVt7xp6VKT1b+A0yLq56g8/SS7aiDiWau/lX4jvXtJN
 9hs+GPuXX/ZKp1/3PoFsr9pMFAXMNO+6ONNUzHn/UyrWnAUtGE4toxrYGPMOGHK6MUSo7f
 g1zXZOEq4yyNg0TARfiO4Nf/6d58F+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712339902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgmfINjfa0KREBaovfqpaMqRxtQTedJK919Mb+133ZU=;
 b=FtaUcMDjY7ogGiYkazMdpdi7LywtPuUh//IG4wb8nJY3kBvh/qVdpNzv/B+Od4WnjWZ23L
 +xiATxmpx9yF18Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F643139F1;
 Fri,  5 Apr 2024 17:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id BRApBr47EGZiCAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 17:58:22 +0000
Date: Fri, 5 Apr 2024 19:58:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240405175815.GA644726@pevik>
References: <20240405143904.642340-1-pvorel@suse.cz>
 <ZhAOlIfnfwaD2JNd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhAOlIfnfwaD2JNd@yuki>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 56AF32124C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] doc: Remove make install
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
> > make install in doc is broken on out-of-tree builds. Although we may
> > want to install generated docs (final html), for now just disable the
> > target to fix CI. Previously was the install target used just for
> > installing man pages (which are deprecated anyway).

> > Fixes: 4a72aada8 ("New LTP documentation")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  Makefile | 1 -
> >  1 file changed, 1 deletion(-)

> > diff --git a/Makefile b/Makefile
> > index 49d91f4d5..96edd5a80 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -38,7 +38,6 @@ export UCLINUX
> >  # We're not using uclinux based targets (default).
> >  ifneq ($(UCLINUX),1)

> We should probably remove the UCLINUX later on as well...

Agree. Do you mean whole UCLINUX (I could rebase the patch I have sent)
or just in here in this Makefile (or in all Makefiles?)

Kind regards,
Petr

> >  COMMON_TARGETS		:= pan utils
> > -INSTALL_TARGETS		:= doc
> >  endif

> >  define target_to_dir_dep_mapping
> > -- 
> > 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
