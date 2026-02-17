Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D81E68165
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771325372; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xTfSbH/3Kpj+ikwEgcrWznsvujXEvaqaSF/OdPVqTaI=;
 b=d78sR/bt5hQTobmEM+v7i3LlPk1hd4YbakJk/sXuUS4ZGNeXHU8PrSnxfiAMbn9xL2E1X
 rwwzqho3Y+YmNYR9PpEsNxksXBGyg2RLEqbyYpLBICUcb+qLKyAtrwCE5Hl5rSeocO2ICbH
 XRT4XmhjXLKEgUpZeTYCwHm+wO9TKJ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5703C5720
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 11:49:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC7E83C0424
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 11:49:08 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CAF4E1A00718
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 11:49:07 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so35290755e9.3
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771325347; x=1771930147; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0TPTOae4fGqLIQxRsy/RaEmjLhTx13+Qcjt3NZk72E=;
 b=YJvhJ7iBJ4HolAVTxuZaU1R0otM5rvaEzjaakj9/pawp8cDi/bTpf8CRvX278qeX21
 VlQWixP8WUA4vxjlJCjNeEPedLNvgVHXqg5dsx17t/qA8e36EyLN08EvulYgGrpK9GNy
 FoU1hq4ahzCdy9sSp9RPIqktSSn0yMN+qNjvcD/QFgJMrckxW/PezKo9XTAXl1auU6LY
 V88dmHjhzFzqWte0zrdgwDwG/iPMBbBmRP60CVc6Zw7UgsHTeJXPj7z0RICjJcxPotIZ
 s+uqGgHL8CrmhPMFIO9Ya93A/E24cWNStPw5EujnWROUurMFbWY0erIOogH5EPQaTX7f
 cXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771325347; x=1771930147;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0TPTOae4fGqLIQxRsy/RaEmjLhTx13+Qcjt3NZk72E=;
 b=elVpoYfU4AR5ERkosLNxj38ZrdSVAwdT82MgiPZLDgUj30ckVhCEttsJ3TQNVw7n69
 eBjuzc+A5kTDfZCIP6Bl+GQ/It7iIo1CcvgsHERb9ufEyPRKidraevIBJHoxhfYrw3ll
 jDR5/GS8RHtBPzD6WH7/JsxR4CyQKIp/EEOaauqL97sc0l3RcXuuScYtwe4vACF4Gt+R
 ii3KXeva2TdEndeEL95qgIAHWOMJKzCnN35t+L5B107mEY/TXdM6WysdW5los4e+5UF7
 fL1ic1lrifCW54haXxiiv+9Dv5j1ClDqn73WUXxns+IQFFqNoZ20YI9tOOI8MGpXQ3hB
 xRag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE54kZ8tV798RORJyWEDru28urLuOTiVKAQqv3pge6PusFwcMeyty8649fUuGNpeoA1nc=@lists.linux.it
X-Gm-Message-State: AOJu0YwFzI71uO2GlACAfNzhHohM4+3/57ZnNA6/IDpSSATRQXFit8+3
 Kp/Sjfh8k2z4hmgLBkF3tfURo3ZLdKsIBOky1eZaM7YLxj2fLqXtCzlNdVz6k1qgVTE=
X-Gm-Gg: AZuq6aLHLf9PT79qe/n+YYdRR+Z10SCB9RgFD0wmzravrkB0UpAWxZMEwCfOGO3vSbZ
 zoyDV0/AWiMa/lLDkQjOHamHacV1IDtYTbJd/2mvmDvcrWvbu7zTIxgvek0kyeUVoR+ZcmxxDfa
 d+u/FwQbqtKpPd8SBPSf17VcMzxJJQKPTn7GrAjbMxzd1u9SEVIkFj4QrXqhiFwkhALe7pDcHXb
 ERKwrJVuFJMUB4U0SxRiPSDeHPB7Q6NHwHK4zKLy++3r/xSbvle+O48vJ3EvNTxdjyLZZi7WQGz
 tUHQt1EP2i9qTeZWVPKyPKQ9sudX9jl7qAtmTXAWX4S8aRn55ODKgz12jCD8kgZRJ9WHnNqyDCB
 hTOb+a2saRdM/w11L6OSrCglZH9MUvplqv6DGopjDAPNhtJbqwWf0DpWsD0L+t5b7wfJ83/iXE+
 bmCwI7n7d+0cqUmqv+h4YiSct5shvHmSgXBkozx3p86abLhX3dUY2ckDX3DmCM2DByCgh+PUnpO
 ETV9ydlEMnPWYyd1pYVLQK08nlkyg==
