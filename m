Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE73C5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 14:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748961260; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=KvCNSIv6el7uUDE0H2zbvdfXLT8iKokJ29kh6y0VvVg=;
 b=HeyqtATHO+o1R+FrKD2bYE7rnIKps26LvVABFwAuAQXsPAvgasNzfgR0ZBvNWmGyY/cbK
 C5ObketuGy7tQ38TmW+FHgL1tkMjp8XdNHzifPPCuaSrvqWpYxYKzMvP3WvIWpbA1xjD1J3
 gp4tD3RVpYnp69UPhi/0fjwnh4yBALM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 174733CA018
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 16:34:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B542A3C681B
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:33:58 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D0EA204724
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:33:57 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a5058d46ceso1511189f8f.0
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748961237; x=1749566037; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xFoaMBZstU7Y0XIyTEYh9qWLGdLEpZcCsvPiad6iK24=;
 b=TyAM3x6wOV/pPkWL4jWzMNtHsehU39w3WW4mWq0djR7WzNEfq/XwtbNk0KwU31s+qe
 JKJY66cB/fS43slPEde2UHAlNipHh3mvuhTzU0imc1vbN3KMCaT7AFdB+lJomFbXGINd
 yNLP5Hv6vxOZpoOa/1O5EDZwy5BhSfv7tLULtE/c2zFl/2nakOO+BF59CI7PjSKQkdKb
 iTmzlj7taG6wuZY6M0tx/6Uo+ugC3DAbNg1YhlJ19fMVocTW1aVqbFlYxfrsm8HDsH0o
 EnhN0xhzgb5yPe4+pkcfjPg4364u+bpYRmHbgbXeFXHTBf3as1vkuIBbbMKukxuWIaxo
 VInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961237; x=1749566037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFoaMBZstU7Y0XIyTEYh9qWLGdLEpZcCsvPiad6iK24=;
 b=nKO/UYU3x4dSz1SCOS+aWC9YvfebRV6miv6ypQ1ntod7JbbtfonnCk5DN5aTPkPyyX
 bCHZ2Y3uDUsA/op13xFvqi6Zj3ujjP/zx519shWvlfD15mR2Ap6bxnNBVutW9EvjCTnu
 dRZL/4kQAxnqaBWdCc3pw8x8Tg/7MZ2gHVDTf9sdo6zcO1FZEHwFWWOniANJuR9bl+Qq
 q+TeQqnQNdmrFYwN9NE4fEiELn8TIPAZRkGJ/AkmYjhj+AjYzdn9BCXepZqLCC93tKJD
 M45+mGMGCCHd1psirhGwpWkAL665Ce59956IO14qf5khQjGvYxivJFZOU7SH7Yas43Up
 ZlkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmxOxutE0dGNhKz2dA+vGiwGkjy9AYo8Pj0+0WhzDs2THSmoiHp1+MUEJp5Rav7MJGfQ4=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+WvVOBPG49nbF4MCa6FSyu49X/VmZV0bzX89lT48fpGmvcJBq
 7nlCPEhx0SdM58W0zq3B13jx8HzzMi420FTE0kUUEddOR+b/YdS3e8ZkYWVpYpM0y40=
X-Gm-Gg: ASbGnctfTMUlkd2N/Z5BZolhs3hW7hVmDF7T65P4C3Kwe2ClmLrs5D9WypqJNKkQnxD
 etONpydIYahguyEcZm1TV3nd6n9HqloKG/opStew/QSfOGpEf0v2FVQPQqzVTaN7xkUucJeX6L5
 yBID3kfddR8uVNv2ORdcR8O9Yh8G+hvFJz2t9kVW5ZwOGBUNaapka9cdRK95OAl5OkU2HoNngYf
 ReED/nYsh1ZzEl7phqBiNnVVdZlR531lQt28wsA5EvOjW56YPwy4prjbXwfFGOJfQyrdWZ09hx2
 iz/4N7aJcu9Xz0GaI1WutOf5N8CZnI3z7LMX5fLCucaMGPNieM0kKQsbbPz3tg==
X-Google-Smtp-Source: AGHT+IF8w+9Rk8QahZYf8JAxD3duJWHPyKxZ9h3BZffe6xnUEiYLeS1b7sHSVzLEM/Io9AWWfUFllQ==
X-Received: by 2002:adf:f4c9:0:b0:3a4:fbd9:b93c with SMTP id
 ffacd0b85a97d-3a4fbd9b95emr8991887f8f.30.1748961236762; 
 Tue, 03 Jun 2025 07:33:56 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bd93a5sm88358575ad.82.2025.06.03.07.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 07:33:56 -0700 (PDT)
