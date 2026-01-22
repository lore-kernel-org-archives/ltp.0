Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F1D3EE66
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 14:07:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BC323CB6BD
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 15:07:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6FE83C0EB3
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:07:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24E0F200B73
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 15:07:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 083CC5BCDD;
 Thu, 22 Jan 2026 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769090828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HS1co48tSM1MMoPtt+LH/ryQkeIhrfeSZH+b1d2JWXk=;
 b=245vdLY4moWMyUfTJl5RYHhea5N9CqRq5EUPZDBo8hTU2CcxYBZA/ssp+hfj2vTTP2uS1P
 0Y3kWVaZsg0FKvUn2ShxfKjkdpmLxKGGGHS1PnuAEbJRCto4lRiYkUgM4ZO+s57xZegBJF
 YhMzbCcrf0BWK6yEgsz+KZ93oI9d89w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769090828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HS1co48tSM1MMoPtt+LH/ryQkeIhrfeSZH+b1d2JWXk=;
 b=IcpfsQlEDu/U/XoAhYpzsNybqCk208DL4SnWAorFhvFYuX4fDf65u35xNvtVYO+4vuhvT1
 9/woPKkbnddQKUAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=245vdLY4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IcpfsQlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769090828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HS1co48tSM1MMoPtt+LH/ryQkeIhrfeSZH+b1d2JWXk=;
 b=245vdLY4moWMyUfTJl5RYHhea5N9CqRq5EUPZDBo8hTU2CcxYBZA/ssp+hfj2vTTP2uS1P
 0Y3kWVaZsg0FKvUn2ShxfKjkdpmLxKGGGHS1PnuAEbJRCto4lRiYkUgM4ZO+s57xZegBJF
 YhMzbCcrf0BWK6yEgsz+KZ93oI9d89w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769090828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HS1co48tSM1MMoPtt+LH/ryQkeIhrfeSZH+b1d2JWXk=;
 b=IcpfsQlEDu/U/XoAhYpzsNybqCk208DL4SnWAorFhvFYuX4fDf65u35xNvtVYO+4vuhvT1
 9/woPKkbnddQKUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B141A1395E;
 Thu, 22 Jan 2026 14:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AQ6nKAsvcmmAEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 14:07:07 +0000
Date: Thu, 22 Jan 2026 15:07:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260122140706.GA72518@pevik>
References: <20260121134146.259161-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260121134146.259161-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 083CC5BCDD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] thermal: add new test group
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

not a complete review, just few thoughts.

> diff --git a/testcases/kernel/thermal/thermal_interrupt_events.c b/testcases/kernel/thermal/thermal_interrupt_events.c
...
> +/*\
> + * Tests the CPU package thermal sensor interface for Intel platforms.
> +
> + * Works by checking the initial count of thermal interrupts.
IMHO this part should be in setup function.

> Then it
> + * decreases the threshold for sending a thermal interrupt to just above
> + * the current temperature and runs a workload on the CPU.

First, why test needs to run for 30 sec and then sleep for 10 sec?
Is it possible to check the expected value from sysfs and quit testing before?
Also we have TST_RETRY_FUNC() and TST_RETRY_FN_EXP_BACKOFF() which could be used
for the loop (you create a function which does the check to quit before the
timeout.

> Finally, it restores
> + * the original thermal threshold and checks whether the number of thermal
> + * interrupts increased.
NOTE: the restore will not work if test exits before for some reason
(i.e. any of SAFE_*() macros fail). Therefore restore should be in a cleanup
function.

> + */
> +
> +#include "tst_safe_stdio.h"
> +#include "tst_test.h"
> +#include <ctype.h>
> +#include <pthread.h>
> +#define	PATH_LEN	69
> +#define	STRING_LEN	23
> +
> +static void *cpu_workload(void *arg)
> +{
> +	time_t start_time = time(NULL);
> +	int num = 2;
> +
> +	while (difftime(time(NULL), start_time) < *(double *)arg) {

difftime() is sufficient, but FYI we have include/tst_timer.h for
measuring time difference (which uses more precise struct timeval).

> +		for (int i = 2; i * i <= num; i++) {
> +			if (num % i == 0)
> +				break;
> +		}
> +		num++;
This is supposed to do some real workload on CPU? Is that really enough?
> +	}
> +	return NULL;
> +}
...
> +static void run(void)
> +{
> +	bool status = 1;
> +	char line[8192];
> +	int nproc = tst_ncpus();
> +	uint64_t interrupt_init[nproc], interrupt_later[nproc];
> +
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +	read_interrupts(interrupt_init, nproc);
> +
> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +	uint8_t tz_counter = 0;
I'm not sure if AI advices you to use it, but really we don't optimize that much
that we could not afford just to use plain int. Using exact-width types is
usually used only when needed, e.g. when mapping some struct from kernel.

> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);

