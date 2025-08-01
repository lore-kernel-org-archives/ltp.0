Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D757C87FCB
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 12:40:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2483CCEAA
	for <ltp@archiver.kernel.org>; Fri,  1 Aug 2025 14:40:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8CE3CCD39
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 14:40:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F2218200143
 for <ltp@lists.linux.it>; Fri,  1 Aug 2025 14:40:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90D8D2127D;
 Fri,  1 Aug 2025 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754052027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhe3eFVPtJ6EizWyqEzD90+qCS5r4KA4L4hz+jaoB4=;
 b=RYBP15cWbOujJ+spFeJS4LJ4uq34hVhqj75gg+K+nhYtWzAWNTVmEWt8MDpnFbYlQi+vOm
 8VIPvbHamvMAUtGu0VedrKerFBsCiS0cwXBJhxI1Eh5u43r24CzStr8arirjnUNXaeNk29
 OutvzwGSFBoUOQl7fqjDt8FUoTpzoAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754052027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhe3eFVPtJ6EizWyqEzD90+qCS5r4KA4L4hz+jaoB4=;
 b=3l7idKOsdR3VxK3oIobDQC6S1OG80VV4W0vJg7zPXIzVBnJPYFsbQkXGm4mPW7wjSFLAxu
 M2Y2k39UgZi7q0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754052027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhe3eFVPtJ6EizWyqEzD90+qCS5r4KA4L4hz+jaoB4=;
 b=RYBP15cWbOujJ+spFeJS4LJ4uq34hVhqj75gg+K+nhYtWzAWNTVmEWt8MDpnFbYlQi+vOm
 8VIPvbHamvMAUtGu0VedrKerFBsCiS0cwXBJhxI1Eh5u43r24CzStr8arirjnUNXaeNk29
 OutvzwGSFBoUOQl7fqjDt8FUoTpzoAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754052027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhe3eFVPtJ6EizWyqEzD90+qCS5r4KA4L4hz+jaoB4=;
 b=3l7idKOsdR3VxK3oIobDQC6S1OG80VV4W0vJg7zPXIzVBnJPYFsbQkXGm4mPW7wjSFLAxu
 M2Y2k39UgZi7q0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8267B13876;
 Fri,  1 Aug 2025 12:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RKmbHru1jGjcdwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 01 Aug 2025 12:40:27 +0000
Date: Fri, 1 Aug 2025 14:41:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aIy16j72Yke0W69n@yuki.lan>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
 <20250717-clock_nanosleep05-v4-2-78bc62df960f@suse.com>
 <aIjUY9_MhWC3KMaN@yuki.lan>
 <b0a34ad9-9e59-4d46-b202-2eada747b791@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0a34ad9-9e59-4d46-b202-2eada747b791@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
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
> > Here as well, SAFE_CLOCK_GETTIME() uses struct timespec as defined by
> > libc, so we have to either use syscall that corresponds to the
> > begin->type (tv->clock_gettime), or covert the value from
> > SAFE_CLOCK_GETTIME() into the right type. I guess that it would look
> > like:
> 
> Why not just going back to the original idea in v1, where we are using 
> the clock_gettime/settime corresponding to the right libc?

Actually the v4 was quite close to what I had in my mind, the corrected
code looks like:

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
 */

/*\
 * Verify that changing the value of the CLOCK_REALTIME clock via
 * clock_settime() shall have no effect on a thread that is blocked on
 * absolute/relative clock_nanosleep().
 */

#include "tst_test.h"
#include "tst_timer.h"
#include "tst_safe_clocks.h"
#include "time64_variants.h"

#define SEC_TO_US(x)     (x * 1000 * 1000)

#define CHILD_SLEEP_US SEC_TO_US(5)
#define PARENT_SLEEP_S 2
#define DELTA_US SEC_TO_US(1)

static struct tst_ts *sleep_child;

static struct time64_variants variants[] = {
	{
		.clock_nanosleep = libc_clock_nanosleep,
		.ts_type = TST_LIBC_TIMESPEC,
		.desc = "vDSO or syscall with libc spec"
	},

#if (__NR_clock_nanosleep != __LTP__NR_INVALID_SYSCALL)
	{
		.clock_nanosleep = sys_clock_nanosleep,
		.ts_type = TST_KERN_OLD_TIMESPEC,
		.desc = "syscall with old kernel spec"
	},
#endif

#if (__NR_clock_nanosleep_time64 != __LTP__NR_INVALID_SYSCALL)
	{
		.clock_nanosleep = sys_clock_nanosleep64,
		.ts_type = TST_KERN_TIMESPEC,
		.desc = "syscall time64 with kernel spec"
	},
#endif
};

static void child_nanosleep(struct time64_variants *tv, const int flags)
{
	long long delta;
	struct timespec begin, end;

	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &begin);

	if (flags & TIMER_ABSTIME) {
		tst_res(TINFO, "Using absolute time sleep");

		tst_ts_set_sec(sleep_child, begin.tv_sec);
		tst_ts_set_nsec(sleep_child, begin.tv_nsec);

		*sleep_child = tst_ts_add_us(*sleep_child, CHILD_SLEEP_US);
	} else {
		tst_res(TINFO, "Using relative time sleep");

		*sleep_child = tst_ts_from_us(sleep_child->type, CHILD_SLEEP_US);
	}

	TEST(tv->clock_nanosleep(CLOCK_REALTIME, flags, tst_ts_get(sleep_child), NULL));
	if (TST_RET)
		tst_brk(TBROK | TERRNO, "clock_nanosleep() error");

	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC, &end);

	if (tst_timespec_lt(end, begin)) {
		tst_res(TFAIL, "clock_settime() didn't sleep enough. "
			"begin: %lld ms >= end: %lld ms",
			tst_timespec_to_ms(begin),
			tst_timespec_to_ms(end));
		return;
	}

	delta = tst_timespec_abs_diff_us(begin, end);
	if (!(flags & TIMER_ABSTIME))
		delta -= CHILD_SLEEP_US;

	if (delta > DELTA_US) {
		tst_res(TFAIL, "parent clock_settime() affected child sleep. "
			"begin: %lld ms, end: %lld ms",
			tst_timespec_to_ms(begin),
			tst_timespec_to_ms(end));
		return;
	}

	tst_res(TPASS, "parent clock_settime() didn't affect child sleep "
		"(delta time: %lld us)", delta);
}

static void run(unsigned int tc_index)
{
	struct time64_variants *tv = &variants[tst_variant];
	struct timespec begin;
	struct timespec sleep_parent = {
		.tv_sec = PARENT_SLEEP_S,
	};

	if (!SAFE_FORK()) {
		child_nanosleep(tv, tc_index ? TIMER_ABSTIME : 0);
		exit(0);
	}

	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &begin);
	SAFE_CLOCK_NANOSLEEP(CLOCK_REALTIME, 0, &sleep_parent, NULL);
	SAFE_CLOCK_SETTIME(CLOCK_REALTIME, &begin);
}

static void setup(void)
{
	sleep_child->type = variants[tst_variant].ts_type;

	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
}

static struct tst_test test = {
	.test = run,
	.setup = setup,
	.tcnt = 2,
	.needs_root = 1,
	.forks_child = 1,
	.restore_wallclock = 1,
	.test_variants = ARRAY_SIZE(variants),
	.bufs = (struct tst_buffers []) {
		{&sleep_child, .size = sizeof(struct tst_ts)},
		{},
	}
};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
