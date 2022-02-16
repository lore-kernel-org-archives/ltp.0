Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38D0C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 14:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A39C13CA094
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778A63C952F
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 15:09:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5E371400E70
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 15:09:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6F3D212B5;
 Wed, 16 Feb 2022 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645020557;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYV+GkUmoFzvvoK4HdLb/nUa2EMZgnyrs6K/XmGRsO0=;
 b=AWLLtlZ7X4WMdwXDWerq10O0UMpwHK3kZLxUYcsBzj+GKEmIPqhfy/w6HQ6KrhAJoOxUKy
 zBVFb5uWLsB65eAVi1oA2vqqxfKaU5SUsbcWgyojWqco5DI+G5U302Hm0H95epZRerk4dW
 wcL08lQv7z/lNECthdVL1H4UGgW9XWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645020557;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYV+GkUmoFzvvoK4HdLb/nUa2EMZgnyrs6K/XmGRsO0=;
 b=5qCfSbHc4hy7plAJQNIn0FS+eENg5y0wp6gJn388doGYgiGw9cQARQYpXdEhITYwpWsoro
 /8rbxO9AfrZAMNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A074613B24;
 Wed, 16 Feb 2022 14:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H/LrI40FDWIQBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 16 Feb 2022 14:09:17 +0000
Date: Wed, 16 Feb 2022 15:09:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg0FjFPfTOXxUbWx@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645005868-2373-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] pidfd_getfd.h: add fallback
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

Hi Xu,

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  configure.ac               |  1 +
>  include/lapi/pidfd_getfd.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/lapi/pidfd_getfd.h

> diff --git a/configure.ac b/configure.ac
> index 8d2c5b1c4..49499704e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -115,6 +115,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      open_tree \
>      openat \
>      openat2 \
> +    pidfd_getfd \
>      pidfd_open \
>      pidfd_send_signal \
>      pkey_mprotect \
> diff --git a/include/lapi/pidfd_getfd.h b/include/lapi/pidfd_getfd.h
> new file mode 100644
> index 000000000..1f488a518
> --- /dev/null
> +++ b/include/lapi/pidfd_getfd.h
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +#ifndef LAPI_PIDFD_GETFD_H__
> +#define LAPI_PIDFD_GETFD_H__
> +
> +#include "lapi/syscalls.h"
> +#include "config.h"
nit: IMHO it's better to always put config.h at the first place.

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +static inline void pidfd_getfd_supported(void)
> +{
> +	/* allow the tests to fail early */
> +	tst_syscall(__NR_pidfd_getfd);
> +}
> +
> +#ifndef HAVE_PIDFD_GETFD
> +static inline int pidfd_getfd(int pidfd, int targetfd, unsigned int flags)
> +{
> +	return tst_syscall(__NR_pidfd_getfd, pidfd, targetfd, flags);
> +}
> +#endif
> +
> +#endif /* LAPI_PIDFD_GETFD_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
