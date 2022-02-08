Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189D8C433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:47:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 275913C9B4D
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 12:47:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F2953C0E9D
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 12:47:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2FB4200B65
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 12:47:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B75C0210F8;
 Tue,  8 Feb 2022 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644320852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWjYilmPjFEyoBN4cPplkli/RyaVl0lS4WGuz4ehn7Y=;
 b=GcakN5ghUbVYbaUB+5KraxExRFTD1sp3pQYNpKwgGNCop3w/9zWWrQankRwLfXorZ8l5Iq
 UZFhwQ6jt/mmy9BwbMd8oTNsWd2LcmrhWPDbp2e7ficfC4dlkvNFoxAm4J8UCBouhFva0M
 MuhkE8KK75Pv9ng/O8P0SDdFjJu464k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644320852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWjYilmPjFEyoBN4cPplkli/RyaVl0lS4WGuz4ehn7Y=;
 b=3nv+qKLVL8OufdRSvb526v3yGpIfyCt5UqTBdiq51XRnMbtNpU/kZe0R31X7JIunwLKWYy
 r95EPRUphWfyOwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AF7713C99;
 Tue,  8 Feb 2022 11:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PgHcJFRYAmLnKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 11:47:32 +0000
Date: Tue, 8 Feb 2022 12:49:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgJY0DLBR5ptRjm9@yuki>
References: <20220207144148.27033-1-andrea.cervesato@suse.de>
 <20220207144148.27033-4-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220207144148.27033-4-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] Add futex_waitv testing suite
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
> v4 introduces guarded buffers, more safe macros and TST_THREAD_STATE_WAIT usage.
> 
>  testcases/kernel/syscalls/futex/.gitignore    |   3 +
>  testcases/kernel/syscalls/futex/Makefile      |  14 +-
>  testcases/kernel/syscalls/futex/futex2test.h  |  30 ++++
>  .../kernel/syscalls/futex/futex_waitv01.c     | 162 ++++++++++++++++++
>  .../kernel/syscalls/futex/futex_waitv02.c     | 111 ++++++++++++
>  .../kernel/syscalls/futex/futex_waitv03.c     | 122 +++++++++++++
>  testcases/kernel/syscalls/futex/futextest.h   |  58 ++-----
>  7 files changed, 456 insertions(+), 44 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/futex/futex2test.h
>  create mode 100644 testcases/kernel/syscalls/futex/futex_waitv01.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_waitv02.c
>  create mode 100644 testcases/kernel/syscalls/futex/futex_waitv03.c
> 
> diff --git a/testcases/kernel/syscalls/futex/.gitignore b/testcases/kernel/syscalls/futex/.gitignore
> index 54cd02b02..9d08ba7d3 100644
> --- a/testcases/kernel/syscalls/futex/.gitignore
> +++ b/testcases/kernel/syscalls/futex/.gitignore
> @@ -10,3 +10,6 @@
>  /futex_wake02
>  /futex_wake03
>  /futex_wake04
> +/futex_waitv01
> +/futex_waitv02
> +/futex_waitv03
> diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
> index 5713c615d..7228496bc 100644
> --- a/testcases/kernel/syscalls/futex/Makefile
> +++ b/testcases/kernel/syscalls/futex/Makefile
> @@ -3,8 +3,18 @@
>  
>  top_srcdir		?= ../../../..
>  
> -futex_cmp_requeue01 futex_cmp_requeue02 futex_wait02 futex_wake03 futex_wait05 futex_wait_bitset01: LDLIBS += -lrt
> -futex_wait03 futex_wake02 futex_wake04: CFLAGS += -pthread
> +futex_cmp_requeue01: LDLIBS+=-lrt
> +futex_cmp_requeue02: LDLIBS+=-lrt
> +futex_wait02: LDLIBS+=-lrt
> +futex_wake03: LDLIBS+=-lrt
> +futex_wait05: LDLIBS+=-lrt
> +futex_wait_bitset01: LDLIBS+=-lrt
> +
> +futex_wait03: CFLAGS+=-pthread
> +futex_wake02: CFLAGS+=-pthread
> +futex_wake04: CFLAGS+=-pthread
> +futex_waitv02: CFLAGS+=-pthread
> +futex_waitv03: CFLAGS+=-pthread
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
> new file mode 100644
> index 000000000..ec3667376
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex2test.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Futex2 library addons for futex tests
> + *
> + * Copyright 2021 Collabora Ltd.
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef _FUTEX2TEST_H
> +#define _FUTEX2TEST_H

