Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7792C103E198
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:40:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EA153E61CA
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 16:40:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46FB93CB061
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:40:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F4AF1000DB5
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:40:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4575F4D3F8;
 Wed, 18 Mar 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EA054273B;
 Wed, 18 Mar 2026 15:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BEa7BWXHumlbLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 15:40:21 +0000
Date: Wed, 18 Mar 2026 16:40:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260318154019.GE31214@pevik>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-6-pvorel@suse.cz>
 <abkh9aPkKAewapRr@redhat.com> <abqLM0iQY7nwPaDm@yuki.lan>
 <abqZ3h1iVo5DaQ_4@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abqZ3h1iVo5DaQ_4@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 4575F4D3F8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

Hi Cyril,

> Hi!
> > It's a bit more complicated we do not have only iterations but also
> > duration and timeout per iteration. So we would need a function that
> > would return if the script should continue or not and also call the
> > heartbeat() function. Something as:

> > int tst_next_shell_iteration(void)
> > {
> > 	int cont = 0;
> > 	static int iteration = 0;

> > 	if (iteration < iterations)
> > 		cont = 1;

> > 	if (stop_time && get_time_ms() < stop_time())
> > 		cont = 1;

> > 	if (!cont)
> > 		return 0;

> > 	heartbeat();
> > 	return ++iteration;
> > }

> > The shell helper would call this and we would use it in tst_run.sh and
> > loop the tst_test() until we are said to stop.

Wait, tst_run_shell.c calls shell script via tst_run_script(). This can be
called only once, before starting the script...

> Note also that this solution would move the iteration into the shell

... but from the code it's obvious that you want to call it more times.
How do you want to reach C library code from shell test?

> script, since if we do not iterate in the shell, we will end up with a
> different environment in the second and subsequent iterations. That
> means that any variables exported in setup() would be lost in subsequent
> iterations, the pid of the shell would be different, etc.

Yes, I noticed that during du01.sh rewrite. I was surprised but thought that you
wanted to have most of the library code be in C API (having shell part of the
shell loader really thin).

Before sending the patchset I was thinking if some shell variables should be
shared and exported into new shell run. But it'd be unpractical and as you write
PID of the shell would be always different.

I have to admit sometimes I think whether rewriting everything into C wouldn't
be a better time investment than implementing shell loader, given we are going
to redesign network API. Anyway, any new test should really be using C API.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
