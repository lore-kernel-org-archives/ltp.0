Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB44C433F5
	for <ltp@archiver.kernel.org>; Fri, 15 Apr 2022 01:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653983CA60B
	for <ltp@archiver.kernel.org>; Fri, 15 Apr 2022 03:27:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A5133CA119
 for <ltp@lists.linux.it>; Fri, 15 Apr 2022 03:27:42 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0738160067B
 for <ltp@lists.linux.it>; Fri, 15 Apr 2022 03:27:39 +0200 (CEST)
Received: from canpemm500008.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KfdwK4pSLz1HBJx
 for <ltp@lists.linux.it>; Fri, 15 Apr 2022 09:26:57 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 09:27:35 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Fri, 15 Apr 2022 09:27:35 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
Thread-Index: AdhQZCvF0w198cEtQCSZC/G4mQVHUQ==
Date: Fri, 15 Apr 2022 01:27:35 +0000
Message-ID: <c9aee645b8c146aa9b87b2cb26a6dfd1@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
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

Hi Cyril,

I also wondered whether to add these two testcases into futex_waitv01.c, there is a consideration that there are alse two other testcases need to be added according to linux manual:

1. A signal was sent to the sleeping task, returning -ERESTARTSYS.
2. Some futex at the list was woken, returning the index of some waked futex.

Best wishes!

Gongyi

> Hi!
> > diff --git a/testcases/kernel/syscalls/futex/futex_waitv04.c
> > b/testcases/kernel/syscalls/futex/futex_waitv04.c
> > new file mode 100644
> > index 000000000..783d481e9
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/futex/futex_waitv04.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2022 Zhao Gongyi <zhaogongyi@huawei.com>  */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * This test verifies EAGIN and ETIMEDOUT for futex_waitv syscall.
>                          ^
>                          EAGAIN
> 
> Is there a reason why can't we add these two testcases into
> futex_waitv01.c?
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
