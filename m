Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46364CA0FE5
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 16:15:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13A473CC234
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 18:15:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A10A43CBB5B
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 18:15:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81BAF140170F
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 18:15:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCAAE1F45F;
 Fri,  1 Sep 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693584930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkX8iaGakm/M4Ogb70xeICdWqLXJB9brXAX+RocOrgc=;
 b=FjVYzwfIwWNxUJuJ0lq4WcWPJJ+wu4x2JMl5CrEFCv3mzA+FyY12LOtgLZfU1p1lG4Oc3k
 Ahlo7UJLx9jb6DIz4CLUOyM8rU1uxHMVt1RTs88BowNVqeQxIUZVxXqHJNyZlUzwKieKDN
 WxT7NxdHVroQd/mQGPJK7BydV3JwtPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693584930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZkX8iaGakm/M4Ogb70xeICdWqLXJB9brXAX+RocOrgc=;
 b=FJyKxKhj5xTYgoCLdHfb6P3pXmH9ipywHrNolIcBFMYPCXKNXLv3yWFK5l6P8C3Uwlj9zu
 mGJQsvwXMZRvmgAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CF9613582;
 Fri,  1 Sep 2023 16:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1hBYBiIO8mSMFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 16:15:30 +0000
Date: Fri, 1 Sep 2023 18:15:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230901161528.GA364687@pevik>
References: <20230901144433.2526-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901144433.2526-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Currently the test fails due to kernel bug, I will send patch to LKML
> later on.
+1.

> The problem with kernel is that sysctl_sched_rt_period is unsigned int
> but it's processed with proc_dointvec() which means that you are allowed
> to write negative values into the variable even though documentation
> says it shouldn't be possible and the kernel code asserts that rt_period
> is > 0.

Interesting.

LTP patch uses sometimes spaces instead of tabs:

$ make check-proc_sched_rt01
CHECK testcases/kernel/sched/sysctl/proc_sched_rt01.c
proc_sched_rt01.c:49: ERROR: code indent should use tabs where possible
proc_sched_rt01.c:55: ERROR: code indent should use tabs where possible
proc_sched_rt01.c:57: ERROR: code indent should use tabs where possible
proc_sched_rt01.c:63: ERROR: code indent should use tabs where possible
proc_sched_rt01.c:76: ERROR: code indent should use tabs where possible

...
> diff --git a/testcases/kernel/sched/sysctl/.gitignore b/testcases/kernel/sched/sysctl/.gitignore
> new file mode 100644
> index 000000000..29b859b81
> --- /dev/null
> +++ b/testcases/kernel/sched/sysctl/.gitignore
> @@ -0,0 +1 @@
> +proc_sched_rt01
nit: We usually put / in the front:
/proc_sched_rt01

...
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
very nit: If you use dot at the end of this sentence, please add it also to the
previous sentences.

> + *
> + *   This is a regression test for a commit:
> + *
> + *   commit c1fc6484e1fb7cc2481d169bfef129a1b0676abe
> + *   Author: Cyril Hrubis <chrubis@suse.cz>
> + *   Date:   Wed Aug 2 17:19:06 2023 +0200
> + *
> + *       sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

nit: this makes docparse formatting ugly. This would be nicer:
c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
(Unless we really prefer to have the date in the output, but in that case adding
a note which kernel version was fixing it would be IMHO more informative than
the date.)

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
Why not 1 as 3rd write() parameter?

> +	             "echo 0 > "RT_PERIOD_US);
nit: I'd add blank line here (readability).
> +	TST_EXP_FAIL(write(period_fd, "-1", 2), EINVAL,
> +	             "echo -1 > "RT_PERIOD_US);
> +}
> +
> +static void rt_runtime_us_einval(void)
> +{
> +	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
> +	             "echo -2 > "RT_RUNTIME_US);
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
> +	             "echo rt_period_us+1 > "RT_RUNTIME_US);
4x use of the same code, but I agree it's not worth of creating a function, as
the code is simple enough and probably more readable.

> +}
> +
> +static void verify_sched_proc(void)
> +{
Is there any value to print content of /proc/sys/kernel/sched_rt_runtime_us
before writing into it?

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
