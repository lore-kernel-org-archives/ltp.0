Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54775C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 18:17:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C8BF3C8D7C
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 19:17:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B937B3C8982
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 17:51:17 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A0A71000F26
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 17:51:17 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id d5so33944945wrc.1
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:reply-to:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=APE9ce1oamnPdQjXEcMukuKqcJOxL3i0qU2D/3ee32Y=;
 b=VZFBq1ErQERStcDQb/RfavsYGCXwgxmYoWSKcpcMPPSv1L6iDHUHXmjGL+ALaUajIc
 zyvnV0494M2isgnA1IWQ9p4TpjnufkRB4TnCGAevuvWuJxZOvBxvvZF0DodYXM9AvYlE
 mA05DPwpbdtyTjgGzBD/ky5Sct5ZRUlfUAsMLrETcxnP535JdTB5b9z+1HpKo1kssz/m
 xJ/ulE3KEjLbvZxiGiwdvpNv6Osz9elXtH65e9NAdsGhs5wy8n+32WDqj34AI5jhLrzI
 Rpt+Hkz/TNi4NpVugyCsu5f0ASPSqIjigtHEYEypxxGKRLIrnwpDXVMKd/u+WaV1i6X0
 NCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
 :subject:content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=APE9ce1oamnPdQjXEcMukuKqcJOxL3i0qU2D/3ee32Y=;
 b=am2rGk0wKFuABE6qok1T+UKSN3oAF3Dj8p8AQrS8Xjsb5/v/MV8iX2kU4OyAEiJxx3
 reopwH6vGH9ezz3ZSuOTLeagDsBC3OZUeXCdZKb9hVLcG8cvgMMQrpgdG98INXzFWoXe
 GUQUxXoQ8tRNsTz2yynP4nIG6Q0iL2+w4dDUR4AkzOzB6YYTvQ7FHixQUmBBMcB5Se7/
 0JVnh8j+Y1kKkihUHiMXZVZ/gr7OQG8LpDZ+Eu7A/tPSK8Qko9u2X9yo4uPakud+vClH
 DLJOdp21SBsWDC6cmaN+WvsOb1HI/GJjIXIUdytTf9FQ3B42XUug3lNVvjlzy/Zz0GUC
 itaQ==
X-Gm-Message-State: AOAM532y1Xhy0YCeeodrXLeVvNCoMH0Zm4C/R4xfEdubPv1OLtiR7Zby
 MdDTttNfhOgWzqpnvYOKWzg=
X-Google-Smtp-Source: ABdhPJwiCdHnVEJcvSR3PYQyyVUEvELVqDkgOhTYvCGt/mA5mTfb+wjYeTcjhlkJLajz8I2ECfSaLg==
X-Received: by 2002:a05:6000:1a88:: with SMTP id
 f8mr39590723wry.54.1637599876815; 
 Mon, 22 Nov 2021 08:51:16 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id o25sm10501981wms.17.2021.11.22.08.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 08:51:16 -0800 (PST)
Message-ID: <8dfbe1be-0b4d-cdda-2c71-7a098faf07da@gmail.com>
Date: Mon, 22 Nov 2021 17:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, linux-kernel@vger.kernel.org
References: <YZvIlz7J6vOEY+Xu@yuki>
From: "Alejandro Colomar (mailing lists)" <alx.mailinglists@gmail.com>
In-Reply-To: <YZvIlz7J6vOEY+Xu@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 22 Nov 2021 19:17:19 +0100
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
Reply-To: alx.manpages@gmail.com
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 11/22/21 17:43, Cyril Hrubis wrote:
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace.
> 
> This allows us to use the kernel structure definitions in userspace. For
> example we can use PRIu64 and PRId64 modifiers in printf() to print
> structure members. Morever with this there would be no need to redefine
> these structures in libc implementations as it is done now.
> 
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
> 
> 	printf("%" PRIu64 "\n", stx.stx_size);
> 
> We get:
> 
> 	warning: format '%lu' expects argument of type 'long unsigned int',
> 	         but argument 5 has type '__u64' {aka 'long long unsigned int'}
> 
> After this patch the types match and no warnings are generated.
This would make it even easier to ignore the existence of different 
kernel types, and let userspace use standard types.

Related recent discussion:
<https://lore.kernel.org/linux-man/20210423230609.13519-1-alx.manpages@gmail.com/>

> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Acked-by: Alejandro Colomar <alx.manpages@gmail.com>

Thanks,
Alex

> ---
>   include/uapi/asm-generic/types.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
> index dfaa50d99d8f..ae748a3678a4 100644
> --- a/include/uapi/asm-generic/types.h
> +++ b/include/uapi/asm-generic/types.h
> @@ -1,9 +1,16 @@
>   /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>   #ifndef _ASM_GENERIC_TYPES_H
>   #define _ASM_GENERIC_TYPES_H
> +
> +#include <asm/bitsperlong.h>
> +
>   /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
>    */
> -#include <asm-generic/int-ll64.h>
> +#if __BITS_PER_LONG == 64 && !defined(__KERNEL__)

BTW, C2X adds LONG_WIDTH in <limits.h> (and in general TYPE_WIDTH) to 
get the bits of a long.

> +# include <asm-generic/int-l64.h>
> +#else
> +# include <asm-generic/int-ll64.h>
> +#endif
>   
>   #endif /* _ASM_GENERIC_TYPES_H */
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
