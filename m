Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228ECC77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 15:00:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32FBE3C92AE
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 17:00:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 088F63C597B
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 17:00:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62CAF600C54
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 17:00:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C6E5721172;
 Fri, 27 Jun 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B09E0138A7;
 Fri, 27 Jun 2025 15:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id is0nKgmyXmj6WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jun 2025 15:00:25 +0000
Date: Fri, 27 Jun 2025 17:01:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aF6yMvf2xLHZ6Y0d@yuki.lan>
References: <20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C6E5721172
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add clock_settime04 test
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
> Test that changing the value of the CLOCK_REALTIME clock via
> clock_settime(2) shall have no effect on a thread that is blocked
> on a relative clock_nanosleep().
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Both clock_settime_7-1 and clock_settime_8-1 are affected by the
> same bug which is probably related to the way tests are written.
> 
> sleep() is used by the parent and is not reliable. It can oversleep
> or undersleep according to system overload or signals which are
> received. And we never check for its return value. Using
> clock_nanosleep would make parent more reliable in this case.
> 
> At the same time, the test is taking for granted a certain
> synchronization between child and parent, which is not always true
> in case of system overload.
> 
> My suggestion is to rewrite the test using LTP, which has better
> timing handling (see tst_timer.h).
> ---
>  runtest/syscalls                                   |   1 +
>  testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
>  .../syscalls/clock_settime/clock_settime04.c       | 170 +++++++++++++++++++++
>  3 files changed, 172 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d5582ca8da01f11adba75a56d22cb6e5c4996c68..2dc734c5537f1d5477f4c98d08b9717fb89ac05c 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -112,6 +112,7 @@ leapsec01 leapsec01
>  clock_settime01 clock_settime01
>  clock_settime02 clock_settime02
>  clock_settime03 clock_settime03
> +clock_settime04 clock_settime04
>  
>  clone01 clone01
>  clone02 clone02
> diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
> index b66169b3eb7b4d8c8ea95e9e689b612d8da37b11..8bcc83d6fc9162087e99193a00b8d3d784d4737d 100644
> --- a/testcases/kernel/syscalls/clock_settime/.gitignore
> +++ b/testcases/kernel/syscalls/clock_settime/.gitignore
> @@ -1,3 +1,4 @@
>  clock_settime01
>  clock_settime02
>  clock_settime03
> +clock_settime04
> diff --git a/testcases/kernel/syscalls/clock_settime/clock_settime04.c b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6050fb3c6dabe81116d4a3697605d8137691458a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that changing the value of the CLOCK_REALTIME clock via
> + * clock_settime() shall have no effect on a thread that is blocked on
> + * absolute clock_nanosleep().
> + */
> +
> +#include "tst_test.h"
> +#include "tst_timer.h"
> +#include "time64_variants.h"
> +
> +#define SEC_TO_US(x)     (x * 1000 * 1000)
> +
> +#define CHILD_SLEEP_US   SEC_TO_US(5)
> +#define PARENT_SLEEP_US  SEC_TO_US(2)
> +#define DELTA_US         SEC_TO_US(1)
> +
> +static struct tst_ts *begin, *sleep_child, *sleep_parent, *end;
> +
> +static struct time64_variants variants[] = {
> +	{
> +		.clock_gettime = libc_clock_gettime,
> +		.clock_settime = libc_clock_settime,
> +		.clock_nanosleep = libc_clock_nanosleep,
> +		.ts_type = TST_LIBC_TIMESPEC,
> +		.desc = "vDSO or syscall with libc spec"
> +	},
> +
> +#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
> +	{
> +		.clock_gettime = sys_clock_gettime,
> +		.clock_settime = sys_clock_settime,
> +		.clock_nanosleep = sys_clock_nanosleep,
> +		.ts_type = TST_KERN_OLD_TIMESPEC,
> +		.desc = "syscall with old kernel spec"
> +	},
> +#endif
> +
> +#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{
> +		.clock_gettime = sys_clock_gettime64,
> +		.clock_settime = sys_clock_settime64,
> +		.clock_nanosleep = sys_clock_nanosleep64,
> +		.ts_type = TST_KERN_TIMESPEC,
> +		.desc = "syscall time64 with kernel spec"
> +	},
> +#endif
> +};
> +
> +static void child_nanosleep(struct time64_variants *tv, unsigned int tc_index)
> +{
> +	long long delta;
> +
> +	if (tc_index) {
> +		tst_res(TINFO, "Using absolute time sleep");
> +
> +		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US);
> +
> +		TST_CHECKPOINT_WAKE(0);

The elapsed time measurement would be much better if we took a
CLOCK_MONOTONIC timestamp here.

> +		TEST(tv->clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME,
> +				  tst_ts_get(sleep_child), NULL));
> +		if (TST_RET)
> +			tst_brk(TBROK | TERRNO, "clock_nanosleep() error");

