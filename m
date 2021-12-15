Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A74C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAF2F3C8E3B
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 11:52:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7133C8DD6
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 11:52:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C1AE1401113
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 11:52:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A380A2112B;
 Wed, 15 Dec 2021 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639565557;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0nNNSMWab9WQmD1HAMKbLXhqPQZ4oiNv0hJCgB3xi0=;
 b=PacL6TTNF8b18LdcPkAYP0MM+PhQr2SXDxZKM7tLprRUdi6WECwhJja3/l3E1dJlfrGzpJ
 woUxH+JUu6C4SVPPXnaZZTIG7AeMcAiEsE63A/n7sO10gLrRdujLaScCyUwe9QaPTzyLtJ
 RMBNvHnEwUWQX4Ff7jdx2Mx5dgUD9vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639565557;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n0nNNSMWab9WQmD1HAMKbLXhqPQZ4oiNv0hJCgB3xi0=;
 b=DnLOViU2cKr/NDyBhx+X1sXMyAUk1loV8SPZPE3Xj8xwUasQOmXsTfhVkyN6yb6jcS8+2A
 yw1rX6YfzADyj8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BDBB13B1C;
 Wed, 15 Dec 2021 10:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qjGyFPXIuWFEfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 10:52:37 +0000
Date: Wed, 15 Dec 2021 11:52:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YbnI83sr26q+naFd@pevik>
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
 <87lf0oaeui.fsf@suse.de> <Ybc5QJSZM3YIji70@yuki>
 <87h7bca7vu.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h7bca7vu.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: pvorel@suze.cz, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, all,

> Hello,

> Cyril Hrubis <chrubis@suse.cz> writes:

> > Hi!
> >> >>> The issue is we may forget to merge patch sets for features which are
> >> >>> included (a far worse result). It's more stuff waiting around in the
> >> >>> queue. At the least we should have a procedure for tracking them (like
> >> >>> tagging github issues for review at each mainline release).

> >> >>> If a test requires a kernel config which doesn't exist in mainline we
> >> >>> could also look for that automatically.

> >> >> The main issue is that if we happen to release LTP meanwhile with a test
> >> >> for a syscall that didn't get included in the mainline in the end we
> >> >> have released LTP that is supposed to be stable and the test will start
> >> >> to fail when the syscall number is allocated for something else which
> >> >> will happen sooner or later.
> >> > I know a example that is quotactl_path syscall.


> >> If the real issue is LTP releases, then why not exclude tests for new
> >> features from them? I assume it's only a small number of commits which
> >> would need to be removed. Possibly we could tag them in git when merging
> >> so it is not a lot more work for whoever does the release (namely
> >> Cyril) to create a branch without them.

> > That sounds too complex for a test or two we are usually getting during
> > the release cycle.

> > Note that people who contribute the functionality to the kernel are used
> > to wait for next release window, kernel releases are aprox. twice as
> > fast as LTP.

> >> My main concern is this will throw up a barrier to motivated
> >> contributors working on the cutting edge.

> > So far really nobody complained, which may not be a good metric. But
> > still unless there is a evidence that this happens I wouldn't consider
> > spending effort on this.

> OK, well if it comes up again we can revisit it. However Petr please
> could you add the reasoning about not adding unstable tests into
> releases.
Isn't "... because it can be reverted in later rc if problematic" enough?
If not what would you add? Cyril posted test getting released in LTP and later
unstable. I could be more verbose, but not sure if that's better:

* Tests for new functionality in mainline kernel should be merged after final
  release of kernel which contains that functionality. It's not enough when the
  feature gets into rc1, because in later rc the functionality can be changed or
  even reverted if problematic. And this could lead to broken test.

> With that you can add

> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
