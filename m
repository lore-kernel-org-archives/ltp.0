Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C005C54E58
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710258323; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CotO/2E775IJATq4XADnSJgM/FpBtEjEXjWRnzcVBew=;
 b=RLm1hmPHz4m75mG9WvUp/3XpmrVUJKBfZeh2mkll88RBNA2pW4TDJPI/zMrzgzcCv1uVK
 r2lmMydx+pXcRQ5PwBs7TvR+qj4a6meKff/C8P0iHu+1WO8Xzwppf3/46+RABQbfcjx2+WT
 xTFBjrKRyY8GJdprSiNVDUZ5g3SiIl8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE2823CFE10
	for <ltp@archiver.kernel.org>; Tue, 12 Mar 2024 16:45:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BCD83C7FFE
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:44:53 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6185460A79C
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 16:44:52 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5687feeb1feso5116a12.2
 for <ltp@lists.linux.it>; Tue, 12 Mar 2024 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710258292; x=1710863092; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLXWxevtUaOOerNT1FosmkVMFcdwN2HkM6Nedm3h+mE=;
 b=ReN4NzPvsHXSeyOZJB9TGgH9eejOpGfouq1OeiDKbEbgpQJB4Hki+8kum/BuIRB71Y
 HrwdZRRes7QmKf3Yn6vc7FUOEou4HxWdExAr3y48K7YGayut3ahqhKBSau2ZHWhECuTR
 +CGH/3nWYAmwGKXSJ0F7Fuj7cmI0x1eBosTJjs+ftxx+Mw0weyfiu7MFP2zRV861wD/F
 EGA8RXKxabSUGbTqofZ+0rfXwSpeXO9aR+scJGX5DJ9NAN2gu2QgUFHju/VrndAyCQ9e
 AUYcdVPF0WROjjByzX1d3Gdm9dk/kB8epc1eEDyHqHyvXzBVwW36BHGVNyUU1093Py2F
 GSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258292; x=1710863092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLXWxevtUaOOerNT1FosmkVMFcdwN2HkM6Nedm3h+mE=;
 b=K45guN36qtavN7WMFYBrqJ4sCX+SwKfBkEK5q5hrqkCNlmezNQzBkrzw8NJi+3scNG
 oFjsteo2mBn5oZN5PofD6SR9ySvDBuClbbULQzJzZyEvq+DIOxbB2nHGajPK29dMUtJo
 AwZZ/7XIV+M4OwHF/MQED69Z8GIJ6FfLcJ3HbVgDR+t/zyn79PeLlo+3xFu+pc00kEb9
 3PCENSE0kBNzbkNCj00b8RGj8hbLd9U/5CxmgKw6/kq+Kyg60M0GcAThlSBjG7MHpm9n
 tDU/T4dcFFDMxbaVcEVK6ellz+EW7qMR/zByByZ17861vbbDLhCBdeaFg5YKzL04Ltfp
 Nl/g==
X-Gm-Message-State: AOJu0YwlIKGWLPzlyFYOEcSb9NtUoiKDRRVi9SQPKxxXx4DUJDrfH4iz
 sh/YHsFkTV4GtvlyJ9es5tpJquny/6itUjg5HCjeE89ZvlpzVwIUpKLn0+jaKuw=
X-Google-Smtp-Source: AGHT+IHeTI2PBA33QUtaig1UzLW/gg9i5ZEYVtVMm4SLxLbyUbJ2DdIk56LqvmjYS4V1mT89asLxWg==
X-Received: by 2002:a50:d49b:0:b0:568:7abc:a857 with SMTP id
 s27-20020a50d49b000000b005687abca857mr1279490edi.39.1710258291777; 
 Tue, 12 Mar 2024 08:44:51 -0700 (PDT)
Received: from [10.232.133.85] ([88.128.88.28])
 by smtp.gmail.com with ESMTPSA id
 gy4-20020a0564025bc400b0056820311668sm4056399edb.57.2024.03.12.08.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:44:51 -0700 (PDT)
Message-ID: <9ac3a0ea-4d4a-4588-9296-f1395601f096@suse.com>
Date: Tue, 12 Mar 2024 16:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20231017114900.17690-1-andrea.cervesato@suse.de>
 <20231218115811.GA184666@pevik>
In-Reply-To: <20231218115811.GA184666@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor fork14 using new LTP API
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

On 12/18/23 12:58, Petr Vorel wrote:
> Hi Andrea,
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> +#ifndef TST_ABI32
>> +#include <stdlib.h>
>> +#include <sys/wait.h>
>> +#include "tst_test.h"
> This will fail on 32bit arch, where TST_TEST_TCONF() is used. You need to
> include tst_test.h first.
>
> ...
>> +static void run(void)
> {
> ...
>> +	for (i = 0; i < EXTENT; i++) {
>> +		mem = mmap(NULL, 1 * TST_GB,
>> +			PROT_READ | PROT_WRITE,
>> +			MAP_PRIVATE | MAP_ANONYMOUS,
>> +			0, 0);
> We have SAFE_MMAP(), is there a reason not to use it?
I think the original idea was to wait some memory was released by the 
system, but now I see that the algorithm is just broken, since we are 
not skipping any cycle if mmap fails. So I will just use SAFE_MMAP()
>
>> -		reproduced = fork_test();
>> -		if (reproduced == 0)
>> -			tst_resm(TPASS, "fork failed as expected.");
>> -	}
>> -	cleanup();
>> -	tst_exit();
>> -}
>> +		if (mem == MAP_FAILED) {
>> +			tst_res(TINFO, "mmap() failed");
> ...
>> +			if (failures > 10) {
>> +				tst_brk(TCONF, "mmap() fails too many "
>> +					"times, so it's almost impossible to "
>> +					"get a vm_area_struct sized 16TB.");
> I would join this into single string.
This will go away if we use SAFE_MMAP()
>> +			}
>> +		}
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
>> +		if (ret == -1 && errno != ECHILD)
>> +			tst_brk(TBROK | TERRNO, "waitpid() error");
> Why not use SAFE_WAITPID(). It was even used before.
Because child might end before calling waitpid().
>
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
> ...
>> +static void setup(void)
>> +{
>> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
>> +	memset(memvec, 0, EXTENT);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	for (long i = 0; i < EXTENT; i++) {
>> +		if (memvec[i])
> If malloc() in setup() fails (rare case, I know) bad thing happen here,
> you should check for (memvec && memvec[i]) here
>> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
>>   	}
> Also here should be check if (memvec)
>> +	free(memvec);
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
