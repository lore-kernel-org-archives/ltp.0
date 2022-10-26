Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA536C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 09:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D2E73CA56D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 11:20:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AF2A3C0294
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 11:19:53 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9209A10000C8
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 11:19:51 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My38P245mzpVtR
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 17:16:21 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 17:19:46 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Wed, 26 Oct 2022 17:19:46 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH v4 2/4] syscalls/madvise11: new test for
 madvise(MADV_DONTNEED)
Thread-Index: AdjpGPA6dlYZfyMVSImQw7o/cF6YFw==
Date: Wed, 26 Oct 2022 09:19:46 +0000
Message-ID: <0b6a0bfa948b46de9f958b694d68fda7@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
> > Check that madvise(2) MADV_DONTNEED applied to shared mappings
> will
> > lead to the resident set size(RSS) of the calling process reduced
> immediately.
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  runtest/syscalls                              |  1 +
> >  testcases/kernel/syscalls/madvise/.gitignore  |  1 +
> > testcases/kernel/syscalls/madvise/madvise11.c | 82
> +++++++++++++++++++
> >  3 files changed, 84 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/madvise/madvise11.c
> >
> > diff --git a/runtest/syscalls b/runtest/syscalls index
> > eb1910cec..296af9f9d 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -948,6 +948,7 @@ madvise07 madvise07
> >  madvise08 madvise08
> >  madvise09 madvise09
> >  madvise10 madvise10
> > +madvise11 madvise11
> >
> >  newuname01 newuname01
> >
> > diff --git a/testcases/kernel/syscalls/madvise/.gitignore
> > b/testcases/kernel/syscalls/madvise/.gitignore
> > index db8ce47c1..ffd8823d1 100644
> > --- a/testcases/kernel/syscalls/madvise/.gitignore
> > +++ b/testcases/kernel/syscalls/madvise/.gitignore
> > @@ -8,3 +8,4 @@
> >  /madvise08
> >  /madvise09
> >  /madvise10
> > +/madvise11
> > diff --git a/testcases/kernel/syscalls/madvise/madvise11.c
> > b/testcases/kernel/syscalls/madvise/madvise11.c
> > new file mode 100644
> > index 000000000..0132c091c
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> > @@ -0,0 +1,82 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
> > + * Author: Zhao Gongyi <zhaogongyi@huawei.com>  */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Check that madvise(2) MADV_DONTNEED applied to shared
> mappings
> > +will lead to
> > + * the resident set size(RSS) of the calling process reduced immediately.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include "tst_test.h"
> > +
> > +#define MAP_SIZE (8 * 1024)
> > +#define BUF_SIZE 1024
> > +
> > +static FILE *fp;
> > +static char *addr;
> > +
> > +static void run(void)
> > +{
> > +	char cmd[BUF_SIZE];
> > +	char line[BUF_SIZE];
> > +	char vm_area_addr[128];
> > +
> > +	TEST(madvise(addr, MAP_SIZE, MADV_DONTNEED));
> > +	if (TST_RET == -1) {
> > +		tst_brk(TBROK | TTERRNO, "madvise(%p, %d, 0x%x) failed",
> > +			addr, MAP_SIZE, MADV_DONTNEED);
> > +	}
> 
> You have a lot of madvise patches, so why not create SAFE_MADVISE?

Yes, it seems more better, thanks!


> 
> Or there are the TST_EXP_* macros.
> 
> > +
> > +	sprintf(vm_area_addr, "%p", addr);
> > +	sprintf(cmd, "cat /proc/%d/smaps", getpid());
> > +	fp = popen(cmd, "r");
> > +
> > +	/* Find the vm area */
> > +	while (fgets(line, sizeof(line), fp) != NULL) {
> > +		if (strstr(line, &(vm_area_addr[2])))
> 
> AFAICT this could match more than one line by matching the end of the
> preceding range.

Is it only one vma that inlucde the address?

> 
> I think that in general it's better to avoid strstr if memcmp can be easily
> used instead.
> 
> > +			break;
> > +	}
> > +
> > +	/* Find Rss size of the vm area */
> > +	while (fgets(line, sizeof(line), fp) != NULL) {
> > +		if (strstr(line, "Rss:")) {
> 
> Same here although Rss: seems to be unique. Then again it could be added
> to another field in new kernel.
> 
> Perhaps sscanf would be better?

Maybe it will encounter the same problem with sscanf when the field changed?

It seems there is only one way to get the RSS.

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