I still think this part can be done in setup and needed values stored in static
variables (outside function), i.e. static int tz_counter, nproc; Why? Because some
people can run test 1000x via "-i 1000", therefore we cache various preparation
results.
> +
> +	bool x86_pkg_temp_tz[tz_counter], x86_pkg_temp_tz_found = 0;
> +
> +	memset(x86_pkg_temp_tz, 0, sizeof(x86_pkg_temp_tz));
> +
> +	for (uint8_t i = 0; i < tz_counter; i++) {
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
> +		status = 0;
> +	}
> +
> +	for (uint8_t i = 0; i < tz_counter; i++) {
Again, please just use int.

> +		if (x86_pkg_temp_tz[i]) {
> +			char path[PATH_LEN], temp_path[PATH_LEN], trip_path[PATH_LEN], temp_high[12], trip[12];

You read and write integer values. Using char array is overcomplicated:
int trip, temp_high = temp + 10;

(But maybe have 10 defined as a constant with meaningful name. That is kind of
documentation (instead reader having to read the code to understand the meaning
of the number).

#define TEMP_INCREMENT 10

> +			double run_time = 30;
#define RUNTIME 30

> +			uint8_t sleep_time = 10;
#define SLEEP 10

> +			int temp;
> +
> +			snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/", i);
> +			strncpy(temp_path, path, PATH_LEN);
> +			strncat(temp_path, "temp", 4);
> +			tst_res(TDEBUG, "Testing %s", temp_path);
nit: I'd put this as TINFO to get at least some debug info without -D.

> +			SAFE_FILE_SCANF(temp_path, "%d", &temp);
All SAFE_*() macros quit testing, therefore the following check is not needed.

> +			if (temp < 0) {
> +				tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
> +				status = 0;
> +			}
> +			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
> +
This would not be needed:
> +			snprintf(temp_high, sizeof(temp_high), "%d", temp + 10);
> +
> +			strncpy(trip_path, path, PATH_LEN);
> +			strncat(trip_path, "trip_point_1_temp", 17);
> +
> +			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %s", temp_high);
> +			SAFE_FILE_SCANF(trip_path, "%s", trip);
SAFE_FILE_SCANF(trip_path, "%d", &trip);

> +			SAFE_FILE_PRINTF(trip_path, "%s", temp_high);
SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
> +
> +			while (sleep_time > 0) {

> +				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
> +				pthread_t threads[nproc];
> +
> +				for (uint16_t j = 0; j < nproc; j++)
> +					pthread_create(&threads[j], NULL, cpu_workload, &run_time);
IMHO using pthread (and therefore -lpthread) is overkill.
Could you please use simple fork()?

testcases/cve/cve-2017-2618.c

	for (i = 0; i < nproc; i++) {
		if (!SAFE_FORK()) {
			cpu_workload();
			exit(0);
		}

		tst_reap_children();
	}

> +				for (uint16_t j = 0; j < nproc; j++)
> +					pthread_join(threads[j], NULL);
> +
> +				SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
> +
> +				if (temp > atol(temp_high))
> +					break;
> +				sleep(sleep_time--);
> +				run_time -= 3;
> +			}
> +			if (temp <= atol(temp_high)) {
> +				tst_res(TINFO, "Zone temperature is not rising as expected");
> +				status = 0;
> +			}

> +
> +			tst_res(TDEBUG, "Restoring original trip_point_1_temp value: %s", trip);
> +			SAFE_FILE_PRINTF(trip_path, "%s", trip);
> +		}
> +	}
> +	read_interrupts(interrupt_later, nproc);
> +
> +	for (uint16_t i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i]) {
> +			tst_res(TINFO, "For CPU %d interrupt counter is currently %ld, while it was %ld before the test", i, interrupt_later[i], interrupt_init[i]);
> +			status = 0;
> +		}
> +	}
> +
> +	if (status)
> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +	else
> +		tst_res(TFAIL, "x86 package thermal interrupt did not trigger");
> +}
> +
> +static struct tst_test test = {
> +	.min_runtime = 180,

> +	.needs_root = true,
nit: We always set it as 1.

Kind regards,
Petr

> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
> +	.test_all = run
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
