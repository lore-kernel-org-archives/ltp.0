Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1430C83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 14:01:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096A13CA20F
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:01:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5AAC3C9FCD
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:01:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D49D120093F
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 16:01:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D67A221A33;
 Tue, 29 Jul 2025 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753797689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDj4kZdj9aDnXT9tuoGrk2PedjDiXqwaymHxYKDotes=;
 b=vaHar2ApZ5xBIcl+wFQsrcn64+6M0I3Wvpwjmwfi2LOncAW3FHpdAud+pmFuNL8sgQAR6M
 qVyo2Mm2RnB96GqL8E4f6ExCX1s/fEuFYRxEGeH7ahtpjs2RihmrlbErCCHUxgXNvVslvS
 B3T7M6zXkCx8eq+JmmO1X2bzKfWYXG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753797689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDj4kZdj9aDnXT9tuoGrk2PedjDiXqwaymHxYKDotes=;
 b=KeO1xCd+JwJMLRCnlrNf6oMUF5shI4vKAJGyJbkixt6bMzgPvnPgXpdr2LxyRE0/OZSvg6
 0hq1BlBY0QU72DBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753797688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDj4kZdj9aDnXT9tuoGrk2PedjDiXqwaymHxYKDotes=;
 b=dOrKE3ArtmmKMDClW6PB8PwGDQMdpy9NHlhY/DxDBz504huHJ7Qp709coXrdUKI/UYA2/S
 uYY6EdcgtgpKXEc+/wJT+AS9EaJ87wgwMiw26uXNuMcxdPfcQB2QkfKE8u/XkboA9/v7Qe
 0RlQs9fUZQrhBXD7Xh9HCoDvU9Q9+8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753797688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDj4kZdj9aDnXT9tuoGrk2PedjDiXqwaymHxYKDotes=;
 b=z1QkKN1CECSYOdGZ8diF03xuj0PyzxcVBYgYtbJw7UPGVKxKPIjuAeSm31OZMK8Tp+dNCl
 lFeRWpLrbYgLWVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C838D13A73;
 Tue, 29 Jul 2025 14:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PLjrLzjUiGiMKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Jul 2025 14:01:28 +0000
Date: Tue, 29 Jul 2025 16:02:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aIjUY9_MhWC3KMaN@yuki.lan>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
 <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add clock_settime04 test
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
> on a relative/absolute clock_nanosleep().
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                   |   1 +
>  testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
>  .../syscalls/clock_settime/clock_settime04.c       | 140 +++++++++++++++++++++
>  3 files changed, 142 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e738c332bf973840e6cc0bde489882eb65018991..5f392e4845e9ac7bcda30065997a5e6a7fb56945 100644
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
> index 0000000000000000000000000000000000000000..6372b038e18fbab94f2dc34b6745137eeb7dc578
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that changing the value of the CLOCK_REALTIME clock via
> + * clock_settime() shall have no effect on a thread that is blocked on
> + * absolute/relative clock_nanosleep().
> + */
> +
> +#include "tst_test.h"
> +#include "tst_timer.h"
> +#include "tst_safe_clocks.h"
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
> +		.clock_nanosleep = libc_clock_nanosleep,
> +		.ts_type = TST_LIBC_TIMESPEC,
> +		.desc = "vDSO or syscall with libc spec"
> +	},
> +
> +#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
> +	{
> +		.clock_nanosleep = sys_clock_nanosleep,
> +		.ts_type = TST_KERN_OLD_TIMESPEC,
> +		.desc = "syscall with old kernel spec"
> +	},
> +#endif
> +
> +#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{
> +		.clock_nanosleep = sys_clock_nanosleep64,
> +		.ts_type = TST_KERN_TIMESPEC,
> +		.desc = "syscall time64 with kernel spec"
> +	},
> +#endif
> +};
> +
> +static void child_nanosleep(struct time64_variants *tv, const int flags)
> +{
> +	long long delta;
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, tst_ts_get(begin));

Here as well, SAFE_CLOCK_GETTIME() uses struct timespec as defined by
libc, so we have to either use syscall that corresponds to the
begin->type (tv->clock_gettime), or covert the value from
SAFE_CLOCK_GETTIME() into the right type. I guess that it would look
like:

	struct timespec begin_ts;

	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &begin_ts);

	tst_ts_set_sec(begin, begin_ts.tv_sec);
	tst_ts_set_nsec(begin, begin_ts.tv_nsec);

