Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42332C433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 12:54:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCE4E3C908C
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 13:54:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E33443C6F5D
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 13:54:20 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46370601578
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 13:54:20 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id v11so5462789wrw.10
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=M29EUicDRNc21LwZ/GYwswFr7ylJnq6+9wpg0/9AZO8=;
 b=FoBKm5BewmXcIyykMn+POmO0ZC5EFzD8XchEJpxKnVGZ2xez9VQE5HVYHmiSZ4emck
 HSYQjT6j5IDy6Yn+HqwIUneNe/yO77iK/NDreBPXZ9Gyiy9+KIYc1j5cEz/eI1oqLM/N
 AlmPWLOjkuQYu2X166a/6/ogEOKOmVr3/Kx22zyvZ3g/8U4I/8ogDilbSmmI1sxXdXuC
 0+C9X4hLcowYS6GjBu8AC3Dm6sFjAcgA5ldagKmfHccg1nICX092yI5gJ2ArXSbCRL4L
 GD6u09FdZ9fYGrM1pkqLRqRG7SrQ6L6biQTJ1Lf5evjeKSfTEBcp2fZmyddLINY2JF7X
 FIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=M29EUicDRNc21LwZ/GYwswFr7ylJnq6+9wpg0/9AZO8=;
 b=PD/23N3cdzQwxHCjL2VfEYIsUYTACpZWgD1n9bjSZ7+FsX2i8mQQB0PJQU6EM7qXIg
 Cbp/am0QKOleo+hqkV2RCluytVBlgx4OSIQxtqxHcw7u5/POwQvxD9OyXhh4+IR5aGOm
 HHatvvx2wiQn0aENf9x7dm+B7EHtVOGmPfqf75AKYYleTCj6bC+IL7MpTRQpakvYcoeX
 Ogf43xEYoAMmAneq5VObHtwSYVURv/NMGrZdBNPjNBxUOjgfD24djvZNwtrtvDeNT+pC
 Os8V47W3PXpuEDJnATs3imVHB6Kfb8ZaB6sqGhn6D+OurGDXRch6jJE9jURcfpufkTpV
 uuvw==
X-Gm-Message-State: AOAM530LPY3lTR0G/AhVXjkNWSRK/1Nh6BVSr2wOkSgzGLDP9Y0gVLBk
 cMtJDk3PJGExv0xOhNuJzmM=
X-Google-Smtp-Source: ABdhPJxCcHfpP6/ls4pjRE3J3PBUm2yjHM3aCu1AlP68mHE7HmJUXTBzqWbgL9wMas377UObF7VxlQ==
X-Received: by 2002:a05:6000:cd:: with SMTP id
 q13mr21507618wrx.488.1638536059799; 
 Fri, 03 Dec 2021 04:54:19 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id m7sm2472292wml.38.2021.12.03.04.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 04:54:19 -0800 (PST)
Message-ID: <7d3c34ab-41c1-f9b7-43cc-21a18fa61c27@gmail.com>
Date: Fri, 3 Dec 2021 13:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Zack Weinberg <zack@owlfolio.org>, Rich Felker <dalias@libc.org>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
 <20211202153422.GH7074@brightrain.aerifal.cx>
 <20211202232954.GI7074@brightrain.aerifal.cx>
 <855a47d1-a89c-bbc8-7ddd-b89104c6138a@linaro.org>
 <9d24f699-386a-4881-b09a-ebd747310187@www.fastmail.com>
 <0864bd62-7a93-106d-8a36-23dd72a7ab58@linaro.org>
From: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <0864bd62-7a93-106d-8a36-23dd72a7ab58@linaro.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 12/3/21 13:32, Adhemerval Zanella via Libc-alpha wrote:
>>>>> We (musl) don't have an equivalent header or __-prefixed versions of
>>>>> these types.
>>>>>
>>>>> FWIW I don't think stdint.h exposes anything that would be problematic
>>>>> alongside arbitrary use of kernel headers.

>>>>
>>>> Also, per glibc's bits/types.h:
>>>>
>>>> /*
>>>>   * Never include this file directly; use <sys/types.h> instead.
>>>>   */
>>>>
>>>> it's not permitted (not supported usage) to #include <bits/types.h>.
>>>> So I think the above patch is wrong for glibc too. As I understand it,
>>>> this is general policy for bits/* -- they're only intended to work as
>>>> included by the libc system headers, not directly by something else.
>>>
>>> You are right, the idea is to allow glibc to create and remove internal headers.
>>
>> As a general rule yes, but we could make a deal that some specific bits headers are permanent API for use by things like this. They probably should be less of a dumping ground than bits/types.h though.
> 
> I really don't think adding such constraints really would improve the project
> in long term, we already have issues about the need to support some internal
> symbols that were exported by accident.
> 

I think there are a few headers that should be safe to include from the 
kernel.

Could anyone foresee any problem that could arise by including any of 
the following headers in kernel code?:

<stdint.h>
<stddef.h>

They are the intended interface, and they only provide macros and types 
but not functions, and there should be no need to require libcs to 
define another identical stable interface.  If there's an existing 
program that would break by including any of those in uapi headers, I'm 
curious to see that program.

Of course, the kernel already defined some of the macros defined there, 
but the solution would be easy:  remove the redefinitions, since they 
should be defined to equivalent code (e.g., offsetof(), NULL; although 
these are from <stddef.h>, which for this change would be unnecessary, 
but if <stdint.h> can be used within the kernel, a next step could be to 
rely on libc <stddef.h>)

Thanks,
Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
