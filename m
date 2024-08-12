Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D3DC52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 09:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723456496; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=XDAOOMOA9+u9gKZ/GNTlHgRAVyRwVndqcuYJBdv8Ixc=;
 b=eV9sB9w8n9gx8kIyZRbuKmYtkc7PQzxXACcxll1Ps5EIiUT3xXAmNge643V0z/P69PErq
 ZRrH6uddcORt31EyEyk9SuPdNu6DyRFi5Pkmgjakj12j+nqrp1ektNNs+C5c6VgzluRDe4M
 zlkKWhtvyTvs2WtOMCFoEDXIuFJMPi0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5E173D2100
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 11:54:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA813C132A
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 11:54:34 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1362100093C
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 11:54:33 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso446145466b.2
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723456473; x=1724061273; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGGr2BLRsQu66EbxCav+QxGI4o+qM0Yx8B6Pyd7j55k=;
 b=gz7uQ5GokPj27+D4Csx164+H9eeILduQCOZoL5uyuECsGG8xbUcqMPRZ7wLyffXPNU
 5qDSWYkEzUumnSbjOYAK5NMJ5ZZTEooZLamq50UYtNOktxPatQRE1681Ejvd+5Bd6etK
 nW5FPZ+JZJDJn2OaD+uLPPw7BmQuBvB2WPHsbJGCW8vvPBPhhSvPGm3byFgaZrRZvBvc
 5VQsTc1sKK/6AvnFR/+JBBGN9reFyDjZzuOQ2cMywXwA71hK5xIAJwR67m2myKG2HdNS
 o87VlcQPq6xovvR94MGvQ5oQtcnPujI23MZLxpVxCX7U/riPnAvXStrgtMj+UtVLEjp7
 PpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723456473; x=1724061273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGGr2BLRsQu66EbxCav+QxGI4o+qM0Yx8B6Pyd7j55k=;
 b=bQRh8Qtw06Mn+A1DCsAWyeLW3bVjXuZofQGI5Mkml3firZYCEV8Y/0zYv7F41WKhrH
 lwQA9Wueay+dCW1o756vUsMBNUfiBbdF8a8VDZj6ZHnVmClkcPI/q5uw1MiCExBQCGr5
 mmxjYcrR9R9N4BVShrayq7mRQWYPTOMUBhYJ6e5u3WY0YxsUOYDfCGKTBfM9NnWRDUh9
 jGqGkuXujs8v6Qev6k3WqFOgfJ3NZKzOT2ggmAjTTMoDfqQk4Uc7r4MP14gceCRx8HXY
 28GBGIeWrVzkqWkIqdX+5Uuzp9Vb+puwPsVMT2RwPZK3Ne2P7ctst+L3dJq8Ua2chkg7
 Iovg==
X-Gm-Message-State: AOJu0YxkcITcK7vl+WevZGQv0h3LtPvg+t1dvDCdSXhriaeuaMfj1UB3
 O+OGCiSPmHu2oEToif05HxCMbIevP34TlW0DYyvtVzOA3tEf9T5XtYFWfVToZaU=
X-Google-Smtp-Source: AGHT+IHmVhMgYYaDuY2dM38yKwzKweDTtcm6uvRsJ6t5FKd6CrXh3xVzeJoVW+IPvWY7FnR1nFUNJg==
X-Received: by 2002:a17:907:f160:b0:a72:8d2f:859c with SMTP id
 a640c23a62f3a-a80aa5e006dmr590497866b.33.1723456472427; 
 Mon, 12 Aug 2024 02:54:32 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.168])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80bb213798sm215257066b.182.2024.08.12.02.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 02:54:32 -0700 (PDT)
Message-ID: <12b7a3a3-2cfe-49e9-8b83-7cc8306b1040@suse.com>
Date: Mon, 12 Aug 2024 11:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
 <20240522-process_mrelease-v1-3-41fe2fa44194@suse.com> <ZpfGCTTX4BtnKf34@rei>
Content-Language: en-US
In-Reply-To: <ZpfGCTTX4BtnKf34@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add process_mrelease02 test
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

Hi Cyril,

