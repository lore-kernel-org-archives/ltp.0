Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3E3C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D2DC3CD226
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 12:25:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACFE53C2306
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:25:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E434200074
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 12:25:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D524B22958;
 Mon, 14 Nov 2022 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668425130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6tHTYl6RWGQ7DKbE4N6MecHKDRYSsJ20lG/uXrXFWQ=;
 b=AubGDqPUesE2oZaAyoYfXrIReF/a5RfAphDRGBcd+XfUal/0cbVbCv6a57YkMaqxWUwzxx
 qX9x5E6rdpPsSnDnfurQPsPvpf37w62GHDp04FtZCimcCeaQaxTymm26KzzMW6w43xK05X
 /i0qEbExndlv+5Jpo8zZRZWFmgqP6UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668425130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r6tHTYl6RWGQ7DKbE4N6MecHKDRYSsJ20lG/uXrXFWQ=;
 b=UBMAZa/7QKPqtngMjsJCkwbVBbnWYOd09NCuR1l1CGsGhH/ZcpM9rf3qsYfKurtbL+hvX1
 QAcgwYr9MZyqgoCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id ABEE62C141;
 Mon, 14 Nov 2022 11:25:30 +0000 (UTC)
References: <20221105183213.36684-1-federico.bonfiglio@protonmail.ch>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>
Date: Mon, 14 Nov 2022 11:06:04 +0000
Organization: Linux Private Site
In-reply-to: <20221105183213.36684-1-federico.bonfiglio@protonmail.ch>
Message-ID: <87fselu6ad.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] sched_setscheduler: test SCHED_RESET_ON_FORK
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

This patch doesn't apply, the PGP signature appears to be confusing 'git
am'.

Also you need to add the
"Signed-off-by: Federico Bonfiglio <federico.bonfiglio@protonmail.ch>"
trailer to the commit message.

I suppose it should be possible to send the patch with "git send-email"
from any e-mail address using whatever SMTP server. Git should CC in
your proton mail address if you use it in the Signed-off-by trailer.

From just looking at it, the actual patch looks good with just one
comment below.

Federico Bonfiglio via ltp <ltp@lists.linux.it> writes:

> [[PGP Signed Part:Undecided]]
> ---
>  runtest/syscalls                              |  1 +
>  .../syscalls/sched_setscheduler/.gitignore    |  1 +
>  .../sched_setscheduler/sched_setscheduler04.c | 71 +++++++++++++++++++
>  3 files changed, 73 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3dc6fa397..ff516af3d 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1204,6 +1204,7 @@ sched_getscheduler02 sched_getscheduler02
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
> +++ b/testcases/kernel/syscalls/sched_setschedule
> r/.gitignore
> @@ -1,3 +1,4 @@
>  /sched_setscheduler01
>  /sched_setscheduler02
>  /sched_setscheduler03
> +/sched_setscheduler04
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> new file mode 100644
> index 000000000..f2643f001
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> @@ -0,0 +1,71 @@
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
> +static struct test_cas
> e_t cases[] = {
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
> +	tst_res(TINFO, "Testing %s variant", tv->desc);
> +	tst_res(TINFO, "Testing %s policy", tc->desc);
> +
> +	struct sched_param param = { .sched_priority = 1 };
> +
> +	tv->sched_setscheduler(getpid(), tc->policy | SCHED_RESET_ON_FORK, &param);
> +
> +	pid_t pid = SAFE_FORK();
> +
> +	if (!pid == 0) {
> +		if (sched_getscheduler(pid) == SCHED_NORMAL)
> +			tst_res(TPASS, "Policy reset to SCHED_NORMAL");
> +		else
> +			tst_res(TFAIL, "Policy NOT reset to SCHED_NORMAL");
> +	}
> +
> +	tst_reap_children();
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_root = 1,

Does it actually need root or is just CAP_SYS_NICE enough?

We can just set

	.caps = (struct tst_cap []) {
		TST_CAP(TST_CAP_REQ, CAP_SYS_NICE)
        }

If so.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
