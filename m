Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62330D68B2C
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:53:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A463F3D6F65
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:53:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 299123D667E
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:53:09 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B226563F2AD
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:53:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 034B11F445;
 Thu, 14 Nov 2024 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edl0CBciZSK6EqIwlBzi4Uc8qUiMoGyIoKD8z2WaRa4=;
 b=IANopG7kok2+BofHx7r9nhXRTRRiSrkJTb0u8eN44Ha1m4sWzRWNmx+2Wt1uOw+jaCTelk
 G/1N3ezKz15pKcifTmte3DvyS4akPvUOi96lLphDFnJWqnuJjPGlb5v53aZCPnUmP/kZZp
 LU0X962LJEFX3HSIRxRmlF4SpAf7YtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edl0CBciZSK6EqIwlBzi4Uc8qUiMoGyIoKD8z2WaRa4=;
 b=GE48IAVeQQ44PIu0mM2KzHbHt+KPp2YRgZ/yzcyiVF8g12UgytOZU5IafkhCmBqQodfpH+
 v40nUd6WsPyvUJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edl0CBciZSK6EqIwlBzi4Uc8qUiMoGyIoKD8z2WaRa4=;
 b=IANopG7kok2+BofHx7r9nhXRTRRiSrkJTb0u8eN44Ha1m4sWzRWNmx+2Wt1uOw+jaCTelk
 G/1N3ezKz15pKcifTmte3DvyS4akPvUOi96lLphDFnJWqnuJjPGlb5v53aZCPnUmP/kZZp
 LU0X962LJEFX3HSIRxRmlF4SpAf7YtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595987;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edl0CBciZSK6EqIwlBzi4Uc8qUiMoGyIoKD8z2WaRa4=;
 b=GE48IAVeQQ44PIu0mM2KzHbHt+KPp2YRgZ/yzcyiVF8g12UgytOZU5IafkhCmBqQodfpH+
 v40nUd6WsPyvUJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB9E13721;
 Thu, 14 Nov 2024 14:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B99dNNIONmcAfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:53:06 +0000
Date: Thu, 14 Nov 2024 15:53:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241114145301.GA349678@pevik>
References: <20241112171831.156440-1-pvorel@suse.cz>
 <20241112171831.156440-2-pvorel@suse.cz> <ZzQWRTZTrWWMDNDv@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzQWRTZTrWWMDNDv@wegao>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mq_timedreceive01: Workaround segfault on
 libc variant on 32 bit
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

> On Tue, Nov 12, 2024 at 06:18:31PM +0100, Petr Vorel wrote:
> > EFAULT test segfaults on newer kernels (e.g. 6.4) on libc variant on
> > 32bit.  Similarly to 1d4d5a0750 use typical LTP workaround to test by
> > forked child + checking the terminating signal.

...
> > +	unsigned int j;
> > +	unsigned int prio;

> >  	if (tc->invalid_msg)
> >  		len -= 1;
> > @@ -208,6 +192,60 @@ static void do_test(unsigned int i)
> >  			TST_RET, prio, len);
> >  }

> > +static void test_bad_addr(unsigned int i)
> > +{
> > +	struct time64_variants *tv = &variants[tst_variant];
> > +	pid_t pid;
> > +	int status;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		verify_mqt_receive(i, pid);
> > +		_exit(0);
> nit:
> If this is a normal exit, i suggest use s/_exit(0)/exit(0) ?

I copy pasted this from similar tests. IMHO both should work. According to man
exit() calls functions registered with atexit() and _exit(), _exit() just
immediately terminates the process. Any open file descriptors belonging to the process are closed.

@Jan, @Cyril Please correct me if I'm wrong.

Kind regards,
Petr

> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFEXITED(status) && !WEXITSTATUS(status))
> > +		return;
> > +
> > +	if (tv->ts_type == TST_LIBC_TIMESPEC &&
> > +		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > +		tst_res(TPASS, "Child killed by expected signal");
> > +		return;
> > +	}
> > +
> > +	tst_res(TFAIL, "Child %s", tst_strstatus(status));
> > +}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
