Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DF5ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:18:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EE773C97B2
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:18:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147A53C0475
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:18:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 259891400752
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:18:14 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0EA2322169;
 Mon, 24 Oct 2022 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666610294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5G6E1Hg9uPTGH8+EE6+zQFrzTKLEcWW2BfcxOg0nws=;
 b=KT5JutrEquXSIA3utzvxhoeQeyfE8aT02Zf1iEea0YGpyS5peU4qfeBpYOQ24yC+0pwj7P
 RYiOJiwufae06kPH7NDFflZewdNJ6ayq826wkW86/zKVmWvK0ecXUHlh6KJyoPeO+1ejL8
 Aow65mAQsSDxGXDRv1tWZNXrcMIK9fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666610294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5G6E1Hg9uPTGH8+EE6+zQFrzTKLEcWW2BfcxOg0nws=;
 b=tTqyhqUofeaE4d4JLFrIvHzHMKN9t93x/9hPGKrJnudOmPK5VE9nhRpZi5THdD5Y4UsGIh
 fqH75Mm2VSghEnBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8B8882C142;
 Mon, 24 Oct 2022 11:18:13 +0000 (UTC)
References: <20221014035615.185057-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 12:07:13 +0100
In-reply-to: <20221014035615.185057-1-zhaogongyi@huawei.com>
Message-ID: <87ilk9zd01.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/nice05: new test for nice()
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

> Verify that user of root can decrease the nice value of
> the process successfully by passing a lower increment
> value (< min. applicable limits) to nice() system call.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                          |  1 +
>  testcases/kernel/syscalls/nice/.gitignore |  1 +
>  testcases/kernel/syscalls/nice/nice05.c   | 54 +++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/nice/nice05.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bd74373a4..7db399375 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -902,6 +902,7 @@ nice01 nice01
>  nice02 nice02
>  nice03 nice03
>  nice04 nice04
> +nice05 nice05

05 has already been taken. Also this test is very similar to
nice01. Maybe it could be added to that?

>
>  open01 open01
>  open01A symlink01 -T open01
> diff --git a/testcases/kernel/syscalls/nice/.gitignore b/testcases/kernel/syscalls/nice/.gitignore
> index 9d7a1bb43..58d64779e 100644
> --- a/testcases/kernel/syscalls/nice/.gitignore
> +++ b/testcases/kernel/syscalls/nice/.gitignore
> @@ -2,3 +2,4 @@
>  /nice02
>  /nice03
>  /nice04
> +/nice05
> diff --git a/testcases/kernel/syscalls/nice/nice05.c b/testcases/kernel/syscalls/nice/nice05.c
> new file mode 100644
> index 000000000..85f10fadf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/nice/nice05.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright(c) 2022 Huawei Technologies Co., Ltd
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that user of root can decrease the nice value of
> + * the process successfully by passing a lower increment
> + * value (< min. applicable limits) to nice() system call.
> + */
> +#include <unistd.h>
> +#include "tst_test.h"
> +
> +#define	NICEINC -50
> +#define MIN_PRIO  -20
> +#define DEFAULT_PRIO 0
> +
> +static void verify_nice(void)
> +{
> +	int new_nice;
> +
> +	TEST(nice(NICEINC));

Why not use one of the TST_EXP* macros?

> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "nice(%d) returned -1", NICEINC);
> +		return;
> +	}
> +
> +	if (TST_ERR) {
> +		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
> +		return;
> +	}
> +
> +	new_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
> +
> +	if (new_nice != MIN_PRIO) {
> +		tst_res(TFAIL,
> +			"Process priority %i, expected %i", new_nice, MIN_PRIO);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "nice(%d) passed", NICEINC);
> +
> +	TEST(nice(DEFAULT_PRIO));
> +	if (TST_ERR)
> +		tst_brk(TBROK | TTERRNO, "nice(%d) failed",
> DEFAULT_PRIO);

Again, could use TST_EXP* macro. Also just checking TST_ERR is not
strictly correct.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_nice,
> +	.needs_root = 1,
> +};
> --
> 2.17.1

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
