Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F59C4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 13:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8FD3CEA01
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 14:07:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8F93CC903
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 14:07:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63C1F20009C
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 14:07:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24661218F0
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698757649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N8w6xRnc1dJrgBsempGMoPtflbHCLgP3d+vRglIsAE=;
 b=c6UsUBn4A/27zGldD+fHKLwTbFmuBm2PXUQKaKppVA0jPzK9qy0CoMa+6BLEmC2Q61lOwi
 K3slviXlIDTtr1tpRCUKAtZeD5JXnzpPtbwIiHLOJyaXYFZ3YPDtIVrlKrKLfXcT/hPY5c
 INQlg14VOFG+UWxyffegGnOU+e6xI6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698757649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N8w6xRnc1dJrgBsempGMoPtflbHCLgP3d+vRglIsAE=;
 b=vjNXm2zmffrlnolVxNIx2nddvXmdj+EnwF2KxBRVbgBrwPaWruV4rLocwEsdwMdK2S/FiG
 fdTmBOKuzarb05Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1023F1391B
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pDYdAxH8QGULZAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:07:29 +0000
Date: Tue, 31 Oct 2023 14:08:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <ZUD8MDxez8wmZKXk@yuki>
References: <20231031125114.5879-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231031125114.5879-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: add sched sysctl sanity test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Currently the test fails due to kernel bug, I will send patch to LKML
> later on.

Should have removed this line, the patch has been pulled into mainline
today.

> The problem with kernel is that sysctl_sched_rt_period is unsigned int
> but it's processed with proc_dointvec() which means that you are allowed
> to write negative values into the variable even though documentation
> says it shouldn't be possible and the kernel code asserts that rt_period
> is > 0.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> - Fixed a few whitespaces
> - Added second kernel commit into metadata
> 
>  runtest/sched                                 |   2 +
>  testcases/kernel/sched/sysctl/.gitignore      |   1 +
>  testcases/kernel/sched/sysctl/Makefile        |   7 +
>  .../kernel/sched/sysctl/proc_sched_rt01.c     | 122 ++++++++++++++++++
>  4 files changed, 132 insertions(+)
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
> index 000000000..203846ae4
> --- /dev/null
> +++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
> @@ -0,0 +1,122 @@
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
> + * This is a regression test for a commits:
> + *
> + *   commit c1fc6484e1fb7cc2481d169bfef129a1b0676abe
> + *   Author: Cyril Hrubis <chrubis@suse.cz>
> + *   Date:   Wed Aug 2 17:19:06 2023 +0200
> + *
> + *       sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
> + *
> + *  commit 079be8fc630943d9fc70a97807feb73d169ee3fc
> + *  Author: Cyril Hrubis <chrubis@suse.cz>
> + *  Date:   Mon Oct 2 13:55:51 2023 +0200
> + *
> + *       sched/rt: Disallow writing invalid values to sched_rt_period_us
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
> +		"timeslice_ms > 0 after reset to default");
> +}
> +
> +static void rt_period_us_einval(void)
> +{
> +	TST_EXP_FAIL(write(period_fd, "0", 2), EINVAL,
> +		"echo 0 > "RT_PERIOD_US);
> +	TST_EXP_FAIL(write(period_fd, "-1", 2), EINVAL,
> +		"echo -1 > "RT_PERIOD_US);
> +}
> +
> +static void rt_runtime_us_einval(void)
> +{
> +	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
> +		"echo -2 > "RT_RUNTIME_US);
> +}
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
> +		"echo rt_period_us+1 > "RT_RUNTIME_US);
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
> +		{"linux-git", "079be8fc6309"},
> +		{}
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_SYSCTL",
> +		NULL
> +	},
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
