Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB685C4332F
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 16:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55F603C8F88
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 17:29:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5323C8DDE
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 17:29:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93F7C1000F40
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 17:29:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4C3C1F3CB;
 Wed, 15 Dec 2021 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639585749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1GR2lBxWrp2SeMoLjwjLxP4JiMLw9HEWDUYHAtf9fk=;
 b=q3Y8K3aHVZihVv1IUY8Yu2M/dHY97K51wx+wwhR2BwmAvuF8Z8smm7ePdoXz3FTyT6jwI7
 B+SPHDViNfmc3yADtyhYs0Nkw2sqtHKt6BkD6KfEUUUFUeGFSe4EAFPk4Y7cCgJsvTJ8bZ
 JA8vWLI7OUPVRglyp310OBX1vbdG0ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639585749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1GR2lBxWrp2SeMoLjwjLxP4JiMLw9HEWDUYHAtf9fk=;
 b=x5QOSmraiqUWQvh31+YEm6XDRX40npNYzW59QlAynWfcMGyqUruyAff6GR4dIQhekm85aC
 FblebUnEnK8wBmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D7D413B75;
 Wed, 15 Dec 2021 16:29:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +Mi7INUXumFaIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 16:29:09 +0000
Date: Wed, 15 Dec 2021 17:29:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YboX0x4X05tMmUkE@pevik>
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
 <87lf0oaeui.fsf@suse.de> <Ybc5QJSZM3YIji70@yuki>
 <87h7bca7vu.fsf@suse.de> <YbnI83sr26q+naFd@pevik>
 <874k7a9j5p.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874k7a9j5p.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
Cc: pvorel@suze.cz, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Cyril,

> Hello Petr,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie, all,

> >> Hello,

> >> Cyril Hrubis <chrubis@suse.cz> writes:

> >> > Hi!
> >> >> >>> The issue is we may forget to merge patch sets for features which are
> >> >> >>> included (a far worse result). It's more stuff waiting around in the
> >> >> >>> queue. At the least we should have a procedure for tracking them (like
> >> >> >>> tagging github issues for review at each mainline release).

> >> >> >>> If a test requires a kernel config which doesn't exist in mainline we
> >> >> >>> could also look for that automatically.

> >> >> >> The main issue is that if we happen to release LTP meanwhile with a test
> >> >> >> for a syscall that didn't get included in the mainline in the end we
> >> >> >> have released LTP that is supposed to be stable and the test will start
> >> >> >> to fail when the syscall number is allocated for something else which
> >> >> >> will happen sooner or later.
> >> >> > I know a example that is quotactl_path syscall.


> >> >> If the real issue is LTP releases, then why not exclude tests for new
> >> >> features from them? I assume it's only a small number of commits which
> >> >> would need to be removed. Possibly we could tag them in git when merging
> >> >> so it is not a lot more work for whoever does the release (namely
> >> >> Cyril) to create a branch without them.

> >> > That sounds too complex for a test or two we are usually getting during
> >> > the release cycle.

> >> > Note that people who contribute the functionality to the kernel are used
> >> > to wait for next release window, kernel releases are aprox. twice as
> >> > fast as LTP.

> >> >> My main concern is this will throw up a barrier to motivated
> >> >> contributors working on the cutting edge.

> >> > So far really nobody complained, which may not be a good metric. But
> >> > still unless there is a evidence that this happens I wouldn't consider
> >> > spending effort on this.

> >> OK, well if it comes up again we can revisit it. However Petr please
> >> could you add the reasoning about not adding unstable tests into
> >> releases.
> > Isn't "... because it can be reverted in later rc if problematic" enough?
> > If not what would you add? Cyril posted test getting released in LTP and later
> > unstable. I could be more verbose, but not sure if that's better:

> > * Tests for new functionality in mainline kernel should be merged after final
> >   release of kernel which contains that functionality. It's not enough when the
> >   feature gets into rc1, because in later rc the functionality can be changed or
> >   even reverted if problematic. And this could lead to broken test.

> It's only a problem because of LTP releases. We can just fix or revert
> tests otherwise. Especially if the test author is also developing the
> kernel feature and updating the test in lockstep.

> Without LTP releases then a test can be added for a feature only in RC
> and removed again. Only people who test the RC will get a result other
> than TCONF from the test before it disappears again or is updated to
> support the final feature.

> Assuming of course people update LTP from HEAD on a regular basis. Which
> of course they won't or can't, so we have releases. We don't have a
> separate unstable branch because no one has volunteered to create and
> maintain it. If we did we could just add such tests to that.

Agree, but we *do* have releases and do *not* have unstable branch.

Thus, first, do you agree with current policy?
If yes, how would you phrase it (do you want to add / change anything)?

Or do you suggest to have policy when merged to rc1?
It would work for me, but we'd have to ask all maintainers
(I suggested that before, Cyril preferred kernel release).

Kind regards,
Petr

> >> With that you can add

> >> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
