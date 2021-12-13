Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78239C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 14:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27FA03C8B07
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 15:37:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E16D23C825E
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 15:37:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 91210600C54
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 15:37:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3B08B1F3BB;
 Mon, 13 Dec 2021 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639406230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Of7Ufw3HLdc4fJzx3kpvfBc0d4KOfkRh5ll27j/lnQ4=;
 b=bA/mhaQfP/pANW1Hq1UpV215JTButhSW9yZp2yFkbf8e0PH2gtFM/XjMJgPZjWNZOh1q5T
 Fr0dxv96SxYoT6fs2RDmxyfQYulOia86XKSrWIb8Q2uven/FDvXV2mTbcFPNHEzwskRugD
 4y1fwAubnTCGs2V2Tbro/BL7RdLdt8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639406230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Of7Ufw3HLdc4fJzx3kpvfBc0d4KOfkRh5ll27j/lnQ4=;
 b=S6x593kvq3IYpM3f1nu2U2SU6lSK6iGOz9JS594QgVAQXsYmCBu5FEN7kzePRV2hPAZPtz
 qr4rHRY0Sg7iqnDw==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EA9C9A3B85;
 Mon, 13 Dec 2021 14:37:09 +0000 (UTC)
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
 <87lf0oaeui.fsf@suse.de> <Ybc5QJSZM3YIji70@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Dec 2021 14:17:47 +0000
In-reply-to: <Ybc5QJSZM3YIji70@yuki>
Message-ID: <87h7bca7vu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >>> The issue is we may forget to merge patch sets for features which are
>> >>> included (a far worse result). It's more stuff waiting around in the
>> >>> queue. At the least we should have a procedure for tracking them (like
>> >>> tagging github issues for review at each mainline release).
>> >>>
>> >>> If a test requires a kernel config which doesn't exist in mainline we
>> >>> could also look for that automatically.
>> >>
>> >> The main issue is that if we happen to release LTP meanwhile with a test
>> >> for a syscall that didn't get included in the mainline in the end we
>> >> have released LTP that is supposed to be stable and the test will start
>> >> to fail when the syscall number is allocated for something else which
>> >> will happen sooner or later.
>> > I know a example that is quotactl_path syscall.
>> >>
>> 
>> If the real issue is LTP releases, then why not exclude tests for new
>> features from them? I assume it's only a small number of commits which
>> would need to be removed. Possibly we could tag them in git when merging
>> so it is not a lot more work for whoever does the release (namely
>> Cyril) to create a branch without them.
>
> That sounds too complex for a test or two we are usually getting during
> the release cycle.
>
> Note that people who contribute the functionality to the kernel are used
> to wait for next release window, kernel releases are aprox. twice as
> fast as LTP.
>
>> My main concern is this will throw up a barrier to motivated
>> contributors working on the cutting edge.
>
> So far really nobody complained, which may not be a good metric. But
> still unless there is a evidence that this happens I wouldn't consider
> spending effort on this.

OK, well if it comes up again we can revisit it. However Petr please
could you add the reasoning about not adding unstable tests into
releases.

With that you can add

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
