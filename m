Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61F2C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 17:53:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 381893C9226
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 18:53:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CFC53C8E4D
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 18:53:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A27E200C1F
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 18:53:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 305731F388;
 Mon, 20 Dec 2021 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640022798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRRvN6gt2OPH29ucFfDNMT0sgFAw37FKX4OLlALZjP4=;
 b=hqN9Mc3yzHqmbjttkDKOk9Fvq8/CUgF/erGETrmNDvl14RAqzqI7GWc2aBZd+e6Lx/jGSn
 5PjYMxeMbjhbZkxcDjvxg5OF3lfajkW+U9CzydvKsUhqTlj5zRb/0Hfqg4+rAkUcLWUwNb
 7tG6GgEx6GrP2hyAstduQz+lZHnH0vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640022798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRRvN6gt2OPH29ucFfDNMT0sgFAw37FKX4OLlALZjP4=;
 b=CCN08f1mA6HoczIOVUa9UCBINxtF+jcj7sGuYR/yjow3TXVT/PNjlh+f3sJ+qxXQteBRiI
 QHowKYksCJ6cLLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9C1313D6B;
 Mon, 20 Dec 2021 17:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 88kzNg3DwGGVdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 17:53:17 +0000
Date: Mon, 20 Dec 2021 18:53:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YcDDDMtpKZQ8+tAa@pevik>
References: <87tufcao8l.fsf@suse.de> <YbcM8xKx7G0KQxWU@yuki>
 <61B70DE2.4040402@fujitsu.com> <87lf0oaeui.fsf@suse.de>
 <Ybc5QJSZM3YIji70@yuki> <87h7bca7vu.fsf@suse.de>
 <YbnI83sr26q+naFd@pevik> <874k7a9j5p.fsf@suse.de>
 <YboX0x4X05tMmUkE@pevik> <87lf0ffw1y.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lf0ffw1y.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/maintainer: Add policy for new
 functionality
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Cyril,

<snip>
> > Thus, first, do you agree with current policy?

> Yes. Although we could add "next" and "rc" flags to tst_test (or
> similar). Then require an environment variable to be set (or check the
> kernel version) otherwise the test will return TCONF.

> For LTP releases we just need to check if the flags are still needed or
> if the feature has been merged. The metadata parser can generate a list
> of tests to check.

> This seems like quite little work to me. In fact we don't even have to
> implement it until someone wants it. We can just add it to the policy.

Yes, adding flag would work.

> > If yes, how would you phrase it (do you want to add / change
> > anything)?

> Something like:

> "Tests for new functionality should only be added to the LTP once they
> are part of the stable kernel ABI. This happens when a feature is
> included in a final kernel release. Not during the RC phase where they
> can still be removed and, for example, the syscall numbers reused.

> This allows stable LTP releases to be taken directly from Git HEAD at
> any time we are ready. Without needing to remove commits for unstable
> feature tests or synchronise with the kernel releases.

> Alternatively if someone is very motivated to add tests for linux-next
> or the RC phase. We can add flags to tst_test which will prevent these
> tests being run under normal circumstances. Meaning the releases are
> unaffected."

OK, we document our willingness to add infrastructure for merging in rc,
if desired. I'm ok with this, if Cyril agree, I can send v2 for others to
ack/review it.

> > Or do you suggest to have policy when merged to rc1?
> > It would work for me, but we'd have to ask all maintainers
> > (I suggested that before, Cyril preferred kernel release).

> I'd happily accept tests for things going into linux-next if there are
> people willing to write them and they do not "throw them over the
> wall and run".

IMHO it's up to us whether we want to implement. I know just about few tests in
last 2 years - fanotify and IMA subsystems which has brought tests and they just
accepted our decision when we're going to merge it. People are happy that we
help them in tests, nobody haven't felt being put off by merging later.


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
