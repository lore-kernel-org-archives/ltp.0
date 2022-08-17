Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EF2C25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 09:12:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B39543C9DDE
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 11:12:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19E553C9850
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:12:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 749FF2001CE
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 11:12:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BC9034ADD;
 Wed, 17 Aug 2022 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660727563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jkympDtEYtAgCyWR29fJ8pl1c6MvljP9irb6KMuhjkY=;
 b=NRb//t2e5cBzZi4oAPoGfL+5VrBB0M7FYDSWAegt1+DKLvxMKFAHzloOW9pashyrth2nsK
 enFSmFg8W9lzflF/oOjKO5eWWads8w/gAPF/wzHg7S4+pyNLIA1lakj9WWKqYJhveDTVUl
 1AN/kpu+iTNdJpkTPVDGBBozp7lmtbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660727563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jkympDtEYtAgCyWR29fJ8pl1c6MvljP9irb6KMuhjkY=;
 b=JJbumVLQrxbveJZ1+IFWY/JUGPYos21BU9eQY/borCdXVIxgPnDX2cLb+EbNU/gIDW26qG
 Roy0ptIELxSo3DCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59E2413A8E;
 Wed, 17 Aug 2022 09:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bS5wFAux/GIWaAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 Aug 2022 09:12:43 +0000
Date: Wed, 17 Aug 2022 11:12:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <YvyxCXTGYpLd8kbQ@pevik>
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> We are currently building with clang 14.0.6.  I haven't filed a bug report
> with llvm, will work on doing that.
Thanks for info. I expected it'd be for aarch64 arch, but I can reproduce it on
the same clang version on x86_64 on openSUSE Tumbleweed.

Would you mind we delay merging after you fill the bug in llvm, so that we can
add it to git commit message?

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> On Tue, Aug 16, 2022 at 5:43 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Edward,

> > > Hi!
> > > > I think I finally understand what you mean by this now; it is rather
> > > > strange that the volatility of D does not protect loop from being
> > > > optimized away by the compiler.  I don't have a good explanation as to
> > > > why it's happening but I'm not sure how to evaluate what's going on
> > > > either.  Should I do anything to move this patch forward?

> > > It all boils down if we want to work around something that looks like a
> > > compiler bug in tests or not. I would be inclined not to do so since LTP
> > > was littered with quite a lot of workarounds for glibc/compiler bugs and
> > > we spend quite some time cleaning that mess up. But in this case I can
> > > agree that this is a borderland issue so I'm not strongly against that
> > > either.

> > Edward, which which clang version requires it? It'd be nice to document
> > it, so
> > that it can be removed in the future.
> > Is there any bug report for it?

> > Kind regards,
> > Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
