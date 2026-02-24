Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2D5E9B258
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 11:47:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EBC73D0F8C
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 12:47:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DC5E3D0F6E
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 12:46:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FB402005F9
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 12:46:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 784003F1CD;
 Tue, 24 Feb 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30BCD3EA68;
 Tue, 24 Feb 2026 11:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KXAHCa6PnWljHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 11:46:54 +0000
Date: Tue, 24 Feb 2026 12:46:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260224114652.GA48499@pevik>
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
 <20260224093820.GA37927@pevik> <aZ2BGwrdHKeaxXkD@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZ2BGwrdHKeaxXkD@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 784003F1CD
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
> > > And with that we would need some kind of "master file" that would
> > > explain which script should be executed on which host etc. But I guess
> > > that it would be tricky to desing this properly.

> > I'm not sure if separated file is worth of adding. There is tst_rhost_run()
> > function which should be used for checking, which works well on both netns and 2
> > host based setup (that's why v2).

> This is just me thinking if we can actually desing something more proper
> in the future now that runltp is gone. I think that the whole
> tst_rhost_run() infrastructure is a bit of a hack and that the
> multimachine test can be desingned differently. I would say that more
> proper solution would be to have the test split into one script per
> worker and having some master script/description to drive the testing.
> The testrunner would read the information about which script to run on
> which worker and would also have to handle synchronization.

FYI tst_rhost_run() is used for testing itself as well, more than for setup and
cleanup:

$ git grep -l tst_rhost_run |wc -l
35

Therefore we can rethink network test setup, but tst_rhost_run() will be needed
anyway.

> In the case of the NFS tests the master script would say to run a script
> that sets up NFS server and signal the testrunner once it's done and
> wait. The script that would be doing the actuall test would be executed
> once the the NFS server script to signaled it's completion and then
> start the actual test. Once it's finished testing it would exit, which
> would tell the testrunner to wake up the NFS server script in order to
> cleanup. If we decided to write multimachine tests this way we would
> need to add a way how to pass parameters such as IP addresses from kirk
> to tests and also add a way how to propagate events between tests via
> kirk so that we can have some kind of locking.

Also, you call it a hack, but it works standalone, without any runner. I would
be careful to add kirk as a hard dependency to run a single test without a
strong reason (sure, using kirk to handle metadata to run tests in paralel or
replace runtest files will be a great improvement, but I would like to still
keep executing a test itself by just calling it with proper PATH setup).

FYI "multimachine tests": I know only about 1 test which needs more than a
single machine: IPsec (implemented in openQA instead of LTP [1]).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/920

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
