Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B1CC25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715783168; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=8r2Jc7mIWE2nLXu7VIfNhtMuJZBtMpbVAIRD/jyIhMM=;
 b=H0TI3XXn3EgtYedxJ5fos/R3E4bk5UTbxlG7lRRJlcJAB0adT/297ReiqdajQmazVBEc0
 v30kB9dZ/A7yUmHFV3g5RYL9T1U0bMUqf75X8yg/GWwwVGVbGzNJ0NnnmMvIvWVizsAhxgO
 GDvM+B0Av4WR76c7ySvXmG8JRlnPzkc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 067073CF782
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 16:26:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 002563CE29E
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:25:42 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9059E14060C7
 for <ltp@lists.linux.it>; Wed, 15 May 2024 16:25:41 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso234721366b.0
 for <ltp@lists.linux.it>; Wed, 15 May 2024 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715783141; x=1716387941; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0mlTFS3fp3dC6CS8g1c7SV3DR5VMmbdjy/7Gk49gK8=;
 b=f3yAfLPjosfd6/KYppMyEPsEd87tuNVXVr2GnZTls6SOODBn+94EjLamVeUxZsnbVp
 OHrQKWXP53brdlfEw2oMgs65aofEGbw1Lg3tGGh67E48UpuF1+++U2NozUjwS69aZgBJ
 7Z5IpkXd6nB1End5F4IaxcFGG00B1gyeolflYpSiCZ/PdbjRBQVIoKmo0Vd4DCfXE4y6
 7C5++CoZ/LoB43QrsgF6+eqsHyX+XKpTN6g+evBpdx3IJX01KEVA21w1nAU18dVPA6+Z
 x53RIXyQ88+3UI/ZgWsXOO3bhMDlVwXsN8G+dhH2VVi9Iq+r67zzjeQs6JzO34bKWnne
 fKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715783141; x=1716387941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0mlTFS3fp3dC6CS8g1c7SV3DR5VMmbdjy/7Gk49gK8=;
 b=NAaGGzpWzqJmKuXMHFwdLxY2pH63nsQdwPL+ASZIoJm9N9wu5ctznDToykh05ZaAY+
 wBaRzAKk2MLCkT0QWNAosGtHqm60x4ivqIATBMxLItXPezAnHGHwzUxe1M1UjU6P4N//
 0VEZr+lQjRYW885w7fUzOFezKrCj97tphxJApK28pDTfU2o8jb2sm5m+Pe+Kx5oi5v1S
 LfmwTUVL5ZUS53JGdHyzyEIu0cHABkdVKLHRW+1yYmvxb2PUsNSgo6VoDFrbXN6ko6LI
 7CpOM0VyDXk4v1V2+vc/IuX4rEG/bIycxkZQZ6yjHVwJkjj/ivZAMoTGhRcMaoAArLlD
 urvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNOqV298VtS1+62xGpakPIptmDnRgTrkgaZH7J4GbmS9SjCuV9q5eL0SsGbhcPZ5DEYdUCd6NCPIJNC6XXLJKEais=
X-Gm-Message-State: AOJu0Yyv+ysgxcaS/b8zzy8vwAE4pg72fKm16S+tmqX7T3cnE3QAEIN+
 1QWvWTX/SVpZzavIsmovEazfsdYEkOyjA3wSGdKdCw98o8yKXxBlc7YUhknkF8c=
X-Google-Smtp-Source: AGHT+IFGxIiwMqJ5tiSftbJLpEUel+WrAe00jJrp5TOK3Ix96f2enGQBpcPrxddFjTADrtY5t3XjcA==
X-Received: by 2002:a17:907:25c5:b0:a5a:3e00:6317 with SMTP id
 a640c23a62f3a-a5a3e00636bmr1415993566b.31.1715783140804; 
 Wed, 15 May 2024 07:25:40 -0700 (PDT)
Received: from [10.232.133.118] ([88.128.88.179])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c699sm860445866b.53.2024.05.15.07.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 07:25:40 -0700 (PDT)
Message-ID: <b31e60df-cf1b-4d49-bc7c-836582ede3ae@suse.com>
Date: Wed, 15 May 2024 16:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>, 
 ltp@lists.linux.it
