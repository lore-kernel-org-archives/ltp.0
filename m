Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D26C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 10:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AF363CFB0F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:06:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F603CFB0F
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 12:06:16 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62FF92095E6
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 12:06:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC11F33ABC;
 Wed, 17 Apr 2024 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713348373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/i19yCDtoRoI9HLZXS3hVkP7Ws4upsPHCTfL5DbK50=;
 b=VtTJx9NIvmtgcyjbU9NSSQNH4CsLJLF22NvJ8TcEjWORspdextcXxJNGvtEXnTPVLXD/DL
 ud7dYjN3EDmMgo3m1omne0yBHQ6quyhWOAGYpIFveT2lPmyQy63kpP6Og103xVQYIfe5Z+
 Jo+JolmE2kseIGEMqQVo4/e6nNsLbgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713348373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/i19yCDtoRoI9HLZXS3hVkP7Ws4upsPHCTfL5DbK50=;
 b=6D1KrpBN6pDL/q5r+jrMXhD0H3FKFSDDJqisXLEFk1m/LwzwypLzO2CKUtwMSktEnU256B
 e5ZytbagqYiGeDDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713348372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/i19yCDtoRoI9HLZXS3hVkP7Ws4upsPHCTfL5DbK50=;
 b=PmhIprrKFHhSX0LNGjY5ZX4JtqZWFXjcBxobNEJDwA7Wi8UsFhCoE+7EYwgYeR0cwxa7QO
 yp85lkrp9+97zGCeaSPk59Q+3KvZf+2t5G1mswqv/nYIxmYkniMqm7vVyOC5nZgypH/muf
 R07kruNieFFA2npPuiqxc4IC/QoGOY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713348372;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/i19yCDtoRoI9HLZXS3hVkP7Ws4upsPHCTfL5DbK50=;
 b=bWhfwuFTszVLKbFfxOFb4fTGzA9hy9fWnuXUfeprBDuusmivbHgKZ9vilYaPU4JOcodydc
 bgkPIY6hsKJOJXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B661F13957;
 Wed, 17 Apr 2024 10:06:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eApxKxSfH2ZMZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 10:06:12 +0000
Date: Wed, 17 Apr 2024 12:06:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240417100611.GA713385@pevik>
References: <20240417090222.707302-1-pvorel@suse.cz>
 <Zh-eIg51K9UtdQuj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zh-eIg51K9UtdQuj@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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
> > This is hit on systems with 64kb page size (e.g. on aarch64 with
> > CONFIG_ARM64_64K_PAGES=y or on ppc64le with CONFIG_PAGE_SIZE_64KB=y).
> > Using TINFO causes test not "failing" with non-zero exit code.

> > Fixes: f987ffff5 ("libswap: add two methods to create swapfile")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  libs/libltpswap/libswap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> > index 313a15f24..6d4184ef9 100644
> > --- a/libs/libltpswap/libswap.c
> > +++ b/libs/libltpswap/libswap.c
> > @@ -160,7 +160,7 @@ int make_swapfile_(const char *file, const int lineno,

> >  	/* To guarantee at least one page can be swapped out */
> >  	if (blk_size * blocks < pg_size) {
> > -		tst_res(TWARN, "Swapfile size is less than the system page size. "
> > +		tst_res(TINFO, "Swapfile size is less than the system page size. "
> >  			"Using page size (%lu bytes) instead of block size (%lu bytes).",
> >  			(unsigned long)pg_size, blk_size);

> This looks like we are working around a test bug, which test is
> triggering this condition?

All swap tests: swapoff0[12], swapon0[1-3]

https://lore.kernel.org/ltp/CAEemH2ev62JxH7-DA5Sc2LjMKrquYqt927ATHZefNPAOiXb5qA@mail.gmail.com/

Kind regards,
Petr

> >  		blk_size = pg_size;
> > -- 
> > 2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
