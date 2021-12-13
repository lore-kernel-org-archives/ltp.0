Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1F8C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 12:13:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4023C898C
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 13:13:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3516B3C892B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 13:13:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8DF7D1A01111
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 13:13:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62564210F9;
 Mon, 13 Dec 2021 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639397612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPavZQz/BheAH3RUu9eBSAg3WRDv/2obqJuf1wzxlaM=;
 b=mCYt4/iP7aPMLEJz2CGs9AG3kmRcHv9jNZMMZyx6nC7eLAsO4GxJjSxaG0w9rNuVKCNj5E
 8M1nsDHkmKwzhZFALIkpjBRSZtuzN3rAjpVMl9fRnsR+o5MVNMXexXheh8WSpMQ1D8zt2p
 N/3loyZhaX9l2ZG5WlNIpMRf6l5UPjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639397612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPavZQz/BheAH3RUu9eBSAg3WRDv/2obqJuf1wzxlaM=;
 b=4I5S2QzYRmejX5D94BXR46YnePRwkWJwBgKNwNrmp9COgjnXH9htBuNxW9wlHi30jYDSnM
 cztDtBsWUPW7tNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 411E613AFF;
 Mon, 13 Dec 2021 12:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lUztDew4t2HdbQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 12:13:32 +0000
Date: Mon, 13 Dec 2021 13:14:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Ybc5QJSZM3YIji70@yuki>
References: <20211210134556.26091-1-pvorel@suse.cz> <87tufcao8l.fsf@suse.de>
 <YbcM8xKx7G0KQxWU@yuki> <61B70DE2.4040402@fujitsu.com>
 <87lf0oaeui.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lf0oaeui.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: pvorel@suze.cz, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >>> The issue is we may forget to merge patch sets for features which are
> >>> included (a far worse result). It's more stuff waiting around in the
> >>> queue. At the least we should have a procedure for tracking them (like
> >>> tagging github issues for review at each mainline release).
> >>>
> >>> If a test requires a kernel config which doesn't exist in mainline we
> >>> could also look for that automatically.
> >>
> >> The main issue is that if we happen to release LTP meanwhile with a test
> >> for a syscall that didn't get included in the mainline in the end we
> >> have released LTP that is supposed to be stable and the test will start
> >> to fail when the syscall number is allocated for something else which
> >> will happen sooner or later.
> > I know a example that is quotactl_path syscall.
> >>
> 
> If the real issue is LTP releases, then why not exclude tests for new
> features from them? I assume it's only a small number of commits which
> would need to be removed. Possibly we could tag them in git when merging
> so it is not a lot more work for whoever does the release (namely
> Cyril) to create a branch without them.

That sounds too complex for a test or two we are usually getting during
the release cycle.

Note that people who contribute the functionality to the kernel are used
to wait for next release window, kernel releases are aprox. twice as
fast as LTP.

> My main concern is this will throw up a barrier to motivated
> contributors working on the cutting edge.

So far really nobody complained, which may not be a good metric. But
still unless there is a evidence that this happens I wouldn't consider
spending effort on this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