References: <20240515142234.GA227672@pevik>
Content-Language: en-US
In-Reply-To: <20240515142234.GA227672@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork14 using new LTP API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 5/15/24 16:22, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi!
>> On 5/6/24 22:26, Petr Vorel wrote:
>>> Hi Andrea, Martin,
>>>> Hi,
>>>> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
>>> +1
>>> ...
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>>>> +
>>>>> +static struct tst_test test = {
>>>>> +	.test_all = run,
>>>>> +	.setup = setup,
>>>>> +	.cleanup = cleanup,
>>>>> +	.forks_child = 1,
>>>>> +	.skip_in_compat = 1,
>>> BTW test on x86 (i.e. true 64 bit) behaves exactly the same as on compat mode:
>>> tst_test.c:1614: TINFO: Timeout per run is 0h 00m 30s
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:46: TINFO: mmap() failed
>>> fork14.c:49: TCONF: mmap() fails too many times, so it's almost impossible to get a vm_area_struct sized 16TB.
>>> IMHO we should whitelist it as well, I can change before merge with diff below.
>>> (More elegant way would be to add .skip_in_32bit.)
>>> Kind regards,
>>> Petr
>>> +++ testcases/kernel/syscalls/fork/fork14.c
>>> @@ -18,6 +18,8 @@
>>>    #include <stdlib.h>
>>>    #include <sys/wait.h>
>>> +#ifndef __i386__
>> TST_ABI32 is not enough? What about ".skip_in_compat"?
> Yes, TST_ABI32 is actually better than limit to __i386__.
> Do you give ack for these changes below? Or feel free to send new version?
Sure feel free to use TST_API32
> IMHO the problem is 16TB is too much for 32 bit kernel (4 GiB limit).
This is wanted. It's explained in the bug description
>
> .skip_in_compat would not be enough, because the problem is on pure 32 bit
> distro e.g. with 32bit kernel (yes, there are people who use them), but
> .skip_in_compat is for 64 bit kernel with 32bit userspace (compiled with -m32 in
> CFLAGS and LDFLAGS).
>
> Also, I suggested in the patch below to remove .skip_in_compat, but for info
> version it would be good to keep it. I suppose it's not worth to add new flag
> .skip_in_32bit for this single case (it'd be good for doc purposes).
> @Cyril WDYT?
>
> +++ testcases/kernel/syscalls/fork/fork14.c
> @@ -7,17 +7,21 @@
>   /*\
>    * [Description]
>    *
> - * This test is a reporducer for this patch:
> - * https://lore.kernel.org/lkml/1335289853-2923-1-git-send-email-siddhesh.poyarekar@gmail.com/
> - * Since vma length in dup_mmap is calculated and stored in a unsigned
> + * This test is a reproducer for kernel 3.5:
> + * 7edc8b0ac16c ("mm/fork: fix overflow in vma length when copying mmap on clone")
> + *
> + * Since VMA length in dup_mmap() is calculated and stored in a unsigned
>    * int, it will overflow when length of mmaped memory > 16 TB. When
>    * overflow occurs, fork will incorrectly succeed. The patch above fixed it.
>    */
>   
> +#include "lapi/abisize.h"
>   #include "tst_test.h"
>   #include <stdlib.h>
>   #include <sys/wait.h>
>   
> +#ifndef TST_ABI32
> +
>   #define LARGE		(16 * 1024)
>   #define EXTENT		(16 * 1024 + 10)
>   
> @@ -48,7 +52,7 @@ static void run(void)
>   			if (failures > 10) {
>   				tst_brk(TCONF, "mmap() fails too many "
>   					"times, so it's almost impossible to "
> -					"get a vm_area_struct sized 16TB.");
> +					"get a vm_area_struct sized 16TB");
>   			}
>   
>   			continue;
> @@ -115,9 +119,11 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.forks_child = 1,
> -	.skip_in_compat = 1,
>   	.tags = (const struct tst_tag[]) {
>   		{"linux-git", "7edc8b0ac16c"},
>   		{}
>   	}
>   };
> +#else
> +TST_TEST_TCONF("Not supported on x86 in 32-bit");
> +#endif

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
