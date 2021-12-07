Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A1C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 12:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BD8A3C5592
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:52:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F13823C0BCC
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:52:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 37DC71A00CB8
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:52:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C84D1FE07;
 Tue,  7 Dec 2021 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638881556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4AMRWPch1LOuO4BIFDrT84FKy+grXImV+ozGvD2cDU=;
 b=aKSrl2YsKmd/3evDDDqM4MjFXO/nyeXAm23Kw+QwO19RcnrTcFUSa8unz6QHW8kxu9HTlZ
 rmT9aC6QigrsXqlg5wFCKWnhozWquhOqJ6ssTW405WXCodCZzP/oyQ9A1c7Xpj2GGRIM2a
 3YpstQmE9VQj8td5TCFwcNOqJ4jeObM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638881556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4AMRWPch1LOuO4BIFDrT84FKy+grXImV+ozGvD2cDU=;
 b=Lli9c9RoJAQkuYHngt5JFc/cPfBpgXUWCn9lakBrGcpNPvtl87n3neMKsQ26B0zGYIRLU0
 Q9szC5GEIImx+JAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 161CE13A78;
 Tue,  7 Dec 2021 12:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uf+1BBRZr2EMOgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 12:52:36 +0000
Date: Tue, 7 Dec 2021 13:53:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Ya9ZYCErHU/XqjLn@yuki>
References: <20211207114625.30495-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211207114625.30495-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add tst_parse_filesize functionality in LTP
 test API
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
> +++ b/lib/newlib_tests/test_tst_test.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*
> + * Tests for lib/tst_test.c
> + */

Well technically this is a test just for tst_parse_filesize() so I would
name the file test_parse_filesize.c or something like that.

> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +    long long val = 0;
> +    int ret = 0;
> +
> +    if ((ret = tst_parse_filesize("1", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1);
> +    }
> +
> +    /* small letters */
> +    if ((ret = tst_parse_filesize("1k", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1024)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1024);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1m", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1048576)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1048576);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1g", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1073741824)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
> +    }
> +
> +    /* big letters */
> +    if ((ret = tst_parse_filesize("1K", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1024)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1024);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1M", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1048576)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1048576);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1G", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1073741824)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
> +    }
> +
> +    /* test errors */
> +    if ((ret = tst_parse_filesize("k", &val, LLONG_MIN, LLONG_MAX))) {
> +        if (ret == EINVAL)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +    if ((ret = tst_parse_filesize("100", &val, LLONG_MIN, 10))) {
> +        if (ret == ERANGE)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +    if ((ret = tst_parse_filesize("10", &val, 100, LLONG_MAX))) {
> +        if (ret == ERANGE)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +
> +    if ((ret = tst_parse_filesize("garbage", &val, LLONG_MIN, LLONG_MAX))) {
> +        if (ret == EINVAL)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index a79275722..78b107ed0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -679,6 +679,47 @@ int tst_parse_float(const char *str, float *val, float min, float max)
>  	return 0;
>  }
>  
> +int tst_parse_filesize(const char *str, long long *val, long long min, long long max)
> +{
> +	long long rval;
> +	char *end;
> +
> +	if (!str)
> +		return 0;
> +
> +	errno = 0;
> +	rval = strtoll(str, &end, 0);
> +
> +	if (str == end || (strlen(end) != 0 && strlen(end) != 1))

No need for the strlen() here. what you do here is a fancy way of doing (!end[0] && !end[1]).

> +		return EINVAL;
> +
> +	if (errno)
> +		return errno;
> +
> +	switch (*end) {
> +	case 'g':
> +	case 'G':
> +		rval *= (1024 * 1024 * 1024);
> +		break;
> +	case 'm':
> +	case 'M':
> +		rval *= (1024 * 1024);
> +		break;
> +	case 'k':
> +	case 'K':
> +		rval *= 1024;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (rval > max || rval < min)
> +		return ERANGE;
> +
> +	*val = rval;
> +	return 0;
> +}
> +
>  static void print_colored(const char *str)
>  {
>  	if (tst_color_enabled(STDOUT_FILENO))

The rest looks good, but we should add a short note about the function
to the doc/c-test-api.txt as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
