Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC99C27C5F
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 09:21:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 482BD3D0B10
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:21:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91013C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:20:58 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE4541401711
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 11:20:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE0981F7BE;
 Mon, 10 Jun 2024 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718011256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuPT05JJTzA3IOdhGArhy4MABsSBaa/Pv0qHzkNGZHQ=;
 b=UMnoipp/p9TIMv8/dAwXFDiPXk0D1OU9jspZQUNpAG78mS9EDimvQOU3Jlwrtsq7QTjKi1
 sJX57PhZ7e6m3lRmu+HV3BiTOXMjLKTFWC7THO2VsViBnkUW8opRwzYvaqg808KePpEZQM
 dtcUYZWPYuXKVxftjTWdgEaqa7kYRX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718011256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuPT05JJTzA3IOdhGArhy4MABsSBaa/Pv0qHzkNGZHQ=;
 b=HAMGQtAPq+NRGsBXGRawO76W4Pgh5Uene6ndYfk+irU1Wd8/2Oli47ian+dqJx63uN/u15
 WDQ4Wk8QMx3drYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718011256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuPT05JJTzA3IOdhGArhy4MABsSBaa/Pv0qHzkNGZHQ=;
 b=UMnoipp/p9TIMv8/dAwXFDiPXk0D1OU9jspZQUNpAG78mS9EDimvQOU3Jlwrtsq7QTjKi1
 sJX57PhZ7e6m3lRmu+HV3BiTOXMjLKTFWC7THO2VsViBnkUW8opRwzYvaqg808KePpEZQM
 dtcUYZWPYuXKVxftjTWdgEaqa7kYRX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718011256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RuPT05JJTzA3IOdhGArhy4MABsSBaa/Pv0qHzkNGZHQ=;
 b=HAMGQtAPq+NRGsBXGRawO76W4Pgh5Uene6ndYfk+irU1Wd8/2Oli47ian+dqJx63uN/u15
 WDQ4Wk8QMx3drYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE0A13A51;
 Mon, 10 Jun 2024 09:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FFgdKXjFZmZXaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Jun 2024 09:20:56 +0000
Date: Mon, 10 Jun 2024 11:22:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <ZmbFyjuXndeXCLp8@rei>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I don't think it's that simple.
> 
> Currently, Fuego users can choose to either:
> 1. run a suite of tests (specified in the runtest file) using runltp executing on the target

And this is something that I think is a suboptimal solution. If the run
crashes in the middle you can't easily continue with the rest of the
tests after the system under test has been rebooted. So the desing
decision for kirk was that the complete state of the testsuite execution
is being kept on the machine that drives the testing.

I did a talk at SUSE Labs conference when I tried to explain when we are
heading and it was recorded, unfortunately it wasn't uploaded to youtube
yet, I will post the link here once it's there.

The bottom line question is how much code from us can be reused in your
environment and this is something we have to figure out.

> 2. run an individual test, not using runltp.
> 
> In the first case, since some of the suites have a large number of tests,
> there are options in Fuego to convert the results into spreadsheet files
> or PDF reports.  But this is based on the multi-test output from runltp.
> 
> Does kirk provide the same output formats and output options as runltp?

We decided to go for JSON format for generic the test results for kirk.

However given that we store the results in python data structures
internally, it's easy to write an exporter for a format you want and
produce that directly. We can add CSV exporter for spreadsheets in 100
lines of python.

The JSON exported looks like this:

https://github.com/linux-test-project/kirk/blob/master/libkirk/export.py

> If runltp is eventually removed, I'll have to come up with a solution
> for executing suites of tests on the target, and making sure the output
> is the same as runltp (or modifying the report generation code to handle
> a new output).

The second one is preferable.

> Fuego supports multiple "transport" layers.  ssh, serial console,
> and adb transfers are supported, as well as a few weird transports
> (such as ssh to a controller board that then transfers over serial).
> I wouldn't request kirk to support these oddball transport mechanisms,
> but if it had support for mapping it's communication mechanisms
> onto these, or supporting some pluggable mechanism for transferring
> files and executing programs (collecting stdout, stderr and return code),
> that might be useful.

That is actually the end goal. The ltx is designed to marshal messages
over a byte oriented connection, the supported commands at the moment
can execute binaries, transfer files, etc. We intend to use it over
virtio and physical serial ports as well. So the idea is that once ltx
is started on the system uder test kirk connect to that instance to
drive the testing. It's not production ready yet, and that is something
that I have on my TODO.

> > > > We do have the ltx binary, which is the small dispatcher supposed to run
> > > > on the VM. And in an ideal world we would have a python library that
> > > > talks to it on the other end, as a part of kirk, that could be reused
> > > > separately. And the same for building lists of test to execute, ideally
> > > > we would have a python library that would export a simple interface so
> > > > that everyone could integrate the blocks that they really need into
> > > > their solution.
> > >
> > > Automated testing is a hard problem to solve generically and even if
> > > you do manage that, this all looks like a lot of work even just to
> > > reproduce what works today :/.
> > 
> > Indeed. However I stil think that there are reusable parts that may be
> > worth putting together.
> 
> Possibly.  I tried for a few years to integrate Fuego and KernelCI,
> but their architectures were too different, and I eventually gave up.
> Now that KernelCI is changing, I've thought about going back
> and seeing if I could transfer anything between the projects.
> 
> Usually, you have to write some kind of mapping layer, and the mappings
> turn out to be harder than expected, due to assumptions baked in to
> the architecture.

That's what I'm hoping to avoid to keep things in a simple modules, but
I guess that we will run into a lot of implementation details that will
make things hard or even impossible...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