Please do not use indentifiers starting with underscore, these are
reserved for system libraries and kernel.

> +
> +#include <stdint.h>
> +#include "lapi/syscalls.h"
> +#include "futextest.h"
> +
> +/**
> + * futex_waitv - Wait at multiple futexes, wake on any
> + * @waiters:    Array of waiters
> + * @nr_waiters: Length of waiters array
> + * @flags: Operation flags
> + * @timo:  Optional timeout for operation
> + */
> +static inline int futex_waitv(volatile struct futex_waitv *waiters,
> +			      unsigned long nr_waiters, unsigned long flags,
> +			      struct timespec *timo, clockid_t clockid)
> +{
> +	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> +}
> +
> +#endif /* _FUTEX2TEST_H */
> \ No newline at end of file

Please make sure that there are newlines at the end of the files.

> diff --git a/testcases/kernel/syscalls/futex/futex_waitv01.c b/testcases/kernel/syscalls/futex/futex_waitv01.c
> new file mode 100644
> index 000000000..928740c2f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies EINVAL for futex_waitv syscall.
> + */
> +
> +#include <time.h>
> +#include "tst_test.h"
> +#include "lapi/futex.h"
> +#include "futex2test.h"
> +#include "tst_safe_clocks.h"
> +
> +static uint32_t *futex;
> +static struct futex_waitv *waitv;
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants tv;
> +
> +	tv = futex_variants();
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);

Unlike other tests this one does not actually use different variants of
the syscall nor it sets the .variants field in tst_test, so this part is
useless.

> +	futex = SAFE_MALLOC(sizeof(uint32_t));
> +	*futex = FUTEX_INITIALIZER;
> +
> +	waitv = tst_alloc(sizeof(struct futex_waitv));

There is no need to allocate waitv here, it has been allcated allready
since it's passed in the tst_buffers array in tst_test structure.

> +}
> +
> +static void init_timeout(struct timespec *to)
> +{
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, to);
> +	to->tv_sec++;
> +}
> +
> +static void init_waitv(void)
> +{
> +	waitv->uaddr = (uintptr_t)&futex;
> +	waitv->flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +	waitv->val = 0;
> +}
> +
> +static void test_invalid_flags(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Testing a waiter without FUTEX_32 flag */
> +	waitv->flags = FUTEX_PRIVATE_FLAG;
> +
> +	res = futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL) {
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res,
> +			tst_strerrno(res));
> +	} else {
> +		tst_res(TPASS, "futex_waitv with invalid flags");
> +	}

This does not seem to make any sense.

I think that you got confused here by the fact that futex_waitv()
behaves differently when called by the tst_syscall() wrapper. As far as
I can tell it does return -1 and sets errno in a case of a failure, so
we should be able to use TST_EXP_FAIL() here and in the rest of the
tests.

> +}
> +
> +static void test_unaligned_address(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Testing a waiter with an unaligned address */
> +	waitv->uaddr = 1;
> +
> +	res = futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL) {
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res,
> +			tst_strerrno(res));
> +	} else {
> +		tst_res(TPASS, "futex_waitv with unligned address");
> +	}
> +}
> +
> +static void test_null_address(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Testing a NULL address */
> +	waitv->uaddr = 0x00000000;
> +
> +	res = futex_waitv(waitv, 1, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL) {
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res,
> +			tst_strerrno(res));
> +	} else {
> +		tst_res(TPASS, "futex_waitv address is NULL");
> +	}
> +}
> +
> +static void test_null_waiters(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	init_timeout(&to);
> +
> +	/* Testing a NULL address for *waiters */
> +	res = futex_waitv(NULL, 1, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL) {
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res,
> +			tst_strerrno(res));
> +	} else {
> +		tst_res(TPASS, "futex_waitv waiters are NULL");
> +	}
> +}
> +
> +static void test_invalid_clockid(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	init_waitv();
> +	init_timeout(&to);
> +
> +	/* Testing an invalid clockid */
> +	res = futex_waitv(waitv, 1, 0, &to, CLOCK_TAI);
> +	if (res == EINVAL) {
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res,
> +			tst_strerrno(res));
> +	} else {
> +		tst_res(TPASS, "futex_waitv invalid clockid");
> +	}
> +}
> +
> +static void run(void)
> +{
> +	test_invalid_flags();
> +	test_unaligned_address();
> +	test_null_address();
> +	test_null_waiters();
> +	test_invalid_clockid();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "5.16",
> +	.bufs =
> +		(struct tst_buffers[]){
> +			{ &waitv, .size = sizeof(*waitv) },
> +			{},
> +		},
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
> new file mode 100644
> index 000000000..d58de293f
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies futex_waitv syscall using private data.
> + */
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <time.h>
> +#include "tst_test.h"
> +#include "lapi/futex.h"
> +#include "lapi/syscalls.h"
> +#include "futex2test.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_safe_clocks.h"
> +
> +static char *str_numfutex;
> +static int numfutex = 30;
> +
> +static uint32_t *futexes;
> +static struct futex_waitv *waitv;
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants tv;
> +	int i;
> +
> +	tv = futex_variants();
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);

