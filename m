Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B54C47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711097990; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=utD0qQ3kn/MGqZRB5FluCbd/K9QbabJJw3oVHtoKwDM=;
 b=Gj2RWxCTf70bTMMWgZUQCR8s30spx4wey/GyzuX67K7MdSRIR3yCp5mGrILzOUXzOlfbg
 XJvK+x9A+2HPcyMXongPHY5a6BKBm/y+suos0Un+EFWRnIKN01U8y+h/SoCjwGUsIJ/NcM/
 cGYB98jyZ/+vUS15SVmQL9t+/5BNvKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 821D43CD60E
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 09:59:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 926943C998A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 09:59:25 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E909E60B042
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 09:59:23 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-56bc581de56so928885a12.2
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711097963; x=1711702763; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/loFzWywWrZRWd+6HAGNSGSGODwfRRAcoNBoahKstRU=;
 b=eLLtF1iqW4hZz8pr6ySp+WsdBWY5QOQEK2hHCtgocbXCP8LdynELlA7cKDj7a0tu6H
 QEGDX5k3NL0f8VpOBG2keJcxbmldY9Kx19T2SjmHfkzw9ronGqGsC0sHUjbRWXz14XHo
 PfFL9YKqC+1SR3RsDc2WS/pgDRDyz2mgp2NTfKBM+t7qqEnHEkRtM2JSbHDbQnIeJxsv
 2uVkTobpcPAdMuvinH+hFWskYRdkb2CyLw9IN0rrMFPvtstyo0W9enAD0D/nt4fX8wuw
 qxPd1mUyznGrHjeYEzwf3lK+z1KNZ7ZRtNlk0yFeY1SKiCGvbLPwWIA/CIJVM+ZFhW9q
 UfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097963; x=1711702763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/loFzWywWrZRWd+6HAGNSGSGODwfRRAcoNBoahKstRU=;
 b=gdWKIXj+HcD68NFG65WhbtQZQxKk+mthOeq3qMwt8Qr7+yre32QViGkpbPpHW1MWZQ
 XFgj6J/n0cd0To+8cbs+6SCeR2IopQl6oWQgHz7K+XV8R4MRwOfygNVcdKcLuvgvf+Cf
 a2RHbYx/nX5rNYh2VPwI5xKU8DqBJukkLZzJmDpQIKD8kWRxD4KA20aeYR8iuN/3w9ov
 jS/V5f7EdvelrEnSh5Yo5tu+3KHQt1ZeQf9PAVLRVfUGF8hjmzuXCn2coJSU6OlHTK2M
 z5CZY6uPvTl6bV99IqQPyBFA2L1jh/dGrh+SF1lttezjPYg1x0o2ksRRrFab2DTgzQF5
 QBOA==
X-Gm-Message-State: AOJu0YxtyDAW/A6vnY3nMbnZwEHjSPXNyYdS/mEQUCee9UW8cQ7bgdS7
 2/QepUEqgNwwtydluWRTfnhxvdzJB7k3fdeEWWUhLG7FAJICqrXEQuMdjB5V2Oo=
X-Google-Smtp-Source: AGHT+IHgowby+wcYeP8D7XXvSzldgw956sTyEVmLJoFhaDLxsML9b1Hy5EI4hE7V5CkdlopRpthXNg==
X-Received: by 2002:a50:d701:0:b0:566:be15:9a88 with SMTP id
 t1-20020a50d701000000b00566be159a88mr1371146edi.20.1711097963262; 
 Fri, 22 Mar 2024 01:59:23 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.144])
 by smtp.gmail.com with ESMTPSA id
 dh2-20020a0564021d2200b005682a0e915fsm790487edb.76.2024.03.22.01.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 01:59:22 -0700 (PDT)
Message-ID: <fa3e5a8a-eb2b-462f-a58e-a56284725e17@suse.com>
Date: Fri, 22 Mar 2024 09:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240313124542.13636-1-andrea.cervesato@suse.de>
 <20240322064221.GA594557@pevik>
In-Reply-To: <20240322064221.GA594557@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor fork14 using new LTP API
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

Hi,

