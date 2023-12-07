Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC80C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 043383CBCFB
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:41:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BEB83CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:40:53 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 71A091A0199B
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:40:52 +0100 (CET)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9f62fca3bso8745381fa.0
 for <ltp@lists.linux.it>; Thu, 07 Dec 2023 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1701952852; x=1702557652; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vLhoCXiRX+Wx+4Uecdp6paXz6slTFwodI+q+q+tCrpk=;
 b=B1hLz7ku7tVksQ/1HR2heizG3FCIN4uM4tQHy63M9k2hN3AGGy3jv5xbLTWKCgKqxZ
 4+mQmqTNTTDcbmnJ9gUNis5OG4kce8Q8yOa+mROR1Gk+TPqrgM6RwsOM5S5AzQ120nTr
 D26Owu8HWyVOaknq2KuzN0tX918MM0x0dYLcFrvV1dQOgi5eGlp6YXaEFCslSvVTaiif
 gOuRChmJVuIDkyLBQHvsYglTawkIE18aA/cZ8AUGomF1802i53kgzUZe4FL06xvHQx38
 EsnqxcIltbrb6ma2zuoyFaLMCopcvY4r87L3pPRS3Z3o5HbuvxR/LNL/IiLSXlIhAKAX
 lOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701952852; x=1702557652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vLhoCXiRX+Wx+4Uecdp6paXz6slTFwodI+q+q+tCrpk=;
 b=NuIDKLMwk1KcewhTRkw/PaoTizy2BkUGHDNfJhLu3S2KqoGfOLyOdr0uOD/pBI5Wo8
 gzU0qNwww/Vwm6cxS0BCEb82Z9daZm7hpv8U2jprw8EolJvcz4qtaoqY9NevsTtYPCX2
 82/z7EDL+THwfnCkszNnWiBFY2f68uyTdDq4UGPT07xckG3bzCnGVboaPNByJkUvcJzv
 Z8nymg9qO54a+woGAjHTbYivihzBFEbnR204dzZ+BDZUILLHJBXviS5ZyOLWIL2AU9Ay
 /gY0c1Sai5Kpu1K17PNyZhVilwFOfRauoXFeUtX27Z2in30gpb2xaBchyVVc6NKlPcFC
 yKjw==
X-Gm-Message-State: AOJu0YwP7Ppdb1hxoN3mDd1u7jqe+bsF68LT3dc67Zgc9Ra9OhP8eiQz
 CODwhDiXXDs6b904qQIWzitsaJrHILPUQBBHhX5vzw==
X-Google-Smtp-Source: AGHT+IEwjwwc1B0mS6K+aSCHGqogLHDim/iI/Erhd4CTCFnDsc1ql+AXoQ9XjpYvVEiMgsV8dBMLhA==
X-Received: by 2002:a2e:9919:0:b0:2c9:fa20:89df with SMTP id
 v25-20020a2e9919000000b002c9fa2089dfmr1460007lji.30.1701952851699; 
 Thu, 07 Dec 2023 04:40:51 -0800 (PST)
Received: from [10.232.133.55] ([88.128.88.38])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170902d48700b001d0c4869725sm1300227plg.97.2023.12.07.04.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 04:40:51 -0800 (PST)
Message-ID: <6bee08e7-e57f-4d0f-b1a7-3c5441454d9f@suse.com>
Date: Thu, 7 Dec 2023 13:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com> <ZXG5x8R56fISvCLW@rei>
 <164f3362-ef24-4bc8-a27e-56d28ecdb60e@suse.com> <ZXG7d_ImcsTa_a0_@rei>
 <72e80847-aa5d-4180-8f55-fa2fd06aeec7@suse.com> <ZXG9EcGc60JGVnD3@rei>
In-Reply-To: <ZXG9EcGc60JGVnD3@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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

On 12/7/23 13:39, Cyril Hrubis wrote:
> Hi!
>>>> What about mixing TVERB flag with the others ? Something like "TINFO |
>>>> TVERB"
>>> That's too much typing to be honest. Maybe TVINFO?
>>>
>> "TINFO | TVERB" makes somehow sense, since we can have it for other
>> flags as well.
>> And we have the same for TERRNO
> The difference is that TERRNO is applicable to all other types such as
> TPASS, TFAIL, TBROK, TWARN. This does not make sense for TVERB, you
> probably do not want to hide passed messages and you certainly do not
> want to hide falures, bereakages and warnings...
>
I was thinking more about TWARN and TINFO.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
