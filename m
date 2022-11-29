Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D346C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 08:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854BC3CC5AC
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 09:17:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F1A53C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:17:39 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 742F9200759
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:17:38 +0100 (CET)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NLw8z4MkjzJp0k
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 16:14:11 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 16:17:33 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Tue, 29 Nov 2022 16:17:33 +0800
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/nice01: Add test nice(-1) and nice(-50)
Thread-Index: AdkDx4twpiw7lHD0QdSYspPHcUNPSg==
Date: Tue, 29 Nov 2022 08:17:33 +0000
Message-ID: <5b842e074eeb425da7f664ca3395784e@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/nice01: Add test nice(-1) and nice(-50)
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

Hi!

> Hello,
> 
> Zhao Gongyi via ltp <ltp@lists.linux.it> writes:
> 
> > 1. Add test verify that the errno is zero when callling of nice
> > legitimately return -1.(nice(-1), the default nice is usally 0) 2. Add
> > test verify that user of root can decrease the nice value of the
> > process successfully by passing a lower increment value (< min.
> > applicable limits) to nice() system call.(nice(-50))
> >
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  testcases/kernel/syscalls/nice/nice01.c | 27
> > ++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/nice/nice01.c
> > b/testcases/kernel/syscalls/nice/nice01.c
> > index 876246180..bc022a265 100644
> > --- a/testcases/kernel/syscalls/nice/nice01.c
> > +++ b/testcases/kernel/syscalls/nice/nice01.c
> > @@ -17,29 +17,31 @@
> >  #include <sys/resource.h>
> >  #include "tst_test.h"
> >
> > -#define	NICEINC		-12
> > -#define MIN_PRIO	-20
> > +#define MIN_PRIO        -20
> >
> > -static void verify_nice(void)
> > +static int nice_inc[] = {-1, -12, -50};
> > +
> > +static void verify_nice(unsigned int i)
> >  {
> >  	int new_nice;
> >  	int orig_nice;
> >  	int exp_nice;
> > +	int inc = nice_inc[i];
> >
> >  	orig_nice = SAFE_GETPRIORITY(PRIO_PROCESS, 0);
> >
> > -	TEST(nice(NICEINC));
> > +	TEST(nice(inc));
> >
> > -	exp_nice = MAX(MIN_PRIO, (orig_nice + NICEINC));
> > +	exp_nice = MAX(MIN_PRIO, (orig_nice + inc));
> >
> >  	if (TST_RET != exp_nice) {
> >  		tst_res(TFAIL | TTERRNO, "nice(%d) returned %li, expected %i",
> > -			NICEINC, TST_RET, exp_nice);
> > +				inc, TST_RET, exp_nice);
> >  		return;
> >  	}
> >
> >  	if (TST_ERR) {
> > -		tst_res(TFAIL | TTERRNO, "nice(%d) failed", NICEINC);
> > +		tst_res(TFAIL | TTERRNO, "nice(%d) failed", inc);
> >  		return;
> >  	}
> >
> > @@ -47,18 +49,19 @@ static void verify_nice(void)
> >
> >  	if (new_nice != exp_nice) {
> >  		tst_res(TFAIL, "Process priority %i, expected %i",
> > -				new_nice, orig_nice + NICEINC);
> > +				new_nice, exp_nice);
> >  		return;
> >  	}
> >
> > -	tst_res(TPASS, "nice(%d) passed", NICEINC);
> > +	tst_res(TPASS, "nice(%d) passed", inc);
> >
> > -	TEST(nice(-NICEINC));
> > +	TEST(setpriority(PRIO_PROCESS, 0, orig_nice));
> 
> This is the nice test not the setpriority test (which also has a SAFE_ variant).
> 

Thanks, I have submit a v2 patch, please see: https://patchwork.ozlabs.org/project/ltp/patch/20221129081304.47000-1-zhaogongyi@huawei.com/

Regards,
Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
