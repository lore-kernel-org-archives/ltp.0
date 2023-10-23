Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC561CDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 11:03:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B083CECEA
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 13:03:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B1A3C8487
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 13:03:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 903381A01094
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 13:03:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D25A1FE0D;
 Mon, 23 Oct 2023 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698059014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QPhYeZSuHKlVpIHcC50uj3JXJzo/NXSqaPIbicOKW8I=;
 b=VPAzncOlADjRJBf9U1l4O8g8BsmHhetLdbo+t/HCHSyfmpiG/Fb8xCemO+deDDOuLL+mdC
 hKFgKgAdq4bo2S9Egd0a97iKH7ypHTypyhSAhNH3zgyzbGIZyKZB6t7xgOJqxZHkECSz05
 2hpSn11Qw9v+MLvq0470vEcMvsOIyZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698059014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QPhYeZSuHKlVpIHcC50uj3JXJzo/NXSqaPIbicOKW8I=;
 b=aUmUi1bt2OutEUpB0T/yiXChjJ0Vp+xiq5sMEbUHntHdiAIZl+Zn0diH082kodyoFBj5Oh
 Gmsk2aYk+YTVmPAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC98132FD;
 Mon, 23 Oct 2023 11:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wNo2AQZTNmXPdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 23 Oct 2023 11:03:34 +0000
Date: Mon, 23 Oct 2023 13:03:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231023110332.GA23219@pevik>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231021122958.13458-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231021122958.13458-2-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] lib: Add .ulimit
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

> Fix: #530
very nit: Although this works, we usually use:
Fixes: #530

...
>  	/*
>  	 * NULL terminated array of kernel config options required for the
>  	 * test.
> diff --git a/include/tst_ulimit.h b/include/tst_ulimit.h
> new file mode 100644
> index 000000000..b4f97670a
> --- /dev/null
> +++ b/include/tst_ulimit.h

I wonder if it's worth to add new header and C source just for single struct and
function. We might do so, but I consider that as a bad habit. I'd move that to
tst_test.{c,h}. But maybe others see it differently.

> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
Why v2 only? We use GLP v2+ for new code.
SPDX-License-Identifier: GPL-2.0-or-later

> + *
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +#ifndef TST_ULIMIT_H__
> +#define TST_ULIMIT_H__
> +
> +#include <sys/resource.h>
> +
> +struct tst_ulimit_val {
> +	int resource;
> +	struct rlimit rlim;
> +};
> +
> +void tst_ulimit_conf(const struct tst_ulimit_val *conf);
> +
> +#endif
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2e58cad33..a8c7c7ba6 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1227,6 +1227,15 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}

> +	if (tst_test->ulimit) {
> +		const struct tst_ulimit_val *pvl = tst_test->ulimit;
> +
> +		while (pvl->resource) {
> +			tst_ulimit_conf(pvl);
> +			pvl++;
> +		}
> +	}
> +
>  	if (tst_test->mntpoint)
>  		SAFE_MKDIR(tst_test->mntpoint, 0777);

> diff --git a/lib/tst_ulimit.c b/lib/tst_ulimit.c
> new file mode 100644
> index 000000000..1249d65d8
> --- /dev/null
> +++ b/lib/tst_ulimit.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
Again, v2+ please.

> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_ulimit.h"
Again, please IMHO this should be in tst_test.c.

> +
> +struct tst_ulimit_conf {
> +	int resource;
> +	struct rlimit rlim;
> +};
> +
> +void tst_ulimit_conf(const struct tst_ulimit_val *conf)
> +{
> +	struct rlimit rlim;
> +
> +	rlim.rlim_cur = conf->rlim.rlim_cur;
> +	rlim.rlim_max = conf->rlim.rlim_max;
> +
> +	tst_res(TINFO, "Set ulimit resource:%d rlim_cur:%ld rlim_max:%ld", conf->resource, rlim.rlim_cur, rlim.rlim_max);
nit: Could we improve formatting (spaces, commas):
	tst_res(TINFO, "Set ulimit resource: %d, rlim_cur: %ld, rlim_max: %ld",
		conf->resource, rlim.rlim_cur, rlim.rlim_max);

First I thought all library code should use tst_res_(), so that we get file and
line of the original call, not the place in the library. But in code is used
only in the library thus tst_res() is ok.

> +	SAFE_SETRLIMIT(conf->resource, &rlim);
Also here is probably ok that SAFE_SETRLIMIT() is correct (not
safe_setrlimit()).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
