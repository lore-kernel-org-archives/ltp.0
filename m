Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625DC4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 08:59:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1024C3CAEBF
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 10:59:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 445AF3C9481
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:59:16 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58F4C600769
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 10:59:15 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MnRKJ6PkXzHv1R
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:54:12 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 16:59:12 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Wed, 12 Oct 2022 16:59:12 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP][PATCH v3] syscalls/madvise04: new test for
 madvise(MADV_DONTNEED)
Thread-Index: AdjeGORd9Jj3+h+Ik0GmauvmU4WpfQ==
Date: Wed, 12 Oct 2022 08:59:12 +0000
Message-ID: <a27d548c0a8f4186bdfb55b517eb7253@huawei.com>
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> 
> Hi!
> > Test cases for madvise(2) system call, verify that MADV_DONTNEED can
> > be applied to Huge TLB pages after kernel version 5.18.
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  runtest/syscalls                              |  1 +
> >  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
> > testcases/kernel/syscalls/madvise/madvise04.c | 49
> +++++++++++++++++++
> >  3 files changed, 51 insertions(+)
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
> > index 000000000..ba15de092
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/madvise/madvise04.c
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> > + * Author: Zhao Gongyi <zhaogongyi@huawei.com>  */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Test cases for madvise(2) system call, advise value as
> "MADV_MADV_DONTNEED":
> > + *   MADV_DONTNEED can be applied to Huge TLB pages after kernel
> version 5.18.
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
> >
> 
> Should we check that the pages have been zero filled like in the previous
> case?
> 

It looks good to add the checking.

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
