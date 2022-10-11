Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A8FC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 08:49:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ECC03C7319
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 10:49:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9C4B3C3030
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:49:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63657100094C
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 10:49:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4DFBD1F953;
 Tue, 11 Oct 2022 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665478175;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0e0DYRaymnyxEGqzOB56U4iJa3cGKWNeP8fUceD3fg=;
 b=zQ4SXokwTlfMCWGT/FRw5RzO1oKhGBUQDiLjiedNVg5TcJqA3HLg9LeGXA4U2yMlDqESHe
 qsSew32PYJ0bbvUcvQn4D3IyL6IEO/lh3iDs93UNYxYRtb4yEt7i0sWFi0c9OF/xEX39zd
 ytm+ohoxqjuK8siNY8msVkE+EqB3ZoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665478175;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0e0DYRaymnyxEGqzOB56U4iJa3cGKWNeP8fUceD3fg=;
 b=6u4WtkPY8ZcyvE3clPVO9fb0mCHmDM22XY1bY3F9P4EcYS5p6Sna6vlcgB1IBZxN+OSyJJ
 7N6YqKk0X+jaV4Dg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C8E1B2C141;
 Tue, 11 Oct 2022 08:49:34 +0000 (UTC)
References: <87a663als4.fsf@suse.de>
 <1665469442-2051-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87wn9692zk.fsf@suse.de>
 <e797b6d1-c42e-46df-df5f-d1e96470ed1b@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Date: Tue, 11 Oct 2022 09:48:57 +0100
In-reply-to: <e797b6d1-c42e-46df-df5f-d1e96470ed1b@fujitsu.com>
Message-ID: <87o7ui923l.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/prctl10: Add basic test for
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com> writes:

