Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F861C52D71
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723109168; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=pVBcVoLWpdHXxz9dS8eTUtHsbrpryQ0+mdWJqw9TSB4=;
 b=Fg3mNuZPv4SLIco1j/CNlX26CCfptSkaYQaZmC7ZHe+0zWUk6mzDx7inPmWaMH2GEd5sd
 Jouc+UI7x252WgHp7QW7NOqdF/BswSThE5Dlf+Qc9Z7WB7lxpac7rxdZgQY23RBzbdNhzGs
 fKFZWDBLNYuw0YB0jxExouHgFD/2DZc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC8DE3D206E
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 11:26:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C4E3C6022
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:25:46 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61989201DB6
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:25:45 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so70902166b.0
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723109145; x=1723713945; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3D5OXjL8LuBzTY7+FuodEUHdVvA9bxOyPFYok5+sWU=;
 b=WYepuFiWbdJnOIaMGxz8vnPa/3iUOCJi7aLcAsQIVetf0JERuWNKKG3YZt1bAooMwM
 hkxantHCLx7SA5uf+0tlUm548vLMJUgRnNUs/lat0xAXMfN1dDYcW7ZMx7LA/AjULOeS
 Ibokr3Wrm8RYKIEQVwx2i7RBsp0yeV03wNuQOYwdymkORi9qoIzx+ZQHAmbn68PagmDX
 rP6Okq4XL9GYhn8HYBBfQJtSb4Tt0/p/NvYYXaw2jhHrvte9LOGwr1sB1nV8t44dmVid
 1FwKbr7buHwtfx7xgyDXda+WzYy4odOBx5SErh2IuJYQYRyvVsfr5hmMAtgiRlSqmTpE
 gHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723109145; x=1723713945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3D5OXjL8LuBzTY7+FuodEUHdVvA9bxOyPFYok5+sWU=;
 b=smZRgMGMR6psglIEEZHIqd2fWuPV5nXOVXskbAUVo83/q8dpbx49tTb/OIbs1zijWh
 4wYmcy+4ULx8GLnrROjcvg2cB4iviK3knTZXebgYbNNmxBVzhfa1FlVw+r10VAJRjldg
 RS9XEegg4kYYDAdPrXwrPNE0P2s6LWH86nQFty72hG6qgFIOhdWE7ytCUBJo87QDJQit
 tG/ycMebPwnrRQgBn6MasPp3jkjSMz1QML5uHLAbCbw8ValVn+8YtnyZMJ6yjNC6RTrH
 BJ9PsEqDmHF2okYpwQf1uECqnNHRyS0KrwqPvBHv8R7fLqUJc+H0lkSLdJhFPCxL5Ff9
 /U4Q==
X-Gm-Message-State: AOJu0Ywmc/xB6b/16uVHeIxq1L7EyNoTBbM7iyS6tIaVBqNpQ1mrTn4J
 kQJswDt86Ne7WJRsqPnZ8mAHglA+FlPYooRKY/HZisEATf6hgOJKRQPCcorJcck=
X-Google-Smtp-Source: AGHT+IHeFKoJM508uvNIcWBYXytpO5hrc2WzYbNrSU00hiQhIU8NFbjylqmrqxfqViVZOevpu1jAFg==
X-Received: by 2002:a17:907:1b13:b0:a7a:bc34:a4c8 with SMTP id
 a640c23a62f3a-a8090f35272mr87654166b.69.1723109143934; 
 Thu, 08 Aug 2024 02:25:43 -0700 (PDT)
Received: from [10.232.133.106] ([88.128.88.142])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e841a7sm725625766b.179.2024.08.08.02.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 02:25:43 -0700 (PDT)
Message-ID: <1611646b-eac8-4b21-98ed-77f95279dacb@suse.com>
Date: Thu, 8 Aug 2024 11:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Ma Xinjian <maxj.fnst@fujitsu.com>
References: <20240807113601.3882356-1-maxj.fnst@fujitsu.com>
 <20240808091657.GA313341@pevik>
Content-Language: en-US
In-Reply-To: <20240808091657.GA313341@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] getcpu: Add testcase for EFAULT
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ma,


