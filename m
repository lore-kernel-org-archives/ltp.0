Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E52EC433FE
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 13:06:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874323CA067
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 15:06:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD0723C1BBA
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 15:05:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2CAA2009EF
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 15:05:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F17A52160F;
 Thu, 31 Mar 2022 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648731947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zWbaq2kMTpB0ejulwnBKbyAiRc2wZC2l3g5Y714p908=;
 b=Rj699r7TZ3kmySRpAoO604F8EpbXIg2ditLbWZEgajPfz39AtZEPUgrs5MrAnHchKsinl2
 48YH48hYspM09J/GWDFJyvpKdRBz6AJVqI4ssoM7OBKsQEy7qXDNNp5VM9PLMd6gBgvmCm
 6kdw+wmUxaQiNMgAx2sLdTxDuYr4dV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648731947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zWbaq2kMTpB0ejulwnBKbyAiRc2wZC2l3g5Y714p908=;
 b=r6uLeSA+Shg1clPnXVcwfZ8JYX6u9u5oxGtSTq8FgKQcGHqUVBj+flOSUKWHUMZFkBEHCN
 59DU1yGtsxHE6sBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD307133D4;
 Thu, 31 Mar 2022 13:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q+lJNSunRWJcLAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 31 Mar 2022 13:05:47 +0000
Date: Thu, 31 Mar 2022 15:08:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YkWnuA2a+QRQpc5R@yuki>
References: <20220310105533.3012-1-chrubis@suse.cz> <YinZzNWCiKalyWhd@yuki>
 <87ee2vclsf.fsf@suse.de>
 <c9f5b441-2f3f-f2c3-2c3c-32dd3f9595ae@suse.cz>
 <8735iyl7z8.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8735iyl7z8.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/waitid10: Fix on ARM,
 PPC and possibly others
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
> >> I'm wondering if we should branch on the architecture. If it's x86[_64]
> >> then we only do divide by zero as it's reasonable to think that if the
> >> signal is not raised then this is a bug.
> >
> > It's more likely to be a hardware bug/missing feature though. Do we
> > really care? I'd argue that removing the division altogether and just
> > calling raise(SIGFPE) in the child process is all we need in this
> > particular test.
> 
> I suppose it depends on if there is a substantial difference in how the
> signal is raised between div by zero and raise. I guess there is some
> configuration to trap the faulting instruction and raise a
> signal.

I guess that in the case of division by zero we end up in the kernel
interrupt handler where the kernel looks up the process that was running
when the interrupt has raised then it queues the signal delivery and so
on.

In the case of raise() we just do sysenter instruction which triggers
different interrupt handler and the rest would be the same we queue the
signal and so on.

Which is why I think that there is some value in triggering the divison
by zero on architectures that enable it by default because we execute
kernel interrupt handler that is rarely being executed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
