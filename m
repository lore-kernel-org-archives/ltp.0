Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB79C197A0
	for <ltp@archiver.kernel.org>; Fri, 17 Nov 2023 09:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4553CE335
	for <ltp@archiver.kernel.org>; Fri, 17 Nov 2023 10:22:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0CFC3C8206
 for <ltp@lists.linux.it>; Fri, 17 Nov 2023 10:21:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 441A3206500
 for <ltp@lists.linux.it>; Fri, 17 Nov 2023 10:21:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8DBD91F892;
 Fri, 17 Nov 2023 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700212914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfRqqHuNBSuIgcZd3jTgl0PFBNbmo34w1CS8H7iNyZM=;
 b=CGmXUpqSFam3ZphA9AAccpcSLZ0owFWPasRbtsvwJb0fFaOMTgy4tNCtBCPz6L6Ycwc4f3
 FRq3piFy8GY+F5l9xSu1vlGz29ruTi0Jn+LiJ9xkpcJ/JZQP03gPCbmVaHqianeH9OZXcp
 PAIx2C2b4lpZksy9/AyftcUW9BLHsuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700212914;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VfRqqHuNBSuIgcZd3jTgl0PFBNbmo34w1CS8H7iNyZM=;
 b=eLM/KEptuZZbvjc/VDwkzRc/rU/p+UVOGZEa5i4bHo4awQUwYddQAC2s/NYvO3dZ174Ibx
 N7Rjh4LxzbaWAQAg==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3CD5D2C20B;
 Fri, 17 Nov 2023 09:21:54 +0000 (UTC)
References: <20221114225616.54212-1-federico.bonfiglio@protonmail.ch>
 <20230916124919.31203-1-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Fri, 17 Nov 2023 09:21:14 +0000
Organization: Linux Private Site
In-reply-to: <20230916124919.31203-1-wegao@suse.com>
Message-ID: <87edgoag5q.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [14.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; NEURAL_SPAM_SHORT(3.00)[1.000];
 HAS_ORG_HEADER(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 VIOLATED_DIRECT_SPF(3.50)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 8DBD91F892
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched_setscheduler04.c: Test
 SCHED_RESET_ON_FORK
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
Cc: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/capability.h                     |  4 +
>  runtest/syscalls                              |  1 +
>  .../syscalls/sched_setscheduler/.gitignore    |  1 +
>  .../sched_setscheduler/sched_setscheduler04.c | 78 +++++++++++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
>
> diff --git a/include/lapi/capability.h b/include/lapi/capability.h
> index 17ec107b1..2b593797c 100644
> --- a/include/lapi/capability.h
> +++ b/include/lapi/capability.h
> @@ -36,6 +36,10 @@
>  # define CAP_SYS_ADMIN        21
>  #endif
>  
> +#ifndef CAP_SYS_NICE
> +# define CAP_SYS_NICE         23
> +#endif
> +
>  #ifndef CAP_SYS_TIME
>  # define CAP_SYS_TIME         25
>  #endif
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 04b758fd9..b86188013 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1228,6 +1228,7 @@ sched_getscheduler02 sched_getscheduler02
>  sched_setscheduler01 sched_setscheduler01
>  sched_setscheduler02 sched_setscheduler02
>  sched_setscheduler03 sched_setscheduler03
> +sched_setscheduler04 sched_setscheduler04
>  
>  sched_yield01 sched_yield01
>  
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/.gitignore b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> index aa8ad9695..1b8860d2c 100644
> --- a/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> +++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> @@ -1,3 +1,4 @@
>  /sched_setscheduler01
>  /sched_setscheduler02
>  /sched_setscheduler03
> +/sched_setscheduler04
> diff --git
> a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> new file mode 100644
> index 000000000..828d1ec09
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
> + */
> +
> +/*
> + * [Description]
> + *
> + * Testcases that test if sched_setscheduler with flag
> + * SCHED_RESET_ON_FORK restores children policy to
> + * SCHED_NORMAL.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sched.h>
> +#include <linux/sched.h>
> +
> +#include "tst_test.h"
> +#include "tst_sched.h"
> +
> +struct test_case_t {
> +	int policy;
> +	char *desc;
> +};
> +
> +static struct test_case_t cases[] = {
> +	{
> +		.policy = SCHED_FIFO,
> +		.desc = "SCHED_FIFO"
> +	},
> +	{
> +		.policy = SCHED_RR,
> +		.desc = "SCHED_RR"
> +	}
> +};
> +
> +static void test_reset_on_fork(unsigned int i)
> +{
> +	struct sched_variant *tv = &sched_variants[tst_variant];
> +	struct test_case_t *tc = &cases[i];
> +
> +	tst_res(TINFO, "Testing %s variant %s policy", tv->desc, tc->desc);
> +
> +	struct sched_param param = { .sched_priority = 10 };
> +
> +	tv->sched_setscheduler(getpid(), tc->policy | SCHED_RESET_ON_FORK, &param);
> +
> +	pid_t pid = SAFE_FORK();
> +
> +	if (pid) {
> +		if (sched_getscheduler(pid) == SCHED_NORMAL)
> +			tst_res(TPASS, "Policy reset to SCHED_NORMAL");
> +		else
> +			tst_res(TFAIL, "Policy NOT reset to SCHED_NORMAL");
> +
> +		sched_getparam(pid, &param);
> +
> +		/* kernel will return sched_priority 0 if task is not RT Policy */
> +		if (param.sched_priority == 0)
> +			tst_res(TPASS, "Priority set to 0");
> +		else
> +			tst_res(TFAIL, "Priority not set to 0");
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.caps = (struct tst_cap[]) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_NICE),
> +		{}
> +	},
> +	.test_variants = ARRAY_SIZE(sched_variants),
> +	.tcnt = ARRAY_SIZE(cases),
> +	.test = test_reset_on_fork,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
