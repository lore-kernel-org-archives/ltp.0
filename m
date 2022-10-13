Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B68C43217
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 13:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3E063CAEED
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 15:55:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E310D3CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:55:12 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B661C600E4D
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:55:11 +0200 (CEST)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mp9rm3j6fz1P79s
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 21:50:32 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:55:08 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 13 Oct 2022 21:55:08 +0800
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH v3] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
Thread-Index: AdjfCvjBeLcj1J5onkCJXR9RmJ0PkQ==
Date: Thu, 13 Oct 2022 13:55:08 +0000
Message-ID: <72d704502f924162bc8998921c2044de@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/madvise04: new test for
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> Test cases for madvise(2) system call, verify that MADV_DONTNEED can be
> applied to Huge TLB pages after kernel version 5.18.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
> testcases/kernel/syscalls/madvise/madvise04.c | 49
> +++++++++++++++++++
>  3 files changed, 51 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls index c81764df4..eb1910cec
> 100644
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
> diff --git a/testcases/kernel/syscalls/madvise/.gitignore
> b/testcases/kernel/syscalls/madvise/.gitignore
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
> diff --git a/testcases/kernel/syscalls/madvise/madvise04.c
> b/testcases/kernel/syscalls/madvise/madvise04.c
> new file mode 100644
> index 000000000..ba15de092
> --- /dev/null
> +++ b/testcases/kernel/syscalls/madvise/madvise04.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> + * Author: Zhao Gongyi <zhaogongyi@huawei.com>  */
> +
> +/*\
> + * [Description]
> + *
> + * Test cases for madvise(2) system call, advise value as
> "MADV_MADV_DONTNEED":
> + *   MADV_DONTNEED can be applied to Huge TLB pages after kernel
> version 5.18.
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
> +	TST_EXP_PASS(madvise(addr, mapsz, MADV_DONTNEED)); }
> +
> +static void setup(void)
> +{
> +	mapsz = tst_get_hugepage_size();
> +	addr = SAFE_MMAP(NULL, mapsz,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1, 0);
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
> +	.needs_root = 1,
> +	.hugepages = {1, TST_NEEDS},
> +};
> +
> --
> 2.17.1

I am so sorry for resubmit this patch by mistake, please skip this patch and see the v4 of the patch.

Regards,
Gongyi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
