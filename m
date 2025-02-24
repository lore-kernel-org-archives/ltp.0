Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77399C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:46:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F95D3C9A01
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:46:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2273C9911
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:46:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E5E91419F54
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 19:46:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A0991F441;
 Mon, 24 Feb 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEDB313332;
 Mon, 24 Feb 2025 18:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fxb7OIG+vGc8GwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Feb 2025 18:46:25 +0000
Date: Mon, 24 Feb 2025 19:46:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z7y-jJplSsx0TXDs@yuki.lan>
References: <20250224100016.2857704-1-pvorel@suse.cz>
 <Z7yNVQAnQ5NPTtaz@yuki.lan> <20250224180057.GA2897036@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250224180057.GA2897036@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0A0991F441
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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
> > > -	if (tst_test->test_variants)
> > > +	if (tst_test->test_variants) {
> > >  		test_variants = tst_test->test_variants;
> > > +		only_variant = getenv("LTP_SINGLE_VARIANT");
> > > +		if (only_variant && only_variant[0] != '\0') {
> > > +			tst_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
> > > +							  test_variants - 1);
> > > +			tst_res(TINFO, "WARNING: testing only variant %d of %d",
> > > +					tst_variant, test_variants - 1);
> > > +			test_variants = tst_variant + 1;
> > > +		}
> > > +	}
> > > +
> > > +	for (; tst_variant < test_variants; tst_variant++) {
> 
> > > -	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
> > >  		if (tst_test->all_filesystems || count_fs_descs() > 1)
> > >  			ret |= run_tcases_per_fs();
> > >  		else
> 
> > Can we instead add a function that would set two integer variables,
> > first_variant and last variant as:
> 
> > static void setup_variants(unsigned int *first_variant, unsigned int *last_variant)
> > {
> > 	//setup the defaults and parse the variables here
> > }
> 
> Sure, I'll send v2 if you see the patch useful (Li was not sure if this is
> useful).

I do not have a strong opinion here, it may be mildly useful for test
development, in some rare circumstances.

> > diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
> > index adce0ddcf..74a7e514e 100644
> > --- a/testcases/kernel/syscalls/pause/pause01.c
> > +++ b/testcases/kernel/syscalls/pause/pause01.c
> > @@ -20,6 +20,8 @@ static void do_child(void)
> >         SAFE_SIGNAL(SIGINT, sig_handler);
> >         TST_EXP_FAIL(pause(), EINTR);
> >         TST_CHECKPOINT_WAKE(0);
> > +
> > +       tst_res(TPASS, "Process resumed from pause()");
> 
> I guess this is part of some other work, right? (there is no TST_EXP_FAIL() in
> pause01.c).

That's from a different review, sorry...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
