Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4BBC79F8A
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 12:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767617655; h=date :
 message-id : to : mime-version : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=38LJX/i+sx36iAf0q3fbzaARi7yIrO1SaLOl8SDw3uM=;
 b=mYuM1KmoKN5IuX3kFajbGtJa8OcWRDuV7py8R+1MCbYrDhdHgWE9E/NN9+CnhD/hyN46t
 5WYhNY0lZ92QCmRh9lFg1piyrfB6bBM3TstG25EGR4h9OpTdXo/fExLLduF6ceaBbn9+003
 O2/HXa3fKf7N8ObBzDbqS+7CnPXXgWw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6192A3C2466
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 13:54:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20E83C1004
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 13:53:52 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7FE11A0042C
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 13:53:51 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so110553175e9.3
 for <ltp@lists.linux.it>; Mon, 05 Jan 2026 04:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767617631; x=1768222431; darn=lists.linux.it;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=TP0D6GRS9c0MB56JtIubriQnxn/5jmStJtkVGvEOtzs=;
 b=GJmLw/+GxzQL4JJl43Wp9rpFv0/VOr0VhQSdTy2rotv0WPATmwk3oXwC308PIzDZzQ
 56zepKzfSRJj2rLKYj1ZKTv0CbNlwMkrKTNny8E3L0G/3BOCe5j2QiIBODN0vdH0g8Vb
 mq5q1mcQ0doEOizkPlYEQZJAR/+WbQqOz1yXNyuuBBZJPSio7Mzkk3lGe9VogxjpaK33
 vXoe12USfAL3OW0YDvPSZSnR0E03LJxJbDHVcrEZTX1XkPm5pFRkDeUdsyt1vAkSFNf7
 lVQmVnfXlCM8kU7pHbflaouiv1hZ/khcJFlE/L1lTSP+spUzhQi+jwMOkUO1vwr0b/Ev
 SB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767617631; x=1768222431;
 h=in-reply-to:references:content-transfer-encoding:mime-version:to
 :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TP0D6GRS9c0MB56JtIubriQnxn/5jmStJtkVGvEOtzs=;
 b=rXQ9uwl7euLIGL97ymFg7DzPhy0f7PD6gP4+zKGPH6Qqv3c81TL79bBs/onxkY9JuJ
 rF2l44btiqcP+mAvcNdv+urEBx+6tpseJWpwHnS133fbmEBr0NrUaWecXmCk+V/fz2Lm
 4U9GHGOr2j67plnKl+xNHvaidpvs/0gdc/gIab7agXZyNX0RA044U36qaKwy7ogDzXjt
 PFpvO1zz0vWBMWQdM4vIDq2VQWUe0dOM6CApEFpXSqPnK134es+Vqb/zTwv7d7tzjl3L
 wn6jj9DFsGKZmFUUmnMizyZ3k8J4f1zyqOQu5kQFSH1Dzow4Xd3C/FaNhzNmCLyly9iK
 ArMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg/+5ogcxWftMWwvtepiIZ9Vd++ZfwO/iFhB0xxp0qBrzNwsluZmqOV6Mbe5sINl0EbQ0=@lists.linux.it
X-Gm-Message-State: AOJu0YyhVP1xI4GJqbX430comLWZgdfNLxfl9DU4SkP4YhAdTGPsBoAK
 z6sLoLwiB0mj2Ov65AFYa29gkamrqwvqwwk5l96PTbyoYYbe4J1M1hFxH5i1+nwO7Js=
