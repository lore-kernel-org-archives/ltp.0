Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCFEC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 15:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F77E3CC67E
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 16:04:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1834E3C585E
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:04:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4628D6005EC
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:04:36 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 976D221B97;
 Mon, 28 Nov 2022 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669647876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anP7byQpcQtNwmx2+qDhl63dJ2qti0VCz+ThGfONJD0=;
 b=Rz6jYmFobVZJx4y0X8XhGO/pGWnmPJFxKkb8TWv7j4OU9JrP0tH3rTJoUId5oXDv8aYNAM
 kAwfEbhLoo7cCoEqcgNgihcx6mL9VqXLPpafT20vaCO2KgKFt/pIKZquffTltlr/XxlKkI
 88OPLI5U2ZnSwyEIkUzopxNiaVOAU6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669647876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anP7byQpcQtNwmx2+qDhl63dJ2qti0VCz+ThGfONJD0=;
 b=VIXsRKAHrimhk6uE8o79NI0Per086yRD8G5iPRWX1wEx7U7JUpkhAacP6/CPOPwNY+cFpB
 fJg8BPN/swl/vsCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 69FB42C141;
 Mon, 28 Nov 2022 15:04:36 +0000 (UTC)
References: <1668580004-2088-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1668580004-2088-2-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 28 Nov 2022 15:02:32 +0000
Organization: Linux Private Site
In-reply-to: <1668580004-2088-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87cz97unlo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] cgroup_core02: copy from kernel selftest
 test_cgcore_lesser_ns_open
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

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  runtest/controllers                           |   1 +
>  .../kernel/controllers/cgroup/.gitignore      |   1 +
>  .../kernel/controllers/cgroup/cgroup_core02.c | 129 ++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 testcases/kernel/controllers/cgroup/cgroup_core02.c
>
> diff --git a/runtest/controllers b/runtest/controllers
> index 41f8367e4..8d1b936bf 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -1,5 +1,6 @@
>  #DESCRIPTION:Resource Management testing
>  cgroup_core01	cgroup_core01
> +cgroup_core02	cgroup_core02
>  cgroup		cgroup_regression_test.sh
>  memcg_regression	memcg_regression_test.sh
>  memcg_test_3	memcg_test_3
> diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
> index 382f2d9f2..012aedcca 100644
> --- a/testcases/kernel/controllers/cgroup/.gitignore
> +++ b/testcases/kernel/controllers/cgroup/.gitignore
> @@ -2,3 +2,4 @@
>  /cgroup_regression_getdelays
>  /cgroup_regression_6_2
>  /cgroup_core01
> +/cgroup_core02
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> new file mode 100644
> index 000000000..0dff71eea
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * When a task is writing to an fd opened by a different task, the perm check
> + * should use the cgroup namespace of the latter task.
> + *
> + * It is copy from kernel selftests cgroup test_core test_cgcore_lesser_ns_open
> + * subcase. Note that this case only runs on cgroup2 as cgroup1 doesn't have
> + * namespace support.
> + *
> + * It is a regression test for
> + *
> + * commit e57457641613fef0d147ede8bd6a3047df588b95
> + * Author: Tejun Heo <tj@kernel.org>
> + * Date:   Thu Jan 6 11:02:29 2022 -1000
> + *
> + * cgroup: Use open-time cgroup namespace for process migration perm checks
> + */
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +
> +static struct tst_cg_group *cg_child_a, *cg_child_b;
> +static uid_t nobody_uid;
> +
> +struct lesser_ns_open_thread_arg {
> +	int fds[TST_CG_ROOTS_MAX];
> +	int loops;
> +};
> +
> +static int lesser_ns_open_thread_fn(void *arg)
> +{
> +	struct lesser_ns_open_thread_arg *targ = arg;
> +
> +	targ->loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, targ->fds);
> +	return 0;
> +}
> +
> +static void test_lesser_ns_open(void)
> +{
> +	int i;
> +	static char stack[65536];
> +	pid_t pid;
> +	int status;
> +	struct lesser_ns_open_thread_arg targ = { .fds = {0}, .loops = -1};
> +
> +	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
> +	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_CG_PRINT(cg_child_a, "cgroup.procs", "0");
> +		SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
> +		SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);
> +		pid  = ltp_clone(CLONE_NEWCGROUP | CLONE_FILES | CLONE_VM | SIGCHLD,
> +					lesser_ns_open_thread_fn, &targ,
> 65536, stack);

FYI, I would like to replace this with tst_clone.

However merged, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
