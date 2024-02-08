Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F748C48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707396662; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=HIQVm0kAbAmNqqeJ35cPeJPsE+KHOY7ld6yKPF5Flug=;
 b=NR+6pcU0L7XBN6E1+3diWAveoApsUIjDvVmwABTZuWihVNuV++Xxu6sVwJtcduUpNLHtO
 m21LcnPKkTEqAe0cxQRVvsrJp3GineCHSH0PYJe23eUb69ly3nmt6ezygLs543DVbs1KGqY
 fKc5Ht7ZbjaZf3cXtD1NHU6FWsx5rAo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 368FD3CF52F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 13:51:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5087E3CB3D1
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 13:50:38 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9D4161A0153E
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 13:50:37 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40fe3141e1cso16777865e9.0
 for <ltp@lists.linux.it>; Thu, 08 Feb 2024 04:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707396636; x=1708001436; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=stFcSwier1X9cBCgFEPQUOWUmu3jcWhEtAg9AverP84=;
 b=IHIbDcayw4DZ52EZXilQ1M7XzxoZcMeuI2Tl8+MyZypL4CfFBrJRvBle9W5O6rWZbP
 Ks5S2bWBisdDqNk6IMduLNp80fjmNUa6OToGT4uGfIsNrjmpgR1veoEAya71LIK5L7bM
 MBgt/YkjVLFkuqteuWG9U15xQnchn7exh+VhiVvLgTfFNe0hUxwxzNPZzu2cR+YTGLs/
 Oi72wZ8uWj+YhJeEOMJ+eGkReef4AG5q/+iZavSL0q2a+HkzWnaKPOnHCYZXcCzmwdzk
 eAefkHBVpysw34nzI4mCV+gNrmy5gc4gxrQYFFwzSX+0ef9XllsIKijVpkd286uGKuLN
 ByPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707396636; x=1708001436;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stFcSwier1X9cBCgFEPQUOWUmu3jcWhEtAg9AverP84=;
 b=NraPoVUrXHlpvDcLLNL3volLr3CA8oG0bSfMclVM6JkBIEvxfLpkS/R4NHGTRY8FD/
 uEh0BgV2Jz0l9dpoWy40i6iKWLaRCOsKCcoRqYot/uK5a1W2wTgDDfHSVzNLsDOIb6Y1
 yngcVGPBNi1BTO66Lel4URLaGYrz+AH7z7MxjRMs4Oho7N0MX7czy7YYM8yrIoKpqNkQ
 ig5KWiRSnlcaw2eRLmUabM5aoj8ls5UOJJ3FOrkwKRaxHOj0GZN1Bv7dL9IMACXizTG/
 x2wG98fRNf/iIZ2h7cnZql11otJdO9mboG0lUUpzNoFwLNUkJ1xiujE9wen3itwOSXbI
 1Elw==
X-Gm-Message-State: AOJu0YwF9P5B/qSZnVgnhGNDM2I40k4ZP4vzr1UaxWKS2yUxmdlxyWQg
 bKDm4ez8aM3PAthMNYJTRV+Yf4HpSQsZSDKApRiXXP17v4jKRtQB4GUkQGsNQimO5QTsXdoZlA3
 LS00=
X-Google-Smtp-Source: AGHT+IFZqkXBk+LtSBf6zcCtYlS9Ub9DnfpXV9sc4K3g4LwqN3niJKO1iMYmrhfcEbPuJc7Ur8og/Q==
X-Received: by 2002:a05:600c:5119:b0:40e:f1f4:89cc with SMTP id
 o25-20020a05600c511900b0040ef1f489ccmr6149212wms.25.1707396636183; 
 Thu, 08 Feb 2024 04:50:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUI8dGCeG1Yxwq2Oe2pdipOjuBufjAZlTJhtiuXDURop3mIzeTk/eftMJ0LFnMGBQVCVtLYTNECi6Acz2CsBA==
Received: from [10.232.133.56] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 m33-20020a05600c3b2100b004100826da82sm1543280wms.21.2024.02.08.04.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 04:50:35 -0800 (PST)
Message-ID: <36788164-e660-46ed-9828-743fd2c69663@suse.com>
Date: Thu, 8 Feb 2024 13:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it, Wei Gao <wegao@suse.com>
References: <20231203235117.29677-1-wegao@suse.com>
In-Reply-To: <20231203235117.29677-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Futex_waitv: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
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

Hi!

On 12/4/23 00:51, Wei Gao via ltp wrote:
> Futex_waitv can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> Detail info you can refer following email thread:
> https://lkml.org/lkml/2023/11/23/13
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/syscalls/futex/futex2test.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
> index ce97f47c1..f9a031e11 100644
> --- a/testcases/kernel/syscalls/futex/futex2test.h
> +++ b/testcases/kernel/syscalls/futex/futex2test.h
> @@ -13,6 +13,13 @@
>   #include "lapi/syscalls.h"
>   #include "futextest.h"
>   
> +#if !defined(__LP64__)
Here you can use "lapi/abisize.h" header. The TST_ABI32 definition is 
provided when we are running on a 32-bits system.
> +struct timespec64 {
> +	int64_t tv_sec;
> +	int64_t tv_nsec;
> +};
> +#endif
> +
>   /**
>    * futex_waitv - Wait at multiple futexes, wake on any
>    * @waiters:    Array of waiters
> @@ -24,7 +31,16 @@ static inline int futex_waitv(volatile struct futex_waitv *waiters,
>   			      unsigned long nr_waiters, unsigned long flags,
>   			      struct timespec *timo, clockid_t clockid)
>   {
> +#if !defined(__LP64__)
> +	struct timespec64 timo64 = {0};
> +
> +	timo64.tv_sec = timo->tv_sec;
> +	timo64.tv_nsec = timo->tv_nsec;
> +	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
> +#else
>   	return tst_syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> +
> +#endif
>   }
>   
>   #endif /* _FUTEX2TEST_H */

Regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