X-Gm-Gg: AY/fxX45S8ntYFCr947VFNEPIwj6iqvkdGaJlBjXDcB6poQLTSXfd17StNxSchF6hd8
 T+vRV1lybo/S2T/7LI1EAV+1L2baDmzYaCFOLqWBXLI0SSRaagCkgzSliM+mlyr6YQQgRQPl31j
 aEQ1nqRLUylhwNQVOsLcJlPpuFW/LF33XUYNC/co+DFJWzQFF9y9PmT+WhqItq0BR/cyZuvk7qA
 OHuHheQ9iQqNGT4HP6qOmJflv5GwddUmrVnT269jSmZUStdC+SGUnqlFk2/xbkcBRbb/hT75o4u
 aYTRS5DKGRfvbmyOPt/xAqxmyHv64/Uv2KWNQFg0y4XpqlOOzWpMDyt6+QZcqwp9lBXYV3GpnJi
 7WTAycOPUIU9PCZfruQmDtpeI0s9Qo2DEylCwL/DomKRMl5bJBIvdAQicSEtr9h7CcKQgBNpXFb
 aE+mxSny3/WQVULGpE2253wcwyfem8bR5iAb7XZivVHcUlm2C2/nuKnPi6xOmJwDEBlxiJERaZb
 RLkG0rAn5L93VPTeg==
X-Google-Smtp-Source: AGHT+IG1Tai8/abM8x0q/IVci8F0F6fUeOukD4pXCXbvx4PefXJe39/LjD15LDYredSB9majHzYq/g==
X-Received: by 2002:a05:600c:4706:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d195495e1mr611450835e9.3.1767617631014; 
 Mon, 05 Jan 2026 04:53:51 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d33e2f4sm148697835e9.11.2026.01.05.04.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 04:53:50 -0800 (PST)
Date: Mon, 05 Jan 2026 13:53:50 +0100
Message-Id: <DFGO5L1W0DED.2G5VJDLYAJM7L@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
Mime-Version: 1.0
X-Mailer: aerc 0.18.2
References: <20251022020509.6945-1-wegao@suse.com>
 <20251224085004.10267-1-wegao@suse.com>
In-Reply-To: <20251224085004.10267-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] io_submit04: Add test case for RWF_NOWAIT flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Dec 24, 2025 at 9:49 AM CET, Wei Gao wrote:
> Fixes: #467
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  configure.ac                                  |  1 +
>  include/lapi/aio_abi.h                        | 44 ++++++++++
>  runtest/syscalls                              |  1 +
>  .../kernel/syscalls/io_submit/.gitignore      |  1 +
>  .../kernel/syscalls/io_submit/io_submit04.c   | 86 +++++++++++++++++++
>  5 files changed, 133 insertions(+)
>  create mode 100644 include/lapi/aio_abi.h
>  create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c
>
> diff --git a/configure.ac b/configure.ac
> index a0ebbb34d..ee46e3f24 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -172,6 +172,7 @@ AC_CHECK_FUNCS_ONCE([ \
>  ])
>  AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
>  
> +AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
>  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
>  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
>  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> diff --git a/include/lapi/aio_abi.h b/include/lapi/aio_abi.h
> new file mode 100644
> index 000000000..bd8c2965b
> --- /dev/null
> +++ b/include/lapi/aio_abi.h
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +#ifndef LAPI_AIO_ABI_H__
> +#define LAPI_AIO_ABI_H__
> +
> +#include <endian.h>
> +#include <linux/aio_abi.h>
> +
> +#ifndef RWF_NOWAIT
> +# define RWF_NOWAIT 0x00000008
> +#endif
> +
> +struct iocb_fallback {
> +        uint64_t aio_data;
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +        uint32_t   aio_key;
> +        uint32_t aio_rw_flags;
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +        uint32_t aio_rw_flags;
> +        uint32_t   aio_key;
> +#else
> +#error edit for your odd byteorder.
> +#endif
> +        uint16_t   aio_lio_opcode;
> +        int16_t   aio_reqprio;
> +        uint32_t   aio_fildes;
> +        uint64_t   aio_buf;
> +        uint64_t   aio_nbytes;
> +        int64_t   aio_offset;
> +        uint64_t   aio_reserved2;
> +        uint32_t   aio_flags;
> +        uint32_t   aio_resfd;
> +};
> +
> +#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
> +typedef struct iocb_fallback iocb;
> +#else
> +typedef struct iocb iocb;
> +#endif
> +
> +#endif /* LAPI_AIO_ABI_H__ */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a1ef7548b..18182a2d6 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -696,6 +696,7 @@ io_setup02 io_setup02
>  io_submit01 io_submit01
>  io_submit02 io_submit02
>  io_submit03 io_submit03
> +io_submit04 io_submit04
>  
>  keyctl01 keyctl01
>  keyctl02 keyctl02
> diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
> index 60b07970a..abe962e1c 100644
> --- a/testcases/kernel/syscalls/io_submit/.gitignore
> +++ b/testcases/kernel/syscalls/io_submit/.gitignore
> @@ -1,3 +1,4 @@
>  /io_submit01
>  /io_submit02
>  /io_submit03
> +/io_submit04
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit04.c b/testcases/kernel/syscalls/io_submit/io_submit04.c
> new file mode 100644
> index 000000000..bae89828a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Test iocb RWF_* flags support: RWF_NOWAIT
> + *
> + * Checks if an asynchronous read operation with RWF_NOWAIT on a blocking
> + * resource (empty pipe) fails immediately with -EAGAIN.

