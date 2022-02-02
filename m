Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E10C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 10:04:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BCAB3C98AF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 11:04:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CA353C8F8A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:04:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B89171400C52
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 11:04:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6C9C1F383;
 Wed,  2 Feb 2022 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643796286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJegfayGVQyMCFRHDxRfBMiY8dfkc8tg7GoHwzxBz3M=;
 b=xNUkRYdHhUAGzmqI44DvAnNGoWM5RknUX3yMjk00LkbLNJ1CrqYZbd09TFOdkVDNwTdU8G
 xSXHWD5yprqJG7cscm/NkpVwoKbZz24TMT40ckb99vrfb+q6OQHKkDJYmQwviBTfrdtXXX
 R+bk2AKUNX7m5sDFseL7QHATfG9kOc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643796286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RJegfayGVQyMCFRHDxRfBMiY8dfkc8tg7GoHwzxBz3M=;
 b=yf21O6RASYEzmZCgNfXKcuWpwU1WBpRCAbyw6WAyQ9WGA5Lk1G/tsdyDlY/vxSGD1XRjph
 8p5lynj354d0fWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AABB613DFF;
 Wed,  2 Feb 2022 10:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i6q/KD5X+mERWQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Feb 2022 10:04:46 +0000
Date: Wed, 2 Feb 2022 11:06:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YfpXssRUT1g7chXg@yuki>
References: <20220119091311.22150-1-andrea.cervesato@suse.de>
 <20220119091311.22150-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119091311.22150-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add futex_waitv testing suite
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
> new file mode 100644
> index 000000000..ccf1699de
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv01.c
> @@ -0,0 +1,129 @@
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
> +#include <stdlib.h>
> +#include <time.h>
> +#include "tst_test.h"
> +#include "futextest.h"
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
> +	tv = futex_variants[tst_variant];
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);
> +
> +	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
> +		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
> +
> +	futexes = SAFE_MALLOC(sizeof(uint32_t) * numfutex);
> +	memset(futexes, 0, numfutex);
> +
> +	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
> +	for (i = 0; i < numfutex; i++) {
> +		waitv[i].uaddr = (uintptr_t)&futexes[i];
> +		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +		waitv[i].val = 0;
> +	}

Can we allocate these data structures with the guarded buffers?

https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

> +}
> +
> +static void cleanup(void)
> +{
> +	free(futexes);
> +	free(waitv);
> +}
> +
> +static void init_timeout(struct timespec *to)
> +{
> +	if (clock_gettime(CLOCK_MONOTONIC, to))
> +		tst_brk(TBROK, "gettime64 failed");

SAFE_CLOCK_GETTIME()

> +	to->tv_sec++;
> +}
> +
> +static void run(void)
> +{
> +	struct timespec to;
> +	int res;
> +
> +	/* Testing a waiter without FUTEX_32 flag */
> +	waitv[0].flags = FUTEX_PRIVATE_FLAG;
> +
> +	init_timeout(&to);
> +
> +	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL)
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
> +	else
> +		tst_res(TPASS, "futex_waitv without FUTEX_32");
> +
> +	/* Testing a waiter with an unaligned address */
> +	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
> +	waitv[0].uaddr = 1;
> +
> +	init_timeout(&to);
> +
> +	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL)
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
> +	else
> +		tst_res(TPASS, "futex_waitv with an unaligned address");
> +
> +	/* Testing a NULL address for waiters.uaddr */
> +	waitv[0].uaddr = 0x00000000;
> +
> +	init_timeout(&to);
> +
> +	res = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL)
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
> +	else
> +		tst_res(TPASS, "futex_waitv NULL address in waitv.uaddr");
> +
> +	/* Testing a NULL address for *waiters */
> +	init_timeout(&to);
> +
> +	res = tst_futex_waitv(NULL, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (res == EINVAL)
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
> +	else
> +		tst_res(TPASS, "futex_waitv NULL address in *waiters");
> +
> +	/* Testing an invalid clockid */
> +	init_timeout(&to);
> +
> +	res = tst_futex_waitv(NULL, numfutex, 0, &to, CLOCK_TAI);
> +	if (res == EINVAL)
> +		tst_res(TFAIL, "futex_waitv private returned: %d %s", res, tst_strerrno(res));
> +	else
> +		tst_res(TPASS, "futex_waitv invalid clockid");

Can we put these testcases into a tcase structure as we usually do in
tests?

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "5.16",
> +	.test_variants = ARRAY_SIZE(futex_variants),
> +	.options = (struct tst_option[]){
> +		{"n:", &str_numfutex, "Number of futex (default 30)"},

I'm not sure if it makes that much sense to add the number of futexes to
this test.

> +		{},
> +	},
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv02.c b/testcases/kernel/syscalls/futex/futex_waitv02.c
> new file mode 100644
> index 000000000..a19568993
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv02.c
> @@ -0,0 +1,104 @@
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
> +#include <stdlib.h>
> +#include <time.h>
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "futextest.h"
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
> +	tv = futex_variants[tst_variant];
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);
> +
> +	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
> +		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
> +
> +	futexes = SAFE_MALLOC(sizeof(uint32_t) * numfutex);
> +	memset(futexes, 0, numfutex);
> +
> +	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
> +	for (i = 0; i < numfutex; i++) {
> +		waitv[i].uaddr = (uintptr_t)&futexes[i];
> +		waitv[i].flags = FUTEX_32 | FUTEX_PRIVATE_FLAG;
> +		waitv[i].val = 0;
> +	}

