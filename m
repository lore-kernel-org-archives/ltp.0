Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23171C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 07:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27ED3CCBF2
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:18:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10DF93CCB57
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:18:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07071600F2D
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 09:18:27 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1AF5121D40;
 Wed, 25 Oct 2023 07:18:26 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 61D552D30D;
 Wed, 25 Oct 2023 07:18:25 +0000 (UTC)
References: <20231024201135.264768-1-pvorel@suse.cz>
 <20231024201135.264768-2-pvorel@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Oct 2023 08:18:07 +0100
Organization: Linux Private Site
In-reply-to: <20231024201135.264768-2-pvorel@suse.cz>
Message-ID: <8734xzuq4g.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.16 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.95)[99.77%]
X-Rspamd-Queue-Id: 1AF5121D40
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

> With the only definition UI_GET_SYSNAME, which was added in kernel 3.15,
> but we 3.10 (CentOS 7).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac          |  1 +
>  include/lapi/uinput.h | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 include/lapi/uinput.h
>
> diff --git a/configure.ac b/configure.ac
> index e40a18fa0..6d3620c57 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -67,6 +67,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      linux/tls.h \
>      linux/tty.h \
>      linux/types.h \
> +    linux/uinput.h \

Do we use this?

>      linux/userfaultfd.h \
>      netinet/sctp.h \
>      pthread.h \
> diff --git a/include/lapi/uinput.h b/include/lapi/uinput.h
> new file mode 100644
> index 000000000..bdd6f466f
> --- /dev/null
> +++ b/include/lapi/uinput.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> + */
> +
> +#ifndef LAPI_UINPUT_H__
> +#define LAPI_UINPUT_H__
> +
> +#include <linux/uinput.h>
> +
> +#ifndef UI_GET_SYSNAME
> +# define UI_GET_SYSNAME(len)	_IOC(_IOC_READ, UINPUT_IOCTL_BASE, 44, len)
> +#endif
> +
> +#endif	/* LAPI_UINPUT_H__ */


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
