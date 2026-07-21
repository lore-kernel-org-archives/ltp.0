Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7FCC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 07:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBE9F3E6256
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 09:55:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE9B33CEF3D
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:54:46 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C7E31000224
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:54:46 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ccdb73f0e1so70680095ad.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784620485; x=1785225285; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UBVqCu8+eUpp4KtzYzYnQvEXQIPiyRor2SsY16ekbuY=;
 b=LUzmUChaq9vrg2Ui2+7AUgUPs2B8UoXJUYvn2MBkdiX9kaOxJ02L02AopEXjWah5ua
 al3xLK5knJPJIhaAPS6c7zxF1hIOevzMrrpso/5Yio8AELXX3LpiKCYyGLFkKPxKnSi3
 Pf2F83XgV4kWgxNA1Xd25IeUGEWsJ7lnpZz2L5jctrPdXCc9L4lcoGSCf01JS16jzspg
 SzgZZT0a9ohBMy+dUZNLn68ulENJMW0n1+b0RKr4Dj4xUC8Sd5mNw6VpwFW1VAYYfZvl
 rsE67wDY1iJVuzUjSR5q7AJhXbOC4ozSet3IW6zDojL1eTtBccmvbuTKLfDlAUjvQDQA
 O/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620485; x=1785225285;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UBVqCu8+eUpp4KtzYzYnQvEXQIPiyRor2SsY16ekbuY=;
 b=fk0RKWd9mZBw3Ad+Ig+GQ/ABZBOTV8pM/gIFOAG4g8sXose9K9g1XyI6XLh1NsmwJU
 KihYfMKPLHYnptBH4iwOLG6Hh0XOmuSa7qXF1dLT8JWyH7C95A2l3qusAbQ5cocLvdjn
 XxnnCz09RCUNAdvYa2AyIH1WnbQm+SemjmHSogLSv8nJ8yGTpl17L+TQG/qSiAP4wErY
 ee8lNJnjUXyZnBt5WWc5DwQJ3CfkawjMkCEYgpLus08olWeHkh920LKz9QUjVW4bzkBa
 xCnoqp54MRQ7WTxv/t+NQ6NlUr0yx6T9rsUDTjfaxvpZ5V5StPaOT7zNRfxxazuH3DA4
 T7cA==
X-Gm-Message-State: AOJu0YxoxODQouZkTI3sUv6cbrQNlvJr/+mi7fgYSXWLlW2D5qxJwTgN
 C1kUbcpRsWNqv/B2gPvIH0T8W6UXuNDfrjrf/SzzEg6C01C1lvcnZZnM
X-Gm-Gg: AR+sD12XaOvDd5yy7KXixWYJ4XpcwGEx6k2FeoggRnTJ9sKJiSM5jT+YpWaomIxW3n5
 nvt/Xcfz87vtcpFe+29810kGzO/4qArDKkZKlfAycGoFjkd5OhqQXUw94984QIILWjLVTa1xmu3
 PcYq5iCOf2H1ADaZwuMDcwX+H6DNgmYFuBHv3Qb4Q/ad3QpI4uDf09viQmwGWwlcE0gzLiUbvw5
 Vmb0x3gN/KFOhzu3zk6XZQ2OkYEc3Ha6vB0YngPHNvV51bx5aLqywRdxokS8ITj4/Y5VrZCO1oP
 RCvrd9d12Dfef47W2d5jneqA377UgyTRXDuVyBHFt/FgKFX7EQehjnqFtvbGjMzhSgWxyVc45lj
 tjDq49m+zUwBeYeoFS7Fn5EEcT0nV8a0NpZ7kWLLqGlUvkhsppu9tVixlwpH7zz+/t5ACnxKqkl
 ZPcJ+3evU8pZyyY4FG2ZmY
X-Received: by 2002:a17:903:1a43:b0:2cc:aa36:c04c with SMTP id
 d9443c01a7336-2cf348368abmr199767395ad.1.1784620484512; 
 Tue, 21 Jul 2026 00:54:44 -0700 (PDT)
