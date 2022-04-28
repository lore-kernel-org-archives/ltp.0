Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E883C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 06:45:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6513CA6CB
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 08:45:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3001B3C8A88
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:45:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C9B3200C62
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:45:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A31F210EE;
 Thu, 28 Apr 2022 06:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651128335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=butXA7lNkSZEx8SIS5sLU2s9wl4OH5cAXQFEju6ZaQM=;
 b=pOIEp8onUq5KP6Jc46AzNH5UuTAF82v77a06RutFh55gsmMSJY5husKdrZmxthIreLaWFD
 uBYb2C8Iy1zKo6dj6IeqzCWPKOSVC8woE/O6aX2bncJYuYh5dv9UGgP+yfWmaXlbSVAFhF
 OgHsYTqm2V5rP48ttgMcMH1D5pxsZ8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651128335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=butXA7lNkSZEx8SIS5sLU2s9wl4OH5cAXQFEju6ZaQM=;
 b=09/NrbJ77Sja+g5wO9o+o97tZ+2nAWB1gJIu8XYoYaw6AKJaL66ojt3KSD5YR1rnFO+f3C
 jisllVhpyKkYBQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36ACF13A8C;
 Thu, 28 Apr 2022 06:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AOWMCw84amJsVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 06:45:35 +0000
Date: Thu, 28 Apr 2022 08:45:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ymo4DRkq4TwmXca0@pevik>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-2-pvorel@suse.cz>
 <12b407ae-c5c9-8d80-9feb-3daf6d116528@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12b407ae-c5c9-8d80-9feb-3daf6d116528@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] busy_poll_lib.sh: Mention setup/cleanup
 defined in tests
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

> Hi,

> On 27. 04. 22 14:49, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > New in v3

> >  testcases/network/busy_poll/busy_poll_lib.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)

> > diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
> > index d17504466..69e590031 100755
> > --- a/testcases/network/busy_poll/busy_poll_lib.sh
> > +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> > @@ -1,10 +1,14 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) Linux Test Project, 2016-2022
> >  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.

> > -TST_SETUP="setup"
> >  TST_TESTFUNC="test"
> > +
> > +# setup and cleanup defined in tests using this library

> Hooking up callbacks on the reverse end of include is some seriously
> dirty code. I'd recommend dropping this patch and then making a separate
> patchset to move those TST_SETUP/TST_CLEANUP variables out of the library.

Hi Martin,

agree, it's bad. I hesitated to have many variables in the library and just
TST_SETUP/TST_CLEANUP out of it. But it's probably a better idea.

Kind regards,
Petr

> > +TST_SETUP="setup"
> >  TST_CLEANUP="cleanup"
> > +
> >  TST_MIN_KVER="3.11"
> >  TST_NEEDS_TMPDIR=1
> >  TST_NEEDS_ROOT=1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
