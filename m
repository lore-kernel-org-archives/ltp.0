Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B25C433FE
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 09:46:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCF763C916C
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:46:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C4D63C0B99
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:46:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A265200DAF
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:46:40 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4D35D212B8;
 Mon, 20 Dec 2021 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639993600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ygMvFCVwroEZLqIAtNHCYGf12Ie6ONQ/EXJimr9rjQ=;
 b=dglbw/QZeNxsqGvA2Rq+VwTdo73eH0AuVJ3HvHi0CpaMhvh7Jj18GjX1SUB9IqBccmFVLz
 0sP+x/w7m1HvKYNCoXnJGHJAtWxHXL6ZoCvxAOPyDt7HSxLCZ7xL54FHlpgIqN6XvsJ+su
 1EzVwMHLERIjP28rFDuJibGchJcA1fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639993600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ygMvFCVwroEZLqIAtNHCYGf12Ie6ONQ/EXJimr9rjQ=;
 b=3SXlpJh0UeFmZlBYwSts/iUSGMJZ2rlpYfEC4vbNy8ZDai8VYJ0Bfow7reBhd+qtCL7Znm
 WGamtiv6qc1tMmBg==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E8510A3B85;
 Mon, 20 Dec 2021 09:46:39 +0000 (UTC)
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
 <87lf0oaeui.fsf@suse.de> <Ybc5QJSZM3YIji70@yuki> <87h7bca7vu.fsf@suse.de>
 <YbnI83sr26q+naFd@pevik> <874k7a9j5p.fsf@suse.de> <YboX0x4X05tMmUkE@pevik>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Dec 2021 08:58:23 +0000
In-reply-to: <YboX0x4X05tMmUkE@pevik>
Message-ID: <87lf0ffw1y.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: pvorel@suze.cz, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, Cyril,
>
>> Hello Petr,
>
>> Petr Vorel <pvorel@suse.cz> writes:
>
>> > Hi Richie, all,
>
>> >> Hello,
>
>> >> Cyril Hrubis <chrubis@suse.cz> writes:
>
>> >> > Hi!
>> >> >> >>> The issue is we may forget to merge patch sets for features which are
>> >> >> >>> included (a far worse result). It's more stuff waiting around in the
>> >> >> >>> queue. At the least we should have a procedure for tracking them (like
>> >> >> >>> tagging github issues for review at each mainline release).
>
>> >> >> >>> If a test requires a kernel config which doesn't exist in mainline we
>> >> >> >>> could also look for that automatically.
>
>> >> >> >> The main issue is that if we happen to release LTP meanwhile with a test
>> >> >> >> for a syscall that didn't get included in the mainline in the end we
>> >> >> >> have released LTP that is supposed to be stable and the test will start
>> >> >> >> to fail when the syscall number is allocated for something else which
>> >> >> >> will happen sooner or later.
>> >> >> > I know a example that is quotactl_path syscall.
>
>
>> >> >> If the real issue is LTP releases, then why not exclude tests for new
>> >> >> features from them? I assume it's only a small number of commits which
>> >> >> would need to be removed. Possibly we could tag them in git when merging
>> >> >> so it is not a lot more work for whoever does the release (namely
>> >> >> Cyril) to create a branch without them.
>
>> >> > That sounds too complex for a test or two we are usually getting during
>> >> > the release cycle.
>
>> >> > Note that people who contribute the functionality to the kernel are used
>> >> > to wait for next release window, kernel releases are aprox. twice as
>> >> > fast as LTP.
>
>> >> >> My main concern is this will throw up a barrier to motivated
>> >> >> contributors working on the cutting edge.
>
>> >> > So far really nobody complained, which may not be a good metric. But
>> >> > still unless there is a evidence that this happens I wouldn't consider
>> >> > spending effort on this.
>
>> >> OK, well if it comes up again we can revisit it. However Petr please
>> >> could you add the reasoning about not adding unstable tests into
>> >> releases.
>> > Isn't "... because it can be reverted in later rc if problematic" enough?
>> > If not what would you add? Cyril posted test getting released in LTP and later
>> > unstable. I could be more verbose, but not sure if that's better:
>
>> > * Tests for new functionality in mainline kernel should be merged after final
>> >   release of kernel which contains that functionality. It's not enough when the
>> >   feature gets into rc1, because in later rc the functionality can be changed or
>> >   even reverted if problematic. And this could lead to broken test.
>
>> It's only a problem because of LTP releases. We can just fix or revert
>> tests otherwise. Especially if the test author is also developing the
>> kernel feature and updating the test in lockstep.
>
>> Without LTP releases then a test can be added for a feature only in RC
>> and removed again. Only people who test the RC will get a result other
>> than TCONF from the test before it disappears again or is updated to
>> support the final feature.
>
>> Assuming of course people update LTP from HEAD on a regular basis. Which
>> of course they won't or can't, so we have releases. We don't have a
>> separate unstable branch because no one has volunteered to create and
>> maintain it. If we did we could just add such tests to that.
>
> Agree, but we *do* have releases and do *not* have unstable branch.
>
> Thus, first, do you agree with current policy?

Yes. Although we could add "next" and "rc" flags to tst_test (or
similar). Then require an environment variable to be set (or check the
kernel version) otherwise the test will return TCONF.

For LTP releases we just need to check if the flags are still needed or
if the feature has been merged. The metadata parser can generate a list
of tests to check.

This seems like quite little work to me. In fact we don't even have to
implement it until someone wants it. We can just add it to the policy.

> If yes, how would you phrase it (do you want to add / change
> anything)?

Something like:

"Tests for new functionality should only be added to the LTP once they
are part of the stable kernel ABI. This happens when a feature is
included in a final kernel release. Not during the RC phase where they
can still be removed and, for example, the syscall numbers reused.

This allows stable LTP releases to be taken directly from Git HEAD at
any time we are ready. Without needing to remove commits for unstable
feature tests or synchronise with the kernel releases.

Alternatively if someone is very motivated to add tests for linux-next
or the RC phase. We can add flags to tst_test which will prevent these
tests being run under normal circumstances. Meaning the releases are
unaffected."

>
> Or do you suggest to have policy when merged to rc1?
> It would work for me, but we'd have to ask all maintainers
> (I suggested that before, Cyril preferred kernel release).

I'd happily accept tests for things going into linux-next if there are
people willing to write them and they do not "throw them over the
wall and run".

>
> Kind regards,
> Petr
>
>> >> With that you can add
>
>> >> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
>
>> > Kind regards,
>> > Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