X-Received: by 2002:a05:600c:6211:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-48373a09741mr242087025e9.10.1771325347006; 
 Tue, 17 Feb 2026 02:49:07 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48370a41be2sm177134705e9.1.2026.02.17.02.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 02:49:06 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 11:49:06 +0100
Message-Id: <DGH6FI87IFSV.27FV8YYGUAF3I@suse.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260213131328.122625-2-piotr.kubaj@intel.com>
In-Reply-To: <20260213131328.122625-2-piotr.kubaj@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] thermal: add new test group
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: tomasz.ossowski@intel.com, helena.anna.dubel@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Fri Feb 13, 2026 at 2:13 PM CET, Piotr Kubaj wrote:
> This is a new test for checking thermal interrupt events.
> I added some fixes suggested by Petr Vorel. Since no one else
> reviewed this code and two weeks have passed, I'm sending the
> corrected version.
>
> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
>  runtest/thermal                               |   3 +
>  scenario_groups/default                       |   1 +
>  testcases/kernel/Makefile                     |   1 +
>  testcases/kernel/thermal/Makefile             |   9 +
>  .../kernel/thermal/thermal_interrupt_events.c | 209 ++++++++++++++++++
>  5 files changed, 223 insertions(+)
>  create mode 100644 runtest/thermal
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
> index 000000000..d9105ff63
> --- /dev/null
> +++ b/testcases/kernel/thermal/thermal_interrupt_events.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2025-2026 Intel - http://www.intel.com/

Simply use 2026

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
> +static bool x86_pkg_temp_tz_found, *x86_pkg_temp_tz, status = 1;
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
> +
> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +
> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> +
> +	read_interrupts(interrupt_init, nproc);
> +
> +	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));

This is never released.

> +
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
> +}
> +
> +static void test_zone(int i)
> +{
> +			char path[NAME_MAX];
> +			int sleep_time = SLEEP;
> +			double run_time = RUNTIME;

Here we should reset all variables which are used multiple times when -i
parameter is used, otherwise we might have unexpected results between
cycles.

> +
> +			snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/", i);
> +			strncpy(temp_path, path, NAME_MAX);
> +			strncat(temp_path, "temp", 4);

nit: why not just use (?):

    snprintf(temp_path, NAME_MAX, "%stemp", path);

> +			tst_res(TINFO, "Testing %s", temp_path);
> +			SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +			if (temp < 0) {
> +				tst_brk(TBROK, "Unexpected zone temperature value %d", temp);
> +				status = 0;

Anything after tst_brk() will be dead-code, so this status assignment is
not needed.

> +			}
> +			tst_res(TDEBUG, "Current temperature for %s: %d", path, temp);
> +
> +			temp_high = temp + TEMP_INCREMENT;
> +
> +			strncpy(trip_path, path, NAME_MAX);
> +			strncat(trip_path, "trip_point_1_temp", 17);
> +
> +			tst_res(TDEBUG, "Setting new trip_point_1_temp value: %d", temp_high);
> +			SAFE_FILE_SCANF(trip_path, "%d", &trip);
> +			SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
> +
> +			while (sleep_time > 0) {
> +				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
> +
> +				for (int j = 0; j < nproc; j++) {
> +					if (!SAFE_FORK()) {
> +						cpu_workload(run_time);
> +						exit(0);
> +					}
> +				}
> +
> +				tst_reap_children();
> +
> +				SAFE_FILE_SCANF(temp_path, "%d", &temp);
> +				tst_res(TDEBUG, "Temperature for %s after a test: %d", path, temp);
> +
> +				if (temp > temp_high)
> +					break;
> +				sleep(sleep_time--);
> +				run_time -= 3;
> +			}
> +
> +			if (temp <= temp_high) {
> +				tst_brk(TFAIL, "Zone temperature is not rising as expected");

tst_brk? If you want to raise a tst_brk() you should use TBROK.
Otherwise, tst_res(TFAIL...).

> +				status = 0;
> +			}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (x86_pkg_temp_tz_found)
> +		SAFE_FILE_PRINTF(trip_path, "%d", trip);
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

Here we are using the wrong printf() types format. Variables are defined
as uint64_t* so "%llu" should be used.

> +	}
> +
> +	if (status)

I'm not sure about status variable. Most of the information are static
and can be seen here as well.

> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +}
> +
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.forks_child = 1,
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


There's not .gitignore entry for binary once binary is produced.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
