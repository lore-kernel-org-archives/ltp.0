Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7D3EB64DC
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 12:52:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 164793C99A5
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 14:51:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D56933C99A5
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 14:51:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 955BB600990
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 14:51:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1F5321864;
 Wed, 28 Jun 2023 12:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687956705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7/yLRTRZnUDnz6VI/fsrQmcgBR+bb9Z3xzueUGJ4wo=;
 b=C2YfpkoLD/uOYwgOkI/NEKXspOZZwDZvvQd+7GELSP5o8mb+Da2JZDDBgNDJnYM0Mh6LzJ
 9nZHyhezHf1ON0KKFU/dBzaESFf0M9zXvmJha8ehW05NPidPWM1BTcjgKMKrlZ98cBMYh9
 2doML6cF9r9B/A4hzvUIdTuV1o4XHr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687956705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7/yLRTRZnUDnz6VI/fsrQmcgBR+bb9Z3xzueUGJ4wo=;
 b=ZgyqCmSvsa+c/cQ2WfUoIwR2J1NjFbf4NjerPC7V8HYRw1iLfIzETxDQLU1I2BrYbrF3vd
 0Arl4JGWgx/URWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CC8E138E8;
 Wed, 28 Jun 2023 12:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TdjmJOEsnGQkagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 12:51:45 +0000
Date: Wed, 28 Jun 2023 14:51:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230628125144.GA147674@pevik>
References: <20230628081831.123189-1-pvorel@suse.cz>
 <20230628081831.123189-2-pvorel@suse.cz> <ZJwb_wxDrqIlNqfg@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJwb_wxDrqIlNqfg@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/fcntl.h: Fix O_DIRECT definition for
 various archs
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
Cc: NeilBrown <neilb@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > O_DIRECT definitions differ a lot depending on architecture.
> > Because this can lead to problems (e.g. the generic value O_DIRECT
> > 040000 is O_DIRECTORY on powerpc, address that in lapi file.

> > NOTE: Deliberately use correct definitions also on less common archs
> > (maybe LTP even cannot be compiled on m68k or mips, but better to be
> > safe then sorry).  But the problem would IMHO be avoided if the fallback
> > O_DIRECT definition would be removed everywhere and tests just define
> > _GNU_SOURCE (no library code is using O_DIRECT atm).

> > Reported-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  include/lapi/fcntl.h | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)

> > diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> > index 848ac7865..27da9f076 100644
> > --- a/include/lapi/fcntl.h
> > +++ b/include/lapi/fcntl.h
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> > + * Copyright (c) Linux Test Project, 2014-2023
> >   */

> >  #ifndef LAPI_FCNTL_H__
> > @@ -11,7 +12,15 @@
> >  #include <sys/socket.h>

> >  #ifndef O_DIRECT
> > -# define O_DIRECT 040000
> > +# if defined(__mips__)
> > +#  define O_DIRECT 0100000
> > +# elif defined(__arm__) || defined(__aarch64__) || defined(__m68k__)
> > +#  define O_DIRECT 0200000
> > +# elif defined(__powerpc__) || defined(__powerpc64__)
> > +#  define O_DIRECT 0400000
> > +# else
> > +#  define O_DIRECT 040000
> > +# endif
> >  #endif

> I do not think that we should default to any value here, just do

> #error Define O_DIRECT for your architecture

> However I think that actually removing the O_DIRECT fallback and adding
> _GNU_SOURCE to tests that use O_DIRECT is more future proof solution.
> There is about 70 tests that use O_DIRECT and many of them define
> _GNU_SOURCE already.

I have no problem to remove O_DIRECT. The only question is what to do if we need
it in the library one day. Will we be ok that whole LTP becaume _GNU_SOURCE due
that?

> Actually I tried to remove the fallback from lapi/fcntl.h and recompiled
> LTP without any change, which is strange. Does that work for you as
> well?

I'm verifying it [1] in a patch, where I only defined _GNU_SOURCE in
testcases/kernel/fs/scsi/ltpscsi/scsimain.c and
testcases/kernel/fs/fsstress/global.h.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/5401264765

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
