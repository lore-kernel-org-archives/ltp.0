Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E591C433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF1661074
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFF1661074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29FED3C12D0
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 12:10:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF9F3C0FC4
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:10:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6CAAC1001424
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:10:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98C5722300;
 Wed, 13 Oct 2021 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634119802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IB8oWmjbsaa1FAvKbgADnqWgoObk+zrQFlfhTADNUnE=;
 b=pQzE/j1dK6TKP5feMOgzSdI8uwN0M40GALNKBNoWGLfba6RPYeyjJaprgrdwF6bM7F9r7Q
 z0utL69/Q+4OA9RJZlWeX2mA/1gFAM+RWzQLRo61ldaMAz4qcxdrhV4krCpmLMMJkJkNgs
 OQkAOmM5xS82aLY/0q97kbB3EJmnrcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634119802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IB8oWmjbsaa1FAvKbgADnqWgoObk+zrQFlfhTADNUnE=;
 b=j+lLmtS9boTbmm3FU/NUKIRfql4pLZtjot0oTmUMDR2cDcvXH4CloX9itmFkEHKL/xnh/j
 mnOOAYliEyIlb+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86A8813CEC;
 Wed, 13 Oct 2021 10:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ifJwH3qwZmERQwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Oct 2021 10:10:02 +0000
Date: Wed, 13 Oct 2021 12:10:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YWawowTWzUhxGZPi@yuki>
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <87bl3t9zr3.fsf@suse.de> <61669595.3000900@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61669595.3000900@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   scenario_groups/default | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/scenario_groups/default b/scenario_groups/default
> >> index 439783dac..1dc2987d5 100644
> >> --- a/scenario_groups/default
> >> +++ b/scenario_groups/default
> >> @@ -6,6 +6,7 @@ dio
> >>   io
> >>   mm
> >>   ipc
> >> +irq
> >>   sched
> >>   math
> >>   nptl
> >> -- 
> >> 2.23.0
> > 
> > I'm not sure this should go in the default group at this time. The only
> > test in irq (irqbalance), only works on some configurations. As
> > discussed in the test review, the user must figure out if they should
> > run it or not.
> 
> It is hard to say moving this case into default run at this time is good
> or bad.
> 
> With an optimistic attitude, I want to add it into default run(add some
> comment in irqbalance01.c that irqbalance01 may fail because it needs
> some configuration in service or hardware)and then listen whether many
> users complain about this failure.
> 
> ps: Many people still use runltp to test ltp instead of runltp-ng and
> they usually only run default group. That is a important reason that I
> want to add this case into default group.

Well there are two wrong choices.

If we add it to the default scenario people will complain that the test
fails for no good reason.

If we do not, the test will be largerly unused and probably bitrot over
the time.

However if majority here things that we should enable it by default, we
can try that and revert it if we got too many complaints.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
