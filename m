Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1C2C47073
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 13:43:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A117D3CE78D
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 14:43:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7461A3CB399
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 14:42:51 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB920600CF0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 14:42:50 +0100 (CET)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9bc8939d0so2645665b3a.0
 for <ltp@lists.linux.it>; Wed, 03 Jan 2024 05:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704289369; x=1704894169; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tgLZPE3k8mv7OsfjiykkWsKs0r6LBiLCfY/1eBmeem8=;
 b=NODTxBK05IjkKchvsc7qFcp7b0E0Yf6+jnqbu8y0989LvjFEojn3b1E4vOF0RNv44r
 Knzj2I9iXk/serds7Qcz9xaw7xinL3sSEkW00jlIk/pd3b7iZmSFFNMTgnnFNeuSzs5D
 2OZZ2KjB0DoZ/xt+fvm4TNJa4kloKzt/OnHtgqBaBvpmGWZTcGT92/SslcYwfC7bj7OT
 wbY9r905Uc0nNXqOmQrqT/L7A9wgU5FlQzuIJ3zl9FNvD/p/JrdgsyItcn7HTkfpvfbF
 2Mf00g5nVkWB1FB/QKWJvVCIta6I7zfL+FKt9gEAhjGxR8qPuBuy/L+5bAN/UMGOqi8Y
 ZPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704289369; x=1704894169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tgLZPE3k8mv7OsfjiykkWsKs0r6LBiLCfY/1eBmeem8=;
 b=O3wCEzgzM/MYy20H4HaF2AtE3JHed2GQux5XpGFHNjNwWEYpjrWT2xt/3vFmy1TnZt
 P40LrraaK84lE8/0yZUSfODtuio+/0eyzNn/YMV1E1kIudVLU09aGwqrE4Z/fSPApcte
 KonPwh9bPjBChfeFgg9W3GYiD4kmAktucn8em2KIxjio05q8Rqkz0kfIeSKmMqyabisT
 vOKOaUhpbpVC8UguuYp8dfPkioJ9cMm6hdZIPtTDjUMv3XSEYwGtG6IRhCZZaRy6w8cz
 gaEfXWiA8bnRAmrsonm6k8/FkdOa0lgdJqfNXwvwceohRXifQkdcGw2M/pinMfR1+UIt
 1wog==
X-Gm-Message-State: AOJu0Yxh410dMiePpXKX5gCDed77Bo4b80PDvPzXfSs//aeSgjX3zSNw
 I2VLZUyAL6Rp5MpGJVvENshj2A4047Q=
X-Google-Smtp-Source: AGHT+IGVHtOW6EKbDCpxzUHtm7WW4BikEzDVNokpvw/QpyF5/Tq6CY8W9gdqAerJ7dWpHqKd5pfDew==
X-Received: by 2002:a05:6a00:9290:b0:6d9:df28:73df with SMTP id
 jw16-20020a056a00929000b006d9df2873dfmr7206862pfb.6.1704289368397; 
 Wed, 03 Jan 2024 05:42:48 -0800 (PST)
Received: from ?IPV6:2406:7400:94:1ab5:6ddc:48df:f913:fc99?
 ([2406:7400:94:1ab5:6ddc:48df:f913:fc99])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a62ed07000000b006d99e005ea6sm19033195pfh.160.2024.01.03.05.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 05:42:48 -0800 (PST)
Message-ID: <939ec35c-f372-4806-8073-88d35defcf56@gmail.com>
Date: Wed, 3 Jan 2024 19:12:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
 <ZZVX1LUDuJGOxEXu@yuki>
From: Subramanya <subramanya.swamy.linux@gmail.com>
In-Reply-To: <ZZVX1LUDuJGOxEXu@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] read_all :catch alignment faults while reading
 sys entries seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 03/01/24 18:19, Cyril Hrubis wrote:
> Hi!
>> +	/*
>> +	 * This could catch any alignment faults while reading sys entries
>> +	 * seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
>                                   ^
> 				 This does not seem to match any kernel upstream commit.
>> +	 * in chunks of 8 bytes 128 times
>> +	 */
>> +	char check_buf[7];
>                         ^
> 		       This isn't 8 bytes at all as it's written in
> 		       description.
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < 128; i++) {
>> +		count = read(fd, check_buf, sizeof(check_buf));
>> +		if (count == 0 || count < 0)
>> +			break;
>> +	}
> So the intention is to read the buffer in smaller chunks? I guess that
> it's hard to tell without having seen the kernel bugfix.

My bad i provided the wrong commit id in the commit message for the 
kernel bugfix, 
https://github.com/torvalds/linux/commit/1bbc21785b7336619fb6a67f1fff5afdaf229acc 


>>   	count = read(fd, buf, sizeof(buf) - 1);
> I wonder should we seek back in the fd, or do pread() with zero offset here?

yes you're right since we are using open instead of fopen pread() with 
offset zero should be used else the buffer would not print data read_all 
in case the test is run with

-v option

>
>>   	elapsed = worker_elapsed(worker);
>>   
>> @@ -713,5 +727,5 @@ static struct tst_test test = {
>>   	.cleanup = cleanup,
>>   	.test_all = run,
>>   	.forks_child = 1,
>> -	.max_runtime = 100,
>> +	.max_runtime = 200,
>>   };
>> -- 
>> 2.39.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Best Regards,

Subramanya


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
