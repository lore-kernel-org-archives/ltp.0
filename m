Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CE8C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:33:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01AAE3CE20C
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:33:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CC673CB172
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:32:51 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5AD6C140110C
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:32:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26EDF5FF2D;
 Thu,  9 May 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00BE413941;
 Thu,  9 May 2024 12:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 29+EOnDCPGYYYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 12:32:48 +0000
Date: Thu, 9 May 2024 14:32:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <metan@ucw.cz>
Message-ID: <20240509123247.GA287654@pevik>
References: <20240509120942.14952-1-metan@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509120942.14952-1-metan@ucw.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 26EDF5FF2D
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: arch_prctl01.c fix compilation on old
 distros
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

> From: Cyril Hrubis <chrubis@suse.cz>

> There are distros that have asm/prctl.h without the ARCH_{GET,SET}_CPUID
> definitions, fix the compilation on such distributions by adding
> lapi/arch_prctl.h.

I would note that this was for Leap 42.2. We can remove the fallback in the
future once we remove the support for these oldest distros (it's hard to find
the original reason when doing a cleanup few years later).

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/lapi/arch_prctl.h                          | 22 ++++++++++++++++++++++
>  .../kernel/syscalls/arch_prctl/arch_prctl01.c      |  7 +------
>  2 files changed, 23 insertions(+), 6 deletions(-)
>  create mode 100644 include/lapi/arch_prctl.h

> diff --git a/include/lapi/arch_prctl.h b/include/lapi/arch_prctl.h
> new file mode 100644
> index 000000000..6d0ef51f4
> --- /dev/null
> +++ b/include/lapi/arch_prctl.h
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +#ifndef LAPI_ARCH_PRCTL_H__
> +#define LAPI_ARCH_PRCTL_H__
> +
> +#include "config.h"
> +
> +#ifdef HAVE_ASM_PRCTL_H
> +# include <asm/prctl.h>
> +#endif
> +
> +#ifndef ARCH_GET_CPUID
> +# define ARCH_GET_CPUID 1011
This is wrong, in the header is a hex number (missing 0x)
# define ARCH_GET_CPUID      0x1011

> +#endif
> +
> +#ifndef ARCH_SET_CPUID
> +# define ARCH_SET_CPUID 1012
And here as well:
# define ARCH_SET_CPUID      0x1012

It obviously break the result when fallback is used:

arch_prctl01.c:56: TFAIL: arch_prctl_set(ARCH_SET_CPUID, index) failed: EINVAL (22)
arch_prctl01.c:68: TFAIL: get wrong cpuid status
arch_prctl01.c:56: TFAIL: arch_prctl_set(ARCH_SET_CPUID, index) failed: EINVAL (22)
arch_prctl01.c:68: TFAIL: get wrong cpuid status

With that fixed:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
