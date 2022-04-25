Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355E3C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 11:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CC8F3C8122
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 13:10:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33F0E3C0FED
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:09:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4853D140012D
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:09:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FCFE1F74A;
 Mon, 25 Apr 2022 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650884989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPuIcOh1l1dzqm0aEUBUInfo+sM4QYAFMiZkInn/3/s=;
 b=DKoPAuJ7UkL6O3lRGec56yb7J8wGN8+sCkJmbf2daK/KWYUfCEBCm8YJvA9ky/F3ZYkX8f
 /AReFBrduF77i10rj5/K6QF+1skXbw6X4pJZFoY+fmei4NRED4Kgt7zp5lgDHA67f5eHPN
 4cApDNoKCWXncFpfQ+ivd14JLDfm54g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650884989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPuIcOh1l1dzqm0aEUBUInfo+sM4QYAFMiZkInn/3/s=;
 b=MuLrJ32FrM4fEBoWstNh3JN/VFbk54nK1fYVPuqDlKM3+tCDGmR4At2XQ6x6/k+5YaNuSA
 ODwrqXV5xxV45pCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5683D13AED;
 Mon, 25 Apr 2022 11:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GlrfFH2BZmIqSAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Apr 2022 11:09:49 +0000
Date: Mon, 25 Apr 2022 13:09:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Message-ID: <YmaBfMmDa4O/Lc2N@pevik>
References: <20220425092118.21619-1-rpalethorpe@suse.com>
 <YmZrVzxghAnmxIud@rei> <YmaBJM8piHx4Juay@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmaBJM8piHx4Juay@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sighold02: Fix muslc builds by removing __SIGRTMIN
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

> Hi all,

> > Hi!
> > > The minimum real-time signal is always 32 according to
> > > signal(7). Meanwhile __SIGRTMIN is not defined in all lib C
> > > implementations.

> > > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > > ---
> > >  testcases/kernel/syscalls/sighold/sighold02.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)

> > > diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
> > > index daa86192e..1cfb7688b 100644
> > > --- a/testcases/kernel/syscalls/sighold/sighold02.c
> > > +++ b/testcases/kernel/syscalls/sighold/sighold02.c
> > > @@ -33,7 +33,7 @@ static int sigs_map[NUMSIGS];

> > >  static int skip_sig(int sig)
> > >  {
> > > -	if (sig >= __SIGRTMIN && sig < SIGRTMIN)
> > > +	if (sig >= 32 && sig < SIGRTMIN)
> > >  		return 1;

> > Looks like __SIGRTMIN is defined to 32 for all architectures glibc
> > supports, so this should be pretty much safe.

> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Well, we have __SIGRTMIN 32 fallback definition in include/lapi/signal.h,
> we use it in few tests. It was used in old variant, but you removed it during
> rewrite in 38e69985cb2707a056f9c86a90c8570c721e6a7d.

> BTW I looked whether we could use SIGRTMIN instead of underscore variants,
> I suppose we can't (looks like SIGRTMIN is 32 + something):

Ah, looking at the code "if (sig >= __SIGRTMIN && sig < SIGRTMIN)",
we need both underscore and non-underscore.

Let's go back to use lapi again.

Kind regards,
Petr

> musl:
> #define SIGRTMIN  (__libc_current_sigrtmin())
> src/signal/sigrtmin.c
> #include <signal.h>
> int __libc_current_sigrtmin()
> {
>     return 35;
> }

> glibc:
> static int current_rtmin = __SIGRTMIN + RESERVED_SIGRT;
> (current_rtmin is used in __libc_current_sigrtmin(), RESERVED_SIGRT is defined 0 and 2)

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
