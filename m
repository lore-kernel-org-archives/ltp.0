Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DA3C54FD3
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771595343; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=W41f0n0VnpQMZuuSvb59JM46i2m0MQE0bf6f/MKpEJw=;
 b=HKRtMYSP7v5iv6YlMUGf1+IYMFAi7JoO9ec5Hk9gokfizzLo23tk9XC4bckw6pCYA/kWd
 e/+HU27mmbzJDMbmgeK625KdGStUAceJo+nuk/iT994CrRjYALgirmfCTkfa5lYx6Y9IqsS
 WCW0QzaTnY9CEVeW8T8WsksIa8Ymo0Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 692FB3D0843
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 14:49:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E9D53C7B0D
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 14:48:40 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB49D10009F8
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 14:48:39 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so2132088f8f.1
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 05:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771595319; x=1772200119; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewj9iHKUwrXx2VkozPYmmP4ixj51Y/75v4yAvDfUZHU=;
 b=bbCyulscYv2i1m6AydDeB4uXZrpj9ZFPm2x5+7VHmMlejtTBp1Idd9mx3AKLQmOqft
 9+fh4RNifyJ+/reh430zsYkGkVNQ52ctDrMe+tEXmbXtq1O3wd3WBaTl848KPpTFQmUH
 IDypnipOsEwmAYkn2nCShCZGfeZjNnN/7qWgvPsKFrLWQWfE+2VPSU/iffOomEUFY72U
 UG3uwrrmuO4avTaZhLqjf+SZw2kf1IxBU4UqvCPOPSou5MGFGjfbKzu9V/JwIQhQ3kxD
 jXHXnBUEJ96tWGozAb78IcXLrd1LVUu2KUeRy4hx2cxLtanOvwzQl0W6cfmcLBjbzLqu
 u0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771595319; x=1772200119;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ewj9iHKUwrXx2VkozPYmmP4ixj51Y/75v4yAvDfUZHU=;
 b=LuvGbEEG/BdVH/8gQ5lXnJBLFz5vzlNnCSO31IgUtfOpgU3f4RuvDhTUgPMvFeQrm2
 QUnZrFr7ziYeAakIZwiJEULvXUd65VkqqOBWvCEUQn5AGJOn98TtHtBKc45DZ5Nc77Cd
 qOxDoepRx9uXGLcyC0Ovtepm1HwVLqXv1nt8FjqXDZzIuOkeMyp/hjfBDGDXAuHgA2aG
 KwB2gZ2H4Qaa2nGflWYePdhRk2EaancsNMbvFkggqlxIsB6A0KLKaiOhj90zNErYLb4e
 T/FXlmq0RovIQoZSUFlN9NeAZKyMwzZN6eKNWqiPPNSSzmW4r7OTasdT1v+VAmtdHuuh
 1rGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxg04yCTh80XyNKNI70ocuYwYtCa8Bmm6o5fqwugGUzL3cYTACCRxJsgn+68sO2dzHRCE=@lists.linux.it
X-Gm-Message-State: AOJu0YwechpvcvLehOGit/QU68CZWuX5rF73nFI6NJK9psMEhN/ldYpP
 UzAiOyLnFbQi9ezcnPIJHBWKCS0p7XgoVCN1SfBK/IUT+sCu++n/chl3NrqWS8vyiRE=
X-Gm-Gg: AZuq6aI+PUiuwCRFj3Ka69FFaaF9f6ex5VcEAJzgKixsAPqLLIQb5gz8FW1GPRTnSN0
 5CkSBj9WHFac6GWEGcf6tD4rSPnfjhr7FvjCe6GCAM1th2YGVzM4C7xHRHmyiHKvCPLbt2JVWjX
 /JH0l3wgbIyr4IfoOJz7C6rdSv0CKggeKvCsSxvwbc+ZRimG1AS+fasZV29N7nB+LbnqCyAZAit
 qOizewv2WgBPnJW7swsWaVpPfSCoZxFIpgA2rACWHvIpBIyjivD5G65y097HTOuTZW+wZtobTHh
 tfyC66PqLgt2TaG6u1974lid6WJL6Jn8iJFbekOsXzeL24BanpSXcpoB7ERnEzEClMB2Uq1Ux0/
 0LJlBEi8Rus0p2g3o4QJQx7mETrqgpxD65h0aLSLvYZlC4x8AJfjTljZHkhAKrmRYW21KBjgZ2r
 6RDRdFJM7+GBKGt+HQHWPQKW70
X-Received: by 2002:a05:6000:4211:b0:435:db93:7311 with SMTP id
 ffacd0b85a97d-4396270ce66mr10012218f8f.18.1771595318861; 
 Fri, 20 Feb 2026 05:48:38 -0800 (PST)
Received: from localhost ([88.128.90.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a6desm56303089f8f.10.2026.02.20.05.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 05:48:38 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 14:48:37 +0100
Message-Id: <DGJU4LDY92OH.1HHC2VRB4ET16@suse.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260218133856.264992-2-piotr.kubaj@intel.com>
In-Reply-To: <20260218133856.264992-2-piotr.kubaj@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] thermal: add new test group
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

Almost there, but there are still a couple of issues :-)

On Wed Feb 18, 2026 at 2:38 PM CET, Piotr Kubaj wrote:
> This is a new test for checking thermal interrupt events.
> Addresses Andrea's feedback and adds x86_pkg_temp_thermal to
> needs_drivers.

Please provide a meaningful description in the git commit message.

This is the commit message that will be merged in our upstream, so it
has to refer to the test and what it does. You can comment the patch
version by typing this message after Signed-off-by and the "---" sign.
Git will ignore it once patch is merged.

>
> Signed-off-by: Piotr Kubaj <piotr.kubaj@intel.com>
> ---
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
> index 000000000..2adcca5c3
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

Why now we have this 3 tabs indentation? This is not passing the coding
style rules, where only one TAB is accepted.

> +			char path[NAME_MAX] = {0};
> +			int sleep_time = SLEEP;
> +			double run_time = RUNTIME;
> +

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
