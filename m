Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E19CDB471
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 07:36:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745F33E53AB
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 09:36:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9E2D3E53A1
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 09:36:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2A0892003AF
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 09:36:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37BED7058C;
 Mon, 22 Jun 2026 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782113763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33VrWMx3X+mgYqzTcnPFdAFJzuvRd+xNsbm9dmP57O8=;
 b=KxZbzbugfOE78mcqutzm/ULEvQlhYBZU3SF0oFlafpYusyqXVklNVsnAvUnwzoliBpwSkb
 RGWHztkYBNComvAvnVKQvWWe8Zxxba0k7WVWNWNAqkVFQ5pJ1tv6vafTw825hjbdDRN/qt
 GJRSwzgVOZ3B5TE2ChJSYETFpwl+6B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782113763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33VrWMx3X+mgYqzTcnPFdAFJzuvRd+xNsbm9dmP57O8=;
 b=m3lNr/WXtHOA535ZMt//jqmYlk2k0rzNo1Y+CbCaxZ3tb3qLyd1kcyXmiVHbXqmIQOKMWi
 wP0PzfGbG4+GIbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782113762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33VrWMx3X+mgYqzTcnPFdAFJzuvRd+xNsbm9dmP57O8=;
 b=Y8/vjEFhQx5T/XZf4UeGug98OIfg0JgPQdB6vg0Z2bjwZCx7hYcmA1IxptEU6wWl2DI0TI
 UeA2XtCLL+Bvfs0MusGuTFHkckbLPMRaGM4Do85cICjqPkHtje7NXVOYTpLFvZSE0Dd5vR
 f/Imd5wgr+onbjcGEmtPPKuw5dVZU/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782113762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33VrWMx3X+mgYqzTcnPFdAFJzuvRd+xNsbm9dmP57O8=;
 b=SZzzhyv4AtIviXpBZvgrMY2LA4xDQMBSTyA+nJXx3DrtONSkM5EKlFwf/Os1MDRjgZ/INj
 X+Pw6QR0yOVh9DCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F59779A8;
 Mon, 22 Jun 2026 07:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5RD4A+LlOGpFRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jun 2026 07:36:02 +0000
Date: Mon, 22 Jun 2026 09:36:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260622073600.GA19589@pevik>
References: <20260316124022.316230-1-pvorel@suse.cz>
 <69b94b3d.050a0220.29aff4.793b@mx.google.com>
 <afxZ7QDu7Kju1rp3@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afxZ7QDu7Kju1rp3@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Don't consider
 CONFIG_FAULT_INJECTION slow
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

Hi all,

> Hi!
> > I didn't use fault injection extensively, but I read that when verbose mode is
> > enabled we might have a big slowdown, so I wouldn't skip this check.

> > Eventually, we can implement a check that verifies if fault injection is enabled
> > with a high verbosity. That would probably make more sense.

> In this case the fault injection looks like something that you have to
> configure before use so I would assume that anyone who configure this
> can also adjust the LTP multipliers.

> Maybe we can just print TINFO message that the config is on and may
> slown donw the execution instead?

What do you mean by "slow down the execution"?

Anyway, I'd really like to get this solved, not only due 4x longer runtime by
default on Tumbleweed (in case of sigkill test really hangs for 2 mins)

tst_kconfig.c:753: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1870: TINFO: Overall timeout per run is 0h 02m 00s

but on other machines due slow worker with setup LTP_TIMEOUT_MUL=2 we get even
4 min (8x longer wasted time)
tst_kconfig.c:753: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1870: TINFO: Overall timeout per run is 0h 04m 00s

Nobody complained that he's actively using CONFIG_FAULT_INJECTION and needed
this setup, but we are really hit by this. That's why I took a simple approach
to ignore CONFIG_FAULT_INJECTION.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
