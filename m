Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37224D778AF
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 20:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E81C13CB9F7
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 21:25:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614DC3CB5E0
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 21:25:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CC57F100036F
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 21:25:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1313C33693;
 Fri, 23 Jan 2026 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769199928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unaWXGhEa7q5V3p44TuH1Gf+gz7U7V514tV4/hAIV5g=;
 b=eZXsEl4goxVvdDZ94+uDbhMfKslgJvOqMS7ixeqvzSG4gjwHuxAdjldeUMvYCKV3hRPbwd
 xraXQadNy4TauMASBEgBAMS4Daix5NpTj6MjGrQNz9KG22eWtfoCrvzLNZUj8pcWBK+ljs
 mWetawM9aT3O3Nc1o65g8AK7QruCrnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769199928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unaWXGhEa7q5V3p44TuH1Gf+gz7U7V514tV4/hAIV5g=;
 b=f9IWl3klo27PvCYTg7I8vmh11LMUipPFyWWWAXVLH7ZBK3DHnu9lk3UvQn/i76WdO+ao0c
 aQQibO6YoNjgJcBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769199927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unaWXGhEa7q5V3p44TuH1Gf+gz7U7V514tV4/hAIV5g=;
 b=cimjfNp/wdMDENFwNEFJdfBgZn++aIQicXxAKNRh4SIVFQ9/5QjEMbyOp7X+NBaBNMOi/T
 wIZMPpBGU2S6RJBLGa1xocTscIr9+EBKtf7D5RQQsb1q7nBEtuAAW3TzrR/gKPcbWwcjvl
 o7kzhqSa6DFVuTrrlEbZ0yzZCYLStlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769199927;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unaWXGhEa7q5V3p44TuH1Gf+gz7U7V514tV4/hAIV5g=;
 b=vEvSJR6qVCndQ6GGTE0d00hv6aL6RPiHltytuJnEHVV1LSYgoNKnBhsqt0Fjenljv4EnnQ
 OMLO3UY9KVwT2iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94AA1395E;
 Fri, 23 Jan 2026 20:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0lRNLzbZc2ldAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Jan 2026 20:25:26 +0000
Date: Fri, 23 Jan 2026 21:25:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260123202521.GB367190@pevik>
References: <20260123124952.338065-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123124952.338065-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] thermal: add new test group
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> This is a new test for checking thermal interrupt events.
> Corrects issues pointed out by Petr Vorel for v3.

> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/
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
very nit: blank line between includes and defines helps readability
> +#define	PATH_LEN	69
very nit: you mix tabs and spaces after #define.
I'd be ok to use NAME_MAX (255) from <limits.h> than to have an extra constant
just to save little bit of memory.
But maybe worth to define 8192 (/proc/interrupts line), which is used on 2 places.

> +#define RUNTIME		30
> +#define SLEEP		10
> +#define	STRING_LEN	23
You don't use STRING_LEN.

> +#define TEMP_INCREMENT	10
> +
> +static char trip_path[PATH_LEN];
> +static int nproc, trip;
> +
> +static void setup(void)
> +{
> +	nproc = tst_ncpus();
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_res(TDEBUG, "Restoring original trip_point_1_temp value: %d", trip);
I don't think this message is useful. It's just a cleanup. Also if it fails,
you'll get message from LTP library.

> +	SAFE_FILE_PRINTF(trip_path, "%d", trip);
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
> +	}
> +	return NULL;
> +}
> +
> +static void read_interrupts(uint64_t *interrupt_array, const int nproc)
very nit: maybe just interrupts? Variable names can be meaningful and yet short
enough :).

> +{
> +	bool interrupts_found = 0;
very nit: sure it works, but why not using true and false?

> +	char line[8192];
> +
> +	memset(interrupt_array, 0, nproc * sizeof(*interrupt_array));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
> +			interrupts_found = 1;
> +			char *token = strtok(line, " ");
> +
> +			token = strtok(NULL, " ");
> +			int i = 0;
> +
> +			while (!!strncmp(token, "Thermal", 7)) {
> +				interrupt_array[i++] = atoll(token);
> +				token = strtok(NULL, " ");
> +				tst_res(TDEBUG, "Current value of interrupt_array[%d]: %ld", i - 1, interrupt_array[i - 1]);
nit: It's just a debug info, why not just (shorten long lines):
				tst_res(TDEBUG, "interrupts[%d]: %ld", i-1, interrupts[i-1]);

> +			}
We don't need processing any other line after TRM: right?

	while (fgets(line, sizeof(line), fp)) {
		if (!strstr(line, "Thermal event interrupts"))
			continue;

		interrupts_found = 1;
		char *token = strtok(line, " ");

		token = strtok(NULL, " ");
		int i = 0;

		while (!!strncmp(token, "Thermal", 7)) {
			interrupt_array[i++] = atoll(token);
			token = strtok(NULL, " ");
			tst_res(TDEBUG, "Current value of interrupt_array[%d]: %ld", i - 1, interrupt_array[i - 1]);
		}
		break;
	}

> +		}
> +	}
> +	SAFE_FCLOSE(fp);
> +	if (!interrupts_found)
> +		tst_brk(TCONF, "No Thermal event interrupts line in /proc/interrupts");
> +}
> +

