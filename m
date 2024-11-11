Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E09D2E9D1
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 09:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607E93D531C
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 10:58:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43D843D5308
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 10:58:19 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B367311F644D
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 10:58:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C479B1F38E;
 Mon, 11 Nov 2024 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731319097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL2fWxaF1lZPRO7qpn3OK+mvgA/3bTkwRHR5dhnCbLg=;
 b=MeQKEkmCkTqrHRP1kjjNzreXJum05GPKE8wDBj3b4ZqOTglB0Eb90ykE/Q8Ujqx4WD/qUH
 EizmXgkd3izQxeOZFDKCCs4CpFF+TKeM65yAKyMzE35zpYXVMDUQnvmGbeD9F25IwmWrqS
 pfDTBh6cnpQQ/XRRl3V1/Uk+c8eyPJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731319097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL2fWxaF1lZPRO7qpn3OK+mvgA/3bTkwRHR5dhnCbLg=;
 b=Ns3oK67TD8aHXJwov0CcEV0C5IOotfcUp2xS50gFoG/n7biRTeSanM93/y7/4fYSk7FND7
 oLUKOM5tSlgXAYBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731319097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL2fWxaF1lZPRO7qpn3OK+mvgA/3bTkwRHR5dhnCbLg=;
 b=MeQKEkmCkTqrHRP1kjjNzreXJum05GPKE8wDBj3b4ZqOTglB0Eb90ykE/Q8Ujqx4WD/qUH
 EizmXgkd3izQxeOZFDKCCs4CpFF+TKeM65yAKyMzE35zpYXVMDUQnvmGbeD9F25IwmWrqS
 pfDTBh6cnpQQ/XRRl3V1/Uk+c8eyPJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731319097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IL2fWxaF1lZPRO7qpn3OK+mvgA/3bTkwRHR5dhnCbLg=;
 b=Ns3oK67TD8aHXJwov0CcEV0C5IOotfcUp2xS50gFoG/n7biRTeSanM93/y7/4fYSk7FND7
 oLUKOM5tSlgXAYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8C1413301;
 Mon, 11 Nov 2024 09:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AK0RKDnVMWd6DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 11 Nov 2024 09:58:17 +0000
Date: Mon, 11 Nov 2024 10:58:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241111095816.GA162243@pevik>
References: <20241108122139.87974-1-pvorel@suse.cz>
 <ZzHAtb2Zqc7Ffpzi@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzHAtb2Zqc7Ffpzi@wegao>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] recvmmsg01: Workaround segfault on libc
 variant on 32 bit
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

Hi Wei, all,

...
> > -static void do_test(unsigned int i)
> > +static void verify_recvmmsg(unsigned int i, void *timeout)
> >  {
> >  	struct time64_variants *tv = &variants[tst_variant];
> >  	struct test_case *tc = &tcase[i];
> > -	void *timeout;

> >  	ts.type = tv->ts_type;
> >  	tst_ts_set_sec(&ts, tc->tv_sec);
> >  	tst_ts_set_nsec(&ts, tc->tv_nsec);

> > +	TST_EXP_FAIL2(tv->recvmmsg(*tc->fd, *tc->msg_vec, VLEN, 0, timeout),
> > +		      tc->exp_errno, "recvmmsg() %s", tc->desc);
> > +}
> > +
> > +static void test_bad_addr(unsigned int i)
> > +{
> > +	struct time64_variants *tv = &variants[tst_variant];
> > +	void *timeout = bad_addr;
> > +	pid_t pid;
> > +	int status;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		verify_recvmmsg(i, timeout);
> > +		_exit(!TST_PASS);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFEXITED(status))
> > +		return;
> > +
> > +	if (tv->ts_type == TST_LIBC_TIMESPEC &&
> > +		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > +		tst_res(TPASS, "Child killed by signal");
> very nit: 
> 1) s/Child killed by signal/Child killed by SIGSEGV signal/
I copy pasted it. Maybe better would be to print "Child killed by expected
signal" because it's IMHO irrelevant which signal it is, right?
Signal name is important only when there is other signal on TFAIL.

> 2) suggest also print out tc->desc
Here in test_bad_addr()? This is only used for a single testcase,
tc->desc is printed for the main testing with TST_EXP_FAIL2(),
therefore I don't think it will help debugging.

> Thanks for create patch fix our current issue.

Thanks for review. I'll try to get to the other testcases this week.

> Reviewed-by: Wei Gao <wegao@suse.com>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
