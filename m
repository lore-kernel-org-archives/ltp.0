Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A42C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 066E73CE72A
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:53:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42FF23CE6D1
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:53:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FDA3600687
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:53:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C0F31F808;
 Thu,  4 Jan 2024 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704372816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2H4/dvlsbp7iV3Qbp0R3dq4/KhizC1hb6YgIPqfdDU=;
 b=UsNy2k79H6HiZhWzNkk50mJh8hP7xyjGlBz/j4F5cdSVaZYAfX366PRfSa+K2FGSV1XSeo
 9QJF26CyVicRzQQJI1FTeF4gyuKer+KEj//ZDcIpjryb0OAWJRZ1yjudsCBzLn0+mq6aAB
 SKMblJJOd0ZTzxM9zR4nrZ08Ika/E0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704372816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2H4/dvlsbp7iV3Qbp0R3dq4/KhizC1hb6YgIPqfdDU=;
 b=lXqjIp0ZRasiGWcYKnU2RsWhF902EqPS3w/gD3HwgCn5Emz+yufSoC81Gk2CqGiG6gy3wO
 wCGO/NmLzTkDe9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704372816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2H4/dvlsbp7iV3Qbp0R3dq4/KhizC1hb6YgIPqfdDU=;
 b=UsNy2k79H6HiZhWzNkk50mJh8hP7xyjGlBz/j4F5cdSVaZYAfX366PRfSa+K2FGSV1XSeo
 9QJF26CyVicRzQQJI1FTeF4gyuKer+KEj//ZDcIpjryb0OAWJRZ1yjudsCBzLn0+mq6aAB
 SKMblJJOd0ZTzxM9zR4nrZ08Ika/E0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704372816;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T2H4/dvlsbp7iV3Qbp0R3dq4/KhizC1hb6YgIPqfdDU=;
 b=lXqjIp0ZRasiGWcYKnU2RsWhF902EqPS3w/gD3HwgCn5Emz+yufSoC81Gk2CqGiG6gy3wO
 wCGO/NmLzTkDe9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01CE913722;
 Thu,  4 Jan 2024 12:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7xuWNk+qlmWYIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:53:35 +0000
Date: Thu, 4 Jan 2024 13:53:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240104125334.GA1159015@pevik>
References: <20240103115700.14585-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240103115700.14585-1-chrubis@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.49 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[11.62%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UsNy2k79;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lXqjIp0Z
X-Rspamd-Queue-Id: 5C0F31F808
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: TST_EXP_FAIL: Add array variants
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

> For certain cases there is a possibility of a failure with more than one
> errno, for instance testcases with invalid fd may return either EINVAL
> or EBADFD and in many cases either one is fine, at least that was the
> feedback from kernel devs.

> This change also adds a tst_errno_in_set() function that is now the
> single place to validate errno for all TST_EXP_FAIL*() variants. That is
> intentional since this allows us to implement code to relax the
> conditions if needed, e.g. we had requests to allow additional errnos
> for systems with SELinux where failures may be caused by the SELinux
> policies and the errors may differ.

+1, this should be merged before release.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also thanks for starting docs in tst_test_macros.h (I wanted to add more but
haven't done it yet).

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test_macros.h        | 65 ++++++++++++++++++++++++++------
>  lib/newlib_tests/test_macros02.c | 11 ++++++
>  lib/tst_test_macros.c            | 36 ++++++++++++++++++
>  3 files changed, 101 insertions(+), 11 deletions(-)
>  create mode 100644 lib/tst_test_macros.c

> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
> index bd0c491c1..5687d0904 100644
> --- a/include/tst_test_macros.h
> +++ b/include/tst_test_macros.h
> @@ -186,7 +186,18 @@ extern void *TST_RET_PTR;
>  			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
>  	} while (0)                                                            \

> -#define TST_EXP_FAIL_SILENT_(PASS_COND, SCALL, SSCALL, ERRNO, ...)             \
> +/*
> + * Returns true if err is in the exp_err array.
> + */
> +int tst_errno_in_set(int err, const int *exp_errs, int exp_errs_cnt);
nit: we already use bool in fuzzy sync header and tst_af_alg.h. We could use it
here as well (it's immediately obvious it's true/false, not e.g. count).

...
> diff --git a/lib/tst_test_macros.c b/lib/tst_test_macros.c
> new file mode 100644
> index 000000000..a36abbea3
> --- /dev/null
> +++ b/lib/tst_test_macros.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
nit: maybe 2024?

> + */
> +
> +#include <stdio.h>
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_test_macros.h"
> +
> +int tst_errno_in_set(int err, const int *exp_errs, int exp_errs_cnt)
> +{
> +	int i;
> +
> +	for (i = 0; i < exp_errs_cnt; i++) {
> +		if (err == exp_errs[i])
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt)
> +{
> +	int i;
> +	char *cb = buf;
> +
> +	for (i = 0; i < exp_errs_cnt-1; i++)
> +		cb += sprintf(cb, "%s, ", tst_strerrno(exp_errs[i]));
> +
> +	cb += sprintf(cb, "%s", tst_strerrno(exp_errs[i]));
> +
> +	*cb = 0;
very nit: \0 is for me more readable.

Kind regards,
Petr
> +
> +	return buf;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
