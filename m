Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D0C43334
	for <ltp@archiver.kernel.org>; Sat, 18 Jun 2022 01:54:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 206673C8D3E
	for <ltp@archiver.kernel.org>; Sat, 18 Jun 2022 03:54:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 465653C72A0
 for <ltp@lists.linux.it>; Sat, 18 Jun 2022 03:54:13 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4112601D01
 for <ltp@lists.linux.it>; Sat, 18 Jun 2022 03:54:11 +0200 (CEST)
Received: from canpemm100005.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LPzTZ4vXczDqg7
 for <ltp@lists.linux.it>; Sat, 18 Jun 2022 09:53:38 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100005.china.huawei.com (7.192.105.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 18 Jun 2022 09:54:07 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Sat, 18 Jun 2022 09:54:07 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] nice05: Add testcase for nice() syscall
Thread-Index: AdiCtM/zP8qPHR3xSr+uqVjFOlUfZA==
Date: Sat, 18 Jun 2022 01:54:07 +0000
Message-ID: <7f2419764e4a4d399a894578d47820d4@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nice05: Add testcase for nice() syscall
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

Hi Petr,

Thanks for your review!

> make check complains about style, could you please fix it?
> 
> $ make check-nice05
> CHECK testcases/kernel/syscalls/nice/nice05.c
> nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:53: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:75: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:104: WARNING: braces {} are not necessary for single statement
> blocks
> nice05.c:114: WARNING: braces {} are not necessary for single statement
> blocks
> nice05.c:138: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:139: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:148: ERROR: space required before the open parenthesis '('
> nice05.c:154: ERROR: space required before the open parenthesis '('
> make: [../../../../include/mk/rules.mk:56: check-nice05] Error 1 (ignored)
>
I have fix it with "make check-nice05".

> > +#define LIMIT_TIME 3
> > +#define RUN_TIMES 1000000
> It might be useful if user could change this value with getopt switch (to
> debug on error to speedup). I also wonder if we hit timeout on some slow
> machine.
>
I have rewrite the check point with new implement.

> Maybe just:
> 	if (pthread_barrier_init(&barrier, NULL, 3) != 0)
> 		tst_brk(TBROK | TERRNO, "pthread_barrier_init() failed");
>

pthread_barrier_init do not set errno when it is failed according to "man 3"


> if (pthread_cancel(nice_high))
> 	tst_brk(TBROK | TERRNO, "pthread_cancel() failed");
It's ok now.


