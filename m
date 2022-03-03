Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D73C433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 13:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4AF23CA366
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:33:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 208E53C9544
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:33:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8901601B14
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:33:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D59D61F383;
 Thu,  3 Mar 2022 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646314403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fX6snLfA8j2B3+UOFIJ9Ae2a33z/MC4CKVMoieHV6sk=;
 b=m1wmYYag6Cp3++838Tmo2yc08ktBflnVYEm5Ag58J1j5yiEstduqC9b4G1hdRg1tJYrz9g
 6O3srOZb+H9M6RmxtBy9mTR0sgbg0/VGKZDCCuhqjw4W0FQapNRDjDABH5GxMf949JzqG3
 Lxs8+ABeVCBPzW5ZgU1cB0KkIKfAceQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646314403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fX6snLfA8j2B3+UOFIJ9Ae2a33z/MC4CKVMoieHV6sk=;
 b=SbCqMSCrNkN9CZcwrIPsjP6m2wlkuKdgRTjbjn3maFI9evHcxBtMx9PQdBYPHpT3QaCYeN
 zmhy11pqM4y9jmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A425B13C23;
 Thu,  3 Mar 2022 13:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rViLJqPDIGLhXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 13:33:23 +0000
Date: Thu, 3 Mar 2022 14:33:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YiDDoly4t0N30kfo@pevik>
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
 <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f6ka-vK+O33cxw1ewMWDYZQwtRZUQ3eKFMkynqB2+R3w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Create policy for testing unstable kernel features
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > +7 Testing pre-release kernel features
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Tests for features not yet in a mainline kernel release are accepted.
> > However
> > +they must only be added to the +staging+ runtest file. Once a feature is
> > part
> > +of the stable kernel ABI the associated test must be moved out of staging.
> > +
> > +This is primarily to help test kernel RCs by avoiding the need to download
> > +separate LTP patchsets.
> > diff --git a/runtest/staging b/runtest/staging
...

FYI keyctl09 [1] patch is a candidate for merging under this policy.

Cyril wasn't sure [2] that we haven't agreed yet about how this should be
handled. Not sure what exactly is he missing.

I guess the description is quite open to allow testing both tests in next tree
or even in maintainer tree (before endup in next tree). From my point it should
be obvious that not *anything* out of mainline can be added, just tests which
sooner or later endup in mainline (and if not, they should be deleted).

Also procedure after release is pretty clear: just move everything out of
staging to expected runtest files (mostly syscalls).

=> I'd merge this.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20220223200731.1859670-1-yaelt@google.com/
[2] https://lore.kernel.org/ltp/YiC4Pj1sH8UIHY7k@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
