Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6E7C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 08:56:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874D53C25DD
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 09:56:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B772B3C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:56:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A03A6140BB7A
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 09:56:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B71021F805;
 Tue, 21 Jan 2025 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737449769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjDa0kaRI7A6wKF00rcq8CNj7UHpUvkJfg4on1wDyg=;
 b=JQq/qVxXMxeFPMMMCgMQHucAaRPKWIXtxt2wZV158w1UJYet4K2tla8Tyuv8evYWUtVIcP
 e78y+lYVU/RhABfmrpQTEyYYwHK4iSCrMyBxCipnDvA88hlktT5eZp8b7eV+M7n8xkWhXX
 69/mkQMVinOJeNiCAJRJKNmCllZNfms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737449769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjDa0kaRI7A6wKF00rcq8CNj7UHpUvkJfg4on1wDyg=;
 b=I7NS3P3/qgZWOiFE3zSk1fdItGigNRLJb84amawuiQZZ2nMyVAgKde/84fTivFwu40LOD3
 g7GWVkfkJGAz49Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737449769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjDa0kaRI7A6wKF00rcq8CNj7UHpUvkJfg4on1wDyg=;
 b=JQq/qVxXMxeFPMMMCgMQHucAaRPKWIXtxt2wZV158w1UJYet4K2tla8Tyuv8evYWUtVIcP
 e78y+lYVU/RhABfmrpQTEyYYwHK4iSCrMyBxCipnDvA88hlktT5eZp8b7eV+M7n8xkWhXX
 69/mkQMVinOJeNiCAJRJKNmCllZNfms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737449769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjDa0kaRI7A6wKF00rcq8CNj7UHpUvkJfg4on1wDyg=;
 b=I7NS3P3/qgZWOiFE3zSk1fdItGigNRLJb84amawuiQZZ2nMyVAgKde/84fTivFwu40LOD3
 g7GWVkfkJGAz49Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939C21387C;
 Tue, 21 Jan 2025 08:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q10PIylhj2caOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Jan 2025 08:56:09 +0000
Date: Tue, 21 Jan 2025 09:56:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250121085608.GA890303@pevik>
References: <20250120085017.63442-1-acarmina@redhat.com>
 <20250120094634.GB798022@pevik>
 <CAGegRW72RcV+L68y+3prAajqvSfHsZpTrN4+sb0ErcRZ6cOsnA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGegRW72RcV+L68y+3prAajqvSfHsZpTrN4+sb0ErcRZ6cOsnA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cfs-scheduler/starvation.c: Skip test on realtime
 kernels
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Alessandro,

> Hello Petr,
...
> > LGTM. Could you please test if starvation.c worked previously?
> > Or was it always broken?

> Before submitting the patch, I tested the case in various environments.
> One thing that puzzled me for a while was the test's high sensitivity to
> latencies.
> While it works correctly on bare-metal systems under the intended
> conditions with the CFS scheduler, running it on a real-time kernel
> or in a virtualized/emulated environment is likely to cause the
> test to fail.

> This patch addresses the real-time kernel scenario, which is relatively
> easier to handle.
> In a separate RFC patch I plan to send, I would like to ask the
> community for guidance on how to handle the virtualization/emulation
> environment issue.

Thanks, reply send.

FYI there is a git freeze before upcoming release, only fixes are merged.
https://lore.kernel.org/ltp/5202b2ba-a13e-4250-97c5-937dde849975@suse.com/T/#t

But fixes like this should go in (I'll leave the decision to Cyril).

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > +int tst_check_preempt_rt(void)
> > > +{
> > > +     struct utsname uval;
> > > +
> > > +     uname(&uval);
> > > +     if (strstr(uval.version, "PREEMPT_RT"))
> > > +             return -1;
> > > +     return 0;
> > > +}
> > > diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> > > index 901556a7b..c620c9c3e 100644
> > > --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> > > +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> > > @@ -82,6 +82,9 @@ static void setup(void)

> > >       CPU_ZERO(&mask);

> > > +     if (tst_check_preempt_rt())
> > > +             tst_brk(TCONF, "This test is not designed for the RT kernel");
> > nit: I would move it above CPU_ZERO().
> Ok, I'll fix it in the v2

Thanks!

> > NOTE: we should also move tst_has_slow_kconfig() check to be at the top of
> > setup(). But that's unrelated. Also at least on Tumbleweed and SLES which get
> > detected as slow due CONFIG_LATENCYTOP test was worked before.

> Want me to address this issue?

Already done:
https://patchwork.ozlabs.org/project/ltp/patch/20250120143420.815363-1-pvorel@suse.cz/

Kind regards,
Petr

> > Kind regards,
> > Petr


> Cheers
> Alessandro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
