Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB80FD374E
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 13:18:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15B8E3C93D2
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 14:18:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AB6B3C5398
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:18:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E3553600874
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 14:18:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 514924D7CE;
 Wed, 25 Feb 2026 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772025481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcz2XQVKIVOCU/OfrDUiRiG7pyZT6aR/965IeAgSr5s=;
 b=LGGiOFpd16/H8Y7GD3oEVkw5bUxvgbrq1Jkp65ITCfKVvZCSB0v58nJQqFK/H95A1a+zlp
 lA4eMtjv3QjqCDYXwm8A84xbjC7PRU9MDqdfQbiYmlP4nxqbbA9Lt+aVjKtLUzVcKlbvhg
 3+WHXFGc49uH3LUe/IUqCCElR3X32uQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772025481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcz2XQVKIVOCU/OfrDUiRiG7pyZT6aR/965IeAgSr5s=;
 b=lgqanyP3hwstI+QgvmLsLOUowtcbLYvUi09MJdF0a0llf5o99bgfqdd7Au6DKsSWf+DO+/
 pCcr0Tf1U9t6hZCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772025480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcz2XQVKIVOCU/OfrDUiRiG7pyZT6aR/965IeAgSr5s=;
 b=ErwriDPuSfLFF047PfP3krXYbi6RNZtve+VySvYlsif29hf3dElKu/clEgVeCxG9F5UOwc
 RjX/T5s1Ncsh6Om3BDpPokDiB462tCBbheZA1WZAw4Tbnh0VSwCVdIGI6iOACAY/6nvCIO
 Tu/Z9o//VAjBEpA+sfVy5tHiKu6miS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772025480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcz2XQVKIVOCU/OfrDUiRiG7pyZT6aR/965IeAgSr5s=;
 b=wn9RVA38+azad6z1JS1zQOTFqqDghQYnyucLbUFHDOYCBPQ9F+eie5bsVGfFJCmzWK2rrL
 Z+FU10slFywu+UAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 316E53EA65;
 Wed, 25 Feb 2026 13:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rPVZCoj2nmk2DgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Feb 2026 13:18:00 +0000
Date: Wed, 25 Feb 2026 14:18:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aZ72j9KvkhsDF7Yf@yuki.lan>
References: <20260223100015.14834-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260223100015.14834-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, intel.com:url,
 intel.com:email, suse.cz:email, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  runtest/thermal                               |   3 +
>  scenario_groups/default                       |   1 +
>  testcases/kernel/Makefile                     |   1 +
>  testcases/kernel/thermal/.gitignore           |   1 +
>  testcases/kernel/thermal/Makefile             |   9 +
>  .../kernel/thermal/thermal_interrupt_events.c | 212 ++++++++++++++++++
>  6 files changed, 227 insertions(+)
>  create mode 100644 runtest/thermal
>  create mode 100644 testcases/kernel/thermal/.gitignore
>  create mode 100644 testcases/kernel/thermal/Makefile
>  create mode 100644 testcases/kernel/thermal/thermal_interrupt_events.c
> 
> diff --git a/runtest/thermal b/runtest/thermal
> new file mode 100644
> index 000000000..57e3d29f8
> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,3 @@
> +# Thermal driver API
> +# https://docs.kernel.org/driver-api/thermal/
> +thermal_interrupt_events thermal_interrupt_events
> diff --git a/scenario_groups/default b/scenario_groups/default
> index 0e76b2bee..ffdd7ff25 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -26,3 +26,4 @@ crypto
>  kernel_misc
>  uevent
>  watchqueue
> +thermal

We just removed the scenario_groups that were only used by the
deprecated runltp.

> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 98fd45a9d..ac816e4e8 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -36,6 +36,7 @@ SUBDIRS			+= connectors \
>  			   sched \
>  			   security \
>  			   sound \
> +			   thermal \
>  			   tracing \
>  			   uevents \
>  			   watchqueue \

I wonder if it would make more sense to add the test to the kernel_misc
runtest file instead of creating a new one. Are you going to write more
thermal related tests?

