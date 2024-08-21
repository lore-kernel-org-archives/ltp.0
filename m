Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E6C52D7C
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724261676; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=jzdDPDNXBGYOYOdjUorzUxo1dR3sxLHLX42Lek4+XAM=;
 b=P5D6IdfQAdCyGAHdYFqPo5pg6V41P/qA3u2jG7RpMCQDROkPB9kQ5S8/wYDCvSAnPV7Bf
 NtdIfXD+yatu3LL/ZRi52mS/08tZP7VtruLL77k3hu8P3S+oa9mQAy4ufXjhr3jAf7j/fO4
 eSWQKDbzQSKTdx+YZd5CI+qbqGAntB0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580753D227A
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 19:34:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA9AE3C0063
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 19:34:14 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBD4C140021C
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 19:34:12 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8683dc3b17so26185566b.3
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724261652; x=1724866452; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V9QoXIDYeV5MhwDuYoFRq58M0twL7tsMx21MCVWdTkk=;
 b=L1Qa5fGF5Yyxo6VauAbKpMicJPw+ZKuU50tfcrzkZBIwpNYiSWWYy2IJT8tlFB5k+I
 Puw+GWllovp0jIpFMWUKxHCDFfs65ROwvFp/tfpLwjAZlE2lUzGcHPS64CtX7WIneMgV
 6Pzgtraz0gXDJ2IT4EJLsfNMT6sjCv3Wg0Q5B7PgP7PxqgxS2aiD4FuLQm92KhCXbInB
 EnH0j9knjzvRGTlnZQ1UUvhsSWkf2MmTnbpTGJYNmCnO42ZSVk0v3//GNiiNASQ7AiIq
 yl8YKDFUNffcyHiQHx+/pvdR+TNApzsCFlSnEGus5dAsw1EdjU/KnBm+6B5KdAiTBvxl
 sBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724261652; x=1724866452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V9QoXIDYeV5MhwDuYoFRq58M0twL7tsMx21MCVWdTkk=;
 b=IdkuKN8nomppDKILHbKhS0uBTdlXZwUXgvFMBSaiNhONzg2t/Kfc7HGbi3vNG1cXG8
 FBmCGSFyci3HB0I+hAZoZu/xNGA6YrlZp3uxknSoN4X+cM8Y3hC/Y9ZmX4Ex6cya+f3r
 y9xpoMU8Xfj0HVg+e+fmlXMUZxdVpd9bvlHYV477auxIrPgHyyVE+/YtnVEmFw+uUOpN
 Ad/bYDby9ndFiQXyOsS8WItmc4jhS9+noZHbA0XVMahl0y0gnmUf2tgPxNfsELxwBgGD
 NjkPJsjTuHkEhoAqMBZhChpS5wE5CzNZmpmpV0ikV6dl8jIWUey4holFe1BGTb4vnR2F
 SV9Q==
X-Gm-Message-State: AOJu0YyTA7IXRqIp3GzUoynBZrzkixi9ILxKFzgCHXUf8mAS1uUKKr1V
 FG2L1JMC2jtB9v/BkGreEvFicTxiVjMOvaP2OLLp8pl5XH0ETfvd/Wt8/1frJzb5rcwvcAWCWUY
 065I=
X-Google-Smtp-Source: AGHT+IFZ6t8qD/5ZqgzyBiXOKpYu/4g3Knez1xEf4U+6dNkMrgsMcJQiyynZ4h9gbYTtv0zQ1VN47Q==
X-Received: by 2002:a05:6402:40c7:b0:5be:eb4f:d4cb with SMTP id
 4fb4d7f45d1cf-5bf1f0a3b2bmr3162568a12.5.1724261651648; 
 Wed, 21 Aug 2024 10:34:11 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.37.107])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc08109esm8294364a12.81.2024.08.21.10.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 10:34:11 -0700 (PDT)
Message-ID: <3d9e3df7-c502-49ed-ad59-1e3768840f59@suse.com>
Date: Wed, 21 Aug 2024 19:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240821-landlock_houdini-v3-0-15fc43055d02@suse.com>
 <20240821-landlock_houdini-v3-2-15fc43055d02@suse.com>
 <ZsYCTZ9XTw5KdCWn@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZsYCTZ9XTw5KdCWn@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add landlock07 test
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

I fix the typo and push the patch to upstream.

Thanks,
Andrea

On 8/21/24 17:05, Cyril Hrubis wrote:
> Hi!
>> More information at:
>> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   runtest/syscalls                                |   1 +
>>   testcases/kernel/syscalls/landlock/.gitignore   |   1 +
>>   testcases/kernel/syscalls/landlock/landlock07.c | 109 ++++++++++++++++++++++++
>>   3 files changed, 111 insertions(+)
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index fea0c9828..a9fc8c432 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -706,6 +706,7 @@ landlock03 landlock03
>>   landlock04 landlock04
>>   landlock05 landlock05
>>   landlock06 landlock06
>> +landlock07 landlock07
>>   
>>   lchown01 lchown01
>>   lchown01_16 lchown01_16
>> diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
>> index 315ac1dca..db11bff2f 100644
>> --- a/testcases/kernel/syscalls/landlock/.gitignore
>> +++ b/testcases/kernel/syscalls/landlock/.gitignore
>> @@ -5,3 +5,4 @@ landlock03
>>   landlock04
>>   landlock05
>>   landlock06
>> +landlock07
>> diff --git a/testcases/kernel/syscalls/landlock/landlock07.c b/testcases/kernel/syscalls/landlock/landlock07.c
>> new file mode 100644
>> index 000000000..68045da3b
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/landlock/landlock07.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/**
>> + * [Description]
>> + *
>> + * CVE-2024-42318
>> + *
>> + * Test to check if sysem is affected by Landlock Houdini bug:
>                            ^
> 			  t
>
>
> Otherwise:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
