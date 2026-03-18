Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0737D103E162
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:23:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A50623D0EB1
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 12:23:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B69C3C0372
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:23:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C0E51A0099A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 12:23:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7FB694D28E;
 Wed, 18 Mar 2026 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773833008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVGufM1N+9g1lRvS85aAgKlf/cIL3V5X6aeanFMig4Y=;
 b=x862C8TJen0thgf6mb76Nes5ip2garx1Rak7/typvcnvFe9zagMm0AgwkifmcMaQmPoxXQ
 IyxuBXaYkQEgJREudPpFP56hemKzLA42zR0r7GbO9zQGbfruk1LWsMgZkmu6T5NhRvFJsq
 suBtuF4kX2G4t92F1S0UZiWgEb/PVJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773833008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVGufM1N+9g1lRvS85aAgKlf/cIL3V5X6aeanFMig4Y=;
 b=jxEyXe4UcAeElFNqLtNX3iwC+8nmuBpcXybpYKvWdlcc2p35J5peRQIcVSSTdq6OSgHjRx
 GGYv5vutGd0b+SDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x862C8TJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jxEyXe4U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773833008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVGufM1N+9g1lRvS85aAgKlf/cIL3V5X6aeanFMig4Y=;
 b=x862C8TJen0thgf6mb76Nes5ip2garx1Rak7/typvcnvFe9zagMm0AgwkifmcMaQmPoxXQ
 IyxuBXaYkQEgJREudPpFP56hemKzLA42zR0r7GbO9zQGbfruk1LWsMgZkmu6T5NhRvFJsq
 suBtuF4kX2G4t92F1S0UZiWgEb/PVJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773833008;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVGufM1N+9g1lRvS85aAgKlf/cIL3V5X6aeanFMig4Y=;
 b=jxEyXe4UcAeElFNqLtNX3iwC+8nmuBpcXybpYKvWdlcc2p35J5peRQIcVSSTdq6OSgHjRx
 GGYv5vutGd0b+SDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 666C74273B;
 Wed, 18 Mar 2026 11:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WaYSGDCLumk6IAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Mar 2026 11:23:28 +0000
Date: Wed, 18 Mar 2026 12:23:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <abqLM0iQY7nwPaDm@yuki.lan>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
 <abkh9aPkKAewapRr@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abkh9aPkKAewapRr@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 7FB694D28E
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
Cc: ltp@lists.linux.it, Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > NOTE: this is still not working on iterations (-i2), because
> > static int iterations is from tst_test.c is not propagated to
> > tst_run_shell.c. I wonder if I should set the value as environment
> > variable or add it into struct context.
> 
> Passing the current iteration as env variable is feasible.
> 
> Since LTP export an similar variable 'TST_ITERATIONS' in tst_test.sh,
> maybe define another env var for current loop, e.g. TST_ITERATION
> (or TST_CURRENT_LOOP), pass to tst_run.sh?
> 
> Something like:
> 
> 1. Create tst_get_cur_iteration(void) function in LTP core API
> 
> 2. Export current loop in tst_run_shell.c before running run_shell_tcnt()
> 
>   static void run_shell_tcnt(unsigned int n)
>   {
>     ...
>     char iter_buf[32];
>     
>     snprintf(iter_buf, sizeof(iter_buf), "%u", tst_get_cur_iteration());
>     
>     if (setenv("TST_ITERATION", iter_buf, 1))
>     	tst_brk(TBROK | TERRNO, "setenv(TST_ITERATION) failed");
>     
>     tst_run_script(shell_filename, params);
>   }
> 
> 3. Reuse it in tst_run.sh to run setup once globally
> 
>   [ "$1" == "1" ] && [ "${TST_ITERATION:-1}" == "1" ] && $TST_SETUP

It's a bit more complicated we do not have only iterations but also
duration and timeout per iteration. So we would need a function that
would return if the script should continue or not and also call the
heartbeat() function. Something as:

int tst_next_shell_iteration(void)
{
	int cont = 0;
	static int iteration = 0;

	if (iteration < iterations)
		cont = 1;

	if (stop_time && get_time_ms() < stop_time())
		cont = 1;

	if (!cont)
		return 0;

	heartbeat();
	return ++iteration;
}

The shell helper would call this and we would use it in tst_run.sh and
loop the tst_test() until we are said to stop.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
