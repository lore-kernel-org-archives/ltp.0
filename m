Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5673C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716895888; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sGjfAlO9KsVOpvNjWQYVZDKw6iegdzwSU9MSyFdOc6w=;
 b=fcyECemiCqdNVg6c/z3hmbH77RyKHoYOqELO7Y87Z7ylVZPMEo1OcFlSP/CQZ+3BVtGUk
 uHlhvNbfNCIxSTGvnp85ije9c6DHjy0Ouo+rbZpLLIS9+ENVDFBYTV0nRIGV/V2vh8kqKoX
 Se4689WkRaqidWkyLCCTaJqFGKwVoNU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D01EC3D053A
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 13:31:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FC163CFCD7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 13:31:07 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95C86601BC1
 for <ltp@lists.linux.it>; Tue, 28 May 2024 13:31:06 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f464so981278a12.0
 for <ltp@lists.linux.it>; Tue, 28 May 2024 04:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716895866; x=1717500666; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ycQB1WGw9yj5JgkkKXGN8PNHOa5tW3znWt4ebkkKszw=;
 b=bWszQKZ8d5bT/AH6CqEg4Kuys1QcLuSnpNhelgItlvb/kKEbJ+EeJ97O06obvdNXxb
 4IDAIogYlN4KlM0wDCh0gtYnGedS46wCcn1Pk0PsJdY+YRbAQmb2yXrJhr1zaX/rbw+e
 xSto1zCI68sEvFWci9uzMcDrlloGZDgb+FVOQdu1Fo7rK52Z6L9d1LuFyzh2gl8bLuq9
 nJCzcpmKJWUhIUINVtwzPYtcs/d+2kwsznMnYTXIf6MywRubt0nuyuj8kRIDpM9bgdzG
 Wh+0VFy5aOy33pgXQMtfB8t440PGXe4WuwuS9GQbawlJk5IFXc+XbZFogQBfVuqkXYoL
 px1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716895866; x=1717500666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ycQB1WGw9yj5JgkkKXGN8PNHOa5tW3znWt4ebkkKszw=;
 b=KaoLWCNROae5/rZ+rijS0g2pzQ2yTJ46OzNQ3SocrjrczIFiZcFPy92jEET0+Iu7+h
 FAyVJI90Wld8FTpvgj3s5V2RTJhXwVsaTPjfpuDmszDAwgIlOC30nqKUtBB6BuaCFCTB
 CVKpcAFYkPD+IMinmfJtK0zodPINePrn9OgzHHvbproeKoY416qQmdmPIWYFQ6IygMIU
 y5DfLTRJ0HFu3SnM/dGGAA3huO9CUGVofcWQXNBUy0CMohfTiK0Y5rpcp34wx/5v//bE
 gqo17p9x+QrxGgT1miXoKnscFhYhU+HNH97WF6PrlNufu1rCU0qvL6xpcqaVTfDC7Qx7
 fWIQ==
X-Gm-Message-State: AOJu0Yz4sQPETNidnXqLNieIPwebuxd7NqT0tk4U7nLwC/SCLh68GdWI
 wvdwmeWT6SvvSfUb6xBmE0p4HxG01lULmyloh0ziqlifnijalo5dl+y0sRlIuc+wVtYAT5VuXSm
 U
X-Google-Smtp-Source: AGHT+IHcZ0gO6p67k3DwYkIl+pU4jeVdOLtqCwAXbVZP9Qg5bOaq/vEqvuhP/Z2eu6p9rkbsyfs3Pg==
X-Received: by 2002:a17:906:d8d2:b0:a62:c02:425a with SMTP id
 a640c23a62f3a-a626525d448mr849541466b.74.1716895865640; 
 Tue, 28 May 2024 04:31:05 -0700 (PDT)
