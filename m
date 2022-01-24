Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E12C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 17:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B76EC3C93BA
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 18:18:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4B33C6F6F
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:18:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 79424100044C
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 18:18:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6183D1F380;
 Mon, 24 Jan 2022 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643044718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hb8TecJYNCjMEBrGknvQsJHM82ncykmciR7r7/sNRiE=;
 b=BCL7ABFoy9VwDaqhDgXFQ5DBAKzFNQWioFlsl9LktdutJnvDHW8LZ2wmfCx/MBPSR4Do6c
 dGtlvVG58/lt+NSnWXwQXpnrr8MQVSzGyvAdXme0cZSQGuGeMBIDBQ7QIEamYEgilGCCdb
 6PPfoWl57+hKQNbcGI+zrH/D9JNW/4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643044718;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hb8TecJYNCjMEBrGknvQsJHM82ncykmciR7r7/sNRiE=;
 b=vzZLk2fCv+9HL/gTOz648ZhBeDSHZLAIdgaSwob2HLsp9PY2tuqWcXl3zDZkGT+RMkXD2C
 ax9ffyWdbBy80gAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A26213C41;
 Mon, 24 Jan 2022 17:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RZLzEG7f7mGaWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 17:18:38 +0000
Date: Mon, 24 Jan 2022 18:18:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ye7fbKjqzR0Vf3J+@pevik>
References: <20211208082625.26324-1-pvorel@suse.cz>
 <Ye7CwmegfyHXgN2N@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye7CwmegfyHXgN2N@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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

Hi Cyril,

thx for looking into this.

> Hi!
> > diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
> > index 5d729a33d..580df00a3 100644
> > --- a/m4/ltp-eventfd.m4
> > +++ b/m4/ltp-eventfd.m4
> > @@ -12,12 +12,10 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
> >  		AC_SUBST(AIO_LIBS, "-laio")

> >  		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
> > -		AC_TRY_LINK([#include <stdio.h>
> > +		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdio.h>
> >                               #include <libaio.h>
> > -		            ],
> > -		            [io_set_eventfd(NULL, 0); return 0;],
> > +		            ]], [[io_set_eventfd(NULL, 0); return 0;]])],
> >  		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
> > -						AC_MSG_RESULT(yes)],
> > -		            [AC_MSG_RESULT(no)])
> > +						AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])

> Shouldn't we convert this bit into AC_CHECK_FUNCS() (in a separte patch)?
Ah, thx for catching this.

> > +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <unistd.h>
> > +		#include <linux/perf_event.h>]], [[
> >  			struct perf_event_attr pe;
> > -		],
> > -		AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> > +		]])],[AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])

> And this one with AC_CHECK_TYPES()?
+1

> > -AC_TRY_LINK([#define _GNU_SOURCE
> > -             #include <math.h>],
> > -            [
> > +AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
> > +             #include <math.h>]], [[
> >               volatile float val;
> >               exp10(val);
> > -            ],
> > -             AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> > +            ]])],[AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> >  LIBS="$backup_ldlibs"
> >  ])

> Similarily here AC_CHECK_FUNCS()?
+1

I'll recheck all of AC_LINK_IFELSE, AC_COMPILE_IFELSE before posting next
version.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
