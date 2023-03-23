Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF557C6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 05:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF0173CA69D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 06:47:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A3013CA55F
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:46:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D477860070E
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 06:46:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8EBA5C38F;
 Thu, 23 Mar 2023 05:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679550409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYYpUI4qxM83CPlk1wYdf0vbWPjfQ6awcClH2cq5g+A=;
 b=ZZm3eD08uCu5gZ8uPBw366A75guNzQYzKy77uNaVd8HkGOd8omIRNCoJc1rIyE3mx/lX/P
 lU8w/EcWA2L0eV1IWr8tbYmmkRXhR42o8oVMnn0ZXtTTqxRI73kxmaRSkOdCjKDxc8/xXD
 IRRYS4BVuH0xyQea8SHaNd53lfNwT08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679550409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYYpUI4qxM83CPlk1wYdf0vbWPjfQ6awcClH2cq5g+A=;
 b=GcL6Fc4YICJ4y0dPNcmsMAiZc72oILBxSD5QvBmBA9TmIdc2pyposJlRcp/diHiCknzeU1
 VnxmBqnVT8ZVfZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F8B8138FB;
 Thu, 23 Mar 2023 05:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dGXgGMnnG2QzVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 05:46:49 +0000
Date: Thu, 23 Mar 2023 06:46:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230323054647.GC381848@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <ZBB0P/nfffbrMFme@yuki> <87sfe52cms.fsf@suse.de>
 <ZBsxUp08kTPeF27T@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBsxUp08kTPeF27T@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > >> +1. Prevent false positive test results
> > >> +2. Prevent false negative test results
> > >> +3. Make future changes as easy as possible

> > > I would say that number 3 maybe be a bit controversial, I've seen cases
> > > where attempts to futureproof the code caused steep increase in the
> > > test
> > > complexity. So maybe:

> > > 3. Keep the code as simple as possible as well as futureproof

> > Perhaps just

> > 3. Keep the code as simple as possibe, but no simpler

> > This is possibly paraphrasing Einstein:
> > https://quoteinvestigator.com/2011/05/13/einstein-simple/


> > NOTE: I think future proofing is actually very dangerous. What I
> >       probably meant was

> >       3. Keep the code as simple as possible, while maintaining optionality,
> >          but if there appears to be a disproportionate increase in complexity
> >          for an increase in optionality then simplicity takes priority because
> >          identifying relevant optionality is hard.

> >       but "optionality" does not have a nice dictionary definition. I guess
> >       you could substitute it with "freedom". In any case it's not something I
> >       would want to write in documentation. There is no easy way to
> >       express it.

> That sounds way to complicated, unfortunately reality is often
> complicated and cannot be overly simplified.

> So I would go with the simple paraphrase to Einstein, that is short and
> to the point.

+1

> > >> +## How to get patches merged
> > >> +
> > >> +Once you think a patch is good enough you should add your Reviewed-by
> > >> +tags. This means you will get some credit for getting the patch
> > >> +merged. Also some blame if there are problems.

> > > Maybe we should mention the Tested-by: tag explicitly here as well.

> > I'm not sure how we interpret Tested-by when deciding to merge; does it
> > mean someone is happy for the test to be merged or not?

> > Should someone add both tags if they have reviewed and tested it?

> Tested-by: means that someone actually tried the test and that it did
> what it was supposed to do. This has obvious meaning for reproducers,
> and yes for a reproducer you can add both tags and both are meaningful.

> For regular tests Tested-by does not have that much value I guess.

I rarely add Tested-by, usually for non-intel architecture or something
which was non-trivial for me to test.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
