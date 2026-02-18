Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D1AE9A03B
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 12:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771417332; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kh8ld4pbXBOfAvQizCNTYbupDNl5cufIHGMpAJ0zH6g=;
 b=VUE6PL+fq2QaiymX0MJg3GK2kuwlmQfa2Wmd5r9kggvCW+uhFaNsIQmiCJFhn+kShxQ1m
 XzvoY3eAhKiKIvq9QHrHeZDQM6ptw1MhwshAlcKYbkX2z/SvkEKdIG67JOoFwbPWJ4dFtxn
 HnVy+Coz7AYtRXY6v04ez9NEoTopsJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45CA63D06F9
	for <ltp@archiver.kernel.org>; Wed, 18 Feb 2026 13:22:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10653CE321
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:21:48 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A745140053A
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 13:21:48 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso557562f8f.0
 for <ltp@lists.linux.it>; Wed, 18 Feb 2026 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771417307; x=1772022107; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGEMpOFG35kmijI3EctyPKZf0sjjoWj4Omf0KGbAZX8=;
 b=F1BBBY1pq6n8skpsmGuRC5n8x34FH1cqbWwhs8e48k2oPK5+uz8tmEPmmz/gRf+lB7
 4bftDTjgBtSB9dFqjPGMRXw+yB9TZJLlycNC8wD6Mifb8EjlfuMOtrm0jnYtIm1cF7At
 nV+R9hib8Q0T6f3HV2TYjNem/ltElPVemgeeJ2tnWXS7z1y5ruLVAJxTjvGYWq+Lnhvn
 Z0VGjEy6WvdimKN7er9cHLKf03u2WKPxd6cqmg5qPex8LzP2Ysf60tUi7jBiYBlLMFCF
 YFwAB9BAr29Sxo4rbq19ZWk6uHYgpI+pucynSbgVDBaBRLap35+iSwF6oGoj5gSnLaC0
 A2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771417307; x=1772022107;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGEMpOFG35kmijI3EctyPKZf0sjjoWj4Omf0KGbAZX8=;
 b=i3BkocxH+TiTWRmtFYrY6XmpY4IXeq5KqQIJopbhnZ4kycQdM+7tfIJCrop0BmlMQi
 M2u4Tctk063FiqyfpL8dDt3OuXciIMpES80Fv1fq4ZVopzHNPlLGGjeXIv6g1GDfaAyi
 lCxPwfmf9CyBq+tP6Srr7Wn2ssGPtakKYZ+yZ76QzAkXqOJXeSXA85kI+mw/9xSH7mds
 x5i55JVUucfd9w0af2/EHOPkacTdSNuwwyvyhOQHfDBkVqh1U4wO/3FP4Qc0pzkoBs/2
 Nq4p0CfpiB4wNJEjIv7+m9EZ3fHg+ikOtyeGVrv66YO91tvZeAs2qaAakE8NA1MBfbch
 D+qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkCPfE0q6i0ZRRMg4J8mxyLXcvb8Je+Cudc3eJUD8Yp2zMFYbkathNR8P2Gqyk4IGsE6M=@lists.linux.it
X-Gm-Message-State: AOJu0YwXnQIYNfdbElcmOjm77n7rrRaqGyxWcshZs9k7p6Yc7Ovnu5iW
 8Lr7m+ndKfYZb5pmKYO+mde2xAb9AF6chjXVdbGmgYbflYsWqXZmI7CFMlQMe91yxSZR6mccJYv
 bdAuD24U=
X-Gm-Gg: AZuq6aJlkXgohI3VIhyRSt88h84tsF6nMX4ZyBOKUDR5J7PO9PyeLx0n7OXe/GrNep3
 2ChiAUTNd8/ehunD0eivxadEp6Q6HHx7pRHfyxpNAfsxU+zj59RnSokgAV6lQRMzsO2j8Ld+kTX
 Zwp2nnNeLIPDZvqGf3PXUgSKDfa2IViom354NLv4fJ1CclhFJrRTu7Th9FLw+Y5rngIJ7Mfwx5m
 AB59O/y7dcFORlMZQWmVtTQnDJXKo0PSjDizZTSmclRW7ARTQuytuNp1vzoqggQuAIjr6rQPBgw
 nDt84Q9sDl0HgsGRTtNAPMmhfnPTW9tYFfB+jTE5fquaAt/qIa94ZPS/qqgYPGRPWB5XJORcEly
 iww/nBEvqYctMLXvH8PwFtRBGr2/sMgzkNGHuFKW8GvduvW8V99Hf0sJDlk5qnNz1bw8I8V/cHj
 0u8ifpq6mQBaruPLWTGIMNamZUk3k8nHUROKtw+D3LGCjg+mlANWFtWnVKAII1Et08NQcDSHoqx
 /yiL0W/8otf7LtQTvM=
