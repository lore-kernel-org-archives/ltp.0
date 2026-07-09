Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E80C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 14:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDD063E5CA2
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:56:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FAA43E5C9D
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:56:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 64D7C600728
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 16:56:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0528F7625F;
 Thu,  9 Jul 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783608991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaWeNT3wnBFy0vDrqF7PMV1Sp+NR3yl0st8np6lJEXg=;
 b=JnOtqJsO+n3s8r2h09s/gYqrniLM4Ow7bFwE0Ejkrcq34BXWeLLIMBd22wTqxl0u5yPtqV
 /DnHUxb7aMpw434GahRiftLqnhXnGjGQiw2Q+AbYl0ESLxIEmAGyeGe6mBBVhu1bJIle26
 FW6B3oYDRSQ6M6VXWiJ5sZ/Ic/12Ezo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783608991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaWeNT3wnBFy0vDrqF7PMV1Sp+NR3yl0st8np6lJEXg=;
 b=6NgVaHPB85hC6ihbcv0MADooT9VrCui5MFwFBa9nnHTpgT/6MerTKLwi9PkqVn6tKMoXUm
 4kUFEVuThkTWEmCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783608991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaWeNT3wnBFy0vDrqF7PMV1Sp+NR3yl0st8np6lJEXg=;
 b=JnOtqJsO+n3s8r2h09s/gYqrniLM4Ow7bFwE0Ejkrcq34BXWeLLIMBd22wTqxl0u5yPtqV
 /DnHUxb7aMpw434GahRiftLqnhXnGjGQiw2Q+AbYl0ESLxIEmAGyeGe6mBBVhu1bJIle26
 FW6B3oYDRSQ6M6VXWiJ5sZ/Ic/12Ezo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783608991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaWeNT3wnBFy0vDrqF7PMV1Sp+NR3yl0st8np6lJEXg=;
 b=6NgVaHPB85hC6ihbcv0MADooT9VrCui5MFwFBa9nnHTpgT/6MerTKLwi9PkqVn6tKMoXUm
 4kUFEVuThkTWEmCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC2D0779AA;
 Thu,  9 Jul 2026 14:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMRWKp62T2paBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 14:56:30 +0000
Date: Thu, 9 Jul 2026 16:56:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260709145629.GA997675@pevik>
References: <20260709085353.345957-1-chrubis@suse.cz>
 <20260709085353.345957-2-chrubis@suse.cz>
 <20260709105159.GA874350@pevik> <ak-kwx287miu1Bki@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ak-kwx287miu1Bki@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: Add epoll_create03
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
> > > +static void setup(void)
> > > +{
> > > +	int fd;
> > > +
> > > +	variant_info();
> > > +
> > > +	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
> > > +	fds = SAFE_MALLOC(maxfds * sizeof(int));
> > > +	memset(fds, -1, maxfds * sizeof(int));
> > > +
> > > +	fds[0] = SAFE_OPEN("dummy", O_RDWR | O_CREAT, 0700);
> > > +	nfds = 1;
> > > +
> > > +	for (int i = 1; i < maxfds; i++) {
> > > +		fd = dup(fds[0]);
> > > +		if (fd == -1)
> > > +			break;
> > > +		fds[nfds++] = fd;
> > > +	}

> > How many files are created is done via `ulimit -n`, right? (not sure if there
> > is file for it in /proc/sys).

> It's not about created files. There is a per-process limit on the number
> of file descriptors. That can be accessed either via sysconf() or via
> rlimit() and the values are also exported into /proc/$PID/limits.

> > Would it be worth we check that? Or at least check that at least 2 files were
> > opened? Maybe this check should be rather put into dup03.c.

> I guess that it would make more sense to put such check into dup03.c.

OK, let's ignore it.

> However we would have to scan the whole file descriptor table first to
> check on how many fds are already open.

> Something as;

> 	int used_fds = 0;

> 	for (i = 0; i < maxfds; i++) {
> 		if (fcntl(i, F_GETFD) != -1)
> 			used_fds++;
> 	}

> Then we can expect that the limit for the test is maxfds - used_fd

+1

I'll try to add it either into my TODO list or to the issues.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
