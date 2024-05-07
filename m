Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F8CC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715066684; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=4D+uhOpRskkbxzvPf7ZXAZp1zgZfqWlMO/3dIen9nvs=;
 b=LDeUbCUurEYqb9hd8kKIp9WV48L/aM/uQCdLdCqCV9vBi9gTZtzL9BYhYQuz/nrx6C4ig
 ACD38opw5mkYQ3vbFbNSdRwtQ4s5Ge6lm0u3lOCK+RFaH/aWK01BqW3Ga+t5+/43Ohj821f
 tGBZ2A/CVctbPV7Da1k75yyhDQQtwcM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2422D3CDB5E
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 09:24:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39DE73C0562
 for <ltp@lists.linux.it>; Tue,  7 May 2024 09:24:22 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 900921BE2BE9
 for <ltp@lists.linux.it>; Tue,  7 May 2024 09:24:21 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51f1bf83f06so3396750e87.1
 for <ltp@lists.linux.it>; Tue, 07 May 2024 00:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715066661; x=1715671461; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jVRmVmT8VFzs590qhH263seFe1NBqq5/cgD9rVDi6Rw=;
 b=Z316mnjKYOihXCUagMZDSA+/cBVdhy2RZc5AzlOKhp9KI0x0AMN7qwiYqZBvNnhfIo
 bABodQou6m24i+addHn2smvoA6mp0Qx9oTOmqgeh3y6Jnjv2R4TcDOrBMtfOjpNac4Qa
 dXG3o3qvMy7VIuQynrFsbfNvavOMvgEJWl5jHnlmB/MsY7dGq/0T9Rduu7WlbpqJJiLG
 lEQNReNs8ZRt0pyui4m2Ws11+cvZR8dxDPl/LWZ2MGd/bPp28BqAfRuk8LyS0dYg6is4
 NDWFG2g9DncmIkqG6OyyHJINn9nY6gKURQMPWL/i9Pwd58MXRLm1yZxnN0n35dw2fbo1
 UGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066661; x=1715671461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVRmVmT8VFzs590qhH263seFe1NBqq5/cgD9rVDi6Rw=;
 b=nc5CCtuVYk2Bqz6FpI87FEwSRjeCbDyLLv9rutOruXQqrB64vhZCnmemr6y35TGBPR
 lCIbU11s4m2UIM3+FvwEBpVoULZqBuvG1mdhNApk2hty2fQ/1W7TTfsGLUezgYkxMy6y
 zCyqP2bsC06oQiJdZWvfvk4etAtbFbAHFD8iq4UtCnoA6nqrNKQshAAt5oTBn75l+Hnx
 x3vya3nCj8i3uSaRaKUh7a7OiRkUbbfNkHVCcOnPcffhWHqg1mjji4AKTLZgK0yCFLvX
 C4JCo/HUykuBlR4ZD2cmHs8Hsf8qM/Dkq/ZZKePWj/dy9mQ3D+cl+rLyd3JRN/QBloZ8
 vNBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUjnrCYJzfGPx4eMLaRrA4qhePEX38GRyX7FaMA2CRWXTpuAUFSIsGEgBgL2GUO+3qK/LFqyJNDvF6lV9o6+tVIeQ=
X-Gm-Message-State: AOJu0Yx+8Gbk175YhzkgtLtG1d7KH3aUZhT5brMSyPhI2DLeQzaCcgtA
 XM1r8u6/BRBe9wuvx/Rq4BqyNEwGorsZI1WdRT4FVDO568zrBijF1SCsPEp207U=
X-Google-Smtp-Source: AGHT+IGsXxJHUhR1blbeY8ppxaiKXifhrZeEfiRIsRqs9KDBK04+1zMNlFiqIwh/uBxzmuQ4l5fFHQ==
X-Received: by 2002:ac2:5e84:0:b0:51d:416e:8434 with SMTP id
 b4-20020ac25e84000000b0051d416e8434mr8049153lfq.2.1715066660713; 
 Tue, 07 May 2024 00:24:20 -0700 (PDT)
Received: from [10.232.133.81] ([88.128.88.94])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05600c34c100b0041c130520f3sm22239132wmq.6.2024.05.07.00.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:24:20 -0700 (PDT)
Message-ID: <bbcfed6d-caff-43f8-96ce-77e6cb6afd2a@suse.com>
Date: Tue, 7 May 2024 09:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20240503081647.18253-1-andrea.cervesato@suse.de>
 <a85b4fe7-a235-4b7b-8211-4caf8c3112c2@suse.cz> <20240506202614.GC38981@pevik>
Content-Language: en-US
In-Reply-To: <20240506202614.GC38981@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 5/6/24 22:26, Petr Vorel wrote:
> Hi Andrea, Martin,
>
>> Hi,
>> Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> +1
>
> ...
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> +
>>> +static struct tst_test test = {
>>> +	.test_all = run,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +	.forks_child = 1,
>>> +	.skip_in_compat = 1,
> BTW test on x86 (i.e. true 64 bit) behaves exactly the same as on compat mode:
>
> tst_test.c:1614: TINFO: Timeout per run is 0h 00m 30s
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:46: TINFO: mmap() failed
> fork14.c:49: TCONF: mmap() fails too many times, so it's almost impossible to get a vm_area_struct sized 16TB.
>
> IMHO we should whitelist it as well, I can change before merge with diff below.
>
> (More elegant way would be to add .skip_in_32bit.)
>
> Kind regards,
> Petr
>
> +++ testcases/kernel/syscalls/fork/fork14.c
> @@ -18,6 +18,8 @@
>   #include <stdlib.h>
>   #include <sys/wait.h>
>   
> +#ifndef __i386__
TST_ABI32 is not enough? What about ".skip_in_compat"?
> +
>   #define LARGE		(16 * 1024)
>   #define EXTENT		(16 * 1024 + 10)
>   
> @@ -121,3 +123,6 @@ static struct tst_test test = {
>   		{}
>   	}
>   };
> +#else
> +TST_TEST_TCONF("Not supported on x86 in 32-bit");
> +#endif

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
