Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A877CDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876D63CD3DD
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 11:29:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD0603C8716
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 11:29:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA53A1B601BD
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 11:29:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94A201F37E;
 Fri, 13 Oct 2023 09:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697189351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5k2b05Fi43osxrZUE/+QBEQ8hDxg4zcMt0xs9CH8RBE=;
 b=0FP/YGNU/1NUUlkdSoUhjlIzQFkygyg2AazThC8yCzvn5sb0BIBQI4FUzydqTzosW9cgTQ
 VVA/8puDAi+aNYCsHbkT5bfpYmoMBWbMaW3pg1JO0GgC7JlillEqMsuiLinTen9K/7LsMz
 hwtQl9CzUku0GAPCzZxovx8lnXMVhhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697189351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5k2b05Fi43osxrZUE/+QBEQ8hDxg4zcMt0xs9CH8RBE=;
 b=X0Ae9WumudIZMSsKmuBeXg/leRd0c5oJo5IpxfmK6CtQipRewBivG2VBiuzwo8SFpW96B6
 XCkciCOMrLFMT5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 839A61358F;
 Fri, 13 Oct 2023 09:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iWuIH+cNKWVCFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 13 Oct 2023 09:29:11 +0000
Date: Fri, 13 Oct 2023 11:29:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZSkOEKRXAGwvUwR0@yuki>
References: <20231012103916.30712-1-rpalethorpe@suse.com>
 <ZSgIrcu2A5eC_OvZ@yuki> <87y1g6ylc9.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1g6ylc9.fsf@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-10.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add setsockopt10 TLS ULP UAF CVE-2023-0461
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Should we set .needs_drivers for the test so that it only attempts to
> > run either if TLS is compiled in or could be modprobed as a module?
> 
> Yes if it worked :-D, although I would still want to keep the above check. I
> tried it and noticed a number of problems.
> 
> On NixOS:
> 
> $ ./setsockopt10
> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.dep does not exist or not a file
> tst_kernel.c:110: TWARN: expected file /lib/modules/6.5.5/modules.builtin does not exist or not a file

Can you strace modprobe to see what is different on the system, these
files have to be installed somewhere in order for modprobe to actually
work...

> tst_test.c:1195: TCONF: tls driver not available
> $ lsmod | grep tls
> tls                   151552  0
> 
> We have a special switch for Android which disables the check, but it is
> not just Android. Granted NixOS is really wierd by desktop standards,
> but we have ALP and embedded systems to think about.
>
> AFAICT the test library does not do a modprobe if the driver is
> missing. Some tests (e.g. zram, CAN) do that and then claim to require
> modprobe. This is not good, those tests do not need modprobe if the
> module is loaded or compiled in.

That all should be handled in the library when .need_drivers is set.

The problem is that without the modules.buildin file we cannot easily
tell if things have been compiled in. If we manage to find the location
of the files used by modprobe we should do something as:

1) Is foo in modules.buildin -> return to the test
2) Is foo in /proc/modules -> return to the text
3) Is foo in mdules.dep -> try modprobe foo

> Perhaps if the check in tst_kernel fails for any reason we could just do
> a modprobe (or use the configured kernel usermode helper if it is
> set). If that fails we just carry on, like for Android. That's a
> seperate patch though IMO. Once we have a solution for that, this test
> can have needs_drivers added.

I suppose that just calling modprobe and check the return value would
work as well, however that would make it hard dependency.

> >> +	else if (TST_RET == -1)
> >> +		tst_brk(TBROK | TTERRNO, "parent: setsockopt failed");
> >> +
> >> +	SAFE_SETSOCKOPT(tcp1_sk, SOL_TLS, TLS_TX, &opts, sizeof(opts));
> >> +	TST_CHECKPOINT_WAKE(1);
> >> +
> >> +	tst_res(TINFO, "parent: Disconnect by setting unspec address");
> >> +	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
> >> +	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
> >> +
> >> +	TEST(listen(tcp1_sk, 1));
> >> +
> >> +	if (TST_RET == -1) {
> >> +		if (TST_ERR == EINVAL)
> >> +			tst_res(TPASS | TTERRNO, "parent: Can't listen on disconnected TLS socket");
> >> +		else
> >> + tst_res(TCONF | TTERRNO, "parent: Can't listen on disconnected TLS
> >> socket, but the errno is not EINVAL as expected");
> >> +
> >> +		TST_CHECKPOINT_WAKE(2);
> >> +		goto out;
> >> +	}
> >> +
> >> +	tst_res(TINFO, "parent: Can listen on disconnected TLS socket");
> >> +	TST_CHECKPOINT_WAKE(2);
> >> +
> >> +	tcp2_sk = SAFE_ACCEPT(tcp1_sk, NULL, 0);
> >> +	SAFE_CLOSE(tcp2_sk);
> >> +
> >> + tst_res(TINFO, "parent: Attempting double free, because we set
> >> cipher options this should result in an crash");
> >> +	SAFE_CLOSE(tcp1_sk);
> >> +
> >> +	TST_CHECKPOINT_WAKE(3);
> >> +	usleep(0);
> >
> > Did you forget this here?
> 
> It's supposed to give the kernel chance to propagate the taint or
> panic. Which stops it from printing there was no kernel taint in
> parallel with the kernel splat. It appears to work on my test system.

Right, so it's really just sched_yield(), maybe explicit sched_yield()
would be more descriptive.

> >> +	if (tst_taint_check())
> >> +		tst_res(TFAIL, "Kernel is tainted");
> >> +	else
> >> +		tst_res(TCONF, "No kernel taint or crash, maybe the kernel can clone the TLS-ULP context now?");
> >
> > If you set up .taint_check this is going to be redundant since we print
> > TFAIL in the test library in that case.
> 
> In that case we can unconditionally do TCONF and it'll be overridden by
> fail and the resulting panic. Or it will be prevented by the panic.

I guess that we should make the message "No kernel crash, maybe ..."
instead in that case.

> >> +out:
> >> +	tst_reap_children();
> >> +}
> >> +
> >> +static struct tst_test test = {
> >> +	.setup = setup,
> >> +	.cleanup = cleanup,
> >> +	.test_all = run,
> >> +	.forks_child = 1,
> >> +	.needs_checkpoints = 1,
> >> +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> >> +	.needs_kconfigs = (const char *[]) {
> >> +		"CONFIG_TLS",
> >> +		NULL
> >> +	},
> >> +	.tags = (const struct tst_tag[]) {
> >> +		{"linux-git", "2c02d41d71f90"},
> >> +		{"CVE", "2023-0461"},
> >> +		{}
> >> +	}
> >> +};
> >> +
> >> +#else
> >> +
> >> +TST_TEST_TCONF("linux/tls.h missing, we assume your system is too old");
> >> +
> >> +#endif
> >> -- 
> >> 2.40.1
> >> 
> >> 
> >> -- 
> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