On 3/22/24 07:42, Petr Vorel wrote:
> Hi Andrea,
>
> generally LGTM.
> With using .skip_in_compat and SPDX GPL-2.0-only:
Totally forgot the license..
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Minor notes below.
>
>> ---
>> Reverted SAFE_MMAP to mmap
>> Added kernel tags
> +1
>
>>   testcases/kernel/syscalls/fork/fork14.c | 208 +++++++++++-------------
> ...
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>>    * Copyright (C) 2014  Red Hat, Inc.
>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * This program is free software; you can redistribute it and/or
>> - * modify it under the terms of version 2 of the GNU General Public
>> - * License as published by the Free Software Foundation.
> This is GPL-2.0-only.
>> - *
>> - * This program is distributed in the hope that it would be useful,
>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> - *
>> - * Further, this software is distributed without any warranty that it
>> - * is free of the rightful claim of any third person regarding
>> - * infringement or the like.  Any license provided herein, whether
>> - * implied or otherwise, applies only to this software file.  Patent
>> - * licenses, if any, provided herein do not apply to combinations of
>> - * this program with other software, or any other product whatsoever.
>> - *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> - * 02110-1301, USA.
>> - *
>> - * This test is a reporducer for this patch:
>> - *              https://lkml.org/lkml/2012/4/24/328
>> + * This test is a reporducer for this patch: https://lkml.org/lkml/2012/4/24/328
> very nit: I would trust lore more, thus I would use
>
> https://lore.kernel.org/lkml/1335289853-2923-1-git-send-email-siddhesh.poyarekar@gmail.com/
>
>>    * Since vma length in dup_mmap is calculated and stored in a unsigned
>>    * int, it will overflow when length of mmaped memory > 16 TB. When
>> - * overflow occur, fork will  incorrectly succeed. The patch above
>> - * fixed it.
>> - ********************************************************************/
>> + * overflow occur, fork will incorrectly succeed. The patch above fixed it.
> s/occur/occurs/
>
>> + */
>> -#include <sys/mman.h>
>> -#include <sys/wait.h>
>> -#include <stdio.h>
>> -#include <unistd.h>
>> -#include "test.h"
>> -#include "safe_macros.h"
>> -#include "lapi/abisize.h"
>> +#include "tst_test.h"
>> -char *TCID = "fork14";
>> -int TST_TOTAL = 1;
>> +#ifndef TST_ABI32
> We can use .skip_in_compat = 1, flag instead.
>
>> -#define GB		(1024 * 1024 * 1024L)
>> +#include <stdlib.h>
>> +#include <sys/wait.h>
>> -/* set mmap threshold to 16TB */
>>   #define LARGE		(16 * 1024)
>>   #define EXTENT		(16 * 1024 + 10)
>> -static char **pointer_vec;
>> +static char **memvec;
>> -static void setup(void);
>> -static void cleanup(void);
>> -static int  fork_test(void);
>> -
>> -int main(int ac, char **av)
>> +static void run(void)
>>   {
>> -	int lc, reproduced;
>> +	int i, j, ret;
>> +	pid_t pid;
>> +	void *mem;
>> +	int prev_failed = 0;
>> +	int passed = 1;
>> +	int failures = 0;
>> +	for (i = 0; i < EXTENT; i++) {
> I wonder if the code would not be slightly more readable if the content of the
> loop was in the separate function. Probably not, feel free to ignore.
>
>> +		mem = mmap(NULL, 1 * TST_GB,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_PRIVATE | MAP_ANONYMOUS,
>> +			0, 0);
> ...
>> +		if (mem == MAP_FAILED) {
>> +			failures++;
> ...
>> +			if (failures > 10) {
>> +				tst_brk(TCONF, "mmap() fails too many "
>> +					"times, so it's almost impossible to "
>> +					"get a vm_area_struct sized 16TB.");
>> +			}
>> -static void cleanup(void)
>> -{
>> -	free(pointer_vec);
>> -}
>> +			continue;
>> +		}
>
>> -		switch (tst_fork()) {
>> -		case -1:
>> -			prev_failed = 1;
>> -		break;
>> -		case 0:
>> +		if (!pid)
>>   			exit(0);
>> -		default:
>> -			SAFE_WAITPID(cleanup, -1, NULL, 0);
>> -			if (prev_failed > 0 && i >= LARGE) {
>> -				tst_resm(TFAIL, "Fork succeeds incorrectly");
>> -				reproduced = 1;
>> -				goto clear_memory_map;
>> -			}
>> +		ret = waitpid(pid, NULL, 0);
> Why not SAFE_WAITPID() as it was originally?
Was discussed with Cyril in the previous review. It's because we don't 
want it to fail only once.
>
>> +		if (ret == -1 && errno != ECHILD)
>> +			tst_brk(TBROK | TERRNO, "waitpid() error");
>> +
>> +		if (prev_failed && i >= LARGE) {
>> +			passed = 0;
>> +			break;
>>   		}
>> +
>> +		prev_failed = 0;
>> +
>> +		tst_res(TINFO, "fork() passed at %d attempt", i);
>> +	}
>> +
>> +	for (j = 0; j < i; j++) {
>> +		if (memvec[j])
>> +			SAFE_MUNMAP(memvec[j], 1 * TST_GB);
>>   	}
>> -clear_memory_map:
>> -	for (j = 0; j < cnt; j++) {
>> -		if (pointer_vec[j])
>> -			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
>> +	if (passed)
>> +		tst_res(TPASS, "fork() failed as expected");
>> +	else
>> +		tst_res(TFAIL, "fork() succeeded incorrectly");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
>> +	memset(memvec, 0, EXTENT);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	for (long i = 0; i < EXTENT; i++) {
>> +		if (memvec && memvec[i])
>> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
>>   	}
>> -	return reproduced;
>> +	if (memvec)
>> +		free(memvec);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.forks_child = 1,
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "7edc8b0ac16cbaed7cb4ea4c6b95ce98d2997e84"},
> nit: we usually use shorter hash 7edc8b0ac16c (as used in Fixes: in git
> commits).
>
>> +		{}
>> +	}
>> +};
>> +
>> +#else /* TST_ABI32 */
>> +	TST_TEST_TCONF("Test doesn't supports 32bits architecture");
> s/supports/support/
>
> But we can use .skip_in_compat = 1, flag instead.
>
> Kind regards,
> Petr
>
>> +#endif

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