Message-ID: <7f20da41-8cb2-4e93-86e0-09a6be42af36@suse.com>
Date: Tue, 3 Jun 2025 16:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250603141320.161026-1-mdoucha@suse.cz>
 <20250603141320.161026-3-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250603141320.161026-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add regression test for epoll_pwait2() timeout
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

On 6/3/25 16:13, Martin Doucha wrote:
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> Note: The test will get killed by SIGALRM on failure.
>
>   runtest/syscalls                              |  1 +
>   .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
>   .../syscalls/epoll_pwait/epoll_pwait06.c      | 86 +++++++++++++++++++
>   3 files changed, 88 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e7bc7b27b..2a968099a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -192,6 +192,7 @@ epoll_pwait02 epoll_pwait02
>   epoll_pwait03 epoll_pwait03
>   epoll_pwait04 epoll_pwait04
>   epoll_pwait05 epoll_pwait05
> +epoll_pwait06 epoll_pwait06
>   
>   eventfd01 eventfd01
>   eventfd02 eventfd02
> diff --git a/testcases/kernel/syscalls/epoll_pwait/.gitignore b/testcases/kernel/syscalls/epoll_pwait/.gitignore
> index fafb2d782..81e77b8d0 100644
> --- a/testcases/kernel/syscalls/epoll_pwait/.gitignore
> +++ b/testcases/kernel/syscalls/epoll_pwait/.gitignore
> @@ -3,3 +3,4 @@ epoll_pwait02
>   epoll_pwait03
>   epoll_pwait04
>   epoll_pwait05
> +epoll_pwait06
> diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
> new file mode 100644
> index 000000000..487992744
> --- /dev/null
> +++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 SUSE LLC <mdoucha@suse.cz>
> + */
> +
> +/*\
> + * Verify that various timeout values don't get misinterpreted as infinity
> + * by epoll_pwait() and epoll_pwait2()
It would be nice to give the reference of the commit which introduced 
the bug in the tst_test structure.
> + */
> +
> +#include <sys/epoll.h>

#include "tst_epoll.h" instead, since we are already including 
"sys/epoll.h" while including "epoll_pwait_var.h".

and then we can use SAFE_EPOLL_* macros. Check below

> +
> +#include "tst_test.h"
> +#include "tst_timer.h"
> +#include "epoll_pwait_var.h"
> +
> +static int efd;
> +
> +static void run(void)
> +{
> +	struct timespec timeout = {};
> +	struct epoll_event e = {};
> +	int ret;
> +
> +	e.events = EPOLLIN;
> +
> +	TST_FD_FOREACH(fd_in) {
> +		/* File descriptor types not supported by epoll */
> +		switch (fd_in.type) {
> +		case TST_FD_FILE:
> +		case TST_FD_PATH:
> +		case TST_FD_DIR:
> +		case TST_FD_DEV_ZERO:
> +		case TST_FD_PROC_MAPS:
> +		case TST_FD_FSOPEN:
> +		case TST_FD_FSPICK:
> +		case TST_FD_OPEN_TREE:
> +		case TST_FD_MEMFD:
> +		case TST_FD_MEMFD_SECRET:
> +			continue;
> +		default:
> +			break;
> +		}
> +
> +		tst_res(TINFO, "Testing %s", tst_fd_desc(&fd_in));
> +		timeout.tv_nsec = 1000000000;
> +		ret = epoll_ctl(efd, EPOLL_CTL_ADD, fd_in.fd, &e);
> +
> +		if (ret)
> +			tst_brk(TBROK | TERRNO, "epoll_ctl(EPOLL_CTL_ADD)");
SAFE_EPOLL_CTL()
> +
> +		do {
> +			alarm(1);
> +			timeout.tv_nsec /= 10;
> +			do_epoll_pwait(efd, &e, 1, &timeout, NULL);
> +			alarm(0);
What about adding a TINFO here? It should be shown around 10 times, but 
eventually we would have some debugging data on console to use just in 
case the test stuck.
> +		} while (timeout.tv_nsec);
> +
> +		if (epoll_ctl(efd, EPOLL_CTL_DEL, fd_in.fd, &e))
> +			tst_brk(TBROK | TERRNO, "epoll_ctl(EPOLL_CTL_DEL)");
SAFE_EPOLL_CTL()
> +	}
> +
> +	tst_res(TPASS, "Timeout works correctly");
> +}
> +
> +static void setup(void)
> +{
> +	epoll_pwait_init();
> +	efd = epoll_create(1);
SAFE_EPOLL_CREATE1()
> +
> +	if (efd == -1)
> +		tst_brk(TBROK | TERRNO, "epoll_create()");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (efd > 0)
> +		SAFE_CLOSE(efd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = TEST_VARIANTS,
It's worth to add a timeout for the test, since it's a test which is 
testing timeout limits.
> +};

Also we might move the run() inside a process and check if it eventually 
gets killed from the parent due to SIGALARM and not other signals.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
