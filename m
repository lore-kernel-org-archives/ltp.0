Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEB1C48297
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 09:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707469734; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=csxX//LgJ7BuvaKfbUC3c6R/SYQ6jzy8JihnbZBYUmQ=;
 b=Cy7D1cPgNNtNVNjOkw5vO2nSrs0U7Q/NvXABrIwgrqkTIuVCj8tcRmmpN9chwNQQc4w9o
 Z1000iHAIEHjT7vVLnpiWFCg2z6H6mRVG7j3pWr3FoiFVAZJXyiktFaM5KZ2Ajy/Ud71BE4
 Cn6cYLwa8+dzNRAdlBGzjLFFDsdSGvc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C513C84C3
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 10:08:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 551A03C84C3
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 10:08:33 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B1B260A787
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 10:08:32 +0100 (CET)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51032058f17so867143e87.3
 for <ltp@lists.linux.it>; Fri, 09 Feb 2024 01:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707469711; x=1708074511; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58HW2ZTjzzLiNzy6nuz98qahFCrOXWXWXW+3s64ijvA=;
 b=aksDEz7zyL9Bx23z/YMl05p13WcTVByODOZBtr2U0MEaNABIZOVKeIp60fpehVRxTb
 B9UmCpQb5UGKhpGoOvJUSFiRbUTI2jDA6CHRJl1e75c9oLD3AwmMgzx4MkS9eWnYs2E8
 Y/Nxn94Y3apftjabYL5Ixa7caH+3qwFuMCOA7szFmmNv5lNTpjcANX3UPgrKAgdDjfhY
 mhiBx9giNX3nDvDtYmSUOWkwPhTMF1jX/ltS2LSgw+pdW16fksm99MmDnG65ly3FB0gT
 3Hsd7KE+5zyg0GTFoutkab8Znx5Xg+ksRvs4YW0PL7M5gsrW7WjN1L+BnKkXZgVrkysO
 EhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469711; x=1708074511;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58HW2ZTjzzLiNzy6nuz98qahFCrOXWXWXW+3s64ijvA=;
 b=dKuzb9TnyJTqalycrUNWSZO8lHSZCrdRHoMYUNOvTtbov51YFKsHgfRqGCjSDw1O7S
 HtrD58MGGTSJLb3C8fUzRMnbCcjWMTnJ7jlD1rYfAraMZDi/y9rK/HkovEaaeEUR/yFv
 Jc4nZwMSPrDjPaSD8p3dr6bNPO+4t+sCjP/MRuasR9H653BpcL21vcgaknFRhge/3nMW
 geS2Yl3+ULrEtHY4aBg3AXcWekPMrDnoKN/AXwbu4Qba4E5PtClpQUrE0J031eVxcJ2I
 BQov0EdrSYJLYw3O0bLAvAHRxLY6fTrQXCdLEmz35PptSdSmR5RlJvubEPjU4XVKr7AB
 dMEw==
X-Gm-Message-State: AOJu0Yx0NjksLcuW5t2IUAwxN2YUe4sNP/SZVm67qXQzrGxmvDdmhqde
 TbMpAa+WkCc42Wtq7ges0X4BoettB0OSJYcQdeg10KNv6E0z/Hjc9Ve7MPXX+G85Zsa1VCLN65B
 a4q0=
X-Google-Smtp-Source: AGHT+IHJnGZZaeiG922fHyRnlIzPkiGCHjHXW5aYaBKrYOHEtLyp6bDDF+PDybUWKlZQgILoKlnxqg==
X-Received: by 2002:a19:7408:0:b0:511:3ed7:ca7c with SMTP id
 v8-20020a197408000000b005113ed7ca7cmr581979lfe.65.1707469710572; 
 Fri, 09 Feb 2024 01:08:30 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.29])
 by smtp.gmail.com with ESMTPSA id
 fm11-20020a05600c0c0b00b00410794ddfd6sm239089wmb.23.2024.02.09.01.08.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 01:08:30 -0800 (PST)
Message-ID: <22457a5f-586c-4aaf-bc61-0b18fe5f28db@suse.com>
Date: Fri, 9 Feb 2024 10:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20231203235117.29677-1-wegao@suse.com>
 <20240209012657.10797-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20240209012657.10797-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Futex_waitv: Convert 32bit timespec struct to
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
LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato.suse.com>

On 2/9/24 02:26, Wei Gao via ltp wrote:
> Futex_waitv can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> Detail info you can refer following email thread:
> https://lkml.org/lkml/2023/11/23/13
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/syscalls/futex/futex2test.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/futex/futex2test.h b/testcases/kernel/syscalls/futex/futex2test.h
> index ce97f47c1..a3cd0ef5c 100644
> --- a/testcases/kernel/syscalls/futex/futex2test.h
> +++ b/testcases/kernel/syscalls/futex/futex2test.h
> @@ -12,6 +12,14 @@
>   #include <stdint.h>
>   #include "lapi/syscalls.h"
>   #include "futextest.h"
> +#include "lapi/abisize.h"
> +
> +#ifdef TST_ABI32
> +struct timespec64 {
> +	int64_t tv_sec;
> +	int64_t tv_nsec;
> +};
> +#endif
>   
>   /**
>    * futex_waitv - Wait at multiple futexes, wake on any
> @@ -24,7 +32,16 @@ static inline int futex_waitv(volatile struct futex_waitv *waiters,
>   			      unsigned long nr_waiters, unsigned long flags,
>   			      struct timespec *timo, clockid_t clockid)
>   {
> +#ifdef TST_ABI32
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



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