Or maybe we can add tst_ts_convert() that would convert the timespec
into a different type. That way we may do:

	begin->type = TST_LIBC_TIMESPEC;

	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, tst_ts_get(begin));

	tst_ts_convert(begin, tv->type);

static inline void tst_ts_convert(struct tst_ts t, enum tst_ts_type type)
{
	long long sec = tst_ts_get_sec(t);
	long long nsec = tst_ts_get_nsec(t);

	t->type = type;

	tst_ts_set_sec(t, sec);
	tst_ts_set_sec(t, nsec);
}

> +	if (flags & TIMER_ABSTIME) {
> +		tst_res(TINFO, "Using absolute time sleep");
> +
> +		*sleep_child = tst_ts_add_us(*begin, CHILD_SLEEP_US);
> +	} else {
> +		tst_res(TINFO, "Using relative time sleep");
> +
> +		tst_ts_set_sec(sleep_child, 0);
> +		tst_ts_set_nsec(sleep_child, 0);
> +
> +		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);

These three lines could be just:

	*sleep_child = tst_tst_from_us(sleep_child->type, PARENT_SLEEP_US);

No need to zero it and then add the sleep value in us.


> +	}
> +
> +	TEST(tv->clock_nanosleep(CLOCK_REALTIME, flags, tst_ts_get(sleep_child), NULL));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, tst_ts_get(end));


Here as well, we either have to keep everything in the libc timespec and
use the tst_timespec_*() functions or covert the values properly.

> +	if (tst_ts_lt(*end, *begin)) {
> +		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
> +			"begin: %lld ms >= end: %lld ms",
> +			tst_ts_to_ms(*begin),
> +			tst_ts_to_ms(*end));
> +		return;
> +	}
> +
> +	delta = tst_ts_abs_diff_us(*begin, *end);
> +	if (!(flags & TIMER_ABSTIME))
> +		delta -= CHILD_SLEEP_US;
> +
> +	if (delta > DELTA_US) {
> +		tst_res(TFAIL, "parent clock_settime() affected child sleep. "
> +			"begin: %lld ms, end: %lld ms",
> +			tst_ts_to_ms(*begin),
> +			tst_ts_to_ms(*end));
> +		return;
> +	}
> +
> +	tst_res(TPASS, "parent clock_settime() didn't affect child sleep "
> +		"(delta time: %lld us)", delta);
> +}
> +
> +static void run(unsigned int tc_index)
> +{
> +	struct time64_variants *tv = &variants[tst_variant];
> +
> +	if (!SAFE_FORK()) {
> +		child_nanosleep(tv, tc_index ? TIMER_ABSTIME : 0);
> +		exit(0);
> +	}
> +
> +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, tst_ts_get(begin));
> +	SAFE_CLOCK_NANOSLEEP(CLOCK_REALTIME, 0, tst_ts_get(sleep_parent), NULL);
> +	SAFE_CLOCK_SETTIME(CLOCK_REALTIME, tst_ts_get(begin));

The SAFE_CLOCK_*() calls work with the struct timespec as defined by
libc. Using the tst_ts_get() here with the variant is wrong in this
case. The tst_ts_get() can be used only when we use the corresponding
tv->foo calls.

In this case we simply need to define the begin and sleep_parent as
struct timespec.

> +}
> +
> +static void setup(void)
> +{
> +	begin->type = end->type = sleep_child->type = sleep_parent->type =
> +		variants[tst_variant].ts_type;
> +
> +	tst_ts_set_sec(sleep_parent, 0);
> +	tst_ts_set_nsec(sleep_parent, 0);
> +
> +	*sleep_parent = tst_ts_add_us(*sleep_parent, PARENT_SLEEP_US);


> +	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.setup = setup,
> +	.tcnt = 2,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.restore_wallclock = 1,
> +	.test_variants = ARRAY_SIZE(variants),
> +	.bufs = (struct tst_buffers []) {
> +		{&sleep_child, .size = sizeof(struct tst_ts)},
> +		{&sleep_parent, .size = sizeof(struct tst_ts)},
> +		{&begin, .size = sizeof(struct tst_ts)},
> +		{&end, .size = sizeof(struct tst_ts)},
> +		{},
> +	}
> +};
> 
> -- 
> 2.50.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