On 8/8/24 11:16, Petr Vorel wrote:
> Hi Ma,
>
>> Add a testcase with the arguments point to an invalid address.
> Generally LGTM, I have few comments, but I'll fix them before merge.
>
>> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.de>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> @Andrea, Cyril, feel free to have final look during today (otherwise I'll merge
> later today).
>
> @Ma The test has changed 3 times quite significantly. IMHO it's better not to
> add Reviewed-by: unless you change just either simple thing or did changes you
> were explicitly asked to do. Better is to --cc all people who did the review
> when generating patches with 'git format-patch'.
Yes, please add Reviewed-by tag only when the reviewer replied with the 
tag. That actually means "patch is ok for me, so it can be submitted" 
instead of "i took a look at the patch and it needs to be modified".
>
> (It's good to add Reviewed-by: if your patchset has more commits and some of
> them were previously reviewed and they are unchanged in the following version.)
>
>> ---
> Also, not needed, but it helps, if you wrote some changes to the previous
> version after these '---' (it will not be part of the git commit message when
> other developers apply your patch with 'git am'.
>
>>   runtest/syscalls                            |  1 +
>>   testcases/kernel/syscalls/getcpu/getcpu02.c | 71 +++++++++++++++++++++
>>   2 files changed, 72 insertions(+)
>>   create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index b8728c1c5..1537b5022 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -448,6 +448,7 @@ futimesat01 futimesat01
>>   getcontext01 getcontext01
>>   getcpu01 getcpu01
>> +getcpu02 getcpu02
> You miss adding "/getcpu02" into testcases/kernel/syscalls/getcpu/.gitignore.
> I'll do that before merge.
>
>>   getcwd01 getcwd01
>>   getcwd02 getcwd02
>
>> diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
>> new file mode 100644
>> index 000000000..859cb0d3e
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
>> + * Copyright (c) Linux Test Project, 2024
>> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
>> + *
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that getcpu(2) fails with EFAULT:
>> + *
>> + * 1) cpu_id points outside the calling process's address space.
>> + * 2) node_id points outside the calling process's address space.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include "tst_test.h"
>> +#include "lapi/sched.h"
>> +
>> +static unsigned int cpu_id, node_id;
>> +
>> +static struct tcase {
>> +	unsigned int *cpu_id;
>> +	unsigned int *node_id;
>> +} tcases[] = {
>> +	{NULL, &node_id},
>> +	{&cpu_id, NULL}
> I meant to add char *desc here instead of tst_res(TINFO later in check_getcpu()
>> +};
>> +
>> +static void check_getcpu(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +	int status;
>> +	pid_t pid;
>> +
>> +	if (n == 0) {
> It might be better to check this as:
> if (!tc->cpu_id)
> (set cpu_id only if not set.
>
>> +		tst_res(TINFO, "Make cpu_id point outside the calling process's address space.");
>> +		tc->cpu_id = tst_get_bad_addr(NULL);
>> +	} else if (n == 1) {
> and here either if (!tc->node_id) or simple else.
>> +		tst_res(TINFO, "Make node_id point outside the calling process's address space.");
>> +		tc->node_id = tst_get_bad_addr(NULL);
> Also, we usually try to set values which does not change in the setup function
> (because one can run test more times, e.g. 1000x with :/getcpu02 -i1000. Thus
> things which don't have to be repeated go to the setup function.
>
> But when I tried that, even without setup function, using this pointer always
> causes SIGSEGV (test passes). And I use direct static values it does *not* cause
> SIGSEGV (test fails):
>
> static unsigned int cpu_id, node_id;
> static unsigned int *p_cpu_id = &cpu_id, *p_node_id = &node_id;
>
> static struct tcase {
> 	unsigned int **cpu_id;
> 	unsigned int **node_id;
> 	char *desc;
> } tcases[] = {
> 	{NULL, NULL, "none"},
> 	{NULL, &p_node_id, "cpu_id"},
> 	{&p_cpu_id, NULL, "node_id"},
> };
>
> static void check_getcpu(unsigned int n)
> {
> 	struct tcase *tc = &tcases[n];
> 	int status;
> 	pid_t pid;
>
> 	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
>
> 	pid = SAFE_FORK();
> 	if (!pid) {
> 		TST_EXP_FAIL(getcpu(p_cpu_id, p_node_id), EFAULT); // this would always pass
> 		TST_EXP_FAIL(getcpu(*tc->cpu_id, *tc->node_id), EFAULT); // this always fail, even for none
>
> 		exit(0);
> 	}
>
> I guess I miss something obvious. Therefore I suggest to merge (or see the diff
> below).
>
> Kind regards,
> Petr
>
> static struct tcase {
> 	unsigned int *cpu_id;
> 	unsigned int *node_id;
> 	char *desc;
> } tcases[] = {
> 	{NULL, &node_id, "cpu_id"},
> 	{&cpu_id, NULL, "node_id"},
> };
>
> static void check_getcpu(unsigned int n)
> {
> 	struct tcase *tc = &tcases[n];
> 	int status;
> 	pid_t pid;
>
> 	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
>
> 	if (!tc->cpu_id)
> 		tc->cpu_id = tst_get_bad_addr(NULL);
>
> 	if (!tc->node_id)
> 		tc->node_id = tst_get_bad_addr(NULL);
>
> 	pid = SAFE_FORK();
> 	if (!pid) {
> 		TST_EXP_FAIL(getcpu(tc->cpu_id, tc->node_id), EFAULT);
>
> 		exit(0);
> 	}
>
> 	SAFE_WAITPID(pid, &status, 0);
>
> 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> 		tst_res(TPASS, "getcpu() caused SIGSEGV");
> 		return;
> 	}
>
> 	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> 		return;
>
> 	tst_res(TFAIL, "child %s", tst_strstatus(status));
> }
>
> diff --git testcases/kernel/syscalls/getcpu/.gitignore testcases/kernel/syscalls/getcpu/.gitignore
> index 31fec5d35e..cd3022bbb1 100644
> --- testcases/kernel/syscalls/getcpu/.gitignore
> +++ testcases/kernel/syscalls/getcpu/.gitignore
> @@ -1 +1,2 @@
>   /getcpu01
> +/getcpu02
> diff --git testcases/kernel/syscalls/getcpu/getcpu02.c testcases/kernel/syscalls/getcpu/getcpu02.c
> index 859cb0d3eb..83d236a78c 100644
> --- testcases/kernel/syscalls/getcpu/getcpu02.c
> +++ testcases/kernel/syscalls/getcpu/getcpu02.c
> @@ -9,7 +9,7 @@
>   /*\
>    * [Description]
>    *
> - * Verify that getcpu(2) fails with EFAULT:
> + * Verify that getcpu(2) fails with EFAULT if:
>    *
>    * 1) cpu_id points outside the calling process's address space.
>    * 2) node_id points outside the calling process's address space.
> @@ -25,9 +25,10 @@ static unsigned int cpu_id, node_id;
>   static struct tcase {
>   	unsigned int *cpu_id;
>   	unsigned int *node_id;
> +	char *desc;
>   } tcases[] = {
> -	{NULL, &node_id},
> -	{&cpu_id, NULL}
> +	{NULL, &node_id, "cpu_id"},
> +	{&cpu_id, NULL, "node_id"},
>   };
>   
>   static void check_getcpu(unsigned int n)
> @@ -36,13 +37,13 @@ static void check_getcpu(unsigned int n)
>   	int status;
>   	pid_t pid;
>   
> -	if (n == 0) {
> -		tst_res(TINFO, "Make cpu_id point outside the calling process's address space.");
> +	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
> +
> +	if (!tc->cpu_id)
>   		tc->cpu_id = tst_get_bad_addr(NULL);
> -	} else if (n == 1) {
> -		tst_res(TINFO, "Make node_id point outside the calling process's address space.");
> +
> +	if (!tc->node_id)
>   		tc->node_id = tst_get_bad_addr(NULL);
> -	}
>   
>   	pid = SAFE_FORK();
>   	if (!pid) {
Regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
