Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C44D26293
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 19:39:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B9913CB054
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 20:39:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA3493C76D1
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 20:39:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D8CD11000A18
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 20:39:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 444E55BCCC;
 Tue, 20 Jan 2026 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768937939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t29mX5wuvz10VStXJw8gP3P3R0QlnwKcZ6Zyj8eytTo=;
 b=bryQn7+tbgkckWXA7O+XJJ/piqrQYX/sweqDID/LclHPHby8kqd07Kjv9T7iE3OOYQ7Wox
 MGYKJxjtwbYo+q2F2b5JkiwLODuLBdvx20yuWS+DP0Ko1g2pGkhYayrzEUIaiZwKI87/q7
 jLiOIKDX57WcKPi2v36cU+2AwNHU6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768937939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t29mX5wuvz10VStXJw8gP3P3R0QlnwKcZ6Zyj8eytTo=;
 b=1KnwodnXabkOQOOH02kAnUhUJzXvehGuTi6vzFFlQIQM2g+mQ9p8XjNrBXGIJ1ih869XEZ
 jcENu0Kxs62RasAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768937939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t29mX5wuvz10VStXJw8gP3P3R0QlnwKcZ6Zyj8eytTo=;
 b=bryQn7+tbgkckWXA7O+XJJ/piqrQYX/sweqDID/LclHPHby8kqd07Kjv9T7iE3OOYQ7Wox
 MGYKJxjtwbYo+q2F2b5JkiwLODuLBdvx20yuWS+DP0Ko1g2pGkhYayrzEUIaiZwKI87/q7
 jLiOIKDX57WcKPi2v36cU+2AwNHU6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768937939;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t29mX5wuvz10VStXJw8gP3P3R0QlnwKcZ6Zyj8eytTo=;
 b=1KnwodnXabkOQOOH02kAnUhUJzXvehGuTi6vzFFlQIQM2g+mQ9p8XjNrBXGIJ1ih869XEZ
 jcENu0Kxs62RasAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBABD3EA63;
 Tue, 20 Jan 2026 19:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DBHKMdHZb2m6EAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jan 2026 19:38:57 +0000
Date: Tue, 20 Jan 2026 20:38:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260120193851.GB65442@pevik>
References: <20260120144626.231614-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260120144626.231614-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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

> --- /dev/null
> +++ b/runtest/thermal
> @@ -0,0 +1,3 @@
> +# Thermal driver API
> +# https://docs.kernel.org/driver-api/thermal/
> +thermal_interrupt_events thermal_interrupt_events.sh
You rewritten test into C :).
thermal_interrupt_events thermal_interrupt_events

I tried to run test under root:

# ./thermal_interrupt_events
tst_test.c:1856: TINFO: Overall timeout per run is 0h 03m 30s
thermal_interrupt_events.c:168: TBROK: Failed to close FILE '/sys/class/thermal/thermal_zone1/trip_point_1_temp': EINVAL (22)

But later it worked:
tst_test.c:2028: TINFO: LTP version: 20250930-134-g02805b05a1
tst_test.c:2031: TINFO: Tested kernel: 6.17.12+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.17.12-1 (2025-12-14) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.17.12+deb14-amd64'
tst_test.c:1856: TINFO: Overall timeout per run is 0h 03m 30s
thermal_interrupt_events.c:181: TPASS: x86 package thermal interrupt triggered

I wonder what was wrong.

...
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c

Whole C code asks for cleanup and simplification.

> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/
> + */
> +
> +/*
Please use /*\ instead of /* to get test description into our test catalog:
https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

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
> +#include <ctype.h>
> +#include <pthread.h>
> +#include <regex.h>
> +#define	PATH_LEN	69
> +#define	STRING_LEN	23
> +
> +static void *cpu_workload(void *arg)
> +{
> +	time_t start_time = time(NULL);
> +	int num = 2;
> +
> +	while (difftime(time(NULL), start_time) < *(double *)arg) {
> +		for (int i = 2; i * i <= num; i++) {
> +			if (num % i == 0)
> +				break;
> +		}
> +		num++;
> +	}
> +	return NULL;
> +}
> +
> +static void read_interrupts(uint64_t *interrupt_array, const uint16_t nproc)
> +{
> +	bool interrupts_found = 0;
> +	char line[8192];
very nit: IMHO 1024 would be more than enough, but whatever.
> +
> +	memset(interrupt_array, 0, nproc * sizeof(*interrupt_array));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
Can't we use FILE_LINES_SCANF() or SAFE_FILE_LINES_SCANF() to instead of whole
while() block to simplify?

See example code
https://github.com/linux-test-project/ltp/tree/master/lib/newlib_tests/tst_safe_fileops.c

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
> +			}
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
> +	const uint16_t nproc = tst_ncpus();
I'd say just use int.

https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#11-basic-test-structure
	The overall test initialization is done in the setup() function.
=> this would apply to tst_ncpus() result.

If there is any preliminary checking before testing (e.g. content of
/proc/interrupts) it should be in setup() function.

=> but this can be used for checking as well.
One of these would be tst_ncpus() result.

This helps to quit early.

> +	uint64_t interrupt_init[nproc], interrupt_later[nproc];
> +
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +	read_interrupts(interrupt_init, nproc);
> +
> +	DIR *dir;
> +
> +	dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +	regex_t regex;
> +	uint8_t tz_counter = 0;
> +
> +	if (regcomp(&regex, "thermal_zone", REG_EXTENDED) != 0)
regex is overkill.  Because we search for /sys/class/thermal/thermal_zone[0-9],
we can simply traverse dirent and check it with strncmp().
Other option would be to use glob() but even that is IMHO too much.
And this searching should be in setup() right? (does not change during test run,
why to do it more than once when run test with -i, e.g. -i3.

> +		tst_res(TINFO | TTERRNO, "regcomp");
> +
> +	while ((entry = readdir(dir)) != NULL) {
> +		if (regexec(&regex, entry->d_name, 0, NULL, 0) == 0)
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	regfree(&regex);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> +
> +	bool x86_pkg_temp_tz[tz_counter], x86_pkg_temp_tz_found = 0;
> +
> +	memset(x86_pkg_temp_tz, 0, sizeof(x86_pkg_temp_tz));
> +
> +	for (uint8_t i = 0; i < tz_counter; i++) {
> +		char path[PATH_LEN];
> +
> +		snprintf(path, PATH_LEN, "/sys/class/thermal/thermal_zone%d/type", i);
> +		FILE *fp = SAFE_FOPEN(path, "r");
You print too many TDEBUG. Why don't you print opened
/sys/class/thermal/thermal_zone%d/type file?
> +
> +		if (fgets(line, sizeof(line), fp) && strstr(line, "x86_pkg_temp")) {
Please use SAFE_FILE_SCANF() or FILE_SCANF()
https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#14-safe-macros

Kind regards,
Petr

> +			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
> +			x86_pkg_temp_tz[i] = 1;
> +			x86_pkg_temp_tz_found = 1;
> +		}
> +		SAFE_FCLOSE(fp);
> +	}
> +	if (!x86_pkg_temp_tz_found) {
> +		tst_res(TINFO, "No thermal zone uses x86_pkg_temp");
> +		status = 0;
> +	}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