Since this test actually uses the function from variants it must set the
.variants filed in the test_test structure.

> +	tst_syscall(__NR_gettid);
> +
> +	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
> +		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
> +
> +	futexes = tst_alloc(sizeof(uint32_t) * numfutex);
> +	memset(futexes, 0, numfutex);
> +
> +	waitv = tst_alloc(sizeof(struct futex_waitv) * numfutex);
> +	for (i = 0; i < numfutex; i++) {
> +		waitv[i].uaddr = (uintptr_t)&futexes[i];
> +		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +		waitv[i].val = 0;
> +	}

Since these two are allocated dynamically based on a commandline
parameter we have to allocate them here and not by passing the pointers
into the tst_test structure.

> +}
> +
> +static void *threaded(void *arg)
> +{
> +	struct futex_test_variants tv;
> +	int ret, tid = *(int *)arg;
> +
> +	tv = futex_variants();
> +	TST_THREAD_STATE_WAIT(tid, 'S', 0);
> +
> +	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr,
> +			 1, FUTEX_PRIVATE_FLAG);
> +	if (ret < 0) {
> +		tst_brk(TBROK, "futex_wake private returned: %d %s", ret,
> +			tst_strerrno(-ret));
> +	}
> +
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	struct timespec to;
> +	int ret, tid;
> +	pthread_t t;
> +
> +	tid = tst_syscall(__NR_gettid);
> +
> +	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
> +
> +	/* setting absolute timeout for futex2 */
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
> +	to.tv_sec++;
> +
> +	ret = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
> +	else if (ret != numfutex - 1)
> +		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);

Here as well, the tst_sycall() wrapper should set the errno instead of
returning the -err.

> +	SAFE_PTHREAD_JOIN(t, NULL);
> +	tst_res(TPASS, "futex_waitv returned correctly");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "5.16",
> +	.bufs =
> +		(struct tst_buffers[]){
> +			{ &waitv, .size = sizeof(*waitv) },
> +			{ &futexes, .size = sizeof(*futexes) },
> +			{},
> +		},
> +	.options =
> +		(struct tst_option[]){
> +			{ "n:", &str_numfutex, "Number of futex (default 30)" },
> +			{},
> +		},
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
> new file mode 100644
> index 000000000..4f3b83ff1
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies futex_waitv syscall using shared data.
> + */
> +
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <time.h>
> +#include <sys/shm.h>
> +#include "tst_test.h"
> +#include "lapi/futex.h"
> +#include "lapi/syscalls.h"
> +#include "futex2test.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_safe_clocks.h"
> +
> +static char *str_numfutex;
> +static int numfutex = 30;
> +
> +static struct futex_waitv *waitv;
> +
> +static void setup(void)
> +{
> +	struct futex_test_variants tv;
> +	int shm_id;
> +	int i;
> +
> +	tv = futex_variants();
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);

Here as well .variants in the tst_test structure.

> +	tst_syscall(__NR_gettid);

What is this useful for?

> +	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
> +		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
> +
> +	waitv = tst_alloc(sizeof(struct futex_waitv) * numfutex);
> +	for (i = 0; i < numfutex; i++) {
> +		shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
> +		if (shm_id < 0)
> +			tst_brk(TBROK, "shmget");

We do have SAFE_SHMGET()

> +		unsigned int *shared_data = shmat(shm_id, NULL, 0);

And SAFE_SHMAT()

> +		waitv[i].uaddr = (uintptr_t)shared_data;
> +		waitv[i].flags = FUTEX_32;
> +		waitv[i].val = 0;
> +	}

Here as well can't be allocated by passing pointer in tst_test
structure.

> +}
> +
> +static void cleanup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < numfutex; i++)
> +		shmdt((void *)(uintptr_t)waitv[i].uaddr);

I guess that we should only detach what was previously attached. Maybe
just memset the waitv to 0 first then do SAFE_SHMDT() for any non-zero
uaddr.

