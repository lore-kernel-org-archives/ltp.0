Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7115CC38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B35593C9741
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:52:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14EDC3C4D7B
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:52:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F5C22001C6
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:52:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CFBB922161;
 Mon, 24 Oct 2022 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666608766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYedk7+Ruhpb73WbHxkvljhk88aVZvQZGPsuPkO8pMg=;
 b=SSttFSo3qGT0Na41xCaMNHEXaThrfSulgzB4y+ZqSfbcJuNfDDdb1vLP1LpB/OLOAnIdiN
 Vvl2hIcKUqriuxcf4fz0bZutVexWa2Otc6x74T2w4kw53cnPhkyopAvTtfmPNLNhhsKgy7
 Fi5vkq29RhLkRXGINuDUB07Y8U0OjZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666608766;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYedk7+Ruhpb73WbHxkvljhk88aVZvQZGPsuPkO8pMg=;
 b=7Mk11FRYVQIb5WoolvDqQ8qq++NEL2uqM6/nzyNlupLsyiNOy52DfHf1pHgwg/GcYWDUsV
 1tDkIEsYyNJpKPAQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 426AE2C141;
 Mon, 24 Oct 2022 10:52:46 +0000 (UTC)
References: <20221013134728.49609-1-zhaogongyi@huawei.com>
 <20221013134728.49609-5-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 11:47:42 +0100
In-reply-to: <20221013134728.49609-5-zhaogongyi@huawei.com>
Message-ID: <87r0yxze6a.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] syscalls/madvise12: new test for
 madvise(MADV_REMOVE)
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

> Check that after a successful madvise(2) MADV_REMOVE operation, subsequent
> accesses in the specified address range will see bytes containing zero.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
>  testcases/kernel/syscalls/madvise/madvise12.c | 85 +++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise12.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 296af9f9d..0697b31ab 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -949,6 +949,7 @@ madvise08 madvise08
>  madvise09 madvise09
>  madvise10 madvise10
>  madvise11 madvise11
> +madvise12 madvise12
>
>  newuname01 newuname01
>
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index ffd8823d1..dc82c82bd 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -9,3 +9,4 @@
>  /madvise09
>  /madvise10
>  /madvise11
> +/madvise12
> diff --git a/testcases/kernel/syscalls/madvise/madvise12.c b/testcases/kernel/syscalls/madvise/madvise12.c
> new file mode 100644
> index 000000000..7c22e464d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise12.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check that after a successful madvise(2) MADV_REMOVE operation, subsequent
> + * accesses in the specified address range will see bytes containing zero.
> + */
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include "tst_test.h"
> +
> +#define MAP_SIZE (8 * 1024)
> +#define FNAME "madvise_remove"
> +#define MOUNT_POINT "mntpoint"
> +
> +static char *addr;
> +static int fd;
> +
> +static void run(void)
> +{

Same as the other test, memset is required here

> +	TEST(madvise(addr, MAP_SIZE, MADV_REMOVE));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "'MADV_REMOVE' not supported?");
> +		else {
> +			tst_res(TFAIL | TTERRNO, "madvise(%p, %d, 0x%x) failed",
> +				addr, MAP_SIZE, MADV_REMOVE);
> +			return;
> +		}
> +	}

Also same as other test, this could be put in SAFE_MADVISE.

> +
> +	for (int i = 0; i < MAP_SIZE; i++) {
> +		if (addr[0]) {
> +			tst_res(TFAIL,
> +				"The content of mapping memory is not
> removed");

This could be replaced with memcmp. Unless you print the location of
where the bytes are non-zero.

> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "The content of mapping memory is removed");
> +}
> +
> +static void setup(void)
> +{
> +	fd = SAFE_OPEN(FNAME, O_CREAT | O_RDWR, 0777);
> +	TEST(fallocate(fd, 0, 0, MAP_SIZE));
> +	if (TST_RET) {
> +		if (TST_ERR == ENOSYS || TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate not support");
> +		else
> +			tst_brk(TBROK | TERRNO, "fallocate failed");
> +	}
> +
> +	addr = SAFE_MMAP(NULL, MAP_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED,
> +			fd, 0);
> +	memset(addr, 1, MAP_SIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(FNAME);
> +	if (addr)
> +		SAFE_MUNMAP(addr, MAP_SIZE);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.min_kver = "2.6.16",
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.all_filesystems = 1,
> +	.mount_device = 1,
> +	.mntpoint = MOUNT_POINT,
> +};
> +
> --
> 2.17.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