X-Received: by 2002:a05:6000:18a4:b0:437:678b:83cd with SMTP id
 ffacd0b85a97d-43958c3dc94mr3335320f8f.15.1771417307158; 
 Wed, 18 Feb 2026 04:21:47 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5e5sm39320833f8f.9.2026.02.18.04.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 04:21:46 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 18 Feb 2026 13:21:46 +0100
Message-Id: <DGI3103QL3WD.19RTIBPXXCGXI@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251224085004.10267-1-wegao@suse.com>
 <20260107061008.18971-1-wegao@suse.com>
In-Reply-To: <20260107061008.18971-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] io_submit04: Add test case for RWF_NOWAIT flag
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

On Wed Jan 7, 2026 at 7:10 AM CET, Wei Gao wrote:
> Fixes: #467
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  configure.ac                                  |  1 +
>  include/lapi/aio_abi.h                        | 44 +++++++++
>  runtest/syscalls                              |  1 +
>  .../kernel/syscalls/io_submit/.gitignore      |  1 +
>  .../kernel/syscalls/io_submit/io_submit04.c   | 94 +++++++++++++++++++
>  5 files changed, 141 insertions(+)
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

checkpatch.pl reports you are using too many spaces for indentation in here.

> +
> +#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
> +typedef struct iocb_fallback iocb;

Why not just define here the iocb, instead of having iocb_fallback
defined before?

> +#else
> +typedef struct iocb iocb;

And this would not be needed then.

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
> index 000000000..d085d3238
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Test RWF_NOWAIT support in io_submit(), verifying that an
> + * asynchronous read operation on a blocking resource (empty pipe)
> + * will cause -EAGAIN. This is done by checking that io_getevents()
> + * syscall returns immediately and io_event.res is equal to -EAGAIN.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/aio_abi.h"
> +
> +

nit: double blank-line is not needed.

> +#define BUF_SIZE 100
> +
> +static int fd[2];

fd should be initialized to -1 and compared to this value in the
cleanup() before closing. zero is a valid value for file descriptors
(stdin).

> +
> +static aio_context_t ctx;
> +static char *buf;
> +static iocb *cb;
> +static iocb **iocbs;
> +
> +static void setup(void)
> +{
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));

We need to break the test here if io_setup fails. Silently failing it
will keep test running.

> +	SAFE_PIPE(fd);
> +
> +	cb->aio_fildes = fd[0];
> +	cb->aio_lio_opcode = IOCB_CMD_PREAD;
> +	cb->aio_buf = (uint64_t)buf;
> +	cb->aio_offset = 0;
> +	cb->aio_nbytes = BUF_SIZE;
> +	cb->aio_rw_flags = RWF_NOWAIT;
> +
> +	iocbs[0] = cb;
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
> +	if (ctx)
> +		if (tst_syscall(__NR_io_destroy, ctx))
> +			tst_brk(TBROK | TERRNO, "io_destroy() failed");
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
> +	if (TST_RET == -1 && errno == EOPNOTSUPP) {
> +		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
> +	} else if (TST_RET != nr) {
> +		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
> +				TST_RET, nr);
> +	}
> +
> +	tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout);

Return value is ignored.

> +
> +	if (evbuf.res == -EAGAIN)
> +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> +	else
> +		tst_res(TFAIL | TTERRNO, "io_getevents() returned with %s instead of EAGAIN",

TTERRNO is not needed.

> +			strerror(-evbuf.res));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AIO=y",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&buf, .size = BUF_SIZE},
> +		{&cb, .size = sizeof(iocb)},
> +		{&iocbs, .size = sizeof(iocb *)},
> +		{},
> +	}
> +};




-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