> +}
> +
> +static void *threaded(void *arg)
> +{
> +	struct futex_test_variants tv;
> +	int ret, tid = *(int *)arg;
> +
> +	tv = futex_variants();
> +	TST_THREAD_STATE_WAIT(tid, 'S', 0);
> +
> +	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, 0);
> +	if (ret < 0) {
> +		tst_brk(TBROK, "futex_wake private returned: %d %s", ret,
> +			tst_strerrno(-ret));
> +	}
> +
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	struct timespec to;
> +	int ret, tid;
> +	pthread_t t;
> +
> +	tid = tst_syscall(__NR_gettid);
> +
> +	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&tid);
> +
> +	/* setting absolute timeout for futex2 */
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &to);
> +	to.tv_sec++;
> +
> +	ret = futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
> +	else if (ret != numfutex - 1)
> +		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);

And here as well.

> +	SAFE_PTHREAD_JOIN(t, NULL);
> +	tst_res(TPASS, "futex_waitv returned correctly");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "5.16",
> +	.bufs =
> +		(struct tst_buffers[]){
> +			{ &waitv, .size = sizeof(*waitv) },
> +			{},
> +		},
> +	.options =
> +		(struct tst_option[]){
> +			{ "n:", &str_numfutex, "Number of futex (default 30)" },
> +			{},
> +		},
> +};
> diff --git a/testcases/kernel/syscalls/futex/futextest.h b/testcases/kernel/syscalls/futex/futextest.h
> index 3f2f36fef..cd925e686 100644
> --- a/testcases/kernel/syscalls/futex/futextest.h
> +++ b/testcases/kernel/syscalls/futex/futextest.h
> @@ -16,52 +16,11 @@
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> -#include <linux/futex.h>
>  #include "lapi/futex.h"
>  #include "tst_timer.h"
>  
>  #define FUTEX_INITIALIZER 0
>  
> -#ifndef FUTEX_CMP_REQUEUE
> -# define FUTEX_CMP_REQUEUE	4
> -#endif
> -#ifndef FUTEX_WAKE_OP
> -# define FUTEX_WAKE_OP		5
> -#endif
> -#ifndef FUTEX_LOCK_PI
> -# define FUTEX_LOCK_PI		6
> -#endif
> -#ifndef FUTEX_UNLOCK_PI
> -# define FUTEX_UNLOCK_PI	7
> -#endif
> -#ifndef FUTEX_WAIT_BITSET
> -# define FUTEX_WAIT_BITSET	9
> -#endif
> -#ifndef FUTEX_WAKE_BITSET
> -# define FUTEX_WAKE_BITSET	10
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI
> -# define FUTEX_WAIT_REQUEUE_PI	11
> -#endif
> -#ifndef FUTEX_CMP_REQUEUE_PI
> -# define FUTEX_CMP_REQUEUE_PI	12
> -#endif
> -#ifndef FUTEX_PRIVATE_FLAG
> -# define FUTEX_PRIVATE_FLAG	128
> -#endif
> -#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
> -# define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif
> -#ifndef FUTEX_REQUEUE_PI_PRIVATE
> -# define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
> -					 FUTEX_PRIVATE_FLAG)
> -#endif
> -
> -#ifndef FUTEX_CLOCK_REALTIME
> -# define FUTEX_CLOCK_REALTIME 256
> -#endif
> -
>  enum futex_fn_type {
>  	FUTEX_FN_FUTEX,
>  	FUTEX_FN_FUTEX64,
> @@ -74,6 +33,21 @@ struct futex_test_variants {
>  	char *desc;
>  };
>  
> +static inline struct futex_test_variants futex_variants(void)
> +{
> +	struct futex_test_variants variants[] = {
> +	#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
> +		{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec" },
> +	#endif
> +
> +	#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
> +		{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec" },
> +	#endif
> +	};
> +
> +	return variants[tst_variant];
> +}

We also need FUTEX_VARIANTS constant defined to 2 here so that we can
add it to the tst_test structure as .test_variants initialized.

Also it will be slight better it this function returned pointer to a
const data as:


static inline const struct futex_test_variants *futex_variant(void)
{
	...
}

>  static inline void futex_supported_by_kernel(enum futex_fn_type fntype)
>  {
>  	if (fntype != FUTEX_FN_FUTEX64)
> @@ -318,4 +292,4 @@ futex_set(futex_t *uaddr, u_int32_t newval)
>  	return newval;
>  }
>  
> -#endif
> +#endif /* _FUTEXTEST_H */
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