> +static void run(void)
> +{
> +	bool status = 1;
> +	char line[8192];
> +	uint64_t interrupt_init[nproc], interrupt_later[nproc];
> +
> +	read_interrupts(interrupt_init, nproc);
> +
> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +	int tz_counter = 0;
> +
> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
As I noted previously, at least this part will not change if you run test more
times, does it? Why not to move it to the setup()?

Imagine running test 1000x iterations:
./thermal_interrupt_events -i 1000

Why to waste time with reading it again?

The only exception might be reading interrupts. I would expect it's ok to have
only the initial state (read in the setup() as well), but maybe (when test run
with more iterations via -i x) it needs to have the updated state (from the
previous iteration).

> +
> +	bool x86_pkg_temp_tz[tz_counter], x86_pkg_temp_tz_found = 0;
> +
> +	memset(x86_pkg_temp_tz, 0, sizeof(x86_pkg_temp_tz));
> +
> +	for (int i = 0; i < tz_counter; i++) {
> +		char path[PATH_LEN];
> +
> +		snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/type", i);
> +		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
> +
> +		SAFE_FILE_SCANF(path, "%s", line);
> +		if (strstr(line, "x86_pkg_temp")) {
> +			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
> +			x86_pkg_temp_tz[i] = 1;
> +			x86_pkg_temp_tz_found = 1;
> +		}
> +	}
> +	if (!x86_pkg_temp_tz_found) {
> +		tst_res(TINFO, "No thermal zone uses x86_pkg_temp");
And probably this part will not happen when you run more iterations (-i1000).

> +		status = 0;

If this happen, test fail, right? (you never set status = 1 later). Why to do
the rest of the testing?

I would really expect the whole part of run() up here is in the setup() and test
quits in this case:

if (!x86_pkg_temp_tz_found)
	tst_brk(TCONF, "No thermal zone uses x86_pkg_temp");

> +	}


> +
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i]) {

run() is quite long. Maybe move content of of this loop would help.
Something like this (use whatever function name) would help the readability.

	for (int i = 0; i < tz_counter; i++) {
		if (x86_pkg_temp_tz[i])
			test_zone(x86_pkg_temp_tz[i]);
	}
Maybe even split the while part into it's own function.

> +			char path[PATH_LEN], temp_path[PATH_LEN];
> +			int sleep_time = SLEEP, temp_high, temp;
> +			double run_time = RUNTIME;
> +
> +			snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/", i);
> +			strncpy(temp_path, path, PATH_LEN);
> +			strncat(temp_path, "temp", 4);
> +			tst_res(TINFO, "Testing %s", temp_path);
> +			SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +			if (temp < 0) {
> +				tst_brk(TINFO, "Unexpected zone temperature value %d", temp);
tst_brk(TINFO, ...) is wrong, because tst_brk() quits testing. TINFO is always
used with tst_res() (normal message).

I guess it should be either tst_brk(TCONF), as wrong temperature looks to me as
a bug.

> +				status = 0;
> +			}
> +			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
> +
> +			temp_high = temp + TEMP_INCREMENT;
> +
> +			strncpy(trip_path, path, PATH_LEN);
> +			strncat(trip_path, "trip_point_1_temp", 17);
> +
> +			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
> +			SAFE_FILE_SCANF(trip_path, "%d", &trip);
> +			SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
> +
> +			while (sleep_time > 0) {
> +				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
nit: %f should be %d, right?

				tst_res(TDEBUG, "Running for %d seconds, then sleeping for %d seconds",
					(int)run_time, sleep_time);
> +
> +				for (int j = 0; j < nproc; j++) {
> +					if (!SAFE_FORK()) {
> +						cpu_workload(run_time);
> +						exit(0);
> +					}
> +				}
> +
> +				for (int j = 0; j < nproc; j++)
> +					tst_reap_children();

tst_reap_children() should be called only once (not for all cpus).

Quoting doc:

	The 'tst_reap_children()' function makes the process wait for all of its
	children and exits with 'tst_brk(TBROK, ...)' if any of them returned
	a non zero exit code.

See function itself in lib/tst_test.c and "Test 3" in lib/newlib_tests/tst_checkpoint.c.

> +
> +				SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
> +
> +				if (temp > temp_high)
> +					break;
> +				sleep(sleep_time--);
> +				run_time -= 3;
> +			}
> +			if (temp <= temp_high) {
> +				tst_res(TINFO, "Zone temperature is not rising as expected");
I'm not the expert on the topic, but IMHO how about have this as TFAIL
and print at the end only TPASS if no error found?

				tst_res(TFAIL, "CPU %d: Zone temperature is not rising as expected", i);

> +				status = 0;
> +			}
> +		}
> +	}
> +	read_interrupts(interrupt_later, nproc);
> +
> +	for (int i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i]) {
> +			tst_res(TINFO, "For CPU %d interrupt counter is currently %ld, while it was %ld before the test", i, interrupt_later[i], interrupt_init[i]);
very nit: this line is really too long.

			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
				i, interrupt_later[i], interrupt_init[i]);

> +			status = 0;
> +		}
> +	}
> +
> +	if (status)
> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +	else
> +		tst_res(TFAIL, "x86 package thermal interrupt did not trigger");

	if (status)
		tst_res(TPASS, "All interrupts triggered");

(Don't print final TFAIL when errors were printed previously.)
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
