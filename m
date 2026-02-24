Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF7BF3C9AD
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 16:12:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8951B3E8B84
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 17:12:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C41A03E8B84
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 17:11:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6E27600342
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 17:11:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9D9C5BCE2;
 Tue, 24 Feb 2026 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771949509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwx9Os2jkKrytKfGdFuupdvkJzA4BzQNiIRvNjZ1wdM=;
 b=U7UDMlQPYWL2BGESo8B1hUOtBDwyD0O7gjNnmbMRA8VGI2PjbcGm9VqW1uwmqnd9CF6t8V
 xfqfLJzFLfzHTpN1v6UJyBLoWC+zQ5pyYvmuXG6sUaPDmGx0n5m2TEhaTIdfNhAf5rXnCp
 ds3Lw+g2nM1CTgnsGq8x71zNu4ZJLys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771949509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwx9Os2jkKrytKfGdFuupdvkJzA4BzQNiIRvNjZ1wdM=;
 b=ToMOMfZy4YtZBnHcydQKTaaQApOgl75WSqYSFQBq/bBbtuuRTp66o53WphqtibdMj8sVI6
 1zy2G9XdQ99haxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771949509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwx9Os2jkKrytKfGdFuupdvkJzA4BzQNiIRvNjZ1wdM=;
 b=U7UDMlQPYWL2BGESo8B1hUOtBDwyD0O7gjNnmbMRA8VGI2PjbcGm9VqW1uwmqnd9CF6t8V
 xfqfLJzFLfzHTpN1v6UJyBLoWC+zQ5pyYvmuXG6sUaPDmGx0n5m2TEhaTIdfNhAf5rXnCp
 ds3Lw+g2nM1CTgnsGq8x71zNu4ZJLys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771949509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwx9Os2jkKrytKfGdFuupdvkJzA4BzQNiIRvNjZ1wdM=;
 b=ToMOMfZy4YtZBnHcydQKTaaQApOgl75WSqYSFQBq/bBbtuuRTp66o53WphqtibdMj8sVI6
 1zy2G9XdQ99haxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E923EA68;
 Tue, 24 Feb 2026 16:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0/4lIMXNnWlPOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 16:11:49 +0000
Date: Tue, 24 Feb 2026 17:11:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260224161144.GA69424@pevik>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
 <20260224093820.GA37927@pevik> <aZ2BGwrdHKeaxXkD@yuki.lan>
 <20260224114652.GA48499@pevik> <aZ2Xcxf6F9f9Bl8V@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZ2Xcxf6F9f9Bl8V@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it,
 Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > > And with that we would need some kind of "master file" that would
> > > > > explain which script should be executed on which host etc. But I guess
> > > > > that it would be tricky to desing this properly.

> > > > I'm not sure if separated file is worth of adding. There is tst_rhost_run()
> > > > function which should be used for checking, which works well on both netns and 2
> > > > host based setup (that's why v2).

> > > This is just me thinking if we can actually desing something more proper
> > > in the future now that runltp is gone. I think that the whole
> > > tst_rhost_run() infrastructure is a bit of a hack and that the
> > > multimachine test can be desingned differently. I would say that more
> > > proper solution would be to have the test split into one script per
> > > worker and having some master script/description to drive the testing.
> > > The testrunner would read the information about which script to run on
> > > which worker and would also have to handle synchronization.

> > FYI tst_rhost_run() is used for testing itself as well, more than for setup and
> > cleanup:

> > $ git grep -l tst_rhost_run |wc -l
> > 35

> > Therefore we can rethink network test setup, but tst_rhost_run() will be needed
> > anyway.

> What I'm thinking about is to replace the tst_rhost_run() with a
> synchronization between multiple tests scripts. With that a script can
> wait for some kind of event instead of running the code itself.

> It would be far more flexible approach than what we have now. With that
> we could easily scale to tests with three or more machines that are
> impossible to implement at the moment. But of course unless we actually
> write a proof of a concept we will not be able fully understand if this
> concept is going to be better or not.

> > > In the case of the NFS tests the master script would say to run a script
> > > that sets up NFS server and signal the testrunner once it's done and
> > > wait. The script that would be doing the actuall test would be executed
> > > once the the NFS server script to signaled it's completion and then
> > > start the actual test. Once it's finished testing it would exit, which
> > > would tell the testrunner to wake up the NFS server script in order to
> > > cleanup. If we decided to write multimachine tests this way we would
> > > need to add a way how to pass parameters such as IP addresses from kirk
> > > to tests and also add a way how to propagate events between tests via
> > > kirk so that we can have some kind of locking.

> > Also, you call it a hack, but it works standalone, without any runner. I would
> > be careful to add kirk as a hard dependency to run a single test without a
> > strong reason (sure, using kirk to handle metadata to run tests in paralel or
> > replace runtest files will be a great improvement, but I would like to still
> > keep executing a test itself by just calling it with proper PATH setup).

> It should be possible to design the system so that tests can be executed
> with a simpler solution than kirk.

+1

> Also it's not as standalone as you may think. You need to 1) start two
> machines and manually install LTP there 2) write the IP addresses into
> the configuration and only once that is done you can execute tests on
> two machines.

Yes, that's job of the framework executor (kirk, openQA, TuxMake, Fuego, Lava,
etc).

Yes, but when there is some bug which needs to be bisected, the fastest approach
for network tests is to run with rapido over netns. New approach should keep
support for netns and real host. Of course real communication over network is
not the same as using netns, but quite a lot of bugs can be caught this way.

> > FYI "multimachine tests": I know only about 1 test which needs more than a
> > single machine: IPsec (implemented in openQA instead of LTP [1]).

> I think that this is because our multimachine design is not as easy to
> use as it should be.

I'm not saying that there is not a requirement for 3+ machines tests just
because I don't see it :). But it would be kind of some special tests
(normally stressing a server is kind of test scenario for multi machine
tests).

And the reason why I'm asking question "do we need it?" is that I know how many
tests we have to rewrite (+ generally how much of LTP rewrite is unfinished,
including readthedoc migration).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