Received: from [192.168.1.29] ([151.51.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93a84bsm598995466b.72.2024.05.28.04.31.05
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 04:31:05 -0700 (PDT)
Message-ID: <8a4a1452-0d8b-473e-be89-c0d4fb286abd@suse.com>
Date: Tue, 28 May 2024 13:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
 <20240528103258.2390-2-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20240528103258.2390-2-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] signalfd: Add negative tests
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Please take into account the same considerations made in signalfd01 test 
refactoring.

Regards,
Andrea Cervesato

On 5/28/24 12:33, Ma Xinjian via ltp wrote:
> Add negative cases for signalfd(), when errno is EBADF or EINVAL
>
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   runtest/syscalls                              |   1 +
>   testcases/kernel/syscalls/signalfd/.gitignore |   1 +
>   .../kernel/syscalls/signalfd/signalfd02.c     | 115 ++++++++++++++++++
>   3 files changed, 117 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/signalfd/signalfd02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a06b046ac..2dac79798 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1487,6 +1487,7 @@ signal05 signal05
>   signal06 signal06
>   
>   signalfd01 signalfd01
> +signalfd02 signalfd02
>   
>   signalfd4_01 signalfd4_01
>   signalfd4_02 signalfd4_02
> diff --git a/testcases/kernel/syscalls/signalfd/.gitignore b/testcases/kernel/syscalls/signalfd/.gitignore
> index 3c9ed737c..959022f41 100644
> --- a/testcases/kernel/syscalls/signalfd/.gitignore
> +++ b/testcases/kernel/syscalls/signalfd/.gitignore
> @@ -1 +1,2 @@
>   /signalfd01
> +/signalfd02
> diff --git a/testcases/kernel/syscalls/signalfd/signalfd02.c b/testcases/kernel/syscalls/signalfd/signalfd02.c
> new file mode 100644
> index 000000000..9ca943942
> --- /dev/null
> +++ b/testcases/kernel/syscalls/signalfd/signalfd02.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that signalfd(2) fails with
> + *
> + * - EBADF when fd is invalid
> + * - EINVAL when fd is not a valid signalfd file descriptor
> + * - EINVAL when flags are invalid
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <signal.h>
> +#include "tst_test.h"
> +#include "config.h"
> +
> +#ifndef HAVE_SIGNALFD
> +#define USE_STUB
> +#endif
> +
> +#ifdef HAVE_SYS_SIGNALFD_H
> +#include <sys/signalfd.h>
> +#elif defined HAVE_LINUX_SIGNALFD_H
> +#include <linux/signalfd.h>
> +#define USE_OWNIMPL
> +#else
> +#define USE_STUB
> +#endif /* HAVE_SYS_SIGNALFD_H */
> +
> +#ifndef HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO
> +#define USE_STUB
> +#endif /* HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO */
> +
> +#ifdef USE_STUB
> +TST_TEST_TCONF("This system does not support signalfd()");
> +#else /* USE_STUB */
> +#if defined USE_OWNIMPL
> +#include "lapi/syscalls.h"
> +int signalfd(int fd, const sigset_t *mask, int flags)
> +{
> +	return tst_syscall(__NR_signalfd, fd, mask, flags);
> +}
> +#endif /* USE_OWNIMPL */
> +
> +#define SIGNAL_FILE "signal_file"
> +
> +static int fd_ebadf = -2;
> +static int fd_einval1;
> +static int fd_einval2 = -1;
> +
> +static sigset_t mask1;
> +static sigset_t mask2;
> +static sigset_t mask3;
> +
> +static struct test_case_t {
> +	int *fd;
> +	sigset_t *mask;
> +	int flags;
> +	int expected_errno;
> +	char *desc;
> +} tcases[] = {
> +	{&fd_ebadf, &mask1, 0, EBADF, "fd is invalid"},
> +	{&fd_einval1, &mask2, 0, EINVAL,
> +		"fd is not a valid signalfd file descriptor"},
> +	{&fd_einval2, &mask3, -1, EINVAL, "flags are invalid"},
> +};
> +
> +static void setup(void)
> +{
> +	SAFE_SIGEMPTYSET(&mask1);
> +	SAFE_SIGADDSET(&mask1, SIGUSR1);
> +	SAFE_SIGPROCMASK(SIG_BLOCK, &mask1, NULL);
> +	SAFE_SIGEMPTYSET(&mask2);
> +	SAFE_SIGADDSET(&mask2, SIGUSR2);
> +	SAFE_SIGPROCMASK(SIG_BLOCK, &mask2, NULL);
> +	SAFE_SIGEMPTYSET(&mask2);
> +	SAFE_SIGADDSET(&mask3, SIGUSR2);
> +	SAFE_SIGPROCMASK(SIG_BLOCK, &mask3, NULL);
> +
> +	fd_einval1 = SAFE_OPEN(SIGNAL_FILE, O_CREAT, 0777);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_ebadf > 0)
> +		SAFE_CLOSE(fd_ebadf);
> +	if (fd_einval1 > 0)
> +		SAFE_CLOSE(fd_einval1);
> +	if (fd_einval2 > 0)
> +		SAFE_CLOSE(fd_einval2);
> +}
> +
> +static void verify_signalfd(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +
> +	TST_EXP_FAIL2(signalfd(*(tc->fd), tc->mask, tc->flags),
> +		tc->expected_errno, "%s", tc->desc);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_signalfd,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> +
> +#endif /* USE_STUB */



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
