Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DB5C02185
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736939052; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=mgCyyGPMn5azLVpBX+t0cEbWoRRueKJ/u0Y3T25TdW8=;
 b=OZuErSJW1naWXJdhbGUA9kLzBUj/POAzk/7ojETJHyijbmgDuJPIaxuvsdC9YcKaadA9O
 VUn74q2Ssnl2d2cM6Mouy8BgxwmZFPV/AQuCI0b2xBUQB+DLY2EaED7+kbUiq21GHGP5HSH
 qtgsMOyXGofQv09kk+4iO4K9Tdenrug=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71F373C7B7A
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:04:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157363C7A3B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:03:51 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B6A891035C6F
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:03:50 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso4346585e9.1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736939030; x=1737543830; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ld1GJzbvjfUMUbLikZcvBl7uWi0Z7CVqw4WeURdiQeI=;
 b=MYZviVM3Mvz9CnX8O2vUUticNX8yIVBrI3oKM04pk1V7M6YidhXcDKfrk5mGVEqej2
 Tw5jLBPSoty0l2h3mNMM173rUvTNUS1ZqxGQCx9AuBzev9BnLbJJ7fDrOBOrIIrz5DF5
 7XHyx6zShPQmvFRvGXpZinPAg0ES0AEnNXaE5rXeHksWc0SgmwbuX0v/JCQyVOmiAAV/
 8B7+LLDUvQCDuuCCWYQtb8yK2JfZIq4xa6yYdjE7qaU5IDhLg3xuCyfHQus8MT7+Xg/z
 s5ThNI0RLpQjq8PM9zquST7Z1bAVOXDkybgWZ3x+I+80AX753T6Lsm1EVZ+42kRPVxE9
 6XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736939030; x=1737543830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ld1GJzbvjfUMUbLikZcvBl7uWi0Z7CVqw4WeURdiQeI=;
 b=U0/Uv6NkOYtXxD9MIFLxuXvCqk3dzcJROSvyq4Omd4EPul3br1SogKP3oB8SHeSMlH
 YCaHf067MByn5z7SZ1hQBtk5SbMS55/KdCAj/H2mskPTJdOOD1ON3b5Xu+910gC2ZWmm
 hiWjkVhZwpZZv7SjoNta0QJIvqzuM2WRvHD2UixdtenDjaWZs7l1PbRT2R5zjMiPRrdt
 GesOYfHouj4fXnl7BDORd5IIGmVjUNUIZR375ZaZLhwi0F+Q2cBkudndImUKm6r+wgDs
 2+1n+lurjadr0D1CqVYbfItX/e4PUYw+aHaABEKbDGXMOEawIfnptkvmmqIgs4sV8ty8
 Xa5A==
X-Gm-Message-State: AOJu0YzNrI4M3Hbk5nC+jbO4CCiEQ1K704kPeMttJX4+10xj7vWWcbto
 r7NuY+zt6u3aYN37SRq0nE14oSPN9xY07d/O4MuUw6HUz84GwJ2lmd7BEMH9BAU=
X-Gm-Gg: ASbGnctFRLAg2Y5segUYYJ03j+I63IuozWgUGJs4v/WcH9CawcE3UYh7JMJYsgt3nKM
 j6X0tIeuXPtJKFddwYGruwoYjvAkbANC4DIRUgzJ/0dHLmQcXHuoSNoZ9BhilKEFfCEeohC0SMg
 hJ0WLbJazOAolQu5tqvX6mgoj0GLymoKy1/VS3If1GuUWnzsqY6hDP55R43gieaLHowLFcA2+Yy
 ZPxkzCxY7vfaoirUjmlky6Ai3SXmFDRx9nGSNowUc58zasnkULDsV5DREJjRjrXftk/9RKSC0Zm
 VVZ2OV9uk5e6qtya+1mb7od1eMA/M2V6j1+jgycCo+NEY0W3jheKxk+Awu41LiwrpqjS+toBbk5
 Pm99BhTcaa0nGHHZSrUg=
X-Google-Smtp-Source: AGHT+IGXAzaTNMUWI+OHkzo4H8zbdLjL0GhawyY8igZYJaSWo8hriKTdQOMAyEkUufQApWL6denxvg==
X-Received: by 2002:a05:600c:4c06:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-437c6a86b58mr19313335e9.0.1736939030081; 
 Wed, 15 Jan 2025 03:03:50 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c0f02c07sm33012865e9.0.2025.01.15.03.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 03:03:49 -0800 (PST)
Message-ID: <867c3f3e-7edd-4a73-b401-85c082cced6c@suse.com>
Date: Wed, 15 Jan 2025 12:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Ricardo B. Marliere" <rbm@suse.com>
References: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
 <7b366388-6a0b-45de-95fe-08beb7528062@suse.com>
 <vifwygnntr4s4u5xk5dgqmq2dni5mb2doay5mw35rf6ji5epd4@semy6ws4gcsx>
Content-Language: en-US
In-Reply-To: <vifwygnntr4s4u5xk5dgqmq2dni5mb2doay5mw35rf6ji5epd4@semy6ws4gcsx>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] .b4-config: Add checkpatch.pl default commands
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 1/15/25 11:44, Ricardo B. Marliere wrote:
> Hi Andrea!
>
> On Wed, Jan 15, 2025 at 09:54:43AM +0100, Andrea Cervesato wrote:
>> Hi,
>>
>> thanks for this patch. I was using something similar, but the output here
>> seems more reliable. What I don't really understand is the following error
>> for many of the commits in the patch-set:
> What patch-set are you referring to?
I was referring to the current patch-set under development in b4 branch.
>
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> I remember seeing those in the past, but was unable to see it when
> running against the last patch-set I sent (regarding mmap refactors).
> I'm running b4 version 0.14.2.
>
> Replying to your other message: I agree with adding FILE_PATH_CHANGES to
> the ignores, since there is no MAINTAINERS file in LTP. That should also
> probably be added to include/mk/env_post.mk.
Yeah I was thinking that. I will submit this patch with a change on 
env_post.mk as well.
>
> Thank you,
> -	Ricardo.
>
>
>> Andrea
>>
>> On 1/14/25 23:43, Ricardo B. Marliere via ltp wrote:
>>> From: Ricardo B. Marliere <rbm@suse.com>
>>>
>>> Blend b4 default checkpatch.pl flags with the ones defined in
>>> include/mk/env_post.mk in .b4-config so that a contributor may use `b4 prep
>>> --check` and `b4 am --check` in his workflow.
>>>
>>> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
>>> ---
>>>    .b4-config | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/.b4-config b/.b4-config
>>> index 2efdf2273240dcf57bd5cab174ff6c7a1952dd5b..5a16bd64ec98b91e17386c0eadc7ef0de54d86f3 100644
>>> --- a/.b4-config
>>> +++ b/.b4-config
>>> @@ -4,3 +4,6 @@
>>>        send-series-to = Linux Test Project <ltp@lists.linux.it>
>>>        pw-url = https://patchwork.ozlabs.org/
>>>        pw-project = ltp
>>> +    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
>>> +    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
>>> +
>>>
>>> ---
>>> base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
>>> change-id: 20250114-fix_b4-config-1ab84320000a
>>>
>>> Best regards,

Thanks,

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
