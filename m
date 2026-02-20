Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE7C56206
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771601563; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RBF61Mddxnfr0Isn/EDlCJlRo+gdg4DXd70r/s2v0DQ=;
 b=fzPwWr9Z7XlMt1zMAfaRpc4Ty8AJir8EN+t4cm1bJMIyKX4dwUSFxM3f0uS5zRgQIJpPl
 x501c2HpFCz5pukJ8eJtCIc93+GLP97Tv4sJ+KMa1EDVCO3gSHFsgqh/A3hV78dxQHfdmN4
 Jvcfiv82CT0tuKHvo4zH2MO8mBIAnJ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318FF3D0842
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:32:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2163D03DC
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:32:19 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0367F1A00A43
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:32:18 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so1501537f8f.0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771601538; x=1772206338; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vyGNXwABoV32kbI6AT4tGwlRXKs4P0wxbfK/aVlh0I=;
 b=ISF1g8CsIONvZM252qUhcAGHKw1IS+AZFn12JdFEVXVHYVnuCg+sWwEFrRvv6CbNtU
 GvEFu0s2ugXiEIgD6FAtLiWMRJU+/lL9ky/6UAW/90EpqhKLFYw9jpfcF7KHOrXMlnnG
 0e/E7afulYnjs1MLpme/zFh+Nfj3fZVYLfHNTmW29EfFs9X2sJt7cTVYXEVLlIVkYzk/
 LRJxf5mQ/8jPdtPfXFcytR0ZTua2e+OPtXw6Gmz604KlvGBOGHfkFH4zLorUYlg+IXJ7
 K4qo+qDQrV/uxZsbNMtwmhqj90bU2ozgiU6WMIjYKxep2F6a3UvwteNEYn7B4ZNb/SGj
 HgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771601538; x=1772206338;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+vyGNXwABoV32kbI6AT4tGwlRXKs4P0wxbfK/aVlh0I=;
 b=jTBomg9AUyh935S/8Y4WwudRxzzLy2hbWOUh0mJpRdCbNhkaxONQ4o5JTnnxlyUWLt
 fth8DKh+nQqQek3UyGTYPHX6Ema79WpkasvKVo240ZTrVR7+wnafzKo2E3lTWqw5FpOe
 eLC9NCxURgtlmgw40K8KPtYTo/3FJ7gcclt5Qm95jkmtExRNOFcwnxzKGZ/rfiB63yap
 RiGqN5UwTSbYGPWsL0xttlOr8X/Cw2yAP9V2/tfGJYG/xkYsQQfCGuELKIltSe9qY9Ht
 lE3YaAMhRSTooAOlc8VS5bgJyZ/e6wg8gZadtsNuSrLvGAG86reBLJFoQqnty9X/pvsf
 5xfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMYwv1XPmBt4vo/cBwp70QFRK0W/mF0kyFYnsGyAWPUk4wL3AssuQJH5KFY6UXSUUdLxs=@lists.linux.it
X-Gm-Message-State: AOJu0YzSAlgeUBY/Kr3rEsv4JGbQ9zJN9M2lRmlO9uHrHpZydqwYXsSp
 R+y95GdTtOvcL0v6SrpFWYeljj0/4GidPxhPPpgnLFoUcKSkBloWZJyHYN6HEfxY+CA=
X-Gm-Gg: AZuq6aJIDoMWfHyKW6VF+Yu7t1WPNqA/L7yaLSxRaSUwydlLb9umhMwKOIxfYDJkEuW
 YLCv9ogCBCr1Npd3uJpkcTOTiUJZ4GkQ9V0AsqoydJENZrBs7ngyTYtLPHFywAPSwENPEryy6p9
 Zh5WcUInRuYQ+57rTXtlXRrkrU08zaYypUJOHe/YVET8+qA7io+8bU7J8TlMYoIZfhKVhKy4yzR
 dJJgShLKlwHbsQd3CMdeFNxFCNd8z6SL01wnn8+Ru8wmP1d6np4zKsfMPaWra1Xg2lMLTbXrCa9
 rsEthqecChJ5nxNbl5jx5+e52tr5qXpuaoH7seOe8lJS+OAA1N31XLKyfX6QFUaES9yeOAJ3/5b
 GOVJ/8ipDfmbaG1MI7fSygj4QGLGM2tmNp/sNBiPeiFKoGV+oKwzCHrGCOKyoUmj9AcLIIqnWbR
 r5zVtGBHnTqOEn1G8ADbYOIUyK
X-Received: by 2002:a5d:5e01:0:b0:437:68d5:f165 with SMTP id
 ffacd0b85a97d-4396f18f81fmr542508f8f.55.1771601538237; 
 Fri, 20 Feb 2026 07:32:18 -0800 (PST)