And another one here. Getting the time in the parent before the fork and
checkpoints introduces quite a bit of randomness in the measurement that
does not need to be there.

Also I do not think that we need to use the variants for the interval
measurement here or in the parent that makes the wall clock jump back.

I would only use the variants for the clock_nanosleep() we are
measuring.

> +	} else {
> +		tst_res(TINFO, "Using relative time sleep");
> +
> +		tst_ts_set_sec(sleep_child, 0);
> +		tst_ts_set_nsec(sleep_child, 0);
> +
> +		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +
> +		TEST(tv->clock_nanosleep(CLOCK_REALTIME, 0,
> +				tst_ts_get(sleep_child), NULL));
> +		if (TST_RET)
> +			tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
> +
> +		/* normalize to absolute time so we can compare times later on */
> +		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US - PARENT_SLEEP_US);
> +	}
> +
> +	TEST(tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(end)));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TERRNO, "clock_gettime() error");
> +
> +	if (tst_ts_lt(*end, *sleep_child)) {
> +		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
> +			"end=%lld < sleep=%lld", tst_ts_get_sec(*end),
> +			tst_ts_get_sec(*sleep_child));
> +		return;
> +	}
> +
> +	delta = tst_ts_abs_diff_us(*sleep_child, *end);
> +	if (delta > DELTA_US) {
> +		tst_res(TFAIL, "clock_settime() affected child sleep. "
> +			"end=%lld <= sleep=%lld", tst_ts_get_nsec(*end),
> +			tst_ts_get_nsec(*sleep_child));
> +		return;
> +	}
> +
> +	tst_res(TPASS, "clock_settime() didn't affect child sleep "
> +		"(delta time: %lld us)", delta);
> +}
> +
> +static void run(unsigned int tc_index)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +
> +	TEST(tv->clock_gettime(CLOCK_REALTIME, tst_ts_get(begin)));
> +	if (TST_RET == -1)
> +		tst_brk(TBROK | TERRNO, "clock_gettime() error");
> +
> +	if (!SAFE_FORK()) {
> +		child_nanosleep(tv, tc_index);
> +		exit(0);
> +	}
> +
> +	*sleep_parent = tst_ts_add_us(*begin, PARENT_SLEEP_US);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	TEST(tv->clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME,
> +			  tst_ts_get(sleep_parent), NULL));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
> +
> +	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(begin)));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_settime() error");
> +
> +	tst_reap_children();
> +
> +	/* restore initial clock */
> +	*end = tst_ts_sub_us(*begin, PARENT_SLEEP_US);
> +
> +	TEST(tv->clock_settime(CLOCK_REALTIME, tst_ts_get(end)));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_settime() error");
> +}
> +
> +static void setup(void)
> +{
> +	begin->type = end->type = sleep_child->type = sleep_parent->type =
> +		variants[tst_variant].ts_type;
> +
> +	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.tcnt = 2,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,

We have .restore_wallclock which should be set by tests that mess with
wall time and the library will restore the clock automatically after the
test has finished. With that and the use of monotonic clock for the
interval measurement we can make the wall clock jump much more in the
parent. E.g. jump in random direction each 100ms or something like that.

> +	.test_variants = ARRAY_SIZE(variants),
> +	.bufs = (struct tst_buffers []) {
> +		{&begin, .size = sizeof(struct tst_ts)},
> +		{&sleep_child, .size = sizeof(struct tst_ts)},
> +		{&sleep_parent, .size = sizeof(struct tst_ts)},
> +		{&end, .size = sizeof(struct tst_ts)},
> +		{},
> +	}
> +};
> 
> ---
> base-commit: df591113afeb31107bc45bd5ba28a99b556d1028
> change-id: 20250620-clock_nanosleep05-60b3cfba52fe
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
