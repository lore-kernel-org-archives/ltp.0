Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF0C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 16:30:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D60BC3CB3A7
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 18:30:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEEDF3CB28D
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:30:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 086CC1A00718
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 18:30:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB2591F749;
 Fri, 11 Jul 2025 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752251429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8C76nkteJvPgB27PPoJHP5N+w4JQPJMbFMuNXOkX9V4=;
 b=Q5A4svR9G1dlMBwyW0ohihyvmq1yrCxlOsdj+Qyvbl9tZPVkIVJ9cnnWBhNaKE2Q+LE2rj
 4NNHh4+pdNrKesLYouCKkIVWU5XQF7SUZP4m5jiL1PTO6Mj/eigo0acpUYmSmLG3xG5Z6f
 IdrkoB+K8lz/C3jRFs7pI+wyH0haM8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752251429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8C76nkteJvPgB27PPoJHP5N+w4JQPJMbFMuNXOkX9V4=;
 b=DvaYBZs2nbO+Ld75/MKJopamqdnXHX/h1MqVBqjBVSf65H5VjPo+m5c/xaVXlpZYrQKXHI
 NbhvFgNFRDBQbjCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752251428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8C76nkteJvPgB27PPoJHP5N+w4JQPJMbFMuNXOkX9V4=;
 b=28me1wCY2S3wZY7I0WKkkp5p3FkgUsp+NnL3ibmh/ZomkuxFIdErPp8orrskoPNty3W+vW
 F/Piv2LVZsbwAmP5MGjeUp9kHR6paGYfSU+OnvBrag1dpzf6A31XjIrQrGUu5iaMrZPHY1
 pgi21/eHSSndrJvgGkmO4gOCvOcmUb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752251428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8C76nkteJvPgB27PPoJHP5N+w4JQPJMbFMuNXOkX9V4=;
 b=/tMWGbUORQu44udLe0FNkFgJnhtuV844npC9lDT8HVn8ub8nhvze+sT0DPkChiwsnUPaRT
 3mFk0oVB8rKyt1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1ED71388B;
 Fri, 11 Jul 2025 16:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NVfFMiQ8cWgJeQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Jul 2025 16:30:28 +0000
Message-ID: <a58557c4-4fb6-4886-aa53-9abbaff96015@suse.cz>
Date: Fri, 11 Jul 2025 18:30:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250630-clock_nanosleep05-v2-0-15522d5551c6@suse.com>
 <20250630-clock_nanosleep05-v2-2-15522d5551c6@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250630-clock_nanosleep05-v2-2-15522d5551c6@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add clock_settime04 test
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
the parent changes CLOCK_REALTIME. If the child sleeps on 
CLOCK_MONOTONIC, the testcase makes no sense. You should use 
CLOCK_MONOTONIC to measure the length of child sleep but the child has 
to sleep on CLOCK_REALTIME.

On 30. 06. 25 13:56, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Test that changing the value of the CLOCK_MONOTONIC clock via
> clock_settime(2) shall have no effect on a thread that is blocked
> on a relative/absolute clock_nanosleep().
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/syscalls                                   |   1 +
>   testcases/kernel/syscalls/clock_settime/.gitignore |   1 +
>   .../syscalls/clock_settime/clock_settime04.c       | 153 +++++++++++++++++++++
>   3 files changed, 155 insertions(+)
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
> index 0000000000000000000000000000000000000000..bea42dd8d75a83b346952fc7d54d19e811ac742e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_settime/clock_settime04.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that changing the value of the CLOCK_MONOTONIC clock via
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
> +static void child_nanosleep(struct time64_variants *tv, const int flags)
> +{
> +	long long delta;
> +
> +	TEST(tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(begin)));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_gettime() error");
> +
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
> +	}
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	TEST(tv->clock_nanosleep(CLOCK_MONOTONIC, flags, tst_ts_get(sleep_child), NULL));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");
> +
> +	TEST(tv->clock_gettime(CLOCK_MONOTONIC, tst_ts_get(end)));
> +	if (TST_RET)
> +		tst_brk(TBROK | TERRNO, "clock_gettime() error");
> +
> +	if (tst_ts_lt(*end, *begin)) {
> +		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
> +			"begin: %lld ms >= end: %lld ms",
> +			tst_ts_to_ms(*begin),
> +			tst_ts_to_ms(*end));
> +		return;
> +	}
> +
> +	delta = tst_ts_abs_diff_us(*begin, *end) - CHILD_SLEEP_US;
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
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_CLOCK_NANOSLEEP(CLOCK_REALTIME, 0, tst_ts_get(sleep_parent), NULL);
> +	SAFE_CLOCK_SETTIME(CLOCK_REALTIME, tst_ts_get(begin));
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
