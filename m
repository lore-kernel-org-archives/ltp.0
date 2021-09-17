Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C84C433F5
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:03:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAEA611CA
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CAEA611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923D63C90EA
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 13:03:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F05A3C1B0A
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 13:03:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58710600A77
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 13:03:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02B0F222E9;
 Fri, 17 Sep 2021 11:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631876583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6a2xWSw3ITAsy3sKdvivJlFWrp/dq1PehXgxF7r0K0=;
 b=1ZhhPRSwaqkaZcHe0n11Y4nzTRbYGy8jCnRZRyPkJABr45UxAI3ffmbTE7UT0uYgE2wZBc
 IRGlSnfS1ZZLJMgYjOfnEDc04WOja3F/Rz3+2OMg3XBuiq1GGoRUoU0ZebDaYsOYQXKkCL
 HoaLWJu/6JeLlDngXm3fxWpiELkwwio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631876583;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6a2xWSw3ITAsy3sKdvivJlFWrp/dq1PehXgxF7r0K0=;
 b=iSPucajPxxoX0+CqHY+l7EP0M6iczIqvGcMSswWEJqSuZqSpQwHPFlpwRGcpUz1QyInNUo
 IiADM4mBmpfNM6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA01114063;
 Fri, 17 Sep 2021 11:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0TZvK+Z1RGFQFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 11:03:02 +0000
Date: Fri, 17 Sep 2021 13:03:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YUR15AMqM4qEYXpV@pevik>
References: <20210519085812.27263-1-liwang@redhat.com> <YUJ2XA7W3JPODyNC@pevik>
 <YUJ7SC/FoA8wTaf2@pevik> <YURW7NKNSSr0J6pL@yuki>
 <YURdMRsvyGRcF77X@pevik> <YURrcrX9RQYIMt4V@pevik>
 <YUR1K7XE3QmTFxT7@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUR1K7XE3QmTFxT7@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: using SIGTERM to terminate process
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox-tech.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917110300.jnu22ARoR39M6wpM7iC-OoqAZweBlynQvojVu7Lo1gc@z>

> Hi!
> > > > I managed to reproduce this in dash. I bet that this is a bug where
> > > > signal handler inside dash is temporarily disabled when we install the
> > > > trap and if we manage to hit that window the signal is discarded. At
> > > > least that is my working theory. After I've installed debug prints, in
> > > > the cases where it hangs the signal was sent just before have installed
> > > > the trap. And in some cases when the signal arrives the timer process is
> > > > killed but the trap is not invoked. So it really looks like signal
> > > > handling in dash is simply broken. Not sure what we can do about bugs
> > > > like this apart from switching to a real programming language.
> > Which version of bash and dash are you testing on?

> > > Thanks for the debugging. *bash* is also affected, at least some releases.
> > > I reproduced it also on some older SLES, with bash 4.4.
> > dash 0.5.11.4 and 5.1.8 on my Tumbleweed laptop are OK.

> > I tested it on various my VM:

> > dash *failing*: 0.5.8 (SLES), 0.5.11.3 (Tumbleweed), 0.5.11+git20200708+dd9ef66-5 (Debian), 0.5.7-4+b1 (Debian)
> > dash *OK*: 0.5.11.2 (SLES 15), 0.5.10.2 (CentOS)

> > bash *failing*: 5.1.4-1.4 (Tumbleweed), 4.4-9.7.1 (SLES 15)
> > bash *ok*: 4.4-17 (SLES 15), 4.3-83 (SLES 12), 4.3-11+deb8u (Debian), 5.1-2+b3
> > (Debian), 4.2.46-34 (CentOS)

> > I have no idea what it causes, whether really some bash and dash versions are
> > buggy or it's reproducible only on certain environment.

> bash 5.1.8 seems to work okay, dash 0.5.11.3-r2 seems to fail here.

> > Any tip what to search for?

> Not really, apart from reading source code and figuring out exactly what
> happens here.

> I guess that we can make things more predictable and easier to read by
> shifting parts of the shell library to a C process.

> For instance if we wrote an utility that would implement all the
> tst_kill_test and timeout process in C we would simplify things greatly.

> Something as:

> tst_timeout_kill

> that would be used as:


> tst_timeout_kill 300 12342
>                   ^    ^
> 		  |    process group leader pid
> 		  timeout in seconds


> That would implement both the loop for killing tests and timeout
> processing as well. That way we would get rid of the trap in the
> subshell and we would end up with a single pid for the whole timeout
> process and avoid the recursive sigkill to begin with.

+1 for this idea instead of never ending story to fix various shells.
Please if you have time, wrote that.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
