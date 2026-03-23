Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F392D58CBF
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 21:21:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19A0E3E6B87
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 22:21:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24EBD3DEC78
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 22:20:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1AA1D1A006FC
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 22:20:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFBA95BE47;
 Mon, 23 Mar 2026 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774300836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxgVp9ZkgeSuzMBY7GBy9zXs/EsYroSEyW/omDei3w8=;
 b=Y95cNtoBdmkVuAjx9nrXRGanFSpfRwONvSmutSW66pfgzjL47KwyT/MUJ5uCCHlW8hjkRi
 wWLFXFEdSz5aLPvNO2nFoirwV1SlDTaatNdp6ojlkVbmx6ZpFupOufh2v7FAqgkeWKyUtk
 8/LdZfNzlMKEFhr7c1aMlGjM9bR69vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774300836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxgVp9ZkgeSuzMBY7GBy9zXs/EsYroSEyW/omDei3w8=;
 b=J6xi0xCmnQaWiSjZ+jeko389W4cdyoDqX3rkBLE2OanQw8/k6Iq/s7E0/RI1VgNoJT2M8m
 rZWWeNncZwpsufAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N1LQjkya;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0UU2/j0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774300835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxgVp9ZkgeSuzMBY7GBy9zXs/EsYroSEyW/omDei3w8=;
 b=N1LQjkyau9W2Uh0obInNFmLWvAGqLHeKEvAK8/18TlViVgs3y4Nl+J+HwJEEaLXN16QKgz
 WTp5vvH9Lf8hG2K0xBqbo98OPgytAE7pqlejIiVU4UZ2cItkmwoNtgbMWrVLwCES0RH3Dk
 +XaAnSoXON5VwFpFpzCkwMu9Jw7gUQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774300835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxgVp9ZkgeSuzMBY7GBy9zXs/EsYroSEyW/omDei3w8=;
 b=0UU2/j0fqEywDNXKjEDvhUu/YJjf56E/0JVS6G7W131dkcVwdGs6+Fy58ZXKzzqcQjVpVW
 WdWI/mJCAb794PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FFA243AA4;
 Mon, 23 Mar 2026 21:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NLTrHKOuwWl0SgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 21:20:35 +0000
Date: Mon, 23 Mar 2026 22:20:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260323212026.GA19781@pevik>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
 <abkh9aPkKAewapRr@redhat.com> <abqLM0iQY7nwPaDm@yuki.lan>
 <abqZ3h1iVo5DaQ_4@yuki.lan> <20260318154019.GE31214@pevik>
 <ab1kdAOb5_YDqyLN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab1kdAOb5_YDqyLN@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: DFBA95BE47
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] [WIP,RFC] tst_run.sh: Run setup() only once
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > It's a bit more complicated we do not have only iterations but also
> > > > duration and timeout per iteration. So we would need a function that
> > > > would return if the script should continue or not and also call the
> > > > heartbeat() function. Something as:

> > > > int tst_next_shell_iteration(void)
> > > > {
> > > > 	int cont = 0;
> > > > 	static int iteration = 0;

> > > > 	if (iteration < iterations)
> > > > 		cont = 1;

> > > > 	if (stop_time && get_time_ms() < stop_time())
> > > > 		cont = 1;

> > > > 	if (!cont)
> > > > 		return 0;

> > > > 	heartbeat();
> > > > 	return ++iteration;
> > > > }

> > > > The shell helper would call this and we would use it in tst_run.sh and
> > > > loop the tst_test() until we are said to stop.

> > Wait, tst_run_shell.c calls shell script via tst_run_script(). This can be
> > called only once, before starting the script...

> The tst_run_script() is set as the tst_test.test or tst_test.test_all
> function. Then we enter the library via the tst_run_tcases() and we do
> the full test library init and everything.

> The problem with that is that we run the shell script is re-executed
> for each -i iteration. That means that unlike the fork() the whole
> environment is re-created. So we cannot run setup() only for first
> iteration as we do for C.

> So we either call the setup in each iteration (that means both tcnt and
> -i) or we push the loop over tcnt and -i into the shell. I think that
> more elegant solution is the latter.

Agree.

> > > Note also that this solution would move the iteration into the shell

> > ... but from the code it's obvious that you want to call it more times.
> > How do you want to reach C library code from shell test?

> We would have to just call the tst_test->test() function directly in the
> fork_testrun() instead of testrun() for script tests. That would avoid
> all the looping and heartbeats() in C library in that case.

+1. My question was answered by "use C helper to read iteration from shared
memory".

> > > script, since if we do not iterate in the shell, we will end up with a
> > > different environment in the second and subsequent iterations. That
> > > means that any variables exported in setup() would be lost in subsequent
> > > iterations, the pid of the shell would be different, etc.

> > Yes, I noticed that during du01.sh rewrite. I was surprised but thought that you
> > wanted to have most of the library code be in C API (having shell part of the
> > shell loader really thin).

> > Before sending the patchset I was thinking if some shell variables should be
> > shared and exported into new shell run. But it'd be unpractical and as you write
> > PID of the shell would be always different.

> > I have to admit sometimes I think whether rewriting everything into C wouldn't
> > be a better time investment than implementing shell loader, given we are going
> > to redesign network API. Anyway, any new test should really be using C API.

> I think that the shell API is nearly finished at this point, the last
> unsolved piece is how we design the test iterations with -i and tcnt.

We need also getopts which we will also have to be handled in shell because we
actually execute the shell. Then timeout handling (LTP_TIMEOUT_MUL, LTP_RUNTIME_MUL),
but that should be part of the function you suggested for iteration.

Hopefully that's all and shell loader will be kept thin, but you know, the devil
is hidden in detail.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
