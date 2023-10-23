Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3AAC001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 12:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79F0D3CECF7
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:28:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C033CCDD2
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:28:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E9E071000415
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 14:28:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DF611FE1A;
 Mon, 23 Oct 2023 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698064125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EWy06uRk5UVzOBW+qxfXDvci7mcbNmWolfoxrQUYj0=;
 b=bbLBQ81BrmKO0i/f5Rs+s/3Bvs53xdxHL0/DoZYeU+iaMfBbwOai4wzJMbj3gBKrXgqezh
 DoT8jDCGzcHDWvPdO8iN6N03+g/tbCtaO5RxqOxCn+zVukRrti+UV1Qc8Wv5kQYrpWMQ9d
 GoOImGyqWekVP71hhFzUZ9YLIWxoGAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698064125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EWy06uRk5UVzOBW+qxfXDvci7mcbNmWolfoxrQUYj0=;
 b=uozFyHB/kkebz0lBiX1MgFvWnZEPZfvnQpxbS0CoP3f/MLcNltkuJqM5iEgtCeRPNezbwy
 mnzPUmXvnRP8iLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4240F139C2;
 Mon, 23 Oct 2023 12:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w101D/1mNmUgKwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 23 Oct 2023 12:28:45 +0000
Date: Mon, 23 Oct 2023 14:29:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZTZnHLi1tSN_WGPc@yuki>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231021122958.13458-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231021122958.13458-2-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.95 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.35)[97.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +	/*
> +	 * {NULL, NULL} terminated array of (ulimit resource type and value)
              ^
	      That's technically {0, NULL} or maybe we can just start
	      using the newer syntax with just {}
> +	 */
> +	const struct tst_ulimit_val *ulimit;
> +
>  	/*
>  	 * NULL terminated array of kernel config options required for the
>  	 * test.
> diff --git a/include/tst_ulimit.h b/include/tst_ulimit.h
> new file mode 100644
> index 000000000..b4f97670a
> --- /dev/null
> +++ b/include/tst_ulimit.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
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

Maybe tst_ulimit_set()?

> +#endif
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2e58cad33..a8c7c7ba6 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1227,6 +1227,15 @@ static void do_setup(int argc, char *argv[])
>  		}
>  	}
>  
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
>  
> diff --git a/lib/tst_ulimit.c b/lib/tst_ulimit.c
> new file mode 100644
> index 000000000..1249d65d8
> --- /dev/null
> +++ b/lib/tst_ulimit.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_ulimit.h"
> +
> +struct tst_ulimit_conf {
> +	int resource;
> +	struct rlimit rlim;
> +};

This structure is defined in header already.

> +void tst_ulimit_conf(const struct tst_ulimit_val *conf)
> +{
> +	struct rlimit rlim;
> +
> +	rlim.rlim_cur = conf->rlim.rlim_cur;
> +	rlim.rlim_max = conf->rlim.rlim_max;

I wonder if we should adjust the max only if it's smallre than the
requested value.

> +	tst_res(TINFO, "Set ulimit resource:%d rlim_cur:%ld rlim_max:%ld", conf->resource, rlim.rlim_cur, rlim.rlim_max);
> +	SAFE_SETRLIMIT(conf->resource, &rlim);
> +}
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
