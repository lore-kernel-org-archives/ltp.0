Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD634C636B7
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 20:22:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C25203D0675
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 21:22:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F42B3CAEC3
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:22:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1C705600640
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:22:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C2D3E8B8;
 Sun, 22 Feb 2026 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771791725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbrS7IbDFM2x/cy7f5Zhb2fPkXCq6EV2eJpP39n0rqc=;
 b=cOfIfMpMi6lmyGMZ8wktZgLc7VWq9SaaeMV595e7CxW1H2eDPikyP5FPkRrBj55vEKnhql
 oOgKcSm7+B3KmrPXFk+3bgVQfoW+apBPiPbadTSj8PTBgkm2yB6eyrlMYg5Ui8pkoAcDIz
 I40UKab9uEVag+2PdaVhUmuNsgFTjUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771791725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbrS7IbDFM2x/cy7f5Zhb2fPkXCq6EV2eJpP39n0rqc=;
 b=DL6igs3A1PZIVqNJAMcM1yhDrbxVe0nlgDdoSnm3HaGaPmaph05CkR5CNnazyhWjZmtiIq
 7nPIHLejBnQa3LAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771791725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbrS7IbDFM2x/cy7f5Zhb2fPkXCq6EV2eJpP39n0rqc=;
 b=cOfIfMpMi6lmyGMZ8wktZgLc7VWq9SaaeMV595e7CxW1H2eDPikyP5FPkRrBj55vEKnhql
 oOgKcSm7+B3KmrPXFk+3bgVQfoW+apBPiPbadTSj8PTBgkm2yB6eyrlMYg5Ui8pkoAcDIz
 I40UKab9uEVag+2PdaVhUmuNsgFTjUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771791725;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbrS7IbDFM2x/cy7f5Zhb2fPkXCq6EV2eJpP39n0rqc=;
 b=DL6igs3A1PZIVqNJAMcM1yhDrbxVe0nlgDdoSnm3HaGaPmaph05CkR5CNnazyhWjZmtiIq
 7nPIHLejBnQa3LAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9886B3EA68;
 Sun, 22 Feb 2026 20:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AUp4IGxlm2nLDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 22 Feb 2026 20:22:04 +0000
Date: Sun, 22 Feb 2026 21:21:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260222202158.GA417048@pevik>
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz>
 <aZQytH7k6pVXqdsz@yuki.lan> <20260219202051.GB341772@pevik>
 <aZhJ7h0toQVUzHnf@yuki.lan> <20260220153410.GA392516@pevik>
 <aZiNbmssVOrwSsiV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZiNbmssVOrwSsiV@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.com,redhat.com,lists.yoctoproject.org,gmail.com];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > > > @@ -105,9 +105,9 @@ Quick Start
> > > > > >  	$ ./configure
> > > > > >  	$ make all
> > > > > >  	# make install
> > > > >         ^
> > > > > 	This should be $ (not caused by this patch but worth fixing)

> > > > I can change it, but IMHO for creating /opt/ltp is needed to run it as root
> > > > for a first time. Or one must chmod/chown /opt/ltp under root.

> > > Huh? The make install should just work fine. I'm just pointing out the
> > > typo # vs $. Or did I miss something?

> > Yeah, I understand it and plan to change # => $. I talked about /opt (our
> > default prefix) usually not being writable by regular users (installing any
> > software using standard system prefix will have this problem). Root is needed
> > only for creating /opt/ltp. That was the reason for the original user to use '#'.
> > But as I wrote, I'm ok to change the prompt.

> Ah, that's a bit confusing then because in shell script # is a comment.
> I usually prefix commands that needs root with sudo instead. So what
> about "$ sudo make install" ?

+1, good point.
I'll merge whole patchset with this change tomorrow.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
