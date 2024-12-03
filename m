Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C822E64A85
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 12:18:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 809403DDF56
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 13:18:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43ED73DC5C0
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:18:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 47BFE101C58F
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:18:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 551631F445;
 Tue,  3 Dec 2024 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733228319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=810lRXG0tzUj2OizmsGcdtNO9XTVWnuYs928PnCB2Is=;
 b=TbY9eE2Gk9WcXD10gkSmj8WQ/94+fsjIw0AWRZQedjk24ixxErhYyPGWBS/o/j8KYoOJyc
 RRLJdrymwe9DFeNg/BQKofGQgehRL72hktUh3gJ2lUCZX45mHDIS4K7AEiKTucZgDJBjqM
 tMj54a4+vCYr18nLC0IAkJC8kr1Q77M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733228319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=810lRXG0tzUj2OizmsGcdtNO9XTVWnuYs928PnCB2Is=;
 b=bKjhVW+PP82aacSL/jubuQUb8vT2xoCbuwLHjpQw8q1MxYY7v796GEsO05kDbPLPk2TXNo
 gYn5E9qGXn65jkDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733228319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=810lRXG0tzUj2OizmsGcdtNO9XTVWnuYs928PnCB2Is=;
 b=TbY9eE2Gk9WcXD10gkSmj8WQ/94+fsjIw0AWRZQedjk24ixxErhYyPGWBS/o/j8KYoOJyc
 RRLJdrymwe9DFeNg/BQKofGQgehRL72hktUh3gJ2lUCZX45mHDIS4K7AEiKTucZgDJBjqM
 tMj54a4+vCYr18nLC0IAkJC8kr1Q77M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733228319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=810lRXG0tzUj2OizmsGcdtNO9XTVWnuYs928PnCB2Is=;
 b=bKjhVW+PP82aacSL/jubuQUb8vT2xoCbuwLHjpQw8q1MxYY7v796GEsO05kDbPLPk2TXNo
 gYn5E9qGXn65jkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 446F313A15;
 Tue,  3 Dec 2024 12:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0JDMDx/3TmeoCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Dec 2024 12:18:39 +0000
Date: Tue, 3 Dec 2024 13:18:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z073Lvv3h7cexyQq@yuki.lan>
References: <20241127121233.14638-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241127121233.14638-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: add extra calibrated runtime to slow
 tests
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
> +/*
> + * List of debug-kernel config options that may degrade performance when enabled.
> + */
> +static const char * const tst_kconf_debug_options[][2] = {
> +	{"CONFIG_PROVE_LOCKING=y", NULL},
> +	{"CONFIG_LOCKDEP=y", NULL},
> +	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
> +	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_MUTEXES=y", NULL},
> +	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
> +	{"CONFIG_KASAN=y", NULL},
> +	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
> +	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
> +	{"CONFIG_LATENCYTOP=y", NULL},
> +	{"CONFIG_DEBUG_NET=y", NULL},
> +	{"CONFIG_EXT4_DEBUG=y", NULL},
> +	{"CONFIG_QUOTA_DEBUG=y", NULL},
> +	{"CONFIG_FAULT_INJECTION=y", NULL},
> +	{"CONFIG_DEBUG_OBJECTS=y", NULL},
> +	{NULL, NULL}
> +};
> +
> +static inline int tst_kconfig_debug_matches(void)
> +{
> +	int i, num = 1;
> +
> +	for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++)
> +		num += !tst_kconfig_check(tst_kconf_debug_options[i]);
> +
> +	return num;
> +}
> +
>  #endif	/* TST_KCONFIG_H__ */
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index 6fb940020..268fc8389 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -17,6 +17,7 @@
>  #include <mqueue.h>
>  #include <time.h>
>  #include "tst_test.h"
> +#include "tst_clocks.h"
>  #include "lapi/common_timers.h"
>  #include "lapi/posix_types.h"
>  #include "lapi/syscalls.h"
> @@ -1074,4 +1075,33 @@ static inline long long tst_timer_elapsed_us(void)
>  	return tst_timespec_to_us(tst_timer_elapsed());
>  }
>  
> +#define CALLIBRATE_LOOPS 120000000
> +
> +/*
> + * Measures the time taken by the CPU to perform a specified
> + * number of empty loops for calibration.
> + */
> +static inline int tst_callibrate(void)
> +{
> +	int i;
> +	struct timespec start, stop;
> +	long long diff;
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++)
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +
> +	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &start);
> +
> +	for (i = 0; i < CALLIBRATE_LOOPS; i++)
> +		__asm__ __volatile__ ("" : "+g" (i) : :);
> +
> +	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &stop);
> +
> +	diff = tst_timespec_diff_us(stop, start);
> +
> +	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
> +
> +	return diff;
> +}
> +
>  #endif /* TST_TIMER */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8db554dea..296683ffb 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -549,13 +549,16 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
>  static int multiply_runtime(int max_runtime)
>  {
>  	static float runtime_mul = -1;
> +	static int extra_runtime = 0;
>  
>  	if (max_runtime <= 0)
>  		return max_runtime;
>  
>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
>  
> -	return max_runtime * runtime_mul;
> +	extra_runtime = (tst_callibrate() / 1000) * tst_kconfig_debug_matches();
> +
> +	return (max_runtime + extra_runtime) * runtime_mul;

I was hoping for a simpler calculation something as:

	if (any_kconfig_debug_enabled())
		max_runtime *= 4;

Or something along these lines. I do not think that the kernel will get
slower with each debug option enabled. And we are not looking for a
tight fit either, so the callbration loop does not make much sense here.

It also makes sense that a debug kernel will be N times slower, where
the exact N would be hard to find out, but in this case we just need a
reasonable upper bound.

And this would work nicely for the starvation test too, since we
calculate a tight fit there first, then we would multiply it by the
"debug kernel slowness" multiplier. There would be no need to modify the
starvation test in that case either (it may make sense to set the
runtime of the test to -1 so that the metadata will have an information
that the test runtime is unbound until we actually execute it though).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
