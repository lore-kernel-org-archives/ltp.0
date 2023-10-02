Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBEEE784AF
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 10:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA89F3CDE6F
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 12:41:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B30B3CC0C7
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 12:41:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E9626000FD
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 12:41:46 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6DF4A2185C
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696243306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cTSez2SDSdLjVw7eKmEKekP2aNb6k9xTVDA9sOBs3V4=;
 b=PAo9gK8lcxwnlhHJtkCU32oy5RixRwhCJ184Ir6Wg6vCKKMRIZCyEPqgW3U20DQTBnaSvO
 YyqpeBPg7M8dqrF+kOUWkCSl/wbQLM36yLiGFRifhswFu79U3jkJICx1a5ZYehb807RYJA
 FzyZFwJD6V9xfHE13h5bFPhnH4UG+zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696243306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cTSez2SDSdLjVw7eKmEKekP2aNb6k9xTVDA9sOBs3V4=;
 b=csCYYvdw3sPcWwcacOUuWiFmRlHwyoAT3J/4HOlKag0NPq0wYI9/exuBLcTCxMG9bbs6Wt
 PhGIxtfZibsb9uCA==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1AAAA2C142;
 Mon,  2 Oct 2023 10:41:46 +0000 (UTC)
References: <20230901144433.2526-1-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 02 Oct 2023 09:26:05 +0100
Organization: Linux Private Site
In-reply-to: <20230901144433.2526-1-chrubis@suse.cz>
Message-ID: <87cyxx2tna.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched: add sched sysctl sanity test
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

[This is a resend because I had some network issues; sorry if it comes
through twice]

Cyril Hrubis <chrubis@suse.cz> writes:

> Currently the test fails due to kernel bug, I will send patch to LKML
> later on.
>
> The problem with kernel is that sysctl_sched_rt_period is unsigned int
> but it's processed with proc_dointvec() which means that you are allowed
> to write negative values into the variable even though documentation
> says it shouldn't be possible and the kernel code asserts that rt_period
> is > 0.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/sched                                 |   2 +
>  testcases/kernel/sched/sysctl/.gitignore      |   1 +
>  testcases/kernel/sched/sysctl/Makefile        |   7 ++
>  .../kernel/sched/sysctl/proc_sched_rt01.c     | 115 ++++++++++++++++++
>  4 files changed, 125 insertions(+)
>  create mode 100644 testcases/kernel/sched/sysctl/.gitignore
>  create mode 100644 testcases/kernel/sched/sysctl/Makefile
>  create mode 100644 testcases/kernel/sched/sysctl/proc_sched_rt01.c
>
> diff --git a/runtest/sched b/runtest/sched
> index 172fe4174..3457114f4 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -16,3 +16,5 @@ sched_cli_serv run_sched_cliserv.sh
>  sched_stress sched_stress.sh
>  
>  autogroup01 autogroup01
> +
> +proc_sched_rt01
> diff --git a/testcases/kernel/sched/sysctl/.gitignore b/testcases/kernel/sched/sysctl/.gitignore
> new file mode 100644
> index 000000000..29b859b81
> --- /dev/null
> +++ b/testcases/kernel/sched/sysctl/.gitignore
> @@ -0,0 +1 @@
> +proc_sched_rt01
> diff --git a/testcases/kernel/sched/sysctl/Makefile b/testcases/kernel/sched/sysctl/Makefile
> new file mode 100644
> index 000000000..18896b6f2
> --- /dev/null
> +++ b/testcases/kernel/sched/sysctl/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/sched/sysctl/proc_sched_rt01.c b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
> new file mode 100644
> index 000000000..b30256792
> --- /dev/null
> +++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Sanity tests for the /proc/sys/kernel/sched_r* files.
> + *
> + * - The sched_rt_period_us range is 1 to INT_MAX
> + *   try invalid values and check for EINVAL
> + *
> + * - The sched_rt_runtime_us range is -1 to INT_MAX
> + *   try invalid values and check for EINVAL
> + *
> + * - The sched_rt_runtime_us must be less or equal to sched_rt_period_us
> + *
> + * - Reset sched_rr_timeslice_ms to default value by writing -1 and check that
> + *   we get the default value on next read.
> + *
> + *   This is a regression test for a commit:
> + *
> + *   commit c1fc6484e1fb7cc2481d169bfef129a1b0676abe
> + *   Author: Cyril Hrubis <chrubis@suse.cz>
> + *   Date:   Wed Aug 2 17:19:06 2023 +0200
> + *
> + *       sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
> + */
> +
> +#include <stdio.h>
> +#include "tst_test.h"
> +
> +#define RT_PERIOD_US "/proc/sys/kernel/sched_rt_period_us"
> +#define RT_RUNTIME_US "/proc/sys/kernel/sched_rt_runtime_us"
> +#define RR_TIMESLICE_MS "/proc/sys/kernel/sched_rr_timeslice_ms"
> +
> +static int period_fd;
> +static int runtime_fd;
> +
> +static void rr_timeslice_ms_reset(void)
> +{
> +	long timeslice_ms;
> +
> +	SAFE_FILE_PRINTF(RR_TIMESLICE_MS, "-1");
> +	SAFE_FILE_SCANF(RR_TIMESLICE_MS, "%li", &timeslice_ms);
> +
> +	TST_EXP_EXPR(timeslice_ms > 0,
> +	             "timeslice_ms > 0 after reset to default");
> +}
> +
> +static void rt_period_us_einval(void)
> +{
> +	TST_EXP_FAIL(write(period_fd, "0", 2), EINVAL,
> +	             "echo 0 > "RT_PERIOD_US);
> +	TST_EXP_FAIL(write(period_fd, "-1", 2), EINVAL,
> +	             "echo -1 > "RT_PERIOD_US);
> +}
> +
> +static void rt_runtime_us_einval(void)
> +{
> +	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
> +	             "echo -2 > "RT_RUNTIME_US);
> +}

