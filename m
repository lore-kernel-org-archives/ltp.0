Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51968C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:54:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00E33CCBC2
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:54:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35C143CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:54:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9E81F1A0C253
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:54:04 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 36D4C1FF26;
 Wed, 25 Oct 2023 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698220443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGLZuTNLxTjCF3p0AMdQ2plrF6OxzNG3spKSVk13AHw=;
 b=dzh/Id+1o/El06p5N6BwidxIi8em74uMkhwF5QgZskoobSGabyOQQY4mJ4t1eouuA37yir
 bJBBownPMpEuOfjvGPhPCA/IuYFk1PgGRR0bP+lFKs1ZxAqhcD6cGRQNB/xZzK2RurFipc
 opsm4P/Xoc/ZoDQgiwrF3Vw8STTKooA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698220443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kGLZuTNLxTjCF3p0AMdQ2plrF6OxzNG3spKSVk13AHw=;
 b=8oFiwgC0HKaAaiYMIM5HPttTMmhKgAtUWuO86lm7qz3uJPW1fi6IHIgwvLO07kCwxqHqcF
 fNxHtgqoNH/cWZBg==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 98D272C355;
 Wed, 25 Oct 2023 07:54:02 +0000 (UTC)
References: <20231024201135.264768-1-pvorel@suse.cz>
 <20231024201135.264768-2-pvorel@suse.cz> <8734xzuq4g.fsf@suse.de>
 <20231025073952.GA286089@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Oct 2023 08:52:18 +0100
Organization: Linux Private Site
In-reply-to: <20231025073952.GA286089@pevik>
Message-ID: <87y1frt9wn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi: Add uinput.h
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> > +++ b/configure.ac
>> > @@ -67,6 +67,7 @@ AC_CHECK_HEADERS_ONCE([ \
>> >      linux/tls.h \
>> >      linux/tty.h \
>> >      linux/types.h \
>> > +    linux/uinput.h \
>
>> Do we use this?
> Yes, see below.
>
>> >      linux/userfaultfd.h \
>> >      netinet/sctp.h \
>> >      pthread.h \
>> > diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
>> > new file mode 100644
>> > index 000000000..bdd6f466f
>> > --- /dev/null
>> > +++ b/include/lapi/uinput.h
>> > @@ -0,0 +1,15 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +/*
>> > + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
>> > + */
>> > +
>> > +#ifndef LAPI_UINPUT_H__
>> > +#define LAPI_UINPUT_H__
>> > +
>> > +#include <linux/uinput.h>
> Here. We have policy, that we first load the header and then check for a
> fallback.

But we don't check if the header exists with HAVE_LINUX_UINPUT_H before
loading it?

>
> Kind regards,
> Petr
>
>> > +
>> > +#ifndef UI_GET_SYSNAME
>> > +# define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
>> > +#endif
>> > +
>> > +#endif	/* LAPI_UINPUT_H__ */


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
