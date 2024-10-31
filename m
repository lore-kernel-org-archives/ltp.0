Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4D6D767C8
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 14:09:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 712E33CC112
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 15:09:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEE073C88C1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 15:08:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55C7A144A4FB
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 15:08:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C4EB1FF14;
 Thu, 31 Oct 2024 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730383729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cgj3a4nJi1V3GImV1yfqzo5h0Eo6FOQgw/N2iW5+oCI=;
 b=KIXhNzKrI0l5eqr11eEIdS0AzB2vRL4RjLGZq4LYNnv/hbTxN3eoRtPbze1iejtMIOajKa
 O8y9HHT4FXrEd/ISblktPO+iNF6wSCBQsd5bIrH3nFeSTaTk6n3lgfwgtnPl752qOmVlea
 TVx68kyU3Ryu9cKfcWXBV5vbTsN6n2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730383729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cgj3a4nJi1V3GImV1yfqzo5h0Eo6FOQgw/N2iW5+oCI=;
 b=74yDd+ojIqbgCohFDoxUV9n8ApdyDVi3QGd/NKodDNWzJhBFgTa1sA4DXjRFCchOC2WOu9
 qVydm8XVAeMgboCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730383729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cgj3a4nJi1V3GImV1yfqzo5h0Eo6FOQgw/N2iW5+oCI=;
 b=KIXhNzKrI0l5eqr11eEIdS0AzB2vRL4RjLGZq4LYNnv/hbTxN3eoRtPbze1iejtMIOajKa
 O8y9HHT4FXrEd/ISblktPO+iNF6wSCBQsd5bIrH3nFeSTaTk6n3lgfwgtnPl752qOmVlea
 TVx68kyU3Ryu9cKfcWXBV5vbTsN6n2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730383729;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cgj3a4nJi1V3GImV1yfqzo5h0Eo6FOQgw/N2iW5+oCI=;
 b=74yDd+ojIqbgCohFDoxUV9n8ApdyDVi3QGd/NKodDNWzJhBFgTa1sA4DXjRFCchOC2WOu9
 qVydm8XVAeMgboCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A8913A53;
 Thu, 31 Oct 2024 14:08:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U45oC3GPI2fmBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 14:08:49 +0000
Date: Thu, 31 Oct 2024 15:08:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241031140847.GA1097555@pevik>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-1-f3e26c06814e@suse.com>
 <20241031130117.GA1017691@pevik>
 <b507e053-8404-4b46-bba7-ce5e86383a97@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b507e053-8404-4b46-bba7-ce5e86383a97@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] Refactor regen.sh script to generate
 syscalls
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

Hi Andrea,

> > > --- /dev/null
> > > +++ b/include/lapi/syscalls/generate_syscalls.sh
> > > @@ -0,0 +1,109 @@
> > > +#!/bin/sh -eux
> > I'm very sorry, I asked for "#!/bin/sh -eux", but better would be without "x".
> > "x" prints output of the commands which is too verbose on generate_syscalls.sh.
> > Could you please, when you merge, change it to "#!/bin/sh -eu"?
> No problem, I will do it before merge.

+1

> > I'm not sure if it should stay in the other script.
> > This is on dash, but I suppose this can be reproducible on bash as well.

> > $ ./configure
> > ...
> > + syscall_nr=__NR_writev
> > + echo # ifndef __NR_writev
> > + echo #  define __NR_writev __LTP__NR_INVALID_SYSCALL
> > + echo # endif
> > + echo #endif

> > $ ./configure > /tmp/out 2> /tmp/err; wc -l /tmp/out /tmp/err

> Did you check the CI result I mentioned in the cover letter?

Yes, I did. Sure, it can be a problem with my setup (or it can be a bug in a
script which is visible only on certain setup).

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
