Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC3C433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 10:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD2B43C4D65
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 11:33:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44103C0894
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:33:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 488A4200FEC
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 11:33:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CE9B21941;
 Wed, 24 Nov 2021 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637749998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tUCGSb5B3WyOpTHJ4HyJ4LgYhd9/zJPfnuD9ft5zkRo=;
 b=tZC+ekgrqxO1cFZt39TiRilDmeoADl7DMSbl8OWPr6dQV/XrWHGDVa+5UR/RczMNkS9Oz0
 TyP3BXtjRkE7TgSvnuz/S0FKbMe4uDgRfpMFellig+h72ecr4F2j9C9xfJIIF9UKsw/1cF
 c2Fs+6df33S/J/mKG6LMy04regoK84I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637749998;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tUCGSb5B3WyOpTHJ4HyJ4LgYhd9/zJPfnuD9ft5zkRo=;
 b=RNk6J8yVlVOJeMamtAPPLkHfh9+508bYqOxetwd10lKahA/+GAfHnZanYAYkAjuMbRHh+F
 UZXDXivuFviAnrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 403DD13F05;
 Wed, 24 Nov 2021 10:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1UE/Du4UnmGOZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 24 Nov 2021 10:33:18 +0000
Date: Wed, 24 Nov 2021 11:33:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YZ4U7OyYDVl0KIYK@pevik>
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87bl3t9zr3.fsf@suse.de> <61669595.3000900@fujitsu.com>
 <YWawowTWzUhxGZPi@yuki> <6167802F.1040007@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6167802F.1040007@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default
 run
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
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Cyril
> > Hi!
> >>>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >>>> ---
> >>>>    scenario_groups/default | 1 +
> >>>>    1 file changed, 1 insertion(+)

> >>>> diff --git a/scenario_groups/default b/scenario_groups/default
> >>>> index 439783dac..1dc2987d5 100644
> >>>> --- a/scenario_groups/default
> >>>> +++ b/scenario_groups/default
> >>>> @@ -6,6 +6,7 @@ dio
> >>>>    io
> >>>>    mm
> >>>>    ipc
> >>>> +irq
> >>>>    sched
> >>>>    math
> >>>>    nptl
> >>>> --
> >>>> 2.23.0

> >>> I'm not sure this should go in the default group at this time. The only
> >>> test in irq (irqbalance), only works on some configurations. As
> >>> discussed in the test review, the user must figure out if they should
> >>> run it or not.

> >> It is hard to say moving this case into default run at this time is good
> >> or bad.

> >> With an optimistic attitude, I want to add it into default run(add some
> >> comment in irqbalance01.c that irqbalance01 may fail because it needs
> >> some configuration in service or hardware)and then listen whether many
> >> users complain about this failure.

> >> ps: Many people still use runltp to test ltp instead of runltp-ng and
> >> they usually only run default group. That is a important reason that I
> >> want to add this case into default group.

> > Well there are two wrong choices.

> > If we add it to the default scenario people will complain that the test
> > fails for no good reason.

> > If we do not, the test will be largerly unused and probably bitrot over
> > the time.

> > However if majority here things that we should enable it by default, we
> > can try that and revert it if we got too many complaints.
> Yes, that's what I was thinking too.

OK, merged, let's see if it's ok to run for majority (we can always revert it).

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
