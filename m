Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D93C433EF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 12:44:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED48C3C0CCF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 13:44:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422593C8DC3
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 00:43:25 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7192320101D
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 00:43:24 +0100 (CET)
Received: by mail-qv1-xf30.google.com with SMTP id i13so1144993qvm.1
 for <ltp@lists.linux.it>; Thu, 02 Dec 2021 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=NRHD8v+tRRUHCg4eVJNU2+6QjpHDHulBgn/4Ya8pJhM=;
 b=aX7WenwnFgVumYBbGyaHgnNTJ7wSb7HEj0fPTxLMGTQJJkVOY/CxBp10dNxZR0DSp5
 SobGbBdr4AWwVYcXbmxu8O9OU+r54RLY3I4Dpc/f3wm6xTLR1riK79dd070b0xnNQf0y
 aM6KUPE3KKsNW/WIHbwkDIUV8Ym8Bac1c1dxTw10rzLxZbS3P8ibgNPsZJKNPuDHNKPa
 XtckZr3Ht347w8SB1RwJbggxyoMvB/WxyZGGk+4e6N9ZIdf2JZni7OeKyg3j2Nc0XyBa
 xQg+5aXscVEl2oxKA+2vVa00QHYfFmVqKnw8ChvuGVSj+WowY+B7TxwmahXla5MU2VHE
 aOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NRHD8v+tRRUHCg4eVJNU2+6QjpHDHulBgn/4Ya8pJhM=;
 b=EEXiOyR99ON1VVJcxhz6JHBaPffRn1wnmFQ1z7L9YBp3drGjM4iQbjQPNHrvcqPtcb
 wlmoaHBdp8qJOytVHjXKXyIiqxd9btgT8TeQ5ZVfQfAaXdKuHYsgFpoOdbchBwCNgxSt
 Br2WdgZuHh06Xd3jHArUmlWWmgvU/BOfjyO5KPTiOT7AxFPeR7CktuhhT+HR9+TLeb86
 Nu6+7XtLG604nwbh6QXPLjVnpkcE9i627pZF/nd0gcJl7aJ8rrf3sC7WpSqi2vo2+5ZF
 2e/bpwzv4QjZYmA7HZasHPgbgGIWnrp64QSMnJprYVtfO+L9keyVsHYeetNt7eJ5BiCr
 CoNA==
X-Gm-Message-State: AOAM531yqbfz9WV3K43ZOeB4hAfRjcQ+pRrNFxu47pkZ2+htaI/3EfnF
 KhbFbnNzIW+Hm8u2Js8QkwAAnQ==
X-Google-Smtp-Source: ABdhPJx3c5+v5PHgltg8FiV34qsEJ3E0Bw5hri3ElAyjV5b9D6e7I/y3MxZ7ggfYBmxa7XokUXXLXg==
X-Received: by 2002:ad4:4752:: with SMTP id c18mr16053040qvx.96.1638488602916; 
 Thu, 02 Dec 2021 15:43:22 -0800 (PST)
Received: from ?IPV6:2804:431:c7cb:30f8:3030:59d3:d31c:ed39?
 ([2804:431:c7cb:30f8:3030:59d3:d31c:ed39])
 by smtp.gmail.com with ESMTPSA id o1sm998201qtw.1.2021.12.02.15.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 15:43:22 -0800 (PST)
Message-ID: <855a47d1-a89c-bbc8-7ddd-b89104c6138a@linaro.org>
Date: Thu, 2 Dec 2021 20:43:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: Rich Felker <dalias@libc.org>, Zack Weinberg <zack@owlfolio.org>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
 <20211202153422.GH7074@brightrain.aerifal.cx>
 <20211202232954.GI7074@brightrain.aerifal.cx>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
In-Reply-To: <20211202232954.GI7074@brightrain.aerifal.cx>
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



On 02/12/2021 20:29, Rich Felker wrote:
> On Thu, Dec 02, 2021 at 10:34:23AM -0500, Rich Felker wrote:
>> On Mon, Nov 22, 2021 at 10:19:59PM +0000, Zack Weinberg via Libc-alpha wrote:
>>> On Mon, Nov 22, 2021, at 4:43 PM, Cyril Hrubis wrote:
>>>> This changes the __u64 and __s64 in userspace on 64bit platforms from
>>>> long long (unsigned) int to just long (unsigned) int in order to match
>>>> the uint64_t and int64_t size in userspace.
>>> ....
>>>> +
>>>> +#include <asm/bitsperlong.h>
>>>> +
>>>>  /*
>>>> - * int-ll64 is used everywhere now.
>>>> + * int-ll64 is used everywhere in kernel now.
>>>>   */
>>>> -#include <asm-generic/int-ll64.h>
>>>> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)
>>>> +# include <asm-generic/int-l64.h>
>>>> +#else
>>>> +# include <asm-generic/int-ll64.h>
>>>> +#endif
>>>
>>> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
>>>
>>>  /*
>>> - * int-ll64 is used everywhere now.
>>> + * int-ll64 is used everywhere in kernel now.
>>> + * In user space match <stdint.h>.
>>>   */
>>> +#ifdef __KERNEL__
>>>  # include <asm-generic/int-ll64.h>
>>> +#elif __has_include (<bits/types.h>)
>>> +# include <bits/types.h>
>>> +typedef __int8_t __s8;
>>> +typedef __uint8_t __u8;
>>> +typedef __int16_t __s16;
>>> +typedef __uint16_t __u16;
>>> +typedef __int32_t __s32;
>>> +typedef __uint32_t __u32;
>>> +typedef __int64_t __s64;
>>> +typedef __uint64_t __u64;
>>> +#else
>>> +# include <stdint.h>
>>> +typedef int8_t __s8;
>>> +typedef uint8_t __u8;
>>> +typedef int16_t __s16;
>>> +typedef uint16_t __u16;
>>> +typedef int32_t __s32;
>>> +typedef uint32_t __u32;
>>> +typedef int64_t __s64;
>>> +typedef uint64_t __u64;
>>> +#endif
>>>
>>> The middle clause could be dropped if we are okay with all uapi
>>> headers potentially exposing the non-implementation-namespace names
>>> defined by <stdint.h>. I do not know what the musl libc equivalent
>>> of <bits/types.h> is.
>>
>> We (musl) don't have an equivalent header or __-prefixed versions of
>> these types.
>>
>> FWIW I don't think stdint.h exposes anything that would be problematic
>> alongside arbitrary use of kernel headers.
> 
> Also, per glibc's bits/types.h:
> 
> /*
>  * Never include this file directly; use <sys/types.h> instead.
>  */
> 
> it's not permitted (not supported usage) to #include <bits/types.h>.
> So I think the above patch is wrong for glibc too. As I understand it,
> this is general policy for bits/* -- they're only intended to work as
> included by the libc system headers, not directly by something else.

You are right, the idea is to allow glibc to create and remove internal headers.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
