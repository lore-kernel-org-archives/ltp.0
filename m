Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CDECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:04:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFFE13C9788
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:04:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE3E93C0475
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:04:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 03FE11A00800
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:04:16 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DD00F21EAE;
 Mon, 24 Oct 2022 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666605855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QBnxrKdCBm4WQ+MCImd1/qpxviqtyH3L+tQndxh2B/A=;
 b=YZx8s24XFFiCYFxFSZvxJU9YdFvYqvBrgJyVo8wAOm8SimYV9bYZ1iQzZ4G99KNRJjEpeM
 YqCrs3kMJCfW5mo1xm/sm/8X2+7vJ1VJawIrjMDcYCTJdkMjx2DQehyWA1LxnWAau5uXZP
 MwLAES4AZD9KeXWaptQctcPn5A4V4C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666605855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QBnxrKdCBm4WQ+MCImd1/qpxviqtyH3L+tQndxh2B/A=;
 b=gPLgS9pvs3AqoWsbDiy4lDg3CFb2KkystNEva5WHsQMNuOQNSUP3Pb0TxqaAjqbbDqcCl0
 kpmYYgUGuNi2rkDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 56E3F2C142;
 Mon, 24 Oct 2022 10:04:14 +0000 (UTC)
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
 <20221013134728.49609-4-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 10:48:19 +0100
In-reply-to: <20221013134728.49609-4-zhaogongyi@huawei.com>
Message-ID: <87v8o9zgfc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls/madvise11: new test for
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

> Check that madvise(2) MADV_DONTNEED applied to shared mappings will lead to
> the resident set size(RSS) of the calling process reduced immediately.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
>  testcases/kernel/syscalls/madvise/madvise11.c | 82 +++++++++++++++++++
>  3 files changed, 84 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index eb1910cec..296af9f9d 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -948,6 +948,7 @@ madvise07 madvise07
>  madvise08 madvise08
>  madvise09 madvise09
>  madvise10 madvise10
> +madvise11 madvise11
>
>  newuname01 newuname01
>
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index db8ce47c1..ffd8823d1 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -8,3 +8,4 @@
>  /madvise08
>  /madvise09
>  /madvise10
> +/madvise11
> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> new file mode 100644
> index 000000000..0132c091c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check that madvise(2) MADV_DONTNEED applied to shared mappings will lead to
> + * the resident set size(RSS) of the calling process reduced immediately.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define MAP_SIZE (8 * 1024)
> +#define BUF_SIZE 1024
> +
> +static FILE *fp;
> +static char *addr;
> +
> +static void run(void)
> +{
> +	char cmd[BUF_SIZE];
> +	char line[BUF_SIZE];
> +	char vm_area_addr[128];
> +
> +	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x) failed",
> +			addr, MAP_SIZE, MADV_DONTNEED);
> +	}

You have a lot of madvise patches, so why not create SAFE_MADVISE?

Or there are the TST_EXP_* macros.

> +
> +	sprintf(vm_area_addr, "%p", addr);
> +	sprintf(cmd, "cat /proc/%d/smaps", getpid());
> +	fp = popen(cmd, "r");
> +
> +	/* Find the vm area */
> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		if (strstr(line, &(vm_area_addr[2])))

AFAICT this could match more than one line by matching the end of the
preceding range.

I think that in general it's better to avoid strstr if memcmp can be
easily used instead.

> +			break;
> +	}
> +
> +	/* Find Rss size of the vm area */
> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		if (strstr(line, "Rss:")) {

Same here although Rss: seems to be unique. Then again it could be added
to another field in new kernel.

Perhaps sscanf would be better?

> +			if (strstr(line, " 0 kB"))
> +				tst_res(TPASS, "RSS is released");
> +			else
> +				tst_res(TFAIL, "RSS is not released");
> +			return;
> +		}
> +	}
> +
> +	tst_brk(TBROK, "There is no 'Rss:' or vm_area %p in smaps?", addr);
> +}
> +
> +static void setup(void)
> +{
> +	addr = SAFE_MMAP(NULL, MAP_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			-1, 0);
> +	memset(addr, 1, MAP_SIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (addr)
> +		SAFE_MUNMAP(addr, MAP_SIZE);
> +	if (fp)
> +		pclose(fp);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> +
> --
> 2.17.1

Otherwise looks good.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
