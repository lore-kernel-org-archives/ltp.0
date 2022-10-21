Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2AFC4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:12:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF7213CB250
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 15:12:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE8923C062C
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 15:12:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CC1C200139
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 15:12:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DABC62252C;
 Fri, 21 Oct 2022 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666357921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFzAi095BjtfflujxchKrsGF4uDDX9244JHB590G2D4=;
 b=i6on9mI2Sb3bIv9pVGJQfIiUqxW8JZ3P3tl/2Y951+61uHBIunYJrakdzFLlGCc7MJw0nA
 IKjZQrxvd7MoAcCFBzSNPLryjBWI0xBs8TTv3uhBPI1ekAx9RDRE003XulsRT/xS80WJPm
 /VOuthacaSIRBXnZW7PNbU8/kyAmd0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666357921;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFzAi095BjtfflujxchKrsGF4uDDX9244JHB590G2D4=;
 b=GM7pCXKZbiHOt13MLv7ax0Bfx3Py38Cpxb+NsGbgr7rqSJkzQgYxhk4LRovqUyJ3EIa1rT
 drAyac35aw0bUUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 842841331A;
 Fri, 21 Oct 2022 13:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EmwcHqGaUmOpeAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 13:12:01 +0000
Date: Fri, 21 Oct 2022 15:11:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y1KanyaTySzBG7xN@pevik>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik> <Y1JiQSWlxVSkhuoq@yuki>
 <Y1KBzfdqbibHmAa3@pevik> <Y1KTyn/9pv5lvbhj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1KTyn/9pv5lvbhj@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > > > index 28b7d12ba..5ebbe1d25 100644
> > > > > --- a/testcases/lib/tst_test.sh
> > > > > +++ b/testcases/lib/tst_test.sh
> > > > > @@ -831,3 +831,5 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> > > > >  		fi
> > > > >  	fi
> > > > >  fi
> > > > > +
> > > > > +export LC_ALL=C

> > > > Thinking about it twice this might have impact on other tests.
> > > > Li, Cyril, any idea about it?

> > > Actually I think that we should have put this into the tst_test.sh from
> > > the start. We do have this as a workaround in du01.sh and telnet01.sh
> > > already.

> > > The plus side is that all possible bugreports from users will have all
> > > messages in english which would make debugging easier.

> > Thanks for acking this.

> > I suppose Akihiko is correct that we don't have to put it via setlocale()
> > in C API, right?

> I do not think so. It's not entirely clear from documentation how this
> is supposed to work. However it seems that in bash the effect is
> immediate, if you export new locale and then type nonexisting command
> name to bash prompt to get a message from bash it's in the new locale.
> So either setlocale() is not needed or bash calls it if it detects that
> one of the LC_ variables has been changed and calls it.

> For dash it does not seem that it has been translated at all, it
> produces messages in english either way, so we do not have to care.

> And all localized programs that we start from the shell after the export
> do call setlocale() at the start of the main(). That is actually
> required to enable locale support to begin with.

Yep. I thought more about pure C API programs. Mostly they don't have any locale
related code, but sometimes they call other programs via shell (e.g.
tst_system(), but there are more).

I also aimed for consistency between C and shell API.
That's why I thought we should consider setlocale() on LC_ALL and LANG in
lib/tst_test.c. But maybe I'm wrong.

> > Also I guess you prefer this version (LC_ALL=C). I suggested unset LC_ALL;
> > export LC_COLLATE=C; export LC_NUMERIC=C as it's used in kernel's Makefile (they
> > have more there, but IMHO only this is relevant for us).

> I do not think that LC_COLLATE and LC_NUMERIC is enough, we want actuall
> messages in english. If we do not want to use LC_ALL, which is probably
> the easiest we should use at least LC_MESSAGES and LC_NUMERIC but
> possibly LC_TIME too since date and time can be part of the messages we
> do parse as well.
After some searching and thinking I guess LC_ALL=C and LANG=C should be enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
