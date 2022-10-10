Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB36C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 13:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 711F43CAE82
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 15:18:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D4873CAE54
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:18:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C916360081D
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 15:18:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 933211F8E8;
 Mon, 10 Oct 2022 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665407884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLCe0MS0+nK9CZhcX4+UtnRfDKBSU0f51PYyxPNWMMU=;
 b=dbjz8/5CsYAQi9ldSWBurDcodGHiJIJAw0hiWxJJw2Z/N7Bm3KknX8EwIsIs+uYX+m6No1
 YPhshCIQorCc51kcFT8Exvsl9/+Bv4RHinlTBUFnArVCoGKpntwicEM2fx8MwNvIZExC5I
 rBnT/dLHaPk6J8UelBjFEOS7pwIShKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665407884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLCe0MS0+nK9CZhcX4+UtnRfDKBSU0f51PYyxPNWMMU=;
 b=kQVNLu2XGw++jJAXaKU5D61gkOaCRsQ9rkXkvWOBoGTfg4d05OIsI5IzhYqHekAF99OAZ6
 JIEaRAH21L8Pz3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74D5513ACA;
 Mon, 10 Oct 2022 13:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6d7oG4wbRGN4egAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Oct 2022 13:18:04 +0000
Date: Mon, 10 Oct 2022 15:19:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Y0Qb9we0RmN4emPt@yuki>
References: <20221010030759.248442-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221010030759.248442-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/madvise11: new test for
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test cases for madvise(2) system call, advise value as "MADV_MADV_DONTNEED":
> 1. After a successful MADV_DONTNEED operation, it will result in
> zero-fill-on-demand pages for anonymous private mappings
> 2. MADV_DONTNEED cannot be applied to Huge TLB pages
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
>  testcases/kernel/syscalls/madvise/madvise11.c | 87 +++++++++++++++++++

At the moment we do not have madvise03.c and madvise04.c, why don't we
use them first?

>  3 files changed, 89 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 61a7b7677..a8ed9d65e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -946,6 +946,7 @@ madvise07 madvise07
>  madvise08 madvise08
>  madvise09 madvise09
>  madvise10 madvise10
> +madvise11 madvise11
> 
>  newuname01 newuname01
> 
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore b/testcases/kernel/syscalls/madvise/.gitignore
> index 002d8e5d9..6e5b92ab7 100644
> --- a/testcases/kernel/syscalls/madvise/.gitignore
> +++ b/testcases/kernel/syscalls/madvise/.gitignore
> @@ -6,3 +6,4 @@
>  /madvise08
>  /madvise09
>  /madvise10
> +/madvise11
> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> new file mode 100644
> index 000000000..358c07d3a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test cases for madvise(2) system call, advise value as "MADV_MADV_DONTNEED":
> + * 1. After a successful MADV_DONTNEED operation, it will result in
> + *    zero-fill-on-demand pages for anonymous private mappings
> + * 2. MADV_DONTNEED cannot be applied to Huge TLB pages
> + */
> +
> +#include "tst_test.h"
> +
> +#define MAP_SIZE (8 * 1024)
> +
> +static char *addr;

There is no need for this to be a global variable.

> +static void test_madvise01(void)
> +{
> +	int i;
> +
> +	addr = SAFE_MMAP(NULL, MAP_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			-1, 0);
> +	memset(addr, 1, MAP_SIZE);
> +
> +	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x) failed",
> +			addr, MAP_SIZE, MADV_DONTNEED);
> +	}
> +
> +	for (i = 0; i < MAP_SIZE; i++) {
> +		if (addr[i]) {
> +			tst_res(TFAIL,
> +				"There are no zero-fill-on-demand pages "
> +				"for anonymous private mappings");
> +			break;

I would do goto ret; here insetad and point ret just before the unmap at
the end, that way there would be no reason to add the if (i == MAP_SIZE)
before the TPASS message.

> +		}
> +	}
> +
> +	if (i == MAP_SIZE) {
> +		tst_res(TPASS,
> +			"There are zero-fill-on-demand pages "
> +			"for anonymous private mappings");
> +	}
> +
> +	SAFE_MUNMAP(addr, MAP_SIZE);
> +}
> +
> +static void test_madvise02(void)
> +{
> +	int mapsz = tst_get_hugepage_size();
> +
> +	addr = SAFE_MMAP(NULL, mapsz,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
> +
> +	TEST(madvise(addr, mapsz, MADV_DONTNEED));
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "madvise(%p, %d, 0x%x) succeed unexpectedly",
> +			addr, mapsz, MADV_DONTNEED);
> +	} else {
> +		tst_res(TPASS, "madvise test for 'MADV_DONTNEED' passed");
> +	}

Please make use of TST_EXP_FAIL()

> +	SAFE_MUNMAP(addr, mapsz);
> +}
> +
> +static void test_madvise(void)
> +{
> +	test_madvise01();
> +	test_madvise02();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_madvise,
> +	.needs_root = 1,
> +	.hugepages = {1, TST_NEEDS},

This would mean that the first case would be skipped in case where
hugepages are not supported or if the allocation failed. The best option
here would be splitting the test into two so that the functional test is
not disabled when hugepages are not supported.

> +};
> +
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
