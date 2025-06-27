Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5DDC7EE2A
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 16:35:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DA313C9222
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 18:35:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66F1C3C76B8
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:35:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0648600C8F
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:35:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B36212117C;
 Fri, 27 Jun 2025 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751042127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ubNFVuOokob8SuYL/aoBw010SntLGw+UPbbCEXaZsV8=;
 b=IYbm9wSrO3tHe8VV/+zfpJB9SYhu4sUxV/VyX2fT3mbXNAXjRE+rRyMJ1+meiNPn6w7TbB
 m4aNcGtKtO/YVyRRjkwZNx4Vtc8fdfmQLnZWmlA4qO4nm0UvAhlp+uqGaseltJdSoz70/X
 Rb3Il7x7mChwRdOLF6by5GNipThgUvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751042127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ubNFVuOokob8SuYL/aoBw010SntLGw+UPbbCEXaZsV8=;
 b=sXK+hJVSBv18JQjqj+z1yiVy1TxNPkLo6trIkc/LnYFWVrGf4Cf2IJ/AhOgJXaD4gR2HB8
 Ny6uMlaqvovYmSDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751042127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ubNFVuOokob8SuYL/aoBw010SntLGw+UPbbCEXaZsV8=;
 b=IYbm9wSrO3tHe8VV/+zfpJB9SYhu4sUxV/VyX2fT3mbXNAXjRE+rRyMJ1+meiNPn6w7TbB
 m4aNcGtKtO/YVyRRjkwZNx4Vtc8fdfmQLnZWmlA4qO4nm0UvAhlp+uqGaseltJdSoz70/X
 Rb3Il7x7mChwRdOLF6by5GNipThgUvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751042127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ubNFVuOokob8SuYL/aoBw010SntLGw+UPbbCEXaZsV8=;
 b=sXK+hJVSBv18JQjqj+z1yiVy1TxNPkLo6trIkc/LnYFWVrGf4Cf2IJ/AhOgJXaD4gR2HB8
 Ny6uMlaqvovYmSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3A4513A8E;
 Fri, 27 Jun 2025 16:35:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OTpJk/IXmjkdAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 27 Jun 2025 16:35:27 +0000
Message-ID: <5be3efc6-8fd3-48d1-8911-438d86f2cd14@suse.cz>
Date: Fri, 27 Jun 2025 18:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250627-clock_nanosleep05-v1-1-1357109a2c81@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.cz:mid, suse.com:email]
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Cyril already reviewed clock usage so I'll add some suggestions for 
other improvements.

On 27. 06. 25 13:17, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
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
>   runtest/syscalls                                   |   1 +
>   testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
>   .../syscalls/clock_settime/clock_settime04.c       | 170 +++++++++++++++++++++
>   3 files changed, 172 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d5582ca8da01f11adba75a56d22cb6e5c4996c68..2dc734c5537f1d5477f4c98d08b9717fb89ac05c 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -112,6 +112,7 @@ leapsec01 leapsec01
>   clock_settime01 clock_settime01
>   clock_settime02 clock_settime02
>   clock_settime03 clock_settime03
> +clock_settime04 clock_settime04
>   
>   clone01 clone01
>   clone02 clone02
> diff --git a/testcases/kernel/syscalls/clock_settime/.gitignore b/testcases/kernel/syscalls/clock_settime/.gitignore
> index b66169b3eb7b4d8c8ea95e9e689b612d8da37b11..8bcc83d6fc9162087e99193a00b8d3d784d4737d 100644
> --- a/testcases/kernel/syscalls/clock_settime/.gitignore
> +++ b/testcases/kernel/syscalls/clock_settime/.gitignore
> @@ -1,3 +1,4 @@
>   clock_settime01
>   clock_settime02
>   clock_settime03
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

You could pass the flags for clock_nanosleep() from caller instead of 
passing tc_index. Then you need only the TINFO and sleep_child init in 
the condition and the code from TST_CHECKPOINT_WAKE() onward will be the 
same for both cases.

if (flags & TIMER_ABSTIME) {
	tst_res(...);
	*sleep_child = ...;
} else {
	tst_res(...);
	tst_ts_set_sec(...);
	tst_ts_set_nsec(...);
	*sleep_child = ...;
}

TST_CHECKPOINT_WAKE(0);
...

> +
> +		TST_CHECKPOINT_WAKE(0);
> +
> +		TEST(tv->clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME,
> +				  tst_ts_get(sleep_child), NULL));
> +		if (TST_RET)
> +			tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
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

If you check only tst_ts_abs_diff_us(*begin, *end), you don't need to 
conditionally modify sleep_child above.

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

Any non-zero value should trigger TBROK.

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


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
