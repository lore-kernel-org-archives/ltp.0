Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEDAC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 16:15:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 959CE3D0B5F
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 18:15:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51DDF3D01A9
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 18:14:54 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CD4260344B
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 18:14:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B49D51FDA4;
 Mon, 10 Jun 2024 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718036091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MqHiGzm5r5r+LHW491QuCO0mfW3UDKEwSJu/oS/vlY=;
 b=3JQfgeGW1PgDU+LvGrxwq8p3hbbgsN2fzi3s0t0r1Afxvvs+WROUAGa2/D84kryfjE620d
 BLORJ5hHptZ5ewCHUI3ye1DWLxv2HAe50HwCa9RCWpJJ5siBi4gKaVlHziUpHJyw6rbCMW
 m9ey9bZZP2Lkp2SANeagLWEobDKC3Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718036091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MqHiGzm5r5r+LHW491QuCO0mfW3UDKEwSJu/oS/vlY=;
 b=GY0ZANbCZlzWKAU8ZOUAP/FvANADTrjII5nzZj8o84hruD8AqjSs0uqyP/X8VcdsLr6kvO
 /wGo0QAw+/jBpoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718036091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MqHiGzm5r5r+LHW491QuCO0mfW3UDKEwSJu/oS/vlY=;
 b=3JQfgeGW1PgDU+LvGrxwq8p3hbbgsN2fzi3s0t0r1Afxvvs+WROUAGa2/D84kryfjE620d
 BLORJ5hHptZ5ewCHUI3ye1DWLxv2HAe50HwCa9RCWpJJ5siBi4gKaVlHziUpHJyw6rbCMW
 m9ey9bZZP2Lkp2SANeagLWEobDKC3Dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718036091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MqHiGzm5r5r+LHW491QuCO0mfW3UDKEwSJu/oS/vlY=;
 b=GY0ZANbCZlzWKAU8ZOUAP/FvANADTrjII5nzZj8o84hruD8AqjSs0uqyP/X8VcdsLr6kvO
 /wGo0QAw+/jBpoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8736413A7F;
 Mon, 10 Jun 2024 16:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YN/rH3smZ2boZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 16:14:51 +0000
Date: Mon, 10 Jun 2024 18:14:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20240610161450.GB774421@pevik>
References: <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <4a19e93b-b009-4b0f-9be8-8c348a9ab214@suse.com>
 <SA3PR13MB637200A7A377000193BAF3D2FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SA3PR13MB637200A7A377000193BAF3D2FDC62@SA3PR13MB6372.namprd13.prod.outlook.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> > -----Original Message-----
> > From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Andrea Cervesato via ltp
> > Hi!

> > My 2 cents below.

> > On 6/7/24 23:17, Bird, Tim wrote:
> > >> -----Original Message-----
> > >> From: Cyril Hrubis <chrubis@suse.cz>
> > >>>> I'm afraid that's not a good solution either. The end goal for kirk is
> > >>>> to have a small binary locked in RAM and with realtime priority to
> > >>>> execute tests and send back logs, in case of qemu over virtio, to the
> > >>>> kirk. That is to make sure that logs are collected properly even when
> > >>>> kernel is out of memory and in a similar situations.

> > >>>> If you run kirk on the VM, reporting is not going to be reliable.
> > >>> This means you're effectively mandating how ltp be run and the only
> > >>> variable would be the kernel binary. Whilst I can understand that, I'm
> > >>> not sure how useful us testing with this would be.
> > >> Not at all. As I replied to Tim, there is no secret sauce in runltp or
> > >> kirk. In the end it's a tool to execute a test binaries. If you have a
> > >> system that can execute binaries, reliably transfer logs and handle
> > >> kernel crashes you can as well just execute the tests yourself. All you
> > >> need from us is a tooling that will produce a list(s) of tests to
> > >> execute.
> > > I don't think it's that simple.

> > > Currently, Fuego users can choose to either:
> > > 1. run a suite of tests (specified in the runtest file) using runltp executing on the target
> > > 2. run an individual test, not using runltp.

> > > In the first case, since some of the suites have a large number of tests,
> > > there are options in Fuego to convert the results into spreadsheet files
> > > or PDF reports.  But this is based on the multi-test output from runltp.

> > > Does kirk provide the same output formats and output options as runltp?
> > No, but it provides something better than that: a JSON file that can be
> > easily parsed by most of the libraries out there.
> > kirk can be literally used as it is runltp, with difference of python
> > dependency. If you have python, you can run kirk on
> > host as well as on target. All features like Qemu, LTX, SSH (etc.)
> > supports are meant to be used by host only.

> The python dependency is unfortunate.  In Fuego, we have carefully
> avoided any dependencies on the target other than those that can
> be provided by busybox (or toybox or toolbox).  This includes limiting all
> test programs to either native binaries or shell scripts using  just POSIX
> shell features.

Hi Tim,

as Cyril noted, having kirk on the host you would need only LTX on the target
(SUT). That would avoid python on the target. LTX is very small binary (given
you compile whole LTP for target). Although running kirk on the target is
possible, there is not much benefit (one can just export LTPROOT, modify PATH
and run test manually).

I'm not trying to persuade you to take kirk (understand you have strong reasons
not to take it), just FYI some test in the future will need extra tooling (e.g.
support for reboot) and that functionality you either miss or will need to
implement in Fuego (also probably Cyril already noted).

Other thing is that we all invest time to implement our own tooling (IMHO waste
of time, there is a lot of code, not just run the tests, but dmesg, coredump,
restart SUT after failure, ...) instead of reusing at least a minimal subset
and slowly improve that for the benefit of all.

Also, the more we work with *any* shell implementation the more we see it's from
the long term perspective to avoid having even slightly complex tools in shell.
Simple C code avoids many problems in shell (we know POSIX shell syntax, but
there are subtle differences in each implementation which show later on).  At
certain point we even considered writing our minimal shell implementation to
avoid shell craziness (but then we just decided to write tests mostly in C).
Also some tests are buggy when written in shell (e.g.  cgroup tests).

Kind regards,
Petr

> It sounds like kirk won't be useful to my project.
>   -- Tim

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
