Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C362C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 12:44:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E254D3C21EE
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 13:44:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0453C6F5D
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 13:32:40 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A191A200FE9
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 13:32:39 +0100 (CET)
Received: by mail-qv1-xf32.google.com with SMTP id gu12so2556051qvb.6
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 04:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=tpGZcD4nIKwqnuNHKHO0TBkz7hc0UrH6GNojNQbNLKw=;
 b=CEcz3jokK+2gamU86FUd732G6aGQSldWSgIYDAb1++eUEokprXH6vVcds+LEIFOvpw
 CGcL58iMsLJPtV1sYdGQNrjx76UbdkL8wS6Nr8TKdrBLSU3WmoH4r7TEhESoXa3cjl8I
 kl6yD/ihDzek+MCP6SP2DDP1Y2qbPZEIMFvEVe2a7KTHLELSuZr7ex+owANFJdyUNTj3
 XUPwdZZNgBlEk/tE3YhZQQM8vyJMQPV7Cewrx4SQ89iL7flVKLssOKgLB0rEeGv+A17u
 nsZueDRq8rbCD9tdeBuIThzS5LD3OWlinDAWsIjJIFkYFOB8NKl/Dh2MbBe41kfsYLrT
 DOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=tpGZcD4nIKwqnuNHKHO0TBkz7hc0UrH6GNojNQbNLKw=;
 b=722X4m+0PtN87w7DqBo5Pc3FlGt8J0z/Xfs2l6rQ5m5QqNPUO4Zx03Vi6BpHu7EIKN
 iKh/mhXAG/aFoBmTF90m9bpyDqJv2yFWGaHaHgN4UyCDsZa3Y6MiCgHTFBXRKxITqyn6
 3jMJ12qwFs5gz+8cWsR9BcURn77Jheh2xmzx0SWzoF8sXS5agwSCWmFAIcwMHat6F1ub
 NU1BCklJ0jqoCnrMQ6iZJ1HooiWiGb5bpFJbQnJSh6jbRxfJmVkUgVusiUtmxl9Je/wW
 NIkkJZDa4CGe0FnZRHEQcdAtdwb2KrofNfpqtR/a4bzzmP1rUQZfJKXgm5xGtrAg5g11
 V0rA==
X-Gm-Message-State: AOAM531RcM5cT6Do5yznNLJCy2CLLfX30gMLROWWeTgLSmvf/J6wchR+
 1xM5jDjkUcyDdDf+fCgLqS3Aig==
X-Google-Smtp-Source: ABdhPJzaCgHrIbHSQbI0Sq3nOtRXTwg7hBaKyrlCC9ErC+zf+wgn72iYAl0CHvgkGMkfZn4Bi4B5jQ==
X-Received: by 2002:a05:6214:4007:: with SMTP id
 kd7mr18672354qvb.52.1638534758304; 
 Fri, 03 Dec 2021 04:32:38 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:30f8:f5d6:4b6d:fe6a:d565?
 ([2804:431:c7cb:30f8:f5d6:4b6d:fe6a:d565])
 by smtp.gmail.com with ESMTPSA id h22sm2258645qtb.86.2021.12.03.04.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 04:32:37 -0800 (PST)
Message-ID: <0864bd62-7a93-106d-8a36-23dd72a7ab58@linaro.org>
Date: Fri, 3 Dec 2021 09:32:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Zack Weinberg <zack@owlfolio.org>, Rich Felker <dalias@libc.org>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
 <20211202153422.GH7074@brightrain.aerifal.cx>
 <20211202232954.GI7074@brightrain.aerifal.cx>
 <855a47d1-a89c-bbc8-7ddd-b89104c6138a@linaro.org>
 <9d24f699-386a-4881-b09a-ebd747310187@www.fastmail.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <9d24f699-386a-4881-b09a-ebd747310187@www.fastmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 06 Dec 2021 13:44:12 +0100
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 02/12/2021 21:10, Zack Weinberg wrote:
> On Thu, Dec 2, 2021, at 6:43 PM, Adhemerval Zanella via Libc-alpha wrote:
>> On 02/12/2021 20:29, Rich Felker wrote:
>>> On Thu, Dec 02, 2021 at 10:34:23AM -0500, Rich Felker wrote:
>>>> On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
>>>>> On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
>>>>>> This changes the __u64 and __s64 in userspace on 64bit platforms from
>>>>>> long long (unsigned) int to just long (unsigned) int in order to match
>>>>>> the uint64_t and int64_t size in userspace.
>>>>> ....
>>>>>> +
>>>>>> +#include <asm/bitsperlong.h>
>>>>>> +
>>>>>>  /*
>>>>>> - * int-ll64 is used everywhere now.
>>>>>> + * int-ll64 is used everywhere in kernel now.
>>>>>>   */
>>>>>> -#include <asm-generic/int-ll64.h>
>>>>>> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
>>>>>> +# include <asm-generic/int-l64.h>
>>>>>> +#else
>>>>>> +# include <asm-generic/int-ll64.h>
>>>>>> +#endif
>>>>>
>>>>> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
>>>>>
>>>>>  /*
>>>>> - * int-ll64 is used everywhere now.
>>>>> + * int-ll64 is used everywhere in kernel now.
>>>>> + * In user space match <stdint.h>.
>>>>>   */
>>>>> +#ifdef __KERNEL__
>>>>>  # include <asm-generic/int-ll64.h>
>>>>> +#elif __has_include (<bits/types.h>)
>>>>> +# include <bits/types.h>
>>>>> +typedef __int8_t __s8;
>>>>> +typedef __uint8_t __u8;
>>>>> +typedef __int16_t __s16;
>>>>> +typedef __uint16_t __u16;
>>>>> +typedef __int32_t __s32;
>>>>> +typedef __uint32_t __u32;
>>>>> +typedef __int64_t __s64;
>>>>> +typedef __uint64_t __u64;
>>>>> +#else
>>>>> +# include <stdint.h>
>>>>> +typedef int8_t __s8;
>>>>> +typedef uint8_t __u8;
>>>>> +typedef int16_t __s16;
>>>>> +typedef uint16_t __u16;
>>>>> +typedef int32_t __s32;
>>>>> +typedef uint32_t __u32;
>>>>> +typedef int64_t __s64;
>>>>> +typedef uint64_t __u64;
>>>>> +#endif
>>>>>
>>>>> The middle clause could be dropped if we are okay with all uapi
>>>>> headers potentially exposing the non-implementation-namespace names
>>>>> defined by <stdint.h>. I do not know what the musl libc equivalent
>>>>> of <bits/types.h> is.
>>>>
>>>> We (musl) don't have an equivalent header or __-prefixed versions of
>>>> these types.
>>>>
>>>> FWIW I don't think stdint.h exposes anything that would be problematic
>>>> alongside arbitrary use of kernel headers.
>>>
>>> Also, per glibc's bits/types.h:
>>>
>>> /*
>>>  * Never include this file directly; use <sys/types.h> instead.
>>>  */
>>>
>>> it's not permitted (not supported usage) to #include <bits/types.h>.
>>> So I think the above patch is wrong for glibc too. As I understand it,
>>> this is general policy for bits/* -- they're only intended to work as
>>> included by the libc system headers, not directly by something else.
>>
>> You are right, the idea is to allow glibc to create and remove internal headers.
> 
> As a general rule yes, but we could make a deal that some specific bits headers are permanent API for use by things like this. They probably should be less of a dumping ground than bits/types.h though.

I really don't think adding such constraints really would improve the project
in long term, we already have issues about the need to support some internal
symbols that were exported by accident.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
