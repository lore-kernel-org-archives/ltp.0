Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50ACC282DE
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 10:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 265A03CA1F5
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 11:24:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51C413C2DA5
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:24:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1BED060080B
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 11:24:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 513041F38A;
 Mon, 10 Mar 2025 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741602240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf8zz+KHe8d37B7gBCbeV8OJu7M8WALweFkLKCvuJwc=;
 b=N5I0AFlbHDrUTF3/hSuQ3bfE+ICT6LMkk8E+oM1FYLPLTxYRN8Tc7HvktiROCI87rhEjaE
 SN0SmQ0kAYdwTi4x5OAQV3confq+sAuYLyWa7WUbwQI+JhHngSc8EGZkU5GMp2PSRUM5vB
 eTLK3Xq7HfBROkG6AwjtKLBpwOhCFvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741602240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf8zz+KHe8d37B7gBCbeV8OJu7M8WALweFkLKCvuJwc=;
 b=qCC9+rp/D0pp4k1xqo39VGOPlG1lsTM6kVEsoxeNqJ3QLyxZ1eD6nuEtYHXXDP1N6J4LQA
 c5bBezNKxW2L0cAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=N5I0AFlb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qCC9+rp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741602240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf8zz+KHe8d37B7gBCbeV8OJu7M8WALweFkLKCvuJwc=;
 b=N5I0AFlbHDrUTF3/hSuQ3bfE+ICT6LMkk8E+oM1FYLPLTxYRN8Tc7HvktiROCI87rhEjaE
 SN0SmQ0kAYdwTi4x5OAQV3confq+sAuYLyWa7WUbwQI+JhHngSc8EGZkU5GMp2PSRUM5vB
 eTLK3Xq7HfBROkG6AwjtKLBpwOhCFvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741602240;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wf8zz+KHe8d37B7gBCbeV8OJu7M8WALweFkLKCvuJwc=;
 b=qCC9+rp/D0pp4k1xqo39VGOPlG1lsTM6kVEsoxeNqJ3QLyxZ1eD6nuEtYHXXDP1N6J4LQA
 c5bBezNKxW2L0cAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 036A2139E7;
 Mon, 10 Mar 2025 10:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SLiPNr+9zmf4ZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Mar 2025 10:23:59 +0000
Date: Mon, 10 Mar 2025 11:23:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250310102358.GB396000@pevik>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-3-pvorel@suse.cz>
 <Z8scAAdSbxjCjvV2@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z8scAAdSbxjCjvV2@yuki.lan>
X-Rspamd-Queue-Id: 513041F38A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/5] lib: Allow test to have positional args
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

Hi Cyril,

> Hi!
> > diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> > index 9b18ec059c..f5796ddc49 100644
> > --- a/doc/developers/writing_tests.rst
> > +++ b/doc/developers/writing_tests.rst
> > @@ -521,7 +521,7 @@ LTP C And Shell Test API Comparison
> >      * - not applicable
> >        - TST_NEEDS_MODULE

> > -    * - not applicable
> > +    * - .pos_args (internal use for tst_run_shell.c)
> >        - TST_POS_ARGS

> >      * - not applicable
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index eb73cd593c..b249f833ab 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -292,8 +292,11 @@ struct tst_fs {
> >   *
> >   * @tcnt: A number of tests. If set the test() callback is called tcnt times
> >   *        and each time passed an increasing counter value.
> > + *
> >   * @options: An NULL optstr terminated array of struct tst_option.
> >   *
> > + * @pos_args: An number of positional parameters passed to tst_run_shell.c.

> We do not support positional arguments for the C API. Do we really need
> them for shell?

I needed this for following change 4th commit ("shell lib: Add basic support for
test cleanup", which wrongly mentions cleanup instead of setup):

-	tst_run_shell $(basename "$0") "$@"
+	tst_run_shell tst_exec.sh $(basename "$0") "$@"

I.e. it is only for tst_run_shell.c.  I'll have look on it, if it's not needed
sure this commit would be useless. I would like to avoid this change as well.

> >   * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> >   *
> >   * @supported_archs: A NULL terminated array of architectures the test runs on
> > @@ -528,6 +531,7 @@ struct tst_fs {
> >  	unsigned int tcnt;

> >  	struct tst_option *options;
> > +	int pos_args;

> >  	const char *min_kver;

> > @@ -555,7 +559,6 @@ struct tst_fs {
> >  	unsigned int skip_in_secureboot:1;
> >  	unsigned int skip_in_compat:1;

> > -
> >  	int needs_abi_bits;

> >  	unsigned int needs_hugetlbfs:1;
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 3823ea109e..1c2cc5e3b2 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -711,6 +711,9 @@ static void parse_opts(int argc, char *argv[])

> >  	check_option_collision();

> > +	if (tst_test->pos_args < 0)
> > +		tst_brk(TBROK, ".pos_args must be >= 0");

> You can declare pos_args as unsigned and you don't have to add this
> condition.

Good point, thanks!

> >  	optstr[0] = 0;

> >  	for (i = 0; i < ARRAY_SIZE(options); i++)
> > @@ -751,8 +754,10 @@ static void parse_opts(int argc, char *argv[])
> >  		}
> >  	}

> > -	if (optind < argc)
> > -		tst_brk(TBROK, "Unexpected argument(s) '%s'...", argv[optind]);
> > +	if (optind + tst_test->pos_args < argc) {
> > +		tst_brk(TBROK, "Unexpected argument(s) '%s' (%d + %d < %d)",
> > +			argv[optind], optind, tst_test->pos_args, argc);
> > +	}

> And this half enables the positional arguments for the C API as well. If
> we set the pos_args in tst_test, then we can pass them, but there is no
> way how they can be passed to the test.

Again, this is only for tst_run_shell.c.

Kind regards,
Petr

> So if we are going to add them, we should pass then in
> extern char **tst_args or something like that.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
