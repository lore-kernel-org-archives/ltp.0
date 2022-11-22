Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA65C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:20:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03E783CCAE2
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:20:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E20D93CCABC
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:19:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 72F8A601402
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:19:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D82E21D45;
 Tue, 22 Nov 2022 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669105188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwqz8/01lq+k1olu0Mcdp78ypO3lcJOwsxMpAHHJ1+Y=;
 b=Pn5k2qZNGZ+pY3G2trppwUNT4d3Lcp189v5jV58GH9BijZ944n8N87m6oPdbwS0KchZ5hH
 5jAU7j0QC6eYRrDSkn1dseHgmoDlPVXSAryCyn+FOnpmlnm4yDOFUX86ip18Y/3v62AtUm
 XR3g9ueqGK8xnCNO89YXBMS623ocQ18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669105188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwqz8/01lq+k1olu0Mcdp78ypO3lcJOwsxMpAHHJ1+Y=;
 b=wjTDDQKdXVO16712H3glG65xtn10pgTv7Tm8ZlWyiRii8M5JSPJsbJ2vRxkYYEjyj1KXWO
 Okjy/0CffEUXMnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AFF413B01;
 Tue, 22 Nov 2022 08:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AZ2xFySGfGOHFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 08:19:48 +0000
Date: Tue, 22 Nov 2022 09:19:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y3yGHec6j0qbBXja@pevik>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3> <Y3tF2XF1xVlOE3fA@pevik>
 <Y3tHYo/iQ6t6D7SR@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3tHYo/iQ6t6D7SR@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Cc: Jan Kara <jack@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > > +#define foreach_path(tc, buf, pname) \
> > > > > +	for (int piter = 0; format_path_check((buf), (tc)->pname##_fmt,	\
> > > > Unfortunately we still support C99 due old compiler on CentOS 7,
> > > > therefore int piter needs to be defined outside of for loop.

> > > Hum, but variable declaration in the for loop is part of C99 standard (as
> > > the error message also says). So did you want to say you are compiling
> > > against C89 standard? And CentOS 7 ships with GCC 4.8.5 AFAICS which should
> > > be fully C99 compliant BTW. So what's the situation here?
> > I'm sorry, I didn't express clearly myself. Yes, 4.8.5 supports C99,
> > but the default is C90 [1].

> > > That being said I can workaround the problem in the macro, it will just be
> > > somewhat uglier. So before doing that I'd like to understand whether
> > > following C89 is really required...

> > I'm don't remember why we have just not specified -std=... already, Cyril had
> > some objections, thus Cc him.

> I think that at the time there stil was even older compiler we had to
> support. I guess that we can add -std=c99 now.

> So I would propose adding -std=c99 into CFLAGS and see if anyone would
> complain.
Ah, I overlooked this reply. Cyril, do you mean top level Makefile?
That's what I'd do (going to test it).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
