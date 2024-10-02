Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0360CF31B7
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727874083; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=aw1N7kailWQsfVWObLkgHX9aWBkm2miYUqrJKMty4Qo=;
 b=DurJJA8a3Mp40c5Q4Zg9C+OKBChsZEzRDOtexccF5zJpv6vgJmGioltQyxqHWpHXkpYFn
 IeGvjh7jixfUxJ7GxJdeDU9m+DDb3gzrU8l2ohWMsSVTpuy9by1w4SfCQDJql15CDzFFNkp
 z85lyEcAbZ6T0seWaKdA1k8wF3lRdtU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A9F03C5A3B
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 15:01:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 770A73C5A0F
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 15:01:02 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5C04F10089A4
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 15:01:01 +0200 (CEST)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso45365841fa.3
 for <ltp@lists.linux.it>; Wed, 02 Oct 2024 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727874060; x=1728478860; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4AWcEP90ml5cyAIsboevzXaMegeLmMcMIutz8cMd0ew=;
 b=djmaDsalCiVa/SIotL3wQBn9WLhpQ3g3K7UZB+BjuXaRQuUcfKqVEj71ZoOl1IhUGh
 VVnANKWWWNFVTjVsrYqxgz436j55k7NVW9aUTJ2oWAx4sqIXaAXOY7DzGDTFnjudobQK
 YB8SpsJvWoCmNkP0X3S+HcVMSURJ16PZiVACXeNm0ivVN591MhalU3uw8RaTEZQo8acL
 gFNm7OQQxzXKT9yI34ZFWVm8x/E7LNnSdWFqZ3lFIAtt780L8FHbZxJdiP4pgdlCqK2i
 WQM9spjSVUpMrBqdFpO2tOh2gxl+uY5esaSH4EOMj30RRUV6K6KSXC3zyZTMd5hsT1av
 HN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727874060; x=1728478860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4AWcEP90ml5cyAIsboevzXaMegeLmMcMIutz8cMd0ew=;
 b=vZJXtmMrEYHvMWidxCBfQo4Rt/+HyYX14+Pwkzy5iCllHd/ILyBqhaE+gBnOucWIpx
 r+7i2OfD9pBEXZ3BJ4HXcgoYvkYw08ERrluTgSr8fyKbj3mYUL9ohv9FK9M8hpW21o/U
 BOaQygXszxYThYa9Ty/+j8yJ7x8dMWRSrASRq+agmbp4mwzwlZz7bpRshscR8PI5wUOp
 oLY03ZKP6aRwsCPrtg/FDTkYyYEeb1FVgXxc/Hd0cEeyVHfeIQ77fz45UxPoBQd4GyWN
 hM417iIHWkVWyFV2cpgNP/G8o4li/UvM7IyxhC9pK9bHOyInDuZpMURrZLMpg9pGzg/o
 hZ+g==
X-Gm-Message-State: AOJu0YzD3BjRK3fPhB99FKQM/qFXCy93+/wObQkDNxYV7e+22xN5iAn2
 XW5AR9oCRo/KbH87rZWqY3ZfEgqSVsh5PUtEsOXSn5vqQ1AlZIV4nX+O5OmdPNI=
X-Google-Smtp-Source: AGHT+IHL7HKeKKUyXTS8/VPWPs0jFK4MNe18hLU9qSwJNCN8f02BYBvYoNhjXJT5VUbCKrXWSPsQYw==
X-Received: by 2002:a05:651c:1990:b0:2fa:d4ef:f234 with SMTP id
 38308e7fff4ca-2fae10228c8mr29067321fa.1.1727874060395; 
 Wed, 02 Oct 2024 06:01:00 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c299ac82sm862210666b.217.2024.10.02.06.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 06:01:00 -0700 (PDT)
Message-ID: <dd708dbf-09b8-4520-a57c-3dd44b044de6@suse.com>
Date: Wed, 2 Oct 2024 15:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-1-39558204ddf0@suse.com>
 <Zv08RFdIFcJ1r6cZ@yuki.lan>
Content-Language: en-US
In-Reply-To: <Zv08RFdIFcJ1r6cZ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/13] Add SAFE_STATX macro
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

On 10/2/24 14:27, Cyril Hrubis wrote:
> Hi!
>> --- a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
>> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
>> @@ -12,6 +12,8 @@
>>    * usage on symlinks will raise EOPNOTSUPP.
>>    */
>>   
>> +#define _GNU_SOURCE
>> +
>>   #include "tst_test.h"
>>   #include "tst_safe_file_at.h"
>>   #include "lapi/fcntl.h"
> This looks like it should be in a separate patch as well. At least there
> is no description why this is needed in the patch either.
>
This is clearly an error. Probably git added a wrong file.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