Here as well, guarded buffers please.

> +}
> +
> +static void cleanup(void)
> +{
> +	free(futexes);
> +	free(waitv);
> +}
> +
> +static void *threaded(void *arg)
> +{
> +	struct futex_test_variants tv;
> +	int ret, pid = *(int *)arg;
> +
> +	tv = futex_variants[tst_variant];
> +
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);
> +
> +	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, FUTEX_PRIVATE_FLAG);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_wake private returned: %d %s", ret, tst_strerrno(-ret));
> +
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	struct timespec to;
> +	int ret, pid = getpid();
> +	pthread_t t;
> +
> +	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&pid);
> +
> +	/* setting absolute timeout for futex2 */
> +	if (clock_gettime(CLOCK_MONOTONIC, &to))
> +		tst_brk(TBROK, "gettime64 failed");
> +
> +	to.tv_sec++;
> +
> +	ret = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
> +	else if (ret != numfutex - 1)
> +		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);
> +
> +	SAFE_PTHREAD_JOIN(t, NULL);
> +	tst_res(TPASS, "futex_waitv returned correctly");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "5.16",
> +	.test_variants = ARRAY_SIZE(futex_variants),
> +	.options = (struct tst_option[]){
> +		{"n:", &str_numfutex, "Number of futex (default 30)"},
> +		{},
> +	},
> +};
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv03.c b/testcases/kernel/syscalls/futex/futex_waitv03.c
> new file mode 100644
> index 000000000..3f18a15a2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv03.c
> @@ -0,0 +1,112 @@
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
> +#include <stdlib.h>
> +#include <time.h>
> +#include <sys/shm.h>
> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
> +#include "futextest.h"
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
> +	tv = futex_variants[tst_variant];
> +
> +	tst_res(TINFO, "Testing variant: %s", tv.desc);
> +	futex_supported_by_kernel(tv.fntype);
> +
> +	if (tst_parse_int(str_numfutex, &numfutex, 1, FUTEX_WAITV_MAX))
> +		tst_brk(TBROK, "Invalid number of futexes '%s'", str_numfutex);
> +
> +	waitv = SAFE_MALLOC(sizeof(struct futex_waitv) * numfutex);
> +	for (i = 0; i < numfutex; i++) {
> +		shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
> +		if (shm_id < 0)
> +			tst_brk(TBROK, "shmget");
> +
> +		unsigned int *shared_data = shmat(shm_id, NULL, 0);
> +
> +		waitv[i].uaddr = (uintptr_t)shared_data;
> +		waitv[i].flags = FUTEX_32;
> +		waitv[i].val = 0;
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < numfutex; i++)
> +		shmdt((void *)(uintptr_t)waitv[i].uaddr);
> +
> +	free(waitv);
> +}
> +
> +static void *threaded(void *arg)
> +{
> +	struct futex_test_variants tv;
> +	int ret, pid = *(int *)arg;
> +
> +	tv = futex_variants[tst_variant];
> +
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 0);

Hmm I guess that this works because the original thread that executes
the run() function is the one whose status is exported in the
/proc/$PID/stat file.

Technically there is no need to pass the pid like this since all threads
would have the same pid. What they differ in is the tid (there is no
difference in tid and pid from the kernel point of view though).

I guess that it would be cleaner though to add TST_THREAD_STATE_WAIT()
that would look exactly the same as TST_PROCESS_STATE_WAIT() but would
operate on the tid (see gettid()) and would open
/proc/self/task/$TID/stat instead of /proc/$PID/stat. That way we
could wait on any thread, not only the first one the program had started
with.

> +	ret = futex_wake(tv.fntype, (void *)(uintptr_t)waitv[numfutex - 1].uaddr, 1, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_wake private returned: %d %s", ret, tst_strerrno(-ret));
> +
> +	return NULL;
> +}
> +
> +static void run(void)
> +{
> +	struct timespec to;
> +	int ret, pid = getpid();
> +	pthread_t t;
> +
> +	SAFE_PTHREAD_CREATE(&t, NULL, threaded, (void *)&pid);
> +
> +	/* setting absolute timeout for futex2 */
> +	if (clock_gettime(CLOCK_MONOTONIC, &to))
> +		tst_brk(TBROK, "gettime64 failed");

SAFE_CLOCK_GETTIME()

> +	to.tv_sec++;
> +
> +	ret = tst_futex_waitv(waitv, numfutex, 0, &to, CLOCK_MONOTONIC);
> +	if (ret < 0)
> +		tst_brk(TBROK, "futex_waitv returned: %d %s", ret, tst_strerrno(-ret));
> +	else if (ret != numfutex - 1)
> +		tst_res(TFAIL, "futex_waitv returned: %d, expecting %d", ret, numfutex - 1);
> +
> +	SAFE_PTHREAD_JOIN(t, NULL);
> +	tst_res(TPASS, "futex_waitv returned correctly");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "5.16",
> +	.test_variants = ARRAY_SIZE(futex_variants),
> +	.options = (struct tst_option[]){
> +		{"n:", &str_numfutex, "Number of futex (default 30)"},
> +		{},
> +	},
> +};
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
