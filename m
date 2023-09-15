Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F44EED61A
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 18:22:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00D13CE6BB
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 20:22:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942003CB154
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 20:22:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B1CA10011B5
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 20:22:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3B111F88E;
 Fri, 15 Sep 2023 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694802143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8cvvGjI95Mj7eHpN7zshFimmJH/8XoUQpD2u7lAeRKs=;
 b=nQSKrhQ/mSpOP78IMk5hfVsy3j+GDqfJugL42rxeF6sf8rjeReXLCVwGdyso9UXGpGp4YV
 FSqDu+t0Fl3Eu5PYAIHC5+F7zzJ077Slv3bWFd1CAfAY3zxzurt6wK1L4NGE9TO5IcTIUT
 CNb7Is9S6QbqpERsAqlTyQ7GOQeslyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694802143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8cvvGjI95Mj7eHpN7zshFimmJH/8XoUQpD2u7lAeRKs=;
 b=7hdRLuIJNZmuVyDnUbS3nhBi2eacdnrBH0vPofK9x0WH7BMlnQw1jiXyAFM5VpUvPvWz1r
 1mJQ17hD5nsCeFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0411B1358A;
 Fri, 15 Sep 2023 18:22:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sYohNN6gBGXpZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 18:22:22 +0000
Date: Fri, 15 Sep 2023 20:22:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230915182220.GA92584@pevik>
References: <20230915144156.22380-1-andrea.cervesato@suse.de>
 <20230915144156.22380-3-andrea.cervesato@suse.de>
 <20230915152910.GB73280@pevik> <20230915154135.GA11318@pevik>
 <ZQSJThJZLuAuxaMT@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQSJThJZLuAuxaMT@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add Linux Test eXecutor inside tools
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
> > This is breaking build:

> > 2023-09-15T13:47:12.1128844Z make -C ltx
> > 2023-09-15T13:47:12.1148029Z make[3]: *** No targets specified and no makefile found.  Stop.
> > 2023-09-15T13:47:12.1153175Z make[2]: *** [/__w/ltp/ltp/tools/ltx/Makefile:13: all] Error 2
> > 2023-09-15T13:47:12.1159251Z make[1]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> > 2023-09-15T13:47:12.1163512Z make[1]: Leaving directory '/__w/ltp/ltp/tools'
> > 2023-09-15T13:47:12.1169815Z make: *** [Makefile:94: tools-all] Error 2

> I suppose that we need

> > Reproduce with simple:
> > $ cd tools && make -C ltx

> > The problem is because there is no tools/ltx/Makefile

> Huh? I did apply the two patches and I do have tools/ltx/Makefile

I'm sorry, I was wrong, of course tools/ltx/Makefile is there,
there is another make error.

> And actually there is a minor problem there, without the submodules
> checked out I get:

> CC ltx
> gcc: fatal error: no input files
> compilation terminated.
> make: *** [Makefile:21: ltx] Error 1

> So I guess that we need:

> diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
> index 0fbf7cfd9..43ed93c6b 100644
> --- a/tools/ltx/Makefile
> +++ b/tools/ltx/Makefile
> @@ -7,6 +7,8 @@ top_srcdir              ?= ../..

>  include $(top_srcdir)/include/mk/env_pre.mk

> +ifneq ($(wildcard $(abs_srcdir/ltx-src/*)),)
> +
>  BINARY=ltx

>  MAKE_TARGETS := $(BINARY)
> @@ -23,4 +25,6 @@ endif

>  INSTALL_DIR := $(prefix)

> +endif
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

+1

> > Why are the sources in tools/ltx/ltx-src instead of tools/ltx anyway?

> Because if there is a directory with the name ltx it horribly confused
> Make.

Thx for info!

> > I guess you used sparse approach, which is not necessary here.

> I'm not sure that we can do things simpler, the Makefile in the ltx git
> repository does not support out of tree build, so unless we remove that
> from LTP this is probably the easiest solution.

Your solution looks OK to me. I guess we could merge it on Monday.

Kind regards,
Petr

> > I'm ok with that if it makes things simpler, but please include the required
> > Makefile.

> It is there.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
