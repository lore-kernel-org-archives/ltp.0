Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F0810987A4
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 16:20:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD923E610F
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 17:20:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0634A3CFC0E
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 17:20:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 947F9200AF6
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 17:20:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C53E04D231;
 Fri, 20 Mar 2026 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774023614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGZxxUrKGxhYOul4V0fFLyVWt+UKUYD8BH2Zdb1Syak=;
 b=nyNxXdkuP1vf7ceC0Yc7Vq0oGDen7N6NBSeRGIMCWNSP4Cti+GCBP5jvSe9N5FCMR5nop9
 ckqHCYtVrZBXf/mORlco9jhYT1YyG7LlANdEjkTsBH+Q4lBTKTCVaKcFQk0hPISuuOTJ3C
 v22tsjQMOOnlMd/2ouZqU0siRQhcKq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774023614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGZxxUrKGxhYOul4V0fFLyVWt+UKUYD8BH2Zdb1Syak=;
 b=MwjxtPnvhkU3b/768JekUf274NL7jufAJzBoOHory1puaj+FQUgOd7I7EhFqq/vamJJdI8
 l1IZ/YdWaidWfcCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZidnI8R1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O635BYXU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774023613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGZxxUrKGxhYOul4V0fFLyVWt+UKUYD8BH2Zdb1Syak=;
 b=ZidnI8R1lqfujYFkAZig0CCephjGRwuD43OWgeTqM9jMSMRzJkWyyimfBeJDkPgp4ldG24
 9CNWQAcrkP08ZBQ/ngIJlumlLVpIKlJolp4MG3sW6veRNiINkdWdcd9T2ZootDZPdAKguD
 FWXszIT22EXRfa6te1GGczN0PXcGzxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774023613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGZxxUrKGxhYOul4V0fFLyVWt+UKUYD8BH2Zdb1Syak=;
 b=O635BYXUkDyvBFWpGQdB5TfJYYr04fSrWKx0LjzguEt+TnHbRWs6+RFwkPCd/bEdyvhfMF
 83jcxszUdFjrPOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4BDF428B6;
 Fri, 20 Mar 2026 16:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFgYK71zvWm/LwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 16:20:13 +0000
Date: Fri, 20 Mar 2026 17:20:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ab1zwXCUui24rmmC@yuki.lan>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
 <abq1-BcXR1nfLGcU@yuki.lan> <20260318150252.GA31214@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318150252.GA31214@pevik>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[isofs.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid,tst_test.sh:url,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C53E04D231
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] tst_env.sh: Backport common functions from
 tst_test.sh
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
> > SAFE instead so that the name is closer to the SAFE_XXX macros in C.
> 
> Makes sense. I was even thinking on SAFE_CMD, but we use tst_rod.c, not
> tst_cmd.c. OTOH it was obvious that ROD uses tst_rod.c, should it be also
> renamed? What ROD means anyway? run or dye?

Run or die (we are not coloring anything).

And yes it would make sense to rename tst_rod.c to tst_safe_cmd.c or
similar.

> > > +_tst_expect_pass()
> > > +{
> > > +	local fnc="$1"
> > > +	shift
> > > +
> > > +	tst_rod "$@"
> 
> > If I remmeber correctly the whole reason why we introduced tst_rod.c was
> > that passing the $@ like this causes the $@ to be evaluated twice and
> > produces unexpected results.
> 
> FYI code is copy pasted from tst_test.sh. What do you want me to change?

I've spend a couple of minutes figuring out why we originaly implemented
ROD_BASE() in C.

The problem is that single quotes gets removed as soon as we pass the
parameter.

E.g.: ROD awk '{ print $1 }'

Once we pass that to a shell function the '' disappear, they managed to
keep the { print $1 } to be a single parameter in the list but they are
not there anymore.

And since we were manipulating the parameter list we got, we failed to
reconstruct it correctly in shell since in the next step the { print $1 }
breaks into four separate strings.

As long as we pass the $@ as a whole (even after shift), it does work
since the boundaries of parameters in $@ stay exactly as they were.

TL;DR; The code you copy&pasted is correct, I only misremembered what
was the problem back then.

> > I'm not sure that adding the PASS_BRK and FAIL_BRK is a good idea. I
> > would stick to simple EXPECT_PASS and EXPECT_FAIL. And maybe we can
> > export TST_PASS variable as we do in C to match the API. I think that
> > the closer the C and shell API are the better.
> 
> C API usually returns on if (!TST_PASS). I don't like it either, but it cannot
> be shortened much as we don't use functions but macros.
> 
> But changing the code in the shell API does not look to me an improvement:
> 
> -EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
> +EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
> +[ "$TST_PASS" = 1 ] || tst_brk "Quit due the above error"

Let's keep it then.

> But OTOH maybe route-change-*.sh tests even don't need to quit.
> And it's a question if isofs.sh does (and whether we should even keep isofs.sh).

For the isofs I would probably generate the iso filesystems in advance
and store them in git so that we don't have to re-generate them during
the test run. Other than that mounting an iso filesystem over loopback
and checking that the files are there (which the test does not do) is
valid kernel test. But that is a different problem.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
