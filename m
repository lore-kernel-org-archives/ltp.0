Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0C2ECAAD5
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 15:55:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A2973CA963
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:55:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6E43C004D
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:54:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA7B31A00E15
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:54:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B5C23336FB;
 Tue,  6 Sep 2022 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662479691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2tptv31JmwScy4DRA6fUoXSRMadwcCObus8z602uWI=;
 b=jGTkOgZdPgaeSwmHjdDpOvVL6zelXUPMTWDK89eJvQhg8pJm7hOlUkb57cDqvg+LM3WbN6
 PpGEcillHUEetGwokIp0k9Rntw7xbNBz3N0/DYqO5UDSeaKl9KIJATTxRS4Oy5M2UTNhwE
 ChOvtNc3Ee6DoPsDXNQzzvTYaafdJaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662479691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E2tptv31JmwScy4DRA6fUoXSRMadwcCObus8z602uWI=;
 b=7fYwvjTm7eGNlrGJVWsd2aI2LN6CUmefRgp97N6N/cSLHEV/4voRgB9nijNNQzLeibYPX9
 BsQcH4nKsRcJvWDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F6D13A19;
 Tue,  6 Sep 2022 15:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SVOJHkttF2OSKAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 15:54:51 +0000
Date: Tue, 6 Sep 2022 17:54:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxdtSXUyX6E5S2Ff@pevik>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-3-pvorel@suse.cz>
 <CAOQ4uxjiAqFJajosfa5pkN-4=iDOWtiYFvNy7EU1Fd1=trRmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjiAqFJajosfa5pkN-4=iDOWtiYFvNy7EU1Fd1=trRmMA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify20: Simplify code
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Sep 6, 2022 at 12:26 PM Petr Vorel <pvorel@suse.cz> wrote:

> > * replace do_test() content with TST_EXP_FD_ERRNO() macro
> > * rename variables (shorten, use LTP common names)
> > * remove tc->want_err (not needed)
> > * add macro FLAGS_DESC (stringify)
> > * don't print number of tests (not needed for just 2 tests)

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Nice cleanup.
> You may add
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks a lot for your time to review.

> however...

> > ---
> >  .../kernel/syscalls/fanotify/fanotify20.c     | 81 +++++--------------
> >  1 file changed, 19 insertions(+), 62 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > index de0fdb782..badc4c369 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> >   * Copyright (c) 2021 Google. All Rights Reserved.
> > + * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> >   *
> >   * Started by Matthew Bobrowski <repnop@google.com>
> >   */
> > @@ -25,26 +26,21 @@
> >  #include "fanotify.h"

> >  #define MOUNT_PATH     "fs_mnt"
> > +#define FLAGS_DESC(x) .flags = x, .desc = #x

> > -static int fanotify_fd;
> > +static int fd;


> What is this change for?
> It makes the code less readable.
> fd is quite an unspecific name for a global variable.
The motivation was: fanotify_fd is quite long and there are quite a lot of long
lines which needs to be split. I also thought that the only file descriptor in
fanotify tests does not have to have "fanotify_" prefix. But sure, No problem, I
merge it without this change.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