> diff --git a/testcases/kernel/thermal/.gitignore b/testcases/kernel/thermal/.gitignore
> new file mode 100644
> index 000000000..1090bdad8
> --- /dev/null
> +++ b/testcases/kernel/thermal/.gitignore
> @@ -0,0 +1 @@
> +thermal_interrupt_events
> diff --git a/testcases/kernel/thermal/Makefile b/testcases/kernel/thermal/Makefile
> new file mode 100644
> index 000000000..4657c3fb3
> --- /dev/null
> +++ b/testcases/kernel/thermal/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2025, Intel Corporation. All rights reserved.
> +# Author:Piotr Kubaj <piotr.kubaj@intel.com>
> +
> +top_srcdir             ?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
> new file mode 100644
> index 000000000..7a241cb51
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2026 Intel - http://www.intel.com/
> + */
> +
> +/*\
> + * Tests the CPU package thermal sensor interface for Intel platforms.
> +
> + * Works by checking the initial count of thermal interrupts. Then it
> + * decreases the threshold for sending a thermal interrupt to just above
> + * the current temperature and runs a workload on the CPU. Finally, it restores
> + * the original thermal threshold and checks whether the number of thermal
> + * interrupts increased.
> + */
> +
> +#include "tst_safe_stdio.h"
> +#include "tst_test.h"
> +
> +#define	RUNTIME		30
> +#define	SLEEP		10
> +#define	TEMP_INCREMENT	10
> +
> +static bool x86_pkg_temp_tz_found, *x86_pkg_temp_tz;
> +static char temp_path[NAME_MAX], trip_path[NAME_MAX];
> +static int nproc, temp_high, temp, trip, tz_counter;
> +static uint64_t *interrupt_init, *interrupt_later;
> +
> +static void read_interrupts(uint64_t *interrupts, const int nproc)
> +{
> +	bool interrupts_found = false;
> +	char line[8192];
> +
> +	memset(interrupts, 0, nproc * sizeof(*interrupts));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
> +			interrupts_found = true;
> +			char *token = strtok(line, " ");
> +
> +			token = strtok(NULL, " ");
> +			int i = 0;
> +
> +			while (!!strncmp(token, "Thermal", 7)) {

We should possibly check that i < nprocs here as well. Or just do a for
loop from 0 to < nprocs and properly parse the number and TBROK if we do
not get a number. We can also use strtoull() to consume the string
without breaking it into tokens.


Something as;

	char *ptr = strchr(line, ':');
	if (!ptr)
		//line does not start with XYZ:
	ptr += 1;

	for (i = 0; i < nprocs; i++) {
		char *endptr;

		errno = 0;

		interrupts[i] = strtoll(ptr, &endptr, 10);

		if (ptr == endptr)
			//wrong input

		if (errno == ERANGE)
			//overflow

		ptr = endptr
	}

> +				interrupts[i++] = atoll(token);
> +				token = strtok(NULL, " ");
> +				tst_res(TDEBUG, "interrupts[%d]: %ld", i - 1, interrupts[i - 1]);
> +			}
> +			break;
> +		}
> +	}
> +	SAFE_FCLOSE(fp);
> +	if (!interrupts_found)
> +		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
> +}
> +
> +static void setup(void)
> +{
> +	char line[8192];
> +
> +	nproc = tst_ncpus();
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +	interrupt_init = calloc(nproc, sizeof(uint64_t));
> +	interrupt_later = calloc(nproc, sizeof(uint64_t));
                          ^
			  SAFE_CALLOC()


> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +
> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)

What are we trying to match here? That the d_name has "thremal_zone"
prefix? If that is so the sizeof("thermal_zone") is wrong since sizeof()
always includes the space for '\0'.

I.e. sizeof("thermal_zone") == strlen("thermal_zone") + 1

> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> +
> +	read_interrupts(interrupt_init, nproc);
> +
> +	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));
                          ^
			  SAFE_CALLOC()

