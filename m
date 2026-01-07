Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4346ACFD65A
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 15:59:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61883C4D7D
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:59:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1FE3C3089
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:59:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1505314002B5
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:59:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C7FB33BE7;
 Wed,  7 Jan 2026 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4brvnZRfHNj0hO30QkloQJgy47JcKJmroqPcvfIn2M=;
 b=bRrq80k3GfjL6cPNiz4VPh0jdYOOvBLYL/jbVboUvdaCMhc8umOSNd5OANv5vND/qSYYt8
 rNNqbPG/Yd0ntiAzWjFGUHtwRUcObVOJbTW/q5PlqT+3j1m7oYZg6OLoyfJuzl+vJwXk0g
 Q5dfzus2KppugNEg8nEPPzKZUJLWkVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4brvnZRfHNj0hO30QkloQJgy47JcKJmroqPcvfIn2M=;
 b=SOoCXcTGaXrdtMV4DS7VoA447GtTDtMruJnrLcNJLXgCna0IkHGo4HQjmIQ4vROVxVVQAe
 fUW74/Ef4eTurrAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4brvnZRfHNj0hO30QkloQJgy47JcKJmroqPcvfIn2M=;
 b=bRrq80k3GfjL6cPNiz4VPh0jdYOOvBLYL/jbVboUvdaCMhc8umOSNd5OANv5vND/qSYYt8
 rNNqbPG/Yd0ntiAzWjFGUHtwRUcObVOJbTW/q5PlqT+3j1m7oYZg6OLoyfJuzl+vJwXk0g
 Q5dfzus2KppugNEg8nEPPzKZUJLWkVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4brvnZRfHNj0hO30QkloQJgy47JcKJmroqPcvfIn2M=;
 b=SOoCXcTGaXrdtMV4DS7VoA447GtTDtMruJnrLcNJLXgCna0IkHGo4HQjmIQ4vROVxVVQAe
 fUW74/Ef4eTurrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 629123EA63;
 Wed,  7 Jan 2026 15:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WP8hF8aCXmk3HwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 Jan 2026 15:59:02 +0000
Date: Wed, 7 Jan 2026 17:00:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Terry Tritton <terry.tritton@linaro.org>
Message-ID: <aV6DCbns02E4BCTj@yuki.lan>
References: <20251209211629.95436-1-terry.tritton@linaro.org>
 <20251215155330.GC272695@pevik>
 <DEYWYH3VLMDA.R2SSTA8T80LU@suse.com>
 <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik>
 <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > Sure, .needs_kconfigs is used when test request some functionality based on
> > > kconfig.  But many tests use /proc or /sys based detection (e.g. ioctl_ns06.c)
> > > or based on certain errno, see include/lapi/syscalls.h or
> > > testcases/kernel/syscalls/fanotify/fanotify.h) because these were
> > > added before LTP supported kconfig. Later, when kconfig was added it was
> > > considering as a last resort (when there was no way to detect dependency
> > > otherwise).
> > >
> > > Have we decide to move everything into kconfig?
> > >
> > > I'm not sure myself.  needs_kconfigs is simpler and obvious, but it requires
> > > kernel config.  I suppose the speed of parsing config is not an issue.
> > >
> > > It'd be nice to mention the resolution (preferred vs. only if no other way to
> > > detect the support) into
> > > https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html
> >
> > Feel free to add this comment, but for me it's obvious that if a
> > feature can't be present in the kernel due to kconfigs we should check
> > kconfig :-)
> 
> I've just taken another look at this and it appears the test would still
> fail if the config is not present or if KCONFIG_SKIP_CHECK is set, in
> which case perhaps the run time detection may be preferred as it will
> still work in these cases?

The KCONFIG_SKIP_CHECK is a flag aimed at developers, it shouldn't be
enabled in production testing.

As for the missing config there is 95 testcases that have needs_kconfigs
set at this moment and the number is growing steadily. I would argue
that you cannot run LTP without having config available. And the config
location is autodetected on common distributions as well.

> Would it be better to have the run time detection in tst_kconfig_check
> as a fall back in case the config is not present?
> Then the tests can just define the needs_kconfigs and not have to worry
> about other checks.

I would avoid any complexity that isn't strictly necessary, the less we
do, the less breakage we have to deal with later. In that sense adding
the needs_kconfigs and expect the config to be there is probably the
most straightforward solution.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
