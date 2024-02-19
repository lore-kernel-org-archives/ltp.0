Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE7C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708353594; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=T8Qgh2KvyOJumwiI12znFIf3Y2ZqK3gXCypy48upvu4=;
 b=GGGFPjTDWBWjTnjw2JEfcy2HtjZFLWGrx1DFTzfHTKBTB2Eh9xAHDpO/nAWXl/qfMGD9T
 fJMya55K5NRK/M8fH1w+JsMgXH5uU0zaUQqxPCYGgF8gRdl7qqvm5vG+f/gdZganNtqnFaI
 E3RhOeuW2vnyMY65PJ1BwCH7WX9+ajw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A88EA3D0CF5
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 15:39:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9798E3D0476
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 15:39:30 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 876C52001B0
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 15:39:29 +0100 (CET)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so56245371fa.0
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708353569; x=1708958369; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ehU/SPmkvBSCTDgBlJUGGgWUEyl/qu83C7KS2TADu+A=;
 b=br+Cq6rt2DLHrxjYP2JSibCMiISh3o+C0ro3Bn3KkRHpOU91NjEHxR2z2BIzhgb5eT
 0ZuUBWmRxsaEqlP95u8hkK1nFf5804js4ASA6ZIMXFDUrzdpFlnVOjA3iqrENcACG6p+
 PCINNRZCabvI+KpKKRTYz4wrwxWXtSSJV3XIWHYmWADllcZaluNjQdke1WnTQL7GONA2
 FS8/qIA6oxq7nlOMWDW8yeDXzpU9RFPLEnzQV5IQ39QAbdc+WEmJbrKvFQF62tFl2p5c
 TZxxFCBd0/4v9aLgmgToMxAJoOD8BTF+ngzNs6WdTtmITBDi5ekwU/I/ywTiNh2foCLh
 sp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708353569; x=1708958369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ehU/SPmkvBSCTDgBlJUGGgWUEyl/qu83C7KS2TADu+A=;
 b=U0i2ca5kmg3jKaUUUqcq4aTv/5/Bn19UoeqLKn/cbxUs8nfXlG2/UfLiefFXtb+YY0
 3lgPD8dXjhjUpi6U5SuU3XpXZ1w+u/r1lKb8+1PJji4H4HVzB+96teoLJ10CvXcFxj/n
 N1rsTyVMI2Q5iRdaLqEVpZXzAtPwWxH9hZOAyEYGi3aH1qZVuyu9HuBlEz5L06T7jKqa
 HeV9gLItvec6iGX1eyrOu4tc8JMCeO3p+8x1gLDlkjxtClEgIBATBgYDuyKWPXUtudGC
 tmL1+yClFrsimKyWJPcNeXCgjouDEesNXpdWEhzPXwd1chUBvf4LatO0UfrEbH/3srZY
 guTg==
X-Gm-Message-State: AOJu0YziKPNKBnF/PE9Js/ttbXtjF1b/Un8b0lYQPGrqXIJSsM9BM5uG
 paBoDRMdsuP1G66DzWbZk9OuCXYz40XQ0eFYKynCpDHeC5XxwK6sQ6yxK98NhL+v1QHKmWuXvtE
 peGM=
X-Google-Smtp-Source: AGHT+IG9abMKLS8U4oPb3+kevrm0vWrZK+Lzpst3cbu3CFvRAJmxvCdfvWdWqLHzo9AoUtkhOp9mjw==
X-Received: by 2002:a2e:be8b:0:b0:2d2:2659:a6c1 with SMTP id
 a11-20020a2ebe8b000000b002d22659a6c1mr5821471ljr.33.1708353568719; 
 Mon, 19 Feb 2024 06:39:28 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.52])
 by smtp.gmail.com with ESMTPSA id
 ch17-20020a5d5d11000000b0033d2ae84fafsm7854427wrb.52.2024.02.19.06.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:39:28 -0800 (PST)
Message-ID: <ab934b6c-e1cb-4d3e-abc6-9e5219b9fef6@suse.com>
Date: Mon, 19 Feb 2024 15:39:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240118150742.10792-1-andrea.cervesato@suse.de>
 <Zb0ViyiktMshIdOR@yuki>
Content-Language: en-US
In-Reply-To: <Zb0ViyiktMshIdOR@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add readlink04 test
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

taking in consideration the comments, I think we can just forget about it.
This test doesn't add anything and we can skip this patch.

Andrea

On 2/2/24 17:17, Cyril Hrubis wrote:
> On Thu, Jan 18, 2024 at 04:07:42PM +0100, Andrea Cervesato wrote:
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>
>> This test has been extracted from symlink01 and it verifies that
>> readlink() is working correctly on symlink() generated files.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/syscalls                              |  2 +-
>>   testcases/kernel/syscalls/readlink/.gitignore |  1 +
>>   .../kernel/syscalls/readlink/readlink04.c     | 57 +++++++++++++++++++
>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>   create mode 100644 testcases/kernel/syscalls/readlink/readlink04.c
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 6e2407879..339697533 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1125,9 +1125,9 @@ readahead02 readahead02
>>   readdir01 readdir01
>>   readdir21 readdir21
>>   
>> -readlink01A symlink01 -T readlink01
>>   readlink01 readlink01
>>   readlink03 readlink03
>> +readlink04 readlink04
>>   
>>   #readlinkat test cases
>>   readlinkat01 readlinkat01
>> diff --git a/testcases/kernel/syscalls/readlink/.gitignore b/testcases/kernel/syscalls/readlink/.gitignore
>> index 307817f4d..53e65eb5b 100644
>> --- a/testcases/kernel/syscalls/readlink/.gitignore
>> +++ b/testcases/kernel/syscalls/readlink/.gitignore
>> @@ -1,2 +1,3 @@
>>   /readlink01
>>   /readlink03
>> +/readlink04
>> diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
>> new file mode 100644
>> index 000000000..8d7d038bb
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/readlink/readlink04.c
>> @@ -0,0 +1,57 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *    Author: David Fenner
>> + *    Copilot: Jon Hendrickson
>> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that readlink() is working correctly on symlink()
>> + * generated files.
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +static void test_readlink(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +
>> +	SAFE_SYMLINK(tst_get_tmpdir(), symname);
>> +
>> +	char path[PATH_MAX];
>> +	struct stat path_link;
>> +
>> +	SAFE_READLINK(symname, path, PATH_MAX);
>> +	TST_EXP_PASS(lstat(path, &path_link));
>> +
>> +	SAFE_UNLINK(symname);
>> +}
> Isn't this already tested in readlink01?
>
> And actually the readlink01 is doing this better by comparing the string
> returned from readlink() against the one we passed to the sysmlink()
> syscall previously. The lastat() check is indirectly asserting that we
> got right value as well, however simple memcmp() is better.
>
>> +static void test_readlink_no_path(void)
>> +{
>> +	char *symname = "my_symlink1";
>> +
>> +	SAFE_SYMLINK("bc+eFhi!k", symname);
>> +
>> +	char path[PATH_MAX];
>> +	struct stat path_link;
>> +
>> +	SAFE_READLINK(symname, path, PATH_MAX);
>> +	TST_EXP_FAIL(lstat(path, &path_link), ENOENT);
>> +
>> +	SAFE_UNLINK(symname);
>> +}
> Maybe it would be easier to add this to symlink01 as well?
>
> In reality it probably does not make much difference if we readlink a
> symlink to an existing or non-existing file though...
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
