Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D55C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 06:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C3943C96D7
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 07:20:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B73453C8DB2
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 07:19:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05B181A01117
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 07:19:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F14A81F395;
 Fri, 21 Jan 2022 06:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642745989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GVT0EY45laqj80q9o2qTKoEiQFyvDQeBeQRH5CSwp8w=;
 b=pmNqpoDAsusTT6sZBWqpkmwRvEN2pjRBSAnDahNUzL4Ubz6PFuPpcdFIV72LZ3xIwu5eVo
 3T1mkD4Lf2r2f1nNDb0VElggC1kAqoqN+Hf074MupbYul9H0wAJnwHPydj2i5vKuNcuK3G
 0aEDD57zBldxM19jOw6kEg9tnkogXXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642745989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GVT0EY45laqj80q9o2qTKoEiQFyvDQeBeQRH5CSwp8w=;
 b=NG00g2WicZt7VJVlZ6mcUZBJCd9lTBM6YM6cE4szk8iL2a1ShHokEbzE4Yho9pFmpAaRkW
 KmFNVGYply8nYhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C273013345;
 Fri, 21 Jan 2022 06:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nN7+LIVQ6mHmBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 06:19:49 +0000
Date: Fri, 21 Jan 2022 07:19:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Message-ID: <YepQhE/lpb2sGR0B@pevik>
References: <20220120163407.30744-1-kushalkataria5@gmail.com>
 <YenCsGyklP6fAxz2@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YenCsGyklP6fAxz2@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_taint: print readable error message
 instead of numerical codes
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kusal,

...
> >  	if ((taint & taint_mask) != 0)
> > -		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> > +		for (i = 0; i < ARRAY_SIZE(taint_strings); i++)
> > +			if (taint & (1 << i))
> > +				tst_brk(TBROK, "Kernel is already tainted: %s",
> > +					taint_strings[i]);
> The main reason why I just didn't fix the whitespace myself and applied is using
> tst_brk(). It quits test on first matching flag. You can accumulate letters into
> char array and print after loop.

I'm sorry, actually not a char array - I forgot we don't print just the letter,
but string (letter with a description).
You could accumulate string with strcat and print it at the end.
But maybe just use tst_res(TINFO, ...) to print the flag in the loop
and in the end tst_brk(TBROK, "Kernel is already tainted").

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
