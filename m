Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6FB109878D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 15:15:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E1653E55C6
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 16:15:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB3E63D067A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 16:14:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 27FE8600054
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 16:14:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75F4F4D27B;
 Fri, 20 Mar 2026 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774019697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGgA9gozrmJ/lTuOjtaazItOfZAMlgoOjxP8YEImTWI=;
 b=OfhvXh1oIGcrxg1ZWCkElm/1ohjAXJUfRqXOzg1VbN3BHGOADoCynrmdt9JkQGkoFXhmJe
 BbfU2g6O5Rxs+TE4JNwd+CJxg8oA3ka46ukrOKMnmuKxHvmDhmvTjwV0xjEd8nQhAaM2cq
 0TTLXk+93DS4h0AVnPjYibw3eem7PLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774019697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGgA9gozrmJ/lTuOjtaazItOfZAMlgoOjxP8YEImTWI=;
 b=qu3wLT/i8YHxdeCCcOLia2AfhGFmxKq2WoEd5iuKcI4bj8w7BEl27VN8ZF0kv9dDewXVmk
 Fds7Id7BJ5/kUhDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OfhvXh1o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qu3wLT/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774019697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGgA9gozrmJ/lTuOjtaazItOfZAMlgoOjxP8YEImTWI=;
 b=OfhvXh1oIGcrxg1ZWCkElm/1ohjAXJUfRqXOzg1VbN3BHGOADoCynrmdt9JkQGkoFXhmJe
 BbfU2g6O5Rxs+TE4JNwd+CJxg8oA3ka46ukrOKMnmuKxHvmDhmvTjwV0xjEd8nQhAaM2cq
 0TTLXk+93DS4h0AVnPjYibw3eem7PLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774019697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PGgA9gozrmJ/lTuOjtaazItOfZAMlgoOjxP8YEImTWI=;
 b=qu3wLT/i8YHxdeCCcOLia2AfhGFmxKq2WoEd5iuKcI4bj8w7BEl27VN8ZF0kv9dDewXVmk
 Fds7Id7BJ5/kUhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64C5742872;
 Fri, 20 Mar 2026 15:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vo/dFnFkvWkYagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 15:14:57 +0000
Date: Fri, 20 Mar 2026 16:15:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ab1kdAOb5_YDqyLN@yuki.lan>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
 <abkh9aPkKAewapRr@redhat.com> <abqLM0iQY7nwPaDm@yuki.lan>
 <abqZ3h1iVo5DaQ_4@yuki.lan> <20260318154019.GE31214@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318154019.GE31214@pevik>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 75F4F4D27B
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > It's a bit more complicated we do not have only iterations but also
> > > duration and timeout per iteration. So we would need a function that
> > > would return if the script should continue or not and also call the
> > > heartbeat() function. Something as:
> 
> > > int tst_next_shell_iteration(void)
> > > {
> > > 	int cont = 0;
> > > 	static int iteration = 0;
> 
> > > 	if (iteration < iterations)
> > > 		cont = 1;
> 
> > > 	if (stop_time && get_time_ms() < stop_time())
> > > 		cont = 1;
> 
> > > 	if (!cont)
> > > 		return 0;
> 
> > > 	heartbeat();
> > > 	return ++iteration;
> > > }
> 
> > > The shell helper would call this and we would use it in tst_run.sh and
> > > loop the tst_test() until we are said to stop.
> 
> Wait, tst_run_shell.c calls shell script via tst_run_script(). This can be
> called only once, before starting the script...

The tst_run_script() is set as the tst_test.test or tst_test.test_all
function. Then we enter the library via the tst_run_tcases() and we do
the full test library init and everything.

The problem with that is that we run the shell script is re-executed
for each -i iteration. That means that unlike the fork() the whole
environment is re-created. So we cannot run setup() only for first
iteration as we do for C.

So we either call the setup in each iteration (that means both tcnt and
-i) or we push the loop over tcnt and -i into the shell. I think that
more elegant solution is the latter.

> > Note also that this solution would move the iteration into the shell
> 
> ... but from the code it's obvious that you want to call it more times.
> How do you want to reach C library code from shell test?

We would have to just call the tst_test->test() function directly in the
fork_testrun() instead of testrun() for script tests. That would avoid
all the looping and heartbeats() in C library in that case.

> > script, since if we do not iterate in the shell, we will end up with a
> > different environment in the second and subsequent iterations. That
> > means that any variables exported in setup() would be lost in subsequent
> > iterations, the pid of the shell would be different, etc.
> 
> Yes, I noticed that during du01.sh rewrite. I was surprised but thought that you
> wanted to have most of the library code be in C API (having shell part of the
> shell loader really thin).
> 
> Before sending the patchset I was thinking if some shell variables should be
> shared and exported into new shell run. But it'd be unpractical and as you write
> PID of the shell would be always different.
> 
> I have to admit sometimes I think whether rewriting everything into C wouldn't
> be a better time investment than implementing shell loader, given we are going
> to redesign network API. Anyway, any new test should really be using C API.

I think that the shell API is nearly finished at this point, the last
unsolved piece is how we design the test iterations with -i and tcnt.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
