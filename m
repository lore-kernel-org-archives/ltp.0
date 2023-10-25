Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4471BC0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B0883CCBD8
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:40:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568E23CBE8F
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:39:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A06BA10028B0
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:39:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 29B7421D47;
 Wed, 25 Oct 2023 07:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698219594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VoxxzRe3FFwFbpbGhgra4GJ5nJDKJ2X6rngsjLJoX98=;
 b=NGgqlhPBk7OGT2Vr0bG1gIJTTkiE6LfU5evVIGeH5rgMaLU3ukwd90l9SQLOkoJB2Zh0mM
 AFqT5UFNTkkc69Rt2mFVJH0oLLxNDHpbMWM1m8nPmphJbK8EAD0S6aMn8Kw2O1INWuvk9I
 avWCOdKRo1LVlh+Zsez2ukBkMfOBjUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698219594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VoxxzRe3FFwFbpbGhgra4GJ5nJDKJ2X6rngsjLJoX98=;
 b=KGGY2ASnylNTKQORTisUuK6zgjnAncCrop6sxoTnYNsJe+puEQeA7t/v5SdFRmzjS6XRMF
 Fu/1ZwP4LqPD6oCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D35B5138E9;
 Wed, 25 Oct 2023 07:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3rOZMEnGOGWNYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 07:39:53 +0000
Date: Wed, 25 Oct 2023 09:39:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231025073952.GA286089@pevik>
References: <20231024201135.264768-1-pvorel@suse.cz>
 <20231024201135.264768-2-pvorel@suse.cz> <8734xzuq4g.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8734xzuq4g.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-10.20 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.90)[99.56%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> > +++ b/configure.ac
> > @@ -67,6 +67,7 @@ AC_CHECK_HEADERS_ONCE([ \
> >      linux/tls.h \
> >      linux/tty.h \
> >      linux/types.h \
> > +    linux/uinput.h \

> Do we use this?
Yes, see below.

> >      linux/userfaultfd.h \
> >      netinet/sctp.h \
> >      pthread.h \
> > diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
> > new file mode 100644
> > index 000000000..bdd6f466f
> > --- /dev/null
> > +++ b/include/lapi/uinput.h
> > @@ -0,0 +1,15 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> > + */
> > +
> > +#ifndef LAPI_UINPUT_H__
> > +#define LAPI_UINPUT_H__
> > +
> > +#include <linux/uinput.h>
Here. We have policy, that we first load the header and then check for a
fallback.

Kind regards,
Petr

> > +
> > +#ifndef UI_GET_SYSNAME
> > +# define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
> > +#endif
> > +
> > +#endif	/* LAPI_UINPUT_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
