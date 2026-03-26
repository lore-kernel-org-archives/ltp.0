Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3110A62CA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F943CC2CB
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:12:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52EE53C5E70
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:12:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7D92601980
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:12:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 78C0C4D28D;
 Thu, 26 Mar 2026 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774530728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFQT/65KeVp30CF1HBlp55GBfDOflRkDimoffk6LwOs=;
 b=ZVWN3WWm3UlzUSHWaqLK45U5EQoTnQh0FERiZbo5pEeTmVYA/rzRxsSSLY+hx6cMcUqNLg
 b8auN44+nxIT0B9MAyhJh6+ajq+zvXDACL33xuIMbeEx19k5OK2LYgFdmZptnjyOUH3mwL
 i3p3dT+jFDGiK/r20D+i1yrWHhC2n94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774530728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFQT/65KeVp30CF1HBlp55GBfDOflRkDimoffk6LwOs=;
 b=3ajxyYNEq2kuUUHnlLCeY42asrxTQtDMZp1aU1px9KTsrvj+cNpegBUo3cmva9YIUITmhs
 WeQWHW4o8X79UmBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774530728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFQT/65KeVp30CF1HBlp55GBfDOflRkDimoffk6LwOs=;
 b=ZVWN3WWm3UlzUSHWaqLK45U5EQoTnQh0FERiZbo5pEeTmVYA/rzRxsSSLY+hx6cMcUqNLg
 b8auN44+nxIT0B9MAyhJh6+ajq+zvXDACL33xuIMbeEx19k5OK2LYgFdmZptnjyOUH3mwL
 i3p3dT+jFDGiK/r20D+i1yrWHhC2n94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774530728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFQT/65KeVp30CF1HBlp55GBfDOflRkDimoffk6LwOs=;
 b=3ajxyYNEq2kuUUHnlLCeY42asrxTQtDMZp1aU1px9KTsrvj+cNpegBUo3cmva9YIUITmhs
 WeQWHW4o8X79UmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61A284A0A3;
 Thu, 26 Mar 2026 13:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZmDcFqgwxWkaVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 13:12:08 +0000
Date: Thu, 26 Mar 2026 14:12:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260326131203.GA160250@pevik>
References: <20260326123255.GB152048@pevik>
 <69c529ef.050a0220.2ab184.8fc8@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c529ef.050a0220.2ab184.8fc8@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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

> > Yes, IMHO TFAIL.

> I guess we need to agree on the solution here, otherwise Ricard will be
> puzzled :-)

Yeah, I'm sorry for the noise.

> I see TBROK as the right solution, since TFAIL should be used on the subject of
> our tests. Also, if we receive the wrong event there's no purpose to continue
> with the test because that means we have a kernel bug.

OK, tst_brk(TBROK | TERRNO is probably better (and we definitely want TERRNO).

I overlooked Ricardo suggests tst_brk(TFAIL) not tst_res(TFAIL).
The only concern I have is that we skip testing on userfaultfd01.c due tst_brk()
but it's probably quite rare.

Also, this is the problem when test have a lot of duplicity => tests diverge
sometimes in subtle details. But, similarly to fanotify tests, userfaultfd tests
are quite different that it's questionable if factoring out small parts improves
things or complicate.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
