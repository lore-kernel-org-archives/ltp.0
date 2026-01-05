Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FBEC79F9D
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:24:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7983C2985
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 15:24:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487943C2631
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:24:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 45DE010005B4
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:24:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99B455BD7E;
 Mon,  5 Jan 2026 14:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767623062;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbsfh96sGXL1gPWqt9vkzzAV/pLbiQXQ0yVnyUd/ZA4=;
 b=Vu4A21u87TxNwEHaYgNelZ3mnTr3TqpS2ljeYDizTfoQIeMVosScXtzQOlCs3d64WmngFt
 EsIU7i+5WvJhn7rt0dks1QVnAJb7SdpBnus1UfbSctrC7V3n5yxcUnsLDkLOUk8MxSIad3
 Hjzluk6VgBVyg5LAHdjt3u5GKg4A7ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767623062;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbsfh96sGXL1gPWqt9vkzzAV/pLbiQXQ0yVnyUd/ZA4=;
 b=PIZeYe4HDogUvm2jot5rHk016K41OSA8UvTorsORC5YN3qYM4x/j1s+pc3VaRROCmlZiaS
 JT3WqBHeW3X3/9DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XpE0UMAq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="z/2iTaRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767623061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbsfh96sGXL1gPWqt9vkzzAV/pLbiQXQ0yVnyUd/ZA4=;
 b=XpE0UMAqg0r/djLywIZ4Dt+8tXPUqFRRmD2H/ZzegPcEBAorFumhCZP0RwLYJ7LfxKeiQJ
 LU0NkqRT4iGKPVa2OeiHpN/8VJGwE9IV+Mx0S6FLJ0ilwmuWzOFXtawPYVCzFfQBG/8Tis
 f8BG10MCgpxgvMic1yqIwcsyRRPg31w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767623061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbsfh96sGXL1gPWqt9vkzzAV/pLbiQXQ0yVnyUd/ZA4=;
 b=z/2iTaRf8NYUPEvf1yO/MCRXM7FQviMZysYFGrvHTvGe0H1nAFg8Ysqm70exPlnJf336I5
 +KBG4fN/E32P3WDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EFB53EA63;
 Mon,  5 Jan 2026 14:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vGWVHZXJW2kEBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 14:24:21 +0000
Date: Mon, 5 Jan 2026 15:24:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260105142416.GG654507@pevik>
References: <20250211205734.1932275-1-pvorel@suse.cz>
 <20250211205734.1932275-2-pvorel@suse.cz>
 <DF1CO0LSLWLZ.36NGISAN8GB9T@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DF1CO0LSLWLZ.36NGISAN8GB9T@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,tst_test.sh:url];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 99B455BD7E
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_test.sh: Convert only TBROK/TCONF to
 TWARN in cleanup
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

...
> > +	if [ "$TST_TBROK_TO_TWARN" = 1 ]; then
> > +		if [ "$res" != TBROK -a "$res" != TCONF ]; then
> > +			tst_res TWARN "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
> > +		else
> > +			tst_res TWARN "$@"
> > +		fi
> >  		return
> > +	fi
> > +
> > +	if [ "$res" != TBROK -a "$res" != TCONF ]; then
> > +		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
> >  	else
> >  		tst_res "$res" "$@"
> >  	fi

> Here there's a bit of code duplication. For instance, we can save the
> message inside a variable, as well as the T-flag, the use it accordingly
> to TST_TBROK_TO_TWARN.

Sure, this could be done, but as for other tst_test.sh modifications: unless
it's an important fix I'd not touch it as we now have a shell loader. Again,
I'm sorry to waste your time for the review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
