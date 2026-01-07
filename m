Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FB4CFD65D
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B20B3C52D9
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 17:18:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 207483C4D56
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:18:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1FB620076C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 17:18:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DB6B3404F;
 Wed,  7 Jan 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUZ2o18eNzYWtbyyeenlwN4ysO96sV2KN1aKqxRp7HY=;
 b=wf/aQW+RgHUMLsHzBKPF3FS3nG0E8BnhL5+p8pxEq0kl05e3xihXPSK8cyYjG28CBiJWjF
 jWD/BlKQb+2DcDYyy4wzyZtEzBqvRLu9SKb8AvLVehIddU4UHctwbjiZsTuRvetBYkrUEd
 1e1d3LH4GorSBI4XGI8daq+s6OyNVZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUZ2o18eNzYWtbyyeenlwN4ysO96sV2KN1aKqxRp7HY=;
 b=OpBnOBmTZp8SF+Speje6KMsn1j6/bzRK/5sYaPdtGkpDyV/txUgww7j7ogR9khPOHx1xvN
 XyMDApEb4PeULpDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wf/aQW+R";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OpBnOBmT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767802708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUZ2o18eNzYWtbyyeenlwN4ysO96sV2KN1aKqxRp7HY=;
 b=wf/aQW+RgHUMLsHzBKPF3FS3nG0E8BnhL5+p8pxEq0kl05e3xihXPSK8cyYjG28CBiJWjF
 jWD/BlKQb+2DcDYyy4wzyZtEzBqvRLu9SKb8AvLVehIddU4UHctwbjiZsTuRvetBYkrUEd
 1e1d3LH4GorSBI4XGI8daq+s6OyNVZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767802708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUZ2o18eNzYWtbyyeenlwN4ysO96sV2KN1aKqxRp7HY=;
 b=OpBnOBmTZp8SF+Speje6KMsn1j6/bzRK/5sYaPdtGkpDyV/txUgww7j7ogR9khPOHx1xvN
 XyMDApEb4PeULpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E88BD3EA63;
 Wed,  7 Jan 2026 16:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /FvFMlOHXmkPMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 16:18:27 +0000
Date: Wed, 7 Jan 2026 17:18:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260107161826.GC791855@pevik>
References: <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
 <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
 <aV6DCbns02E4BCTj@yuki.lan> <20260107160656.GB791855@pevik>
 <aV6G0gxYWHSFkls0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV6G0gxYWHSFkls0@yuki.lan>
X-Rspamd-Queue-Id: 5DB6B3404F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Thanks for your input. I understand that you're for replacing in ioctl_ns06.c:

> > 	int exists = access("/proc/self/ns/user", F_OK);

> > 	if (exists < 0)
> > 		tst_res(TCONF, "namespace not available");

> > with .needs_kconfigs:

> > 	.needs_kconfigs = (const char *[]) {
> > 		"CONFIG_USER_NS",
> > 		NULL
> > 	}

> > Because that was my question - really always prefer kconfig even there is a
> > simple runtime solution? I'd like to have some "rule" like conclusion we can
> > point during review.

> I think that from a long term view this is going to be simpler solution
> than having many different types of checks. The less diverse these
> checks are the easier they are to review and maintain. Hence I lean
> towards kernel config checks even though they are slower (mostly
> unmeasurable on today's harware) than the alternatives.

Great, thanks for a general resolution. Unless somebody objects I'm ok with the
conclusion (ideally we should formalise it in rules in docs).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
