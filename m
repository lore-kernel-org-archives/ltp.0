Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B5C48BC4
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708432509; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=u8ehBTh5Xu+cwSm1BFQsulhQtLYuWTF0gG9TQZ0Wjak=;
 b=eBaZsJZwaWLygZnzF5n0lAnyu1fMdy8ARIJDD7519PeGCd1MItEp9Ym5qPNNGTy8+0AHF
 KFgt5QwDh2XssBVqo7tCxV3f/Qw2wQTaaoz7FFUtNuH7O+Hm9KqKJXdMF3g6Gp58dWnWHr0
 y0m/a4lrel3vl3cUgsP3HX8p5VZnDkQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 041A93CF1E1
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:35:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400E03C06DF
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:34:46 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39D40601BBD
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 13:34:45 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4127077ee20so2608015e9.1
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708432484; x=1709037284; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qi57lIYE6y/uEBccjClxNiW8G8c+i33Y91qa5d9YQpU=;
 b=JH6Qo5z3PAg5zQO4XFE6cEpXZEvRRamQFCF2ffB2m+x+L6KG0RL8jm+BD+UEIG43tU
 2Xv3gW/ef0BawgLhnUT4anBY86HiCKSnA3Mu0mhoNZeKdSko8B8xXwcMuxGbd2kBg/z+
 BeNrBoEJq02g15nyvqypfoawC2fHGN6gaunKcZdXn+BPpNXyIW6BGKqiUCEQ3DvrGKYH
 1Mbciw/7r92WWWurrSJpVGso5V0YYwHtt6mFbhNnty70AYGvxK//2k/FzCo0U6Wwbd1E
 RDaiP7Ji2vFb9E4FXTQd7BFK7fJkyQkBlIXr6Xr6aSKG0RZeuXA5CputuWuOkunS0KvU
 u3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708432484; x=1709037284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qi57lIYE6y/uEBccjClxNiW8G8c+i33Y91qa5d9YQpU=;
 b=ZawiDBUKAQ77m3Tis1j5mlYCNclqSbWJtRic03O76zEkklj1l8NgehsZEA78Aj72MR
 f1O/bf2/sUprJ1K8PbuFdxsPsZksnmAB/q1d1nzpuaGbi1+iUfKsYi0BIhU/fH6hyunA
 kpmlh8AkYVZEayV6PaPXXoYKe6A0YhYKxzqF5lHOYkJB8hmCpfh5m/eiXSINwwSfQhO/
 UFOVieOTFnndd2HJVraQ23yOX/GwvezHIQyTkrwGpdjg8xmnpzKHY7xZSSTlqIUFvH6/
 omtkmRSMbckkwmhIB4z2PBNKfQPC2lp9w7cIXhj6fQfD1UHj8eYbBXY35bNCzIGbtHiS
 RV7Q==
X-Gm-Message-State: AOJu0YyqqrPnDWjYXlQKqeSzbmvTr3vmeiPS9rc4wqbGkYE7KkdRWXz+
 EcNCIYt9e5nlqyg+FmcjzXAFIPum4wksTbBZA6kDMoVfbEfNmmg1M300foKAQYI=
X-Google-Smtp-Source: AGHT+IF1ar4C02vI3ge8UIv8kKqLCFJUY8MU/PHfAc+c0jhrOk07YY0EarayLXuKZ7LLJrAX7eFViQ==
X-Received: by 2002:a05:600c:4507:b0:412:6170:a178 with SMTP id
 t7-20020a05600c450700b004126170a178mr5334777wmo.29.1708432484649; 
 Tue, 20 Feb 2024 04:34:44 -0800 (PST)
Received: from [10.232.133.61] ([88.128.88.10])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a5d4a0c000000b0033b60bad2fcsm13299253wrq.113.2024.02.20.04.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:34:44 -0800 (PST)
Message-ID: <e7039690-22d5-493c-857c-6a612d7afc46@suse.com>
Date: Tue, 20 Feb 2024 13:34:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240207152155.10146-1-andrea.cervesato@suse.de>
 <20240209224114.GA371480@pevik>
In-Reply-To: <20240209224114.GA371480@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add mkdir10 test
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

This test can be actually be merged with mkdir01, so I will send an 
another patch for this use case.
Please ignore the patch.

Andrea

On 2/9/24 23:41, Petr Vorel wrote:
> Hi Andrea,
>
> I was thinking if this is filesystem specific (struct inode_operations mkdir
> member is in fs/*/*.c - all filesystems), but it looks to me that code which
> checks for EEXIST is in may_create() in fs/namei.c, which is VFS. Therefore
> there is really no point to use .all_filesystems = 1.
>
> LGTM, just few nits below.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> This test has been extracted from symlink01 and it verifies that
>> mkdir() can't overwrite certain types of files, such as simlinks,
>                                                          ^ symlinks
>
>> directories, pipes, devices, etc.
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/syscalls                           |  2 +-
>>   testcases/kernel/syscalls/mkdir/.gitignore |  1 +
>>   testcases/kernel/syscalls/mkdir/mkdir10.c  | 57 ++++++++++++++++++++++
>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>   create mode 100644 testcases/kernel/syscalls/mkdir/mkdir10.c
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 2af7ade9c..7f4edb901 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -757,8 +757,8 @@ mkdir02 mkdir02
>>   mkdir03 mkdir03
>>   mkdir04 mkdir04
>>   mkdir05 mkdir05
>> -mkdir05A symlink01 -T mkdir05
> This is not the case, but beware runtest/smoketest also use some of symlink
> tests you recently rewrite.
>
>>   mkdir09 mkdir09
>> +mkdir10 mkdir10
> ...
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/mkdir/mkdir10.c
>> @@ -0,0 +1,57 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>> + *    Author: David Fenner
>> + *    Copilot: Jon Hendrickson
> very nit:
> Authors: David Fenner, Jon Hendrickson
>
>> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that mkdir() can't overwrite certain generated files, such
>> + * as symlinks, pipes, devices, folders, etc.
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +#define FILE_FOLDER "myfolder"
>> +#define FILE_MYFILE "myfile"
>> +#define FILE_FIFO "mypipe"
>> +#define FILE_SYMLINK "mylink"
>> +#define FILE_DEVICE "/dev/null"
> nit: _PATH_DEVNULL from <paths.h> defines "/dev/null".
>> +
>> +struct tcase {
>> +	char *file;
>> +	char *msg;
>> +};
>> +
>> +static struct tcase tcases[] = {
>> +	{FILE_FOLDER,	"folder already exists"},
>> +	{FILE_MYFILE,	"file already exists"},
>> +	{FILE_FIFO,		"fifo already exists"},
>> +	{FILE_SYMLINK,	"symlink already exists"},
>> +	{FILE_DEVICE,	"device already exists"},
> very nit: "folder", "file", ...
>
> 	TST_EXP_FAIL(mkdir(tc->file, 0777), EEXIST, "%s already exists", tc->msg);
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
