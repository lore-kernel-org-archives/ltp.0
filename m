Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40BEE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F4A03C201C
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:45:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93A063C0294
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:45:27 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D91DB6373EA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:45:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F7DB1F385;
 Thu,  9 Jan 2025 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736415925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7a846D+AZkdMTZW1K71zTneyxltJrtGIu8tYKFwFzQs=;
 b=BPPF98j3vs4LtaxgDAQkbrWgKdiHjxjIrp2+SS2KvzACsJ0eQrdFbRbdQkfbqMxkHYVY11
 jUUxPQMIB0U1jgP/bvvYhonD1LU/TpG7dUFI3mZfwn6mlQHy8vn2E5R4qwLJcLVxzY/iYA
 OPj6zLJtUk/CrGLWedYddWoot0NkiWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736415925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7a846D+AZkdMTZW1K71zTneyxltJrtGIu8tYKFwFzQs=;
 b=DM6owISFX3svHr38Km7HAqinj/9joRdI5OW+mZGSIgSK3rCvxjPjV2cWhH6aelQ8yql83h
 SIDU/BvJG8vEfFBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BPPF98j3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DM6owISF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736415925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7a846D+AZkdMTZW1K71zTneyxltJrtGIu8tYKFwFzQs=;
 b=BPPF98j3vs4LtaxgDAQkbrWgKdiHjxjIrp2+SS2KvzACsJ0eQrdFbRbdQkfbqMxkHYVY11
 jUUxPQMIB0U1jgP/bvvYhonD1LU/TpG7dUFI3mZfwn6mlQHy8vn2E5R4qwLJcLVxzY/iYA
 OPj6zLJtUk/CrGLWedYddWoot0NkiWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736415925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7a846D+AZkdMTZW1K71zTneyxltJrtGIu8tYKFwFzQs=;
 b=DM6owISFX3svHr38Km7HAqinj/9joRdI5OW+mZGSIgSK3rCvxjPjV2cWhH6aelQ8yql83h
 SIDU/BvJG8vEfFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A83F13876;
 Thu,  9 Jan 2025 09:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9eH3AbWaf2fIAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 09:45:25 +0000
Date: Thu, 9 Jan 2025 10:45:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250109094523.GB184406@pevik>
References: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
 <Zuk6k_8ryjwZqpO9@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zuk6k_8ryjwZqpO9@yuki.lan>
X-Rspamd-Queue-Id: 5F7DB1F385
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rt_sigqueueinfo: Add negative tests for
 rt_sigqueueinfo
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

Hi Ma Xinjian,

Gently ping.

Kind regards,
Petr

> > +static siginfo_t siginfo_einval;
> > +static siginfo_t siginfo_eperm;
> > +static siginfo_t siginfo_esrch;

> Ideally these should be allocated as guarded buffers:

> https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers

> You can have a look at signalfd02.c and the .bufs in the tst_test
> structure initialization.

...
> > +static void child_do(struct test_case_t *tc)
> > +{
> > +	struct sigaction sa;
> > +
> > +	sa.sa_handler = sig_handler;
> > +	SAFE_SIGEMPTYSET(&sa.sa_mask);
> > +	if (tc->sig > 0)
> > +		SAFE_SIGACTION(tc->sig, &sa, NULL);
> > +	else
> > +		SAFE_SIGACTION(SIGUSR1, &sa, NULL);
> > +
> > +	TST_CHECKPOINT_WAKE(0);
> > +	TST_CHECKPOINT_WAIT(1);

> The child will never get any signal so all that needs to be done here is
> to do TST_CHECKPOINT_WAIT() so that the child exists while the parent
> runs.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