Received: from [10.22.68.161] ([122.11.166.8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf346da071sm70889135ad.47.2026.07.21.00.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:54:44 -0700 (PDT)
Message-ID: <a9a318e1-a9e3-4683-8d18-bae45f048c45@gmail.com>
Date: Tue, 21 Jul 2026 15:54:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Yizhou <yizhou.tang@shopee.com>, Martin Doucha <mdoucha@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260714111307.166205-1-yizhou.tang@shopee.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260714111307.166205-1-yizhou.tang@shopee.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open03: Track SUnreclaim growth
 instead of MemAvailable
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 14/7/26 7:13 pm, Tang Yizhou via ltp wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> CVE-2020-25704 leaks a small kmalloc() allocation (the filter's file
> name string) on every failed PERF_EVENT_IOC_SET_FILTER call. The test
> detected this by watching MemAvailable in /proc/meminfo drop by more
> than 100MB over 12M iterations.
> 
> MemAvailable is a global, system-wide estimate. It is heavily influenced
> by other memory activities of unrelated processes. This produces
> intermittent false positives: the test passes when run alone but
> occasionally fails when run with other tasks.
> 
> An improvement is to track the growth of SUnreclaim instead. It is less
> sensitive to other kinds of memory activities.
> 
> Also note in the failure output that unreclaimable slab can still grow
> due to unrelated slab activities, so a failure should be confirmed on an
> idle system or with kmemleak before being treated as a regression.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>  .../perf_event_open/perf_event_open03.c       | 32 ++++++++++++-------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> index 389cc3511..0cc1c27f0 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> @@ -77,13 +77,13 @@ static void check_progress(int i)
>  
>  static void run(void)
>  {
> -	long diff, diff_total, mem_avail, mem_avail_prev;
> +	long diff, diff_total, slab, slab_prev;
>  	int i, sample;
>  
>  	sample = 0;
>  	diff_total = 0;
>  
> -	mem_avail_prev = SAFE_READ_MEMINFO("MemAvailable:");
> +	slab_prev = SAFE_READ_MEMINFO("SUnreclaim:");
>  	tst_timer_start(CLOCK_MONOTONIC);
>  
>  	/* leak about 100MB of RAM */
> @@ -92,28 +92,36 @@ static void run(void)
>  		check_progress(i);
>  
>  		/*
> -		 * Every 1200000 iterations, calculate the difference in memory
> -		 * availability. If the difference is greater than 20 * 1024 (20MB),
> -		 * increment the sample counter and log the event.
> +		 * Every 1200000 iterations, calculate how much the unreclaimable
> +		 * slab has grown. If the increase is greater than 20 * 1024
> +		 * (20MB), increment the sample counter and log the event.
>  		 */
>  		if ((i % 1200000) == 0) {
> -			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
> -			diff = mem_avail_prev - mem_avail;
> +			slab = SAFE_READ_MEMINFO("SUnreclaim:");
> +			diff = slab - slab_prev;
>  			diff_total += diff;
>  
>  			if (diff > 20 * 1024) {
>  				sample++;
> -				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
> +				tst_res(TINFO, "SUnreclaim increased by %ld kB at iteration %d", diff, i);
>  			}
>  
> -			mem_avail_prev = mem_avail;
> +			slab_prev = slab;
>  		}
>  	}
>  
> -	if ((sample > 5) || (diff_total > 100 * 1024))
> -		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
> -	else
> +	if ((sample > 5) || (diff_total > 100 * 1024)) {
> +		tst_res(TFAIL,
> +			"Likely kernel memory leak detected, SUnreclaim increased by %ld kB total",
> +			diff_total);
> +		tst_res(TINFO,
> +			"Unreclaimable slab can also grow due to memory activity from "
> +			"any other unrelated process. If this test fails, re-run it on "
> +			"an otherwise idle system and/or confirm with kmemleak "
> +			"(CONFIG_DEBUG_KMEMLEAK) before treating it as a real regression.");
> +	} else {
>  		tst_res(TPASS, "No memory leak found");
> +	}
>  }
>  
>  static void cleanup(void)

Gentle ping...

-- 
Best Regards,
Yi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
