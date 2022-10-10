Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACEFC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728F23CAE6C
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:47:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A52E3CAE28
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 14:46:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A95F32005FD
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 14:46:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AC4501F8EC;
 Mon, 10 Oct 2022 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665406013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1rXqbZIA4I21HtDHeKt57wEV42vJFFUyKQkkjY6Ge4=;
 b=zJJ4k+ZcMcRfqVd6IF+BbZByVV/3VfXdm3pcmHJJ3UmCiYH/48uf0O0ejcGjdeE6Z5hena
 uaA/BTPslhtuhR3VVHRq17TEIVYkMakuEUMsB8RyH8wrp1sS1+9npQe8oaC25WkQXia8Xm
 qF94mUjEdwVbHvc4xpHGBuMpIC9IvOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665406013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j1rXqbZIA4I21HtDHeKt57wEV42vJFFUyKQkkjY6Ge4=;
 b=FPOtzC79+m9E8gmAuI6MXYT5lfzpP9pcC+Z3IaqaVCkZl2ac19ogYZ0TaMaPGaz+CcqEu1
 eqLe+34z8oz82wBQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 06D782C141;
 Mon, 10 Oct 2022 12:46:52 +0000 (UTC)
References: <1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <42ff1e30-71c9-ee71-2333-48c8cce74f0f@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Mon, 10 Oct 2022 13:11:19 +0100
In-reply-to: <42ff1e30-71c9-ee71-2333-48c8cce74f0f@fujitsu.com>
Message-ID: <87a663als4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl10: Add basic test for
 PR_SET/GET_TSC
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

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi All
>
> Any comment?

Ah, yes, better late than never.

>
> Best Regards
> Yang Xu
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   include/lapi/prctl.h                       |   7 ++
>>   runtest/syscalls                           |   1 +
>>   testcases/kernel/syscalls/prctl/.gitignore |   1 +
>>   testcases/kernel/syscalls/prctl/prctl10.c  | 112 +++++++++++++++++++++
>>   4 files changed, 121 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c
>> 
>> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
>> index fa5922231..8d3ef5c32 100644
>> --- a/include/lapi/prctl.h
>> +++ b/include/lapi/prctl.h
>> @@ -19,6 +19,13 @@
>>   # define PR_SET_SECCOMP  22
>>   #endif
>>   
>> +#ifndef PR_SET_TSC
>> +# define PR_GET_TSC 25
>> +# define PR_SET_TSC 26
>> +# define PR_TSC_ENABLE  1
>> +# define PR_TSC_SIGSEGV 2
>> +#endif
>> +
>>   #ifndef PR_SET_TIMERSLACK
>>   # define PR_SET_TIMERSLACK 29
>>   # define PR_GET_TIMERSLACK 30
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 36fc50aeb..a0935821a 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1004,6 +1004,7 @@ prctl06 prctl06
>>   prctl07 prctl07
>>   prctl08 prctl08
>>   prctl09 prctl09
>> +prctl10 prctl10
>>   
>>   pread01 pread01
>>   pread01_64 pread01_64
>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>> index 0f2c9b194..50ee4bf60 100644
>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>> @@ -8,3 +8,4 @@
>>   /prctl07
>>   /prctl08
>>   /prctl09
>> +/prctl10
>> diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
>> new file mode 100644
>> index 000000000..1b6791679
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/prctl/prctl10.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
>> + *
>> + * Set the state of the flag determining whether the timestamp counter can
>> + * be read by the process.
>> + *
>> + * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
>> + * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when reading TSC.
>> + */
>> +
>> +#include <sys/prctl.h>
>> +#include <string.h>
>> +#include <stdio.h>
>> +#include <setjmp.h>
>> +#include "tst_test.h"
>> +#include "lapi/prctl.h"
>> +
>> +#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
>> +
>> +static int pass;
>> +static sigjmp_buf env;
>> +
>> +static const char *tsc_read_stat_names[] = {
>> +	[0] = "[not set]",
>> +	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
>> +	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
>> +};
>> +
>> +static struct tcase {
>> +	char *name;
>> +	int read_stat;
>> +} tcases[] = {
>> +	TCASE_ENTRY(PR_TSC_ENABLE),
>> +	TCASE_ENTRY(PR_TSC_SIGSEGV)
>> +};
>> +
>> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>> +{
>> +	pass = 1;
>> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, PR_TSC_ENABLE));
>> +	siglongjmp(env, 1);
>> +}
>> +
>> +static uint64_t rdtsc(void)
>> +{
>> +	uint32_t lo, hi;
>> +	/* We cannot use "=A", since this would use %rax on x86_64 */
>> +	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
>> +	return (uint64_t)hi << 32 | lo;
>> +}
>> +
>> +static void verify_prctl(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	unsigned long long time1, time2;
>> +	int tsc_val = 0;
>> +
>> +	TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
>> +	TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
>> +	if (tsc_val == tc->read_stat)
>> +		tst_res(TPASS, "current state is %s(%d)",
>> +				tc->name, tc->read_stat);
>> +	else
>> +		tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
>> +				tsc_read_stat_names[tsc_val], tsc_val, tc->name, tc->read_stat);
>> +
>> +	if (tc->read_stat == PR_TSC_SIGSEGV) {
>> +		if (sigsetjmp(env, 1) == 0)
>> +			rdtsc();

I think that because rdtsc is volatile, the load of 'pass' won't be
moved before it by the compiler. OTOH pass itself is not marked volatile and we
are relying on the compiler infering that it is volatile from the signal
handler instead of assuming it is 0.

To be on the safe side we could mark pass as volatile or use the atomic
functions. However see below.

>> +
>> +		if (pass)
>> +			tst_res(TPASS,
>> +				"get SIGSEGV signal under PR_TSC_SIGSEGV situation");
>> +		else
>> +			tst_res(TFAIL,
>> +				"don't get SIGSEGV signal under PR_TSC_SIGSEGV situation");
>> +		pass = 0;
>> +	}
>> +
>> +	time1 = rdtsc();
>> +	time2 = rdtsc();
>> +	if (time2 > time1)
>> +		tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
>> +			time1, time2);
>> +	else
>> +		tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
>> +			time1, time2);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_SIGNAL(SIGSEGV, sighandler);

So if we segfault for any other reason some wierd stuff could
happen. Wouldn't it be easier to fork a child process and check if it is
killed by SIGSEGV?

It would be easier for me to reason about at least.

>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.test = verify_prctl,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.supported_archs = (const char *const []) {
>> +		"x86",
>> +		"x86_64",
>> +		NULL
>> +	},
>> +};


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