> +	for (int i = 0; i < tz_counter; i++) {
> +		char path[NAME_MAX];
> +
> +		snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/type", i);
> +		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
> +
> +		SAFE_FILE_SCANF(path, "%s", line);
> +		if (strstr(line, "x86_pkg_temp")) {
> +			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
> +			x86_pkg_temp_tz[i] = 1;
> +			x86_pkg_temp_tz_found = 1;
> +		}
> +	}
> +
> +	if (!x86_pkg_temp_tz_found)
> +		tst_brk(TCONF, "No thermal zone uses x86_pkg_temp");
> +}
> +
> +static void *cpu_workload(double run_time)
> +{
> +	time_t start_time = time(NULL);
> +	int num = 2;
> +
> +	while (difftime(time(NULL), start_time) < run_time) {
> +		for (int i = 2; i * i <= num; i++) {
> +			if (num % i == 0)
> +				break;
> +		}
> +		num++;
> +		SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +
> +		if (temp > temp_high)
> +			break;
> +	}
> +	return NULL;

Tracking elapsed time with wall clock is not a good idea in general.
There may be a ntp client running on the system and the wall time can
jump back or forth. We do have a helper functions to track time with
monotonic timers:

	tst_timer_start(CLOCK_MONOTONIC);

	while (!tst_timer_expired_ms(RUNTIME * 1000)) {
		/* Do the work here */
	}

> +}
> +
> +static void test_zone(int i)
> +{
> +	char path[NAME_MAX] = {0};
                   ^
		   This should be PATH_MAX.

Generally NAME_MAX is a limit for a file or directory name, while
PATH_MAX is a limit for a path passed to a syscall.

> +	int sleep_time = SLEEP;
> +	double run_time = RUNTIME;
> +
> +	snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/", i);
> +	strncpy(temp_path, path, NAME_MAX);
> +	strncat(temp_path, "temp", 4);

Why just not use a single snprintf()?

	snprintf(temp_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/temp", i);

> +	tst_res(TINFO, "Testing %s", temp_path);
> +	SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +	if (temp < 0)
> +		tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
> +
> +	tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
> +
> +	temp_high = temp + TEMP_INCREMENT;
> +
> +	strncpy(trip_path, path, NAME_MAX);
> +	strncat(trip_path, "trip_point_1_temp", 17);

Here as well:

        snprintf(temp_path, PATH_MAX, "/sys/class/thermal/thermal_zone%d/trip_point_1_temp", i);

> +	tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
> +	SAFE_FILE_SCANF(trip_path, "%d", &trip);
> +	SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
> +
> +	while (sleep_time > 0) {
> +		tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
> +
> +		for (int j = 0; j < nproc; j++) {
> +			if (!SAFE_FORK()) {
> +				cpu_workload(run_time);
> +				exit(0);
> +			}
> +		}
> +
> +		tst_reap_children();
> +
> +		SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +		tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
> +
> +		if (temp > temp_high)
> +			break;
> +		sleep(sleep_time--);
> +		run_time -= 3;
> +	}
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	if (x86_pkg_temp_tz_found)
> +		SAFE_FILE_PRINTF(trip_path, "%d", trip);
> +
> +	free(x86_pkg_temp_tz);
> +	free(interrupt_init);
> +	free(interrupt_later);
> +}
> +
> +static void run(void)
> +{
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i])
> +			test_zone(i);
> +	}
> +	read_interrupts(interrupt_later, nproc);
> +
> +	for (int i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i])
> +			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
> +				i, interrupt_later[i], interrupt_init[i]);

What are we trying to assert here? The interrupt counters should never
decrease, that's unlikely to happen. Shouldn't we instead check that the
interrupts increased at least for one column?

> +	}
> +
> +	if (temp <= temp_high)
> +		tst_res(TFAIL, "Zone temperature is not rising as expected");
> +	else
> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.needs_drivers = (const char *const []) {
> +		"x86_pkg_temp_thermal",
> +		NULL
> +	},
> +	.min_runtime = 180,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
> +	.test_all = run
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