Received: from localhost ([88.128.90.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439567aad3csm23310294f8f.36.2026.02.20.07.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 07:32:17 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 16:32:17 +0100
Message-Id: <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
To: "Ricardo Branco" <rbranco@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260219225007.218697-1-rbranco@suse.de>
In-Reply-To: <20260219225007.218697-1-rbranco@suse.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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


On Thu Feb 19, 2026 at 11:50 PM CET, Ricardo Branco wrote:
> Signed-off-by: Ricardo Branco <rbranco@suse.de>
> ---
>  configure.ac                                  |   1 +
>  include/lapi/userfaultfd.h                    |  13 ++
>  .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
>  .../kernel/syscalls/userfaultfd/Makefile      |   1 +
>  .../syscalls/userfaultfd/userfaultfd06.c      | 137 ++++++++++++++++++
>  5 files changed, 153 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
>
> diff --git a/configure.ac b/configure.ac
> index 7fa614dcb..94bcbcc98 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -278,6 +278,7 @@ AC_CHECK_TYPES([struct sockaddr_vm],,,[
>  ])
>  
>  AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
> +AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
>  AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
>  
>  # Tools knobs
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 0c9e34c84..aab3890b7 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -233,6 +233,19 @@ struct uffdio_writeprotect {
>  };
>  #endif	/* HAVE_STRUCT_UFFDIO_WRITEPROTECT */
>  
> +#ifndef HAVE_STRUCT_UFFDIO_POISON
> +#define UFFD_FEATURE_POISON			(1<<14)
> +#define _UFFDIO_POISON				(0x08)
> +#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
> +				      struct uffdio_poison)
> +struct uffdio_poison {
> +        struct uffdio_range range;
> +#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
> +        __u64 mode;
> +        __s64 updated;
> +};
> +#endif	/* HAVE_STRUCT_UFFDIO_POISON */
> +
>  #define SAFE_USERFAULTFD(flags, retry) \
>  	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
>  
> diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
> index fb2ae243b..bc32fdf3b 100644
> --- a/testcases/kernel/syscalls/userfaultfd/.gitignore
> +++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
> @@ -3,3 +3,4 @@
>  /userfaultfd03
>  /userfaultfd04
>  /userfaultfd05
> +/userfaultfd06
> diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
> index 96650a65a..3252e47df 100644
> --- a/testcases/kernel/syscalls/userfaultfd/Makefile
> +++ b/testcases/kernel/syscalls/userfaultfd/Makefile
> @@ -16,3 +16,4 @@ userfaultfd02: CFLAGS += -pthread
>  userfaultfd03: CFLAGS += -pthread
>  userfaultfd04: CFLAGS += -pthread
>  userfaultfd05: CFLAGS += -pthread
> +userfaultfd06: CFLAGS += -pthread
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> new file mode 100644
> index 000000000..1f132d4d5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 SUSE LLC
> + * Author: Ricardo Branco <rbranco@suse.com>
> + */
> +
> +/*\
> + * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
> + * from a different thread testing UFFDIO_POISON.
> + */
> +
> +#include "config.h"
> +#include <poll.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "tst_safe_pthread.h"
> +#include "lapi/userfaultfd.h"
> +
> +static int page_size;
> +static char *page;
> +static int uffd;
> +static int poison_fault_seen;
> +static volatile int sigbus_seen;
> +static sigjmp_buf jmpbuf;
> +
> +static void sigbus_handler(int sig)
> +{
> +	if (sig == SIGBUS) {
> +		sigbus_seen = 1;
> +		siglongjmp(jmpbuf, 1);
> +	}
> +}
> +
> +static void set_pages(void)
> +{
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +}
> +
> +static void *handle_thread(void)
> +{
> +	static struct uffd_msg msg;
> +	struct uffdio_poison uffdio_poison = {};
> +	struct pollfd pollfd;
> +	int nready;
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +	nready = poll(&pollfd, 1, -1);
> +	if (nready == -1)
> +		tst_brk(TBROK | TERRNO, "Error on poll");
> +
> +	SAFE_READ(1, uffd, &msg, sizeof(msg));
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +
> +	tst_atomic_store(1, &poison_fault_seen);
> +
> +	/* Poison the page that triggered the fault */
> +	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
> +	uffdio_poison.range.len = page_size;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
> +
> +	close(uffd);
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api = {};
> +	struct uffdio_register uffdio_register;
> +	struct sigaction sa = {};
> +	volatile char dummy;

Here you need to reset the variables for -i > 1

> +
> +	sa.sa_handler = sigbus_handler;
> +	sigemptyset(&sa.sa_mask);
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +
> +	set_pages();

This is done every cycle of -i > 1, but memory is never released and
done once in cleanup().

> +
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);

Maybe this one should be closed inside run(), or even remove it from
static variables and passed to the thread, so we keep it inside run().

> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = UFFD_FEATURE_POISON;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +
> +	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
> +		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
> +
> +	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
> +
> +	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
> +	if (sigsetjmp(jmpbuf, 1) == 0) {
> +		dummy = page[0];
> +		(void)dummy;
> +	}
> +
> +	SAFE_PTHREAD_JOIN(thr, NULL);
> +
> +	int poisoned = tst_atomic_load(&poison_fault_seen);
> +
> +	if (poisoned && sigbus_seen)
> +		tst_res(TPASS, "POISON successfully triggered SIGBUS");
> +	else if (poison_fault_seen && !sigbus_seen)
> +		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
> +	else if (!poison_fault_seen && sigbus_seen)
> +		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
> +	else
> +		tst_res(TFAIL, "No poison fault or SIGBUS observed");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +};

You ar missing the runtest entry.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
