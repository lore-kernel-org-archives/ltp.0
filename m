Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7346CFA373E
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:30:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FADA3C95F4
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:30:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF28A3C0727
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:29:49 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19B501A00215
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 11:29:46 +0200 (CEST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MwqRF41bszVj0K
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 17:24:57 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 17:29:41 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Mon, 24 Oct 2022 17:29:41 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v4 1/4] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
Thread-Index: AdjnifRFpmmPpHyTQcGSN5UckkMwQg==
Date: Mon, 24 Oct 2022 09:29:41 +0000
Message-ID: <1a91d01c73444fdc94af4b04c12739ee@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> Hello,
> 
> Zhao Gongyi via ltp <ltp@lists.linux.it> writes:
> 
> > Check that madvise(2) MADV_DONTNEED operation applied to Huge TLB
> > pages successfully after kernel version 5.18, and will result in
> > zero-fill-on-demand pages for anonymous private mappings.
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  runtest/syscalls                              |  1 +
> >  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
> > testcases/kernel/syscalls/madvise/madvise04.c | 62
> +++++++++++++++++++
> >  3 files changed, 64 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/madvise/madvise04.c
> >
> > diff --git a/runtest/syscalls b/runtest/syscalls index
> > c81764df4..eb1910cec 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -941,6 +941,7 @@ mincore04 mincore04
> >  madvise01 madvise01
> >  madvise02 madvise02
> >  madvise03 madvise03
> > +madvise04 madvise04
> >  madvise05 madvise05
> >  madvise06 madvise06
> >  madvise07 madvise07
> > diff --git a/testcases/kernel/syscalls/madvise/.gitignore
> > b/testcases/kernel/syscalls/madvise/.gitignore
> > index f4bfdfefe..db8ce47c1 100644
> > --- a/testcases/kernel/syscalls/madvise/.gitignore
> > +++ b/testcases/kernel/syscalls/madvise/.gitignore
> > @@ -1,6 +1,7 @@
> >  /madvise01
> >  /madvise02
> >  /madvise03
> > +/madvise04
> >  /madvise05
> >  /madvise06
> >  /madvise07
> > diff --git a/testcases/kernel/syscalls/madvise/madvise04.c
> > b/testcases/kernel/syscalls/madvise/madvise04.c
> > new file mode 100644
> > index 000000000..a970fb33e
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/madvise/madvise04.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> > + * Author: Zhao Gongyi <zhaogongyi@huawei.com>  */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Check that madvise(2) MADV_DONTNEED operation applied to Huge
> TLB
> > +pages
> > + * successfully after kernel version 5.18, and will result in
> > + * zero-fill-on-demand pages for anonymous private mappings.
> > + */
> > +
> > +#include "tst_test.h"
> > +
> > +#define MAP_SIZE (8 * 1024)
> > +
> > +static char *addr;
> > +static int mapsz;
> > +
> > +static void run(void)
> > +{
> > +	TST_EXP_PASS(madvise(addr, mapsz, MADV_DONTNEED));
> > +	for (int i = 0; i < mapsz; i++) {
> > +		if (addr[i]) {
> > +			tst_res(TFAIL,
> > +				"There are no zero-fill-on-demand pages "
> > +				"for anonymous private mappings");
> > +			return;
> > +		}
> > +	}
> > +
> > +	tst_res(TPASS, "There are zero-fill-on-demand pages "
> > +		       "for anonymous private mappings"); }
> > +
> > +static void setup(void)
> > +{
> > +	mapsz = tst_get_hugepage_size();
> > +	addr = SAFE_MMAP(NULL, mapsz,
> > +			PROT_READ | PROT_WRITE,
> > +			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
> > +			-1, 0);
> > +	memset(addr, 1, mapsz);
> 
> If we only do memset here then we are only testing the zero-fill feature on
> the first iteration.

Yes, thanks. It need to move to run().

> 
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (addr)
> > +		SAFE_MUNMAP(addr, mapsz);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.min_kver = "5.18",
> 
> What happens before 5.18? Could we try applying MADV_DONTNEED and
> return TCONF instead?

MADV_DONTNEED is not supported before 5.18. 
Try applying MADV_DONTNEED and return TCONF seems more better, thanks.

> 
> > +	.needs_root = 1,
> 
> Why does this need root?

When we get or set hugepages, we need to read or write '/proc/sys/vm/nr_hugepages', so we need to set needs_root here.

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
