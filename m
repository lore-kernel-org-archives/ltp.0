Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F18103E199
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62793E6130
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 16:03:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA213C7A18
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:03:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 395EB1400BE7
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 16:02:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 907E24D442;
 Wed, 18 Mar 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 685F14273B;
 Wed, 18 Mar 2026 15:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o0SjGKK+uml2CAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 15:02:58 +0000
Date: Wed, 18 Mar 2026 16:02:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260318150252.GA31214@pevik>
References: <20260313142600.243939-1-pvorel@suse.cz>
 <20260313142600.243939-3-pvorel@suse.cz>
 <abq1-BcXR1nfLGcU@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abq1-BcXR1nfLGcU@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 907E24D442
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
...

> > +ROD_SILENT()
> > +{
> > +	local tst_out
> > +
> > +	tst_out=$(tst_rod "$@" 2>&1)
> > +	if [ $? -ne 0 ]; then
> > +		echo "$tst_out"
> > +		tst_brk TBROK "$@ failed"
> > +	fi
> > +}
> > +
> > +ROD()
> > +{
> > +	tst_rod "$@"
> > +	if [ $? -ne 0 ]; then
> > +		tst_brk TBROK "$@ failed"
> > +	fi
> > +}

> Since we are starting from a scratch I wonder if we should call this
> SAFE instead so that the name is closer to the SAFE_XXX macros in C.

Makes sense. I was even thinking on SAFE_CMD, but we use tst_rod.c, not
tst_cmd.c. OTOH it was obvious that ROD uses tst_rod.c, should it be also
renamed? What ROD means anyway? run or dye?

> > +_tst_expect_pass()
> > +{
> > +	local fnc="$1"
> > +	shift
> > +
> > +	tst_rod "$@"

> If I remmeber correctly the whole reason why we introduced tst_rod.c was
> that passing the $@ like this causes the $@ to be evaluated twice and
> produces unexpected results.

FYI code is copy pasted from tst_test.sh. What do you want me to change?

> > +	if [ $? -eq 0 ]; then
> > +		tst_res TPASS "$@ passed as expected"
> > +		return 0
> > +	else
> > +		$fnc TFAIL "$@ failed unexpectedly"
> > +		return 1
> > +	fi
> > +}
> > +
> > +_tst_expect_fail()
> > +{
> > +	local fnc="$1"
> > +	shift
> > +
> > +	# redirect stderr since we expect the command to fail
> > +	tst_rod "$@" 2> /dev/null
> > +	if [ $? -ne 0 ]; then
> > +		tst_res TPASS "$@ failed as expected"
> > +		return 0
> > +	else
> > +		$fnc TFAIL "$@ passed unexpectedly"
> > +		return 1
> > +	fi
> > +}
> > +
> > +EXPECT_PASS()
> > +{
> > +	_tst_expect_pass tst_res "$@"
> > +}
> > +
> > +EXPECT_PASS_BRK()
> > +{
> > +	_tst_expect_pass tst_brk "$@"
> > +}

> I'm not sure that adding the PASS_BRK and FAIL_BRK is a good idea. I
> would stick to simple EXPECT_PASS and EXPECT_FAIL. And maybe we can
> export TST_PASS variable as we do in C to match the API. I think that
> the closer the C and shell API are the better.

C API usually returns on if (!TST_PASS). I don't like it either, but it cannot
be shortened much as we don't use functions but macros.

But changing the code in the shell API does not look to me an improvement:

-EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
+EXPECT_PASS_BRK ping$TST_IPV6 -c1 -I $lhost $rhost \>/dev/null
+[ "$TST_PASS" = 1 ] || tst_brk "Quit due the above error"

But OTOH maybe route-change-*.sh tests even don't need to quit.
And it's a question if isofs.sh does (and whether we should even keep isofs.sh).
=> I'm ok with it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