We can write it better:

/*\
 * Test RWF_NOWAIT support in io_submit(), verifying that an
 * asynchronous read operation on a blocking resource (empty pipe)
 * will cause -EAGAIN. This is done by checking that io_getevents()
 * syscall returns immediately and io_event.res is equal to -EAGAIN.
 */

> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/aio_abi.h"
> +
> +static int fd[2];
> +static char buf[100];
> +
> +static aio_context_t ctx;
> +static iocb cb;
> +static iocb *iocbs[] = {&cb};

Data that is passed to syscalls should be initialized via tst_test.bufs

> +
> +static inline void io_prep_option(iocb *cb, int fd, void *buf,
> +			size_t count, long long offset, unsigned int opcode)
> +{
> +	memset(cb, 0, sizeof(*cb));
> +	cb->aio_fildes = fd;
> +	cb->aio_lio_opcode = opcode;
> +	cb->aio_buf = (uint64_t)buf;
> +	cb->aio_offset = offset;
> +	cb->aio_nbytes = count;
> +	cb->aio_rw_flags = RWF_NOWAIT;
> +}
> +
> +static void setup(void)
> +{
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
> +	SAFE_PIPE(fd);
> +	io_prep_option(&cb, fd[0], buf, sizeof(buf), 0, IOCB_CMD_PREAD);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd[0])
> +		SAFE_CLOSE(fd[0]);
> +
> +	if (fd[1])
> +		SAFE_CLOSE(fd[1]);
> +
> +	if (tst_syscall(__NR_io_destroy, ctx))
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
> +}
> +
> +static void run(void)
> +{
> +	struct io_event evbuf;
> +	struct timespec timeout = { .tv_sec = 1 };
> +	long nr = 1;
> +
> +	TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
> +
> +	if (TST_RET == nr)
> +		tst_res(TPASS, "io_submit() pass");
> +	else
> +		tst_res(TFAIL | TTERRNO, "io_submit() returns %ld, expected %ld", TST_RET, nr);

Our goal is to verify that io_getevents() returns EAGAIN, so we can just:

if (TST_RET != nr) {
	tst_res(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld", TST_RET, nr);
	return;
}

We return because if io_submit() fails there's nothing to do more.

> +
> +	tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout);
> +
> +	if (evbuf.res == -EAGAIN)
> +		tst_res(TINFO, "io_submit RWF_NOWAIT flag check pass");

Why TINFO if we are testing this feature? Also the message is not giving
any information of io_getevents(). We can just (look below)...

> +	else
> +		tst_res(TFAIL | TTERRNO, "io_submit expect EAGAIN, but get %s", strerror(-evbuf.res));
> +
> +}

if (evbuf.res == -EAGAIN)
	tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
else
	tst_res(TFAIL | TTERRNO, "io_getevents() returned with %s instead of EAGAIN", strerror(-evbuf.res));

> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AIO=y",
> +		NULL
> +	},
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
