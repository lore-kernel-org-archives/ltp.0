Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2477C48260
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708090218; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Sq86lPTllcQ9xbhgGtzyYM61LHB/qRSTAdLyMp3wYUg=;
 b=Tdw9neTGt0EjSj3luYJgZ+A6SAJauRPeC55wmTg3lkxHsVFzIJZwIx+qd8SmUJh6uCSbG
 LfCTvfur+onqL/j4dBN0AaD5blj3bPmE7C90US6TJ/aSBWxvjgyGhc50hWYqBQzyv65jPeN
 jbYBckzFfxkyNrPUwvi6d3F9idatemM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEC0A3D0E3D
	for <ltp@archiver.kernel.org>; Fri, 16 Feb 2024 14:30:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A75523C0E51
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 14:29:57 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9834C100EEDB
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 14:29:56 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41242be3460so4707465e9.1
 for <ltp@lists.linux.it>; Fri, 16 Feb 2024 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708090196; x=1708694996; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asXYWPi3egRFvmSsCXUcYmXzdZPgGvURtLrN1JhVPeo=;
 b=bTS9BBUQ4StfyT8ctw0RBScJFqAewXGr2Sk84JwJLDJy1y36vrtLCx2ueF79JsCxFA
 gaeESe5o5zy9BIxHZCpQhAJXnV2skY2K/KuIV6+adNMbCqc3l88VHwt9Diu1KM99fyme
 RTMAVaiCz/dRLTuPjOZPXWmVL4L3qDVvTiLhTG2O4fMoEWQg6eHeormoii+dQhd0tCIK
 Bx3SwTRL1O7dw4wZ4L2aNjAawwBlyLezWKgn5UmK4VRqmQDkmaGq7K2rPQDNkBazZhVv
 zFQiQAlFqgXkTWRGFg3LyA80YqUyFZoW0kI7ZbnsZGEoQCeAeB5al7h6njV8If5dI7GA
 7lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708090196; x=1708694996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asXYWPi3egRFvmSsCXUcYmXzdZPgGvURtLrN1JhVPeo=;
 b=luQyH+F/rODg2MCnO+AaUVyJZD0ikSYW83iLJxQbO1Z1oLTW0FGmwSUy+AYoZPNIzF
 edBiV7hPOLD3nAaS6ruLg+LbiigNopkSf9xwt722lMRyEOKVOt7BwiHW7vUQcxpBDag3
 ZZzb5y6pcW0ZB1xg1HP5DfJ/0jhMRnAPq57q2VFBbWrXW9Q4L/TJ+E3PyV9xaOSrrEEE
 JBmTAmdix9lTA4TDa7PAD6MPk6WEdJeT9viNp2anfaHAGxS04JTumvGfMJMGxstYY5Rq
 GK+Dr5WKv8igsH8TLS3/7E+HJ8i3jBZCF/dPNwnxAipHK5lOuoCvYZvIcKWU0lkL76iZ
 Du1A==
X-Gm-Message-State: AOJu0YwvPpYZZzkjaGHE49NWYjLydfegTmJqsE0mFcF41ZzUWjaRIhUg
 n/KpWDp4fpoL+JFYWaAd9U/RPe3zMqPSVfx0tN4pgOAXvDZjFQJkv7stt1HzSrw=
X-Google-Smtp-Source: AGHT+IGIfNuLbipp8XljHgbBsJPhpTsY65LMHs7MmhhHMR7E7z1FILEzr2sYU+Zq9efld573Als0ig==
X-Received: by 2002:a05:600c:46c7:b0:40f:b0bf:6abf with SMTP id
 q7-20020a05600c46c700b0040fb0bf6abfmr3298845wmo.17.1708090195891; 
 Fri, 16 Feb 2024 05:29:55 -0800 (PST)
Received: from [172.20.10.3] ([37.163.10.101])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a05600c4f0500b0041253692606sm512768wmq.17.2024.02.16.05.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:29:55 -0800 (PST)
Message-ID: <687ebb37-deb9-49c9-818e-142d1996ec8c@suse.com>
Date: Fri, 16 Feb 2024 14:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240118150742.10792-1-andrea.cervesato@suse.de>
 <Zb0ViyiktMshIdOR@yuki>
In-Reply-To: <Zb0ViyiktMshIdOR@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

Hi!

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
I agree, please ignore this test. I think we can just skip it
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
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