On 7/17/24 15:24, Cyril Hrubis wrote:
> On Wed, May 22, 2024 at 04:33:07PM +0200, Andrea Cervesato wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> This test verifies that process_mrelease() syscall correctly raises
>> the errors.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/syscalls                                   |  1 +
>>   .../kernel/syscalls/process_mrelease/.gitignore    |  1 +
>>   .../syscalls/process_mrelease/process_mrelease02.c | 75 ++++++++++++++++++++++
>>   3 files changed, 77 insertions(+)
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 46a85fd31..c2fe919f0 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1051,6 +1051,7 @@ preadv203_64 preadv203_64
>>   profil01 profil01
>>   
>>   process_mrelease01 process_mrelease01
>> +process_mrelease02 process_mrelease02
>>   
>>   process_vm_readv01 process_vm01 -r
>>   process_vm_readv02 process_vm_readv02
>> diff --git a/testcases/kernel/syscalls/process_mrelease/.gitignore b/testcases/kernel/syscalls/process_mrelease/.gitignore
>> index 673983858..f1e7a8fea 100644
>> --- a/testcases/kernel/syscalls/process_mrelease/.gitignore
>> +++ b/testcases/kernel/syscalls/process_mrelease/.gitignore
>> @@ -1 +1,2 @@
>>   /process_mrelease01
>> +/process_mrelease02
>> diff --git a/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
>> new file mode 100644
>> index 000000000..ac13317ee
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/process_mrelease/process_mrelease02.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that process_mrelease() syscall is raising errors:
>> + * * EBADF when a bad file descriptor is given
>> + * * EINVAL when flags is not zero
>> + * * EINVAL when memory of a task cannot be released because it's still running
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +static int badfd = -1;
>> +static int pidfd;
>> +
>> +static struct tcase {
>> +	int needs_child;
>> +	int *fd;
>> +	int flags;
>> +	int exp_errno;
>> +	char *msg;
>> +} tcases[] = {
>> +	{0, &badfd,  0, EBADF,  "bad file descriptor"},
>> +	{1, &pidfd, -1, EINVAL, "flags is not 0"},
>> +	{1, &pidfd,  0, EINVAL,  "memory of running task cannot be released"},
> We can easily trigger ESCHR as well, just fork a child that just exits,
> get pidfd to that child and then wait the child.
>
>> +};
>> +
>> +static void run(unsigned int n)
>> +{
>> +	struct tcase *tc = &tcases[n];
>> +
>> +	if (tc->needs_child) {
>> +		pid_t pid;
>> +
>> +		pid = SAFE_FORK();
>> +		if (!pid) {
>> +			tst_res(TINFO, "Keep child alive");
>> +
>> +			TST_CHECKPOINT_WAKE_AND_WAIT(0);
>> +			exit(0);
>> +		}
>> +
>> +		TST_CHECKPOINT_WAIT(0);
>> +
>> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
>> +	}
> We can set up several types of a child processes in the test setup,
> there is no need to do this on every iteration.
After working a bit on this I can say that LTP doesn't allow it. Simply 
because tst_reap_children() is called before the end of the test, which 
means we have to end all children, even if they need to be alive. And 
the have to be alive for the next step. So the first approach is the 
right one.
>
> Similarily for the ESCHR case we can just do the same for EINVAL cases.
> For the invalid flags we would need a process that did actually exit but
> wasn't waited for. And for the second EINVAL case we would need a
> running process, so perhaps just a child that sleeps in pause().
>
>> +	TST_EXP_FAIL(tst_syscall(__NR_process_mrelease, *tc->fd, tc->flags),
>> +		tc->exp_errno,
>> +		"%s", tc->msg);
>> +
>> +	if (tc->needs_child) {
>> +		SAFE_CLOSE(pidfd);
>> +
>> +		TST_CHECKPOINT_WAKE(0);
>> +	}
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test = run,
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.min_kver = "5.15",
>> +	.needs_checkpoints = 1,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_MMU=y",
> I do not think this is necessary, LTP does not run on non-MMU targets
> anyways.
>
>> +		NULL,
>> +	},
>> +};
> Also I think that it would make sense to CC Michal Hocko on the v2 since
> he did review the kernel patches for this syscall.
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
