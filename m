Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E3AC38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:28:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72BEF3C9606
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:28:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018E73C0475
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:28:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51C022003A6
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:28:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A7A6622169;
 Mon, 24 Oct 2022 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666610888;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkVS7FhDeHZ02Y6aM4KYeFDkSXBGDp4/jvxnDCS3c4s=;
 b=JXG5nQRaSJK9GKp613JQKC8G3pSUkxkoRUms5yLKXxjw1bfuBQ1ivAby0bZhuzM5HO/i73
 chrZGANVFiBSSsIfgaCgIrBOUPWaevSkdI6l6esPID38/3tgg0gO7G3Fm57/DpBf5pkxqr
 bgD+4pKCol0ZIfWTDmB9XjD6QedzRsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666610888;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gkVS7FhDeHZ02Y6aM4KYeFDkSXBGDp4/jvxnDCS3c4s=;
 b=yKsUEmFOXs6YYbtG2KQIDZJVVFtAZ2B/Hizrw6I99d2mfj4sUjZxQnZGYCd7pkx+sc/Owm
 hCJIVIYpEPeYLFBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 528282C141;
 Mon, 24 Oct 2022 11:28:08 +0000 (UTC)
References: <20221020125747.231509-1-zhaogongyi@huawei.com>
 <20221020125747.231509-2-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 12:27:17 +0100
In-reply-to: <20221020125747.231509-2-zhaogongyi@huawei.com>
Message-ID: <87a65lzcjc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/nice06: new test for nice()
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
>  testcases/kernel/syscalls/nice/nice06.c   | 54 +++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/nice/nice06.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a52b93c92..557c946ec 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -902,6 +902,7 @@ nice02 nice02
>  nice03 nice03
>  nice04 nice04
>  nice05 nice05
> +nice06 nice06

Ah I see you resubmitted nice05 with a new test name. Please see
my comments on V1.

>
>  open01 open01
>  open01A symlink01 -T open01
> diff --git a/testcases/kernel/syscalls/nice/.gitignore b/testcases/kernel/syscalls/nice/.gitignore
> index 58d64779e..c96064cdf 100644
> --- a/testcases/kernel/syscalls/nice/.gitignore
> +++ b/testcases/kernel/syscalls/nice/.gitignore
> @@ -3,3 +3,4 @@
>  /nice03
>  /nice04
>  /nice05
> +/nice06
> diff --git a/testcases/kernel/syscalls/nice/nice06.c b/testcases/kernel/syscalls/nice/nice06.c
> new file mode 100644
> index 000000000..92138f21e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/nice/nice06.c
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
> +		tst_res(TFAIL, "Process priority %i, expected %i",
> +			new_nice, MIN_PRIO);
> +		return;
> +	}
> +
> +	tst_res(TPASS, "nice(%d) passed", NICEINC);
> +
> +	TEST(nice(DEFAULT_PRIO));
> +	if (TST_ERR)
> +		tst_brk(TBROK | TTERRNO, "nice(%d) failed", DEFAULT_PRIO);
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