> Hi Richard
>
>
>> Hello,
>> 
>> Yang Xu <xuyang2018.jy@fujitsu.com> writes:
>> 
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   include/lapi/prctl.h                       |   7 ++
>>>   runtest/syscalls                           |   1 +
>>>   testcases/kernel/syscalls/prctl/.gitignore |   1 +
>>>   testcases/kernel/syscalls/prctl/prctl10.c  | 108 +++++++++++++++++++++
>>>   4 files changed, 117 insertions(+)
>>>   create mode 100644 testcases/kernel/syscalls/prctl/prctl10.c
>>>
>>> diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
>>> index fa5922231..8d3ef5c32 100644
>>> --- a/include/lapi/prctl.h
>>> +++ b/include/lapi/prctl.h
>>> @@ -19,6 +19,13 @@
>>>   # define PR_SET_SECCOMP  22
>>>   #endif
>>>   
>>> +#ifndef PR_SET_TSC
>>> +# define PR_GET_TSC 25
>>> +# define PR_SET_TSC 26
>>> +# define PR_TSC_ENABLE  1
>>> +# define PR_TSC_SIGSEGV 2
>>> +#endif
>>> +
>>>   #ifndef PR_SET_TIMERSLACK
>>>   # define PR_SET_TIMERSLACK 29
>>>   # define PR_GET_TIMERSLACK 30
>>> diff --git a/runtest/syscalls b/runtest/syscalls
>>> index 61a7b7677..51de0a614 100644
>>> --- a/runtest/syscalls
>>> +++ b/runtest/syscalls
>>> @@ -1004,6 +1004,7 @@ prctl06 prctl06
>>>   prctl07 prctl07
>>>   prctl08 prctl08
>>>   prctl09 prctl09
>>> +prctl10 prctl10
>>>   
>>>   pread01 pread01
>>>   pread01_64 pread01_64
>>> diff --git a/testcases/kernel/syscalls/prctl/.gitignore b/testcases/kernel/syscalls/prctl/.gitignore
>>> index 0f2c9b194..50ee4bf60 100644
>>> --- a/testcases/kernel/syscalls/prctl/.gitignore
>>> +++ b/testcases/kernel/syscalls/prctl/.gitignore
>>> @@ -8,3 +8,4 @@
>>>   /prctl07
>>>   /prctl08
>>>   /prctl09
>>> +/prctl10
>>> diff --git a/testcases/kernel/syscalls/prctl/prctl10.c b/testcases/kernel/syscalls/prctl/prctl10.c
>>> new file mode 100644
>>> index 000000000..01307ecd7
>>> --- /dev/null
>>> +++ b/testcases/kernel/syscalls/prctl/prctl10.c
>>> @@ -0,0 +1,108 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>>> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> + */
>>> +
>>> +/*\
>>> + * [Description]
>>> + *
>>> + * Basic test to test behaviour of PR_GET_TSC and PR_SET_TSC.
>>> + *
>>> + * Set the state of the flag determining whether the timestamp counter can
>>> + * be read by the process.
>>> + *
>>> + * - Pass PR_TSC_ENABLE to arg2 to allow it to be read.
>>> + * - Pass PR_TSC_SIGSEGV to arg2 to generate a SIGSEGV when read.
>>> + */
>>> +
>>> +#include <sys/prctl.h>
>>> +#include <string.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include "tst_test.h"
>>> +#include "lapi/prctl.h"
>>> +
>>> +#define TCASE_ENTRY(tsc_read_stat) { .name = #tsc_read_stat, .read_stat = tsc_read_stat}
>>> +
>>> +static const char * const tsc_read_stat_names[] = {
>>> +	[0] = "[not set]",
>>> +	[PR_TSC_ENABLE] = "PR_TSC_ENABLE",
>>> +	[PR_TSC_SIGSEGV] = "PR_TSC_SIGSEGV",
>>> +};
>>> +
>>> +static struct tcase {
>>> +	char *name;
>>> +	int read_stat;
>>> +} tcases[] = {
>>> +	TCASE_ENTRY(PR_TSC_ENABLE),
>>> +	TCASE_ENTRY(PR_TSC_SIGSEGV)
>>> +};
>>> +
>>> +static uint64_t rdtsc(void)
>>> +{
>>> +	uint32_t lo, hi;
>>> +	/* We cannot use "=A", since this would use %rax on x86_64 */
>>> +	__asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
>>> +	return (uint64_t)hi << 32 | lo;
>>> +}
>>> +
>>> +
>>> +static int expected_status(int status, int exp_status)
>>> +{
>>> +	if (!exp_status && WIFEXITED(status))
>>> +		return 0;
>>> +
>>> +	if (exp_status && WIFSIGNALED(status) && WTERMSIG(status) == exp_status)
>>> +		return 0;
>>> +
>>> +	return 1;
>>> +}
>>> +
>>> +static void verify_prctl(unsigned int n)
>>> +{
>>> +	struct tcase *tc = &tcases[n];
>>> +	unsigned long long time1, time2;
>>> +	int tsc_val = 0, pid, status;
>>> +
>>> +	pid = SAFE_FORK();
>>> +	if (!pid) {
>>> +		TST_EXP_PASS_SILENT(prctl(PR_SET_TSC, tc->read_stat));
>>> +		TST_EXP_PASS_SILENT(prctl(PR_GET_TSC, &tsc_val));
>>> +		if (tsc_val == tc->read_stat)
>>> +			tst_res(TPASS, "current state is %s(%d)",
>>> +					tc->name, tc->read_stat);
>>> +		else
>>> +			tst_res(TFAIL, "current state is %s(%d), expect %s(%d)",
>>> +					tsc_read_stat_names[tsc_val],
>>> +					tsc_val, tc->name, tc->read_stat);
>>> +
>>> +		time1 = rdtsc();
>>> +		time2 = rdtsc();
>>> +		if (time2 > time1)
>>> +			tst_res(TPASS, "rdtsc works correctly, %lld ->%lld",
>>> +				time1, time2);
>>> +		else
>>> +			tst_res(TFAIL, "rdtsc works incorrectly, %lld ->%lld",
>>> +				time1, time2);
>>> +		exit(0);
>>> +	}
>>> +	SAFE_WAITPID(pid, &status, 0);
>>> +
>>> +	if (expected_status(status, tc->read_stat == PR_TSC_SIGSEGV ? SIGSEGV : 0))
>>> +		tst_res(TFAIL, "Test %s failed", tc->name);
>>> +	else
>>> +		tst_res(TPASS, "Test %s succeeded", tc->name);
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.needs_root = 1,
>> 
>> Why did you add this?
>
> Oh, yes, I should drop this.
>
> So, should I send a v3 or you or other maintainers merge it by
> deleting it?

I'll do the fixup and merge, thanks!

>
> Best Regards
> Yang Xu
>> 
>> It doesn't require root, but it could be denied with seccomp or an
>> LSM. In some cases having root won't help (e.g. in a container). If
>> you want to handle scenarios like these, then it would be better to
>> check the return status of prctl.
>> 
>>> +	.forks_child = 1,
>>> +	.test = verify_prctl,
>>> +	.tcnt = ARRAY_SIZE(tcases),
>>> +	.supported_archs = (const char *const []) {
>>> +		"x86",
>>> +		"x86_64",
>>> +		NULL
>>> +	},
>>> +};
>> 
>> Otherwise LGTM.
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
