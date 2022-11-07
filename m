Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B8C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 13:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00C733CDA15
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 14:35:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F4CE3C6E8B
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 14:34:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66CE5200222
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 14:34:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 610AC1F8B0;
 Mon,  7 Nov 2022 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667828095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKNXXfYp6i0DJRKMYKtXMvUJAbi9XDvclKrEavDRTm4=;
 b=Twt1tfocNBKDZ2jK6zrlk8i08mucbTYfl0WWnj4KLzYIzeISw2cBEDfaaDRJ6fpq/KNkZg
 1jZtOPQzT3Gu5FHTJ0+epOXqJ5rX3a7ie2fXptLtq18ehKqiDs9rj1mm0kKcuKzntCMvdb
 pV8MrmyMkF53eIl7cflitpBx1wFe5GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667828095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKNXXfYp6i0DJRKMYKtXMvUJAbi9XDvclKrEavDRTm4=;
 b=X304pluYv+UiGwqHSA/UoIiQBQ6J5HKGFkCUOaLrNHcYK+PAmUIw+Qo2Gre4AElq7myvl9
 NH1U58uBUr/wLJAw==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E2FC42C141;
 Mon,  7 Nov 2022 13:34:54 +0000 (UTC)
References: <20221026035130.198906-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 07 Nov 2022 12:30:47 +0000
Organization: Linux Private Site
In-reply-to: <20221026035130.198906-1-zhaogongyi@huawei.com>
Message-ID: <87k046x4zl.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_setscheduler04: new test for
 sched_setscheduler()
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

Zhao Gongyi via ltp <ltp@lists.linux.it> writes:

> Verify that the scheduling policy and parameters are in fact per-thread
> attributes on Linux:
> 1. Specifying pid as 0 will operate on the attributes of the calling thread
> 2. The value returned from a call to gettid(2) can be passed in the argument
>    pid.
> 3. Passing the value returned from a call to getpid(2) will operate on the
>    attributes of the main thread of the  thread  group
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  .../syscalls/sched_setscheduler/.gitignore    |  1 +
>  .../syscalls/sched_setscheduler/Makefile      |  2 +
>  .../sched_setscheduler/sched_setscheduler04.c | 91 +++++++++++++++++++
>  4 files changed, 95 insertions(+)
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
> +++ b/testcases/kernel/syscalls/sched_setscheduler/.gitignore
> @@ -1,3 +1,4 @@
>  /sched_setscheduler01
>  /sched_setscheduler02
>  /sched_setscheduler03
> +/sched_setscheduler04
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/Makefile b/testcases/kernel/syscalls/sched_setscheduler/Makefile
> index 044619fb8..e3d54e33e 100644
> --- a/testcases/kernel/syscalls/sched_setscheduler/Makefile
> +++ b/testcases/kernel/syscalls/sched_setscheduler/Makefile
> @@ -3,6 +3,8 @@
>
>  top_srcdir		?= ../../../..
>
> +sched_setscheduler04: CFLAGS += -pthread
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> new file mode 100644
> index 000000000..6f985be88
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler04.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that the scheduling policy and parameters are in fact per-thread
> + * attributes on Linux:
> + * 1. Specifying pid as 0 will operate on the attributes of the calling thread
> + * 2. The value returned from a call to gettid(2) can be passed in the argument
> + *    pid.
> + * 3. Passing the value returned from a call to getpid(2) will operate on the
> + *    attributes of the main thread of the  thread  group
> + */
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "tst_safe_pthread.h"
> +#include <pthread.h>
> +
> +static struct sched_param param;
> +static volatile int sched_prio;
> +
> +#define SCHED_POLICY SCHED_FIFO
> +
> +static void set_param(int tid)
> +{
> +	param.sched_priority = sched_prio;
> +
> +	if (sched_setscheduler(tid, SCHED_POLICY, &param)) {
> +		tst_brk(TBROK | TERRNO,
> +			"sched_setscheduler(%d, %d, ...) failed",
> +			tid, SCHED_POLICY);
> +	}
> +}
> +
> +static void check_prio(int tid)
> +{
> +	if (sched_getparam(tid, &param) != 0)
> +		tst_brk(TBROK | TERRNO, "sched_getparam() failed");
> +
> +	if (param.sched_priority != sched_prio)
> +		tst_res(TFAIL, "Checking of thread priority failed");
> +	else
> +		tst_res(TPASS, "Checking of thread priority passed");

How are we going to debug a test failure?

This can be replaced with the TST_EXP_* macros which will print more
info if used correctly.

At the least we should print what thread or pid we are operating
on. What the priority and policies were originally, what we changed them
to and what they are at the end.

> +}
> +
> +static void *thread_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +{
> +	pid_t threadid = tst_syscall(__NR_gettid);
> +
> +	sched_prio++;
> +	set_param(0);
> +	check_prio(threadid);
> +
> +	sched_prio++;
> +	set_param(threadid);
> +	check_prio(threadid);
> +
> +	return NULL;
> +}
> +
> +static void test_sched_setscheduler01(void)
> +{
> +	sched_prio++;
> +	set_param(getpid());
> +	check_prio(tst_syscall(__NR_gettid));
> +}
> +
> +static void test_sched_setscheduler02(void)
> +{
> +	pthread_t tid;
> +
> +	SAFE_PTHREAD_CREATE(&tid, NULL, thread_func, NULL);
> +	SAFE_PTHREAD_JOIN(tid, NULL);
> +}
> +
> +
> +static void run(void)
> +{
> +	sched_prio = sched_get_priority_min(SCHED_POLICY);

This can go in the setup function.

> +
> +	test_sched_setscheduler01();
> +	test_sched_setscheduler02();

This should be replaced with .tcnt = 2 and .test. or else just merge
them into run.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,

We probably need to ensure CAP_SYS_NICE. Full details are in 'man 7
sched'

i.e. .caps = (struct tst_cap[]) {
  TST_CAP(TST_CAP_REQ, CAP_SYS_NICE),
   null
}

> +};
> --
> 2.17.1

Setting patchwork to changes requested for the reasons above.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