I would happily add my tags to the test except that as a general
principal, I don't want to deal with tests that fail if an unexpected
error number is returned.

Unless something can be done (e.g. with meta-data), so that TST_EXP_FAIL
and similar can be reduced to a TCONF when the wrong errno is returned.

For instance, this would allow running the tests with a seccomp BPF
profile, LSM, CGroup or /proc bind mount that blocks the write.

Or you could just seperate the tests I guess. Then the reset can be
checked while skipping the errno checks.

> +
> +static void rt_runtime_us_le_period_us(void)
> +{
> +	int period_us;
> +	char buf[32];
> +
> +	SAFE_FILE_SCANF(RT_PERIOD_US, "%i", &period_us);
> +
> +	sprintf(buf, "%i", period_us+1);
> +
> +	TST_EXP_FAIL(write(runtime_fd, buf, strlen(buf)), EINVAL,
> +	             "echo rt_period_us+1 > "RT_RUNTIME_US);
> +}
> +
> +static void verify_sched_proc(void)
> +{
> +	rr_timeslice_ms_reset();
> +	rt_period_us_einval();
> +	rt_runtime_us_einval();
> +	rt_runtime_us_le_period_us();
> +}
> +
> +static void setup(void)
> +{
> +	period_fd = open(RT_PERIOD_US, O_RDWR);
> +	runtime_fd = open(RT_RUNTIME_US, O_RDWR);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (period_fd > 0)
> +		SAFE_CLOSE(period_fd);
> +
> +	if (runtime_fd > 0)
> +		SAFE_CLOSE(runtime_fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_sched_proc,
> +	.tags = (struct tst_tag []) {
> +		{"linux-git", "c1fc6484e1fb"},
> +		{}
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_SYSCTL",
> +		NULL
> +	},
> +};
> -- 
> 2.41.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
