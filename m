Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449E6C38145
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 10:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250CF3CA98B
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 12:49:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 668203C02C2
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 12:49:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7AEE5200C69
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 12:49:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 728A721F0A;
 Wed,  7 Sep 2022 10:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662547755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqkWhZ7nGpWSIB6OYa+9jABa3BX9SYaPlzczQFhAHIc=;
 b=XKxoHAPAXTBBmDL5u4/yMsCfV7AXT+yHJGeHHmciUuR//REcXJoZlxU7pYAnlzRy32xMyU
 ZxgMb+lHH1UBDO1UP2PpsZ9a3Ed9695k+1XIZkJ+TW8tOzdNauuMroAR1NICItiRQNu6fH
 SjWGiomUTc8k3azeG6ig4GpMqg6D0Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662547755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqkWhZ7nGpWSIB6OYa+9jABa3BX9SYaPlzczQFhAHIc=;
 b=KfETLKTE4NNg+UGq0SbHueyHTOExw2uE9tgL5JHDeYr0j0AvmhKwmS4/NtgMSO2yr59A1E
 lqnmwykDMLdrI0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4500813A66;
 Wed,  7 Sep 2022 10:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M8YfDyt3GGNXUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 07 Sep 2022 10:49:15 +0000
Date: Wed, 7 Sep 2022 12:49:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <Yxh3Kd0NQRSE5Zk6@pevik>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-3-pvorel@suse.cz>
 <YxhCvWE5AaO/hve2@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxhCvWE5AaO/hve2@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Sep 06, 2022 at 11:26:14AM +0200, Petr Vorel wrote:
> > * replace do_test() content with TST_EXP_FD_ERRNO() macro
> > * rename variables (shorten, use LTP common names)
> > * remove tc->want_err (not needed)
> > * add macro FLAGS_DESC (stringify)
> > * don't print number of tests (not needed for just 2 tests)

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Awesome simplification!

> Reviewed-by: Matthew Bobrowski <repnop@google.com>

Thanks for your review!

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

> >  #define MOUNT_PATH	"fs_mnt"
> > +#define FLAGS_DESC(x) .flags = x, .desc = #x

> I'm wondering whether it makes sense to move this out into fanotify.h,
> so that if the same test approach is ever used, we can simply recycle
> this macro definition.
I'd prefer to keep it now in fanotify20.c as that's the only file where is used.
It will be moved once other files starts to use it.

Kind regards,
Petr

> /M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
