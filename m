Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9957C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 08:04:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09FB33C91B5
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:04:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DEB83C1AE9
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 10:04:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 57AD514002B5
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 10:04:13 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9138021BA9;
 Mon, 24 Oct 2022 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666598653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbh5T07HVuUQIbQFUIAKXNxXKAW0ExgyMusEXCvSOHI=;
 b=uUxDZv/PQHs/HCxIi+E7IYlNvU3THMjLRcTKwa1vehoxvZkLKrHPEm/ZUHWSSuJN2ZvcWw
 uoI9SJlfrBoImGhfa0Svor/icbdA/MO32k8COb+2e4GL0lf5kZdWs0sLN0ReTMJrW4GrZf
 CwkB0orMmuqrxa5euqqOQ/eo8XQHE0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666598653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbh5T07HVuUQIbQFUIAKXNxXKAW0ExgyMusEXCvSOHI=;
 b=UYjRXqHT6AsspE5hRBa7VzEOS3pR6qts2hfrBp6+IwI+KoIBnu1kVm8z8mEHs5c6cxSk9+
 ygUcoFfZ70gABpDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 113752C141;
 Mon, 24 Oct 2022 08:04:13 +0000 (UTC)
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
 <20221013134728.49609-3-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 08:58:36 +0100
In-reply-to: <20221013134728.49609-3-zhaogongyi@huawei.com>
Message-ID: <87zgdlzlz7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
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

> Check that madvise(2) MADV_DONTNEED operation applied to Huge
> TLB pages successfully after kernel version 5.18, and will result
> in zero-fill-on-demand pages for anonymous private mappings.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
>  testcases/kernel/syscalls/madvise/madvise04.c | 62 +++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index c81764df4..eb1910cec 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -941,6 +941,7 @@ mincore04 mincore04
>  madvise01 madvise01
>  madvise02 madvise02
>  madvise03 madvise03
> +madvise04 madvise04
>  madvise05 madvise05
>  madvise06 madvise06
>  madvise07 madvise07
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index f4bfdfefe..db8ce47c1 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -1,6 +1,7 @@
>  /madvise01
>  /madvise02
>  /madvise03
> +/madvise04
>  /madvise05
>  /madvise06
>  /madvise07
> diff --git a/testcases/kernel/syscalls/madvise/madvise04.c b/testcases/kernel/syscalls/madvise/madvise04.c
> new file mode 100644
> index 000000000..a970fb33e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise04.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check that madvise(2) MADV_DONTNEED operation applied to Huge TLB pages
> + * successfully after kernel version 5.18, and will result in
> + * zero-fill-on-demand pages for anonymous private mappings.
> + */
> +
> +#include "tst_test.h"
> +
> +#define MAP_SIZE (8 * 1024)
> +
> +static char *addr;
> +static int mapsz;
> +
> +static void run(void)
> +{
> +	TST_EXP_PASS(madvise(addr, mapsz, MADV_DONTNEED));
> +	for (int i = 0; i < mapsz; i++) {
> +		if (addr[i]) {
> +			tst_res(TFAIL,
> +				"There are no zero-fill-on-demand pages "
> +				"for anonymous private mappings");
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "There are zero-fill-on-demand pages "
> +		       "for anonymous private mappings");
> +}
> +
> +static void setup(void)
> +{
> +	mapsz = tst_get_hugepage_size();
> +	addr = SAFE_MMAP(NULL, mapsz,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
> +	memset(addr, 1, mapsz);

If we only do memset here then we are only testing the zero-fill feature
on the first iteration.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (addr)
> +		SAFE_MUNMAP(addr, mapsz);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "5.18",

What happens before 5.18? Could we try applying MADV_DONTNEED and return
TCONF instead?

> +	.needs_root = 1,

Why does this need root?

> +	.hugepages = {1, TST_NEEDS},
> +};
> +
> --
> 2.17.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
