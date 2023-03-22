Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59096C76196
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 16:47:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56A113CD2AD
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 17:47:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8236C3C5624
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 17:47:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BF11F1A007AB
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 17:47:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 08A8833D20;
 Wed, 22 Mar 2023 16:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679503627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ2H7zOrMwIgqlgK8TRkpAQgt5IgFEXBMUF0RU6KiXk=;
 b=2mk3IhVOK/950ICZ7KaNkmMa53eSw04kkhL4Rz9nIlCtOm2yQHAvq9nEhWPkOoUwoV4ddD
 30pyWYi6Y5f+VzVW6xEvU2hVzOxHTajElSBWmH6MCscF1dpBfCzRL+xMl0hSKndAyTvPtl
 iFDiji5BWJQgzenN9aPyrQ10jwMKUE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679503627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ2H7zOrMwIgqlgK8TRkpAQgt5IgFEXBMUF0RU6KiXk=;
 b=pnWiHK9+A385csz1NWM8JcoJyVX8zbQPDUPLF6/k9w8Yhqpflio3bcZYL1gglRYh8jhyV8
 7YQw/OEavSXnQ4Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D873413416;
 Wed, 22 Mar 2023 16:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wpGPMwoxG2SfegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Mar 2023 16:47:06 +0000
Date: Wed, 22 Mar 2023 17:48:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZBsxUp08kTPeF27T@yuki>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <ZBB0P/nfffbrMFme@yuki> <87sfe52cms.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87sfe52cms.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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
> >> +1. Prevent false positive test results
> >> +2. Prevent false negative test results
> >> +3. Make future changes as easy as possible
> >
> > I would say that number 3 maybe be a bit controversial, I've seen cases
> > where attempts to futureproof the code caused steep increase in the
> > test
> > complexity. So maybe:
> >
> > 3. Keep the code as simple as possible as well as futureproof
> 
> Perhaps just
> 
> 3. Keep the code as simple as possibe, but no simpler
> 
> This is possibly paraphrasing Einstein:
> https://quoteinvestigator.com/2011/05/13/einstein-simple/
> 
> 
> NOTE: I think future proofing is actually very dangerous. What I
>       probably meant was
> 
>       3. Keep the code as simple as possible, while maintaining optionality,
>          but if there appears to be a disproportionate increase in complexity
>          for an increase in optionality then simplicity takes priority because
>          identifying relevant optionality is hard.
> 
>       but "optionality" does not have a nice dictionary definition. I guess
>       you could substitute it with "freedom". In any case it's not something I
>       would want to write in documentation. There is no easy way to
>       express it.

That sounds way to complicated, unfortunately reality is often
complicated and cannot be overly simplified.

So I would go with the simple paraphrase to Einstein, that is short and
to the point.

> >> +## How to get patches merged
> >> +
> >> +Once you think a patch is good enough you should add your Reviewed-by
> >> +tags. This means you will get some credit for getting the patch
> >> +merged. Also some blame if there are problems.
> >
> > Maybe we should mention the Tested-by: tag explicitly here as well.
> 
> I'm not sure how we interpret Tested-by when deciding to merge; does it
> mean someone is happy for the test to be merged or not?
> 
> Should someone add both tags if they have reviewed and tested it?

Tested-by: means that someone actually tried the test and that it did
what it was supposed to do. This has obvious meaning for reproducers,
and yes for a reproducer you can add both tags and both are meaningful.

For regular tests Tested-by does not have that much value I guess.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
