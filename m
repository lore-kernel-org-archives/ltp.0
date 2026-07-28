Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75DC531F9
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 04:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8C63E756E
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 06:01:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46ADD3E74A8
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:00:51 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C46FA200766
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:00:50 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so43111365ad.1
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 21:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785211249; x=1785816049; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2IWSeywazGX3nlJzqwrs2BS+R8eUImIo5+343HfEXgM=;
 b=k/JFbDpLXMiofh0X2nbUS+rBqLNsqpROVGD7wX9xfao//andx3qBLd134tF2Ug2oss
 nctU/RHczWIMzOik4U64MiZs+K1ux+1iN4/atJB021kJ3QZybtk5hsiYrUQIoVqOx4Un
 M3VDy9lruDYGzOOkSsBd6coBYE2d3K7ggkpXPlLJvsClYkeYvvy2AcP7cxCfVZSKOsfa
 j5HYYEZghj+bwkv9qrtRAwDHz9SyNFkftqQmTmVDrNPiR2XkmT2nUx/CzTCLixnmimyS
 wCjI7+ybLa0Zm15B+8RgO6TDcgABCetb3i0+l2XvzXsqgU+n4PMKsRmDNfLpxqphpxYA
 Ke2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785211249; x=1785816049;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IWSeywazGX3nlJzqwrs2BS+R8eUImIo5+343HfEXgM=;
 b=dZdJbA9abvKX4G+jj6zHupE1o0phUpLdHpnzcCPFMy6ECc9+Z42USXufahXl+WPxMd
 WrUVtV/lAtmBforGRXyTb0yberlh12xS+bvt8DnR4RQYz+J0RboD7Gm9sYbPecJtQ2Mm
 P/jePVdhhgtJ0RslZiQ9TgehAicl9dmqUk/2ltvt/CBw/m7gCn//ON5ntvLcqcMFE6DB
 ZuQSpcxHnIgmz00JjcR9zQXR16zsPh3XMU3NrAU1ox2jfR3yqyKZspIjP5cWrZW3Oes7
 yxjtgiGUEARt4I6rEzm+bb26uAtxDhVdVvMR4RN4vGJGXZDdumkenWc8RMQGGzFJrhlS
 gLPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqw+nggnLx0cehYQBXdnF/nlVnO8BSYXdjgL+ZezNsuwP+jSRjPxxQShOkq3k3FTkaC7YI=@lists.linux.it
X-Gm-Message-State: AOJu0YxVNwB2BfyiR5MY4IGL/6NnWunDBwmlHDq0aYUP0xEPdQalMVqx
 bTFlaHEriTFViBZuZOIeXakkRtfMdzKgppNqD0cBVbznRAxockcISPZD
X-Gm-Gg: AR+sD12DZEIkK4XFZhlukpoyCXYxl1iF0sHVo1fNjcqEK9GGF5fCYX9rKX8TTj2OY0i
 Y5mx0KKdLGqtZC4aMcCkjoAyvUzgtexFAVep6QER6B+EaFIhO+aaD15EVtVf1Hg1GG1rq5GuqyD
 K2ectEGBGCTfihpt91Z2qfGgEZzuxfdW222Zb02NbngcDrn5a9jzltOYbMcvRkNVYy0VFvDEK6s
 zp3YkdJWQcl5nS8PDjcg4gdg5GLCdSQ36MkZM1X+taYliEbxRjFW3qKJ2DycLWruEChisH+V2mJ
 KYw2iv3eKDK3b8bepTPP8kwSHIMfErN+dalDEs9siC0X3Xp22Vk38akzCboxgNNAxXLSE17koZ6
 xznBU7unxihvNpRygrXpzaAq3qigZOIwUKIzK+NIrtQH6k1D0pZhFB04jy+4zCmfzexZEvWsK5c
 0C+C9DWAMtjsIQHu9iHrLlC0LeqGnW
X-Received: by 2002:a17:902:fda5:b0:2ce:faa6:7cbb with SMTP id
 d9443c01a7336-2d015c9241amr9001835ad.4.1785211248857; 
 Mon, 27 Jul 2026 21:00:48 -0700 (PDT)
Received: from [10.22.69.1] ([122.11.166.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde5e3a55sm45090345ad.28.2026.07.27.21.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 21:00:48 -0700 (PDT)
Message-ID: <44dc40d3-c0a5-4ed5-bd9f-9911df65cd1f@gmail.com>
Date: Tue, 28 Jul 2026 12:00:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Yizhou <yizhou.tang@shopee.com>, Martin Doucha <mdoucha@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260722054125.197919-1-yizhou.tang@shopee.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260722054125.197919-1-yizhou.tang@shopee.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] perf_event_open03: Track SUnreclaim growth
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
Cc: Vlastimil Babka <vbabka@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 22/7/26 1:41 pm, Tang Yizhou via ltp wrote:
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
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
> v2:
> Take Vlastimil and Cyril's reviewed-by tag.
> Update the printed error message.
> 
>  .../perf_event_open/perf_event_open03.c       | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> index 389cc35111b4..a4ce6eaffc02 100644
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
> @@ -92,28 +92,34 @@ static void run(void)
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
> +			"Unreclaimable slab can also grow due to unrelated reasons as well. "
> +			"You can rerun the test with CONFIG_DEBUG_KMEMLEAK to make sure the leak is real");
> +	} else {
>  		tst_res(TPASS, "No memory leak found");
> +	}
>  }
>  
>  static void cleanup(void)

Gentle ping.

-- 
Best Regards,
Yi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