> > +	if (time_nice_low > time_nice_high) {
> > +		tst_res(TPASS, "time_nice_low = %lld time_nice_high = %lld",
> > +			time_nice_low, time_nice_high);
> > +	} else {
> > +		tst_brk(TFAIL | TTERRNO, "Test failed :"
> Wrong space between ':', missing after it, use:
> 		tst_brk(TFAIL | TTERRNO, "Test failed: "
Thanks, it's ok now.


I have rewrite the patch and submit it, please see: https://patchwork.ozlabs.org/project/ltp/patch/20220618014014.224668-1-zhaogongyi@huawei.com/

Best wishes,
Gongyi



> 
> Hi Zhao,
> 
> on first look LGTM, few notes below.
> 
> make check complains about style, could you please fix it?
> 
> $ make check-nice05
> CHECK testcases/kernel/syscalls/nice/nice05.c
> nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:48: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:53: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:70: ERROR: "foo* bar" should be "foo *bar"
> nice05.c:75: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:104: WARNING: braces {} are not necessary for single statement
> blocks
> nice05.c:114: WARNING: braces {} are not necessary for single statement
> blocks
> nice05.c:138: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:139: ERROR: "(foo*)" should be "(foo *)"
> nice05.c:148: ERROR: space required before the open parenthesis '('
> nice05.c:154: ERROR: space required before the open parenthesis '('
> make: [../../../../include/mk/rules.mk:56: check-nice05] Error 1 (ignored)
> 
> 
> > Add test verify that the low nice thread execute more cycles than
>                                            ^ executes
> 
> > the high nice thread since the two thread binded on the same cpu.
> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> 
> ...
> > diff --git a/testcases/kernel/syscalls/nice/nice05.c
> > b/testcases/kernel/syscalls/nice/nice05.c
> ...
> > +/*\
> > + * [Description]
> > + *
> > + * 1. Create a high nice thread and a low nice thread, the main
> > + *    thread wake them at the same time
> > + * 2. Both threads run on the same CPU
> > + * 3. Verify that the low nice thread execute more cycles than
>                                          ^ executes
> 
> > + *    the high nice thread
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <pthread.h>
> > +#include "tst_test.h"
> > +#include "tst_safe_pthread.h"
> > +
> > +#define LIMIT_TIME 3
> > +#define RUN_TIMES 1000000
> It might be useful if user could change this value with getopt switch (to
> debug on error to speedup). I also wonder if we hit timeout on some slow
> machine.
> 
> ...
> > +static void verify_nice(void)
> > +{
> > +	int ret;
> > +	int nice_inc_high = -1;
> > +	int nice_inc_low = -2;
> > +	pthread_t nice_low, nice_high;
> > +
> > +	ret = pthread_barrier_init(&barrier, NULL, 3);
> > +	if (ret != 0) {
> > +		tst_brk(TBROK, "pthread_barrier_init() returned %s",
> > +			tst_strerrno(-ret));
> > +	}
> Maybe just:
> 	if (pthread_barrier_init(&barrier, NULL, 3) != 0)
> 		tst_brk(TBROK | TERRNO, "pthread_barrier_init() failed");
> 
> Or feel free to use ret if you need it (see below), the point is with tst_brk()
> use TERRNO. Or am I missing something pthread specific?
> 
> > +	SAFE_PTHREAD_CREATE(&nice_high, NULL, nice_high_thread,
> (void*)&nice_inc_high);
> > +	SAFE_PTHREAD_CREATE(&nice_low, NULL, nice_low_thread,
> > +(void*)&nice_inc_low);
> > +
> > +	pthread_barrier_wait(&barrier);
> Not an expert on pthread, but IMHO you should compare
> PTHREAD_BARRIER_SERIAL_THREAD with the result of
> pthread_barrier_wait(), with your current code you compare with the
> result of pthread_barrier_init().
> > +	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD)
> > +		tst_brk(TBROK | TERRNO, "pthread_barrier_wait() failed");
> > +
> > +	sleep(LIMIT_TIME);
> > +
> > +	ret = pthread_cancel(nice_high);
> > +	if(ret) {
> > +		tst_brk(TBROK, "pthread_cancel() returned %s",
> > +			tst_strerrno(-ret));
> if (pthread_cancel(nice_high))
> 	tst_brk(TBROK | TERRNO, "pthread_cancel() failed");
> 
> > +	}
> > +
> > +	ret = pthread_cancel(nice_low);
> > +	if(ret) {
> > +		tst_brk(TBROK, "pthread_cancel() returned %s",
> > +			tst_strerrno(-ret));
> and here as well.
> > +	}
> > +
> > +	ret = pthread_barrier_destroy(&barrier);
> > +	if (ret) {
> > +		tst_brk(TBROK, "pthread_barrier_destroy() returned %s",
> > +			tst_strerrno(-ret));
> > +	}
> > +
> > +	SAFE_PTHREAD_JOIN(nice_high, NULL);
> > +	SAFE_PTHREAD_JOIN(nice_low, NULL);
> > +
> > +	if (time_nice_low > time_nice_high) {
> > +		tst_res(TPASS, "time_nice_low = %lld time_nice_high = %lld",
> > +			time_nice_low, time_nice_high);
> > +	} else {
> > +		tst_brk(TFAIL | TTERRNO, "Test failed :"
> Wrong space between ':', missing after it, use:
> 		tst_brk(TFAIL | TTERRNO, "Test failed: "
> 
> 
> Kind regards,
> Petr
> 
> > +			"time_nice_low = %lld time_nice_high = %lld",
> > +			time_nice_low, time_nice_high);
> > +	}
> > +}
> > +
> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.test_all = verify_nice,
> > +	.needs_root = 1,
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
