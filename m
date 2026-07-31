Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6198CC55173
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 18:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75CD33E9138
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 20:16:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 646163E2A65
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 20:16:05 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2B541A0042C
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 20:16:04 +0200 (CEST)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so804399a12.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785521763; x=1786126563; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hz49WiYWap8svVpVzulE5f4+1HuWq6oGQ+OERHfZlvA=;
 b=AM6VXb5iWiaU7dju1nRpAaiVH19SfztIMyTHSO5C0fht5xvVWJjrLKtdUc4FIhFfiJ
 HuGe7ZGtVDQCEkRQJ7TXpKsk+keSE+yC2MLW4l59aln12mgsLKpR/RwXwmgkB0wY4pFh
 QFq32lG/nowowR+N1sbBtpp0gl9/DB82i20oiQ1vQqW4to9qA27ra4f9u4Awwajwl2yr
 568YvtSAUBxndogMJjg51MC+nF1rdsD6CfwWDFDDBS1dErQtGS60K3xwVKJusfqOxYdw
 IleP2SUMwQlhY6+J5m9y3EzHJaGn3XwUQ5z9XtdsvHV+p5wo/1hR/DSCC8JR8eUZ3KQm
 sboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785521763; x=1786126563;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hz49WiYWap8svVpVzulE5f4+1HuWq6oGQ+OERHfZlvA=;
 b=pQK3gOFn2CJ1NmWnNDlukDSsfIoSvZN9r64wPaCW0TpwQVatkJuQNC87kAnL0urFcW
 eP4EybwnZ32kHnGICnFwOeUHK0IGG0cq/Y8EQaLHADkcAsFD4xFlkQbPWtKtvdHRwXHp
 MRfR+BUYx2L9WOvdrudPZHWp88aNrBbdQ4JHGtkVpNwJCnPGp3VAMStSqtqrJcxluQSu
 LQSqQFmAdQ1AWDUS+iTFsU5ZqWGk8nx+vU4axycJkHR9zIRyXjibc2zvwf79aHIp4P5p
 oJb9+SfS2QwNhzi3IXBOAI29kkLwi4szRnKhNZ4CKyU9S4tLMbLQbdgWDiYYrJRnToh6
 7wiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFJ3upygIkHG3fUGfVQcWkJrETsnT89AWWWTDTckcTyCfrzzThxDzBJGaFC1DMNwUXamI=@lists.linux.it
X-Gm-Message-State: AOJu0YwQ96yq7ktrm3KIZotgGADWMM6CxkorK18VtySvKkLAZSnbC60O
 f6uwkRJuNI6LDkzRm9YfcrHJGoI5nniDAW+zHmmWwKPrYlXRLHRIpgyt
X-Gm-Gg: AR+sD10LtsA5wtGDirtd9BiQx3R6p0Oe6gfQAVwfnl2Bh/9umnrhM6KAuovz0W6Y8AA
 0YCVa5Wxxa2I1AbiIrapMB+nT4/eGhNDOVLPoUqA9EjcEV0RirJYYsqvpzilsbW9sq8SOoVFJvS
 BDeJu0gBzhCMwiCxEWjRYmpux+6zyQHwqLLsbkD7ZZe3Wy3XKLRapZ0qjuwcwvTqt0C55XOOhPf
 90d6515qhBJa6wDYZusvL8BaQeD24EL/+ptAXp4lfkRbjVLW6TFUuTrhZegidmoUwVcAUa1czNo
 gEbQiQ33t3DLGWYY1G3I6j8+vqu92/U1rX3eVPuowxLzg8mSSDUSI5+kjqVtQQ6cCfcOJQfmB5h
 oTzGxjC3+mlir+J9KHhVNORzkNRcdxF/fvufKRlDW4uvFRtgn1eZ+Chrq24vhoy7grepuraIh3c
 EYCTPvxtbRzcOGhG357Xb8UviBe5oKrB64RpwpJxZC0hqkNJNyx7mcUFaxTOJrX5LhBvZhCfkDV
 pfBTgXZKLNEj2/k3n8bewBuPFucHOO9AWBTxSWIYk/Qtm1ibs2EmhfjgzTzkIC8cGhS
X-Received: by 2002:a05:6a21:4c06:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c91a9e1746mr3110909637.34.1785521763064; 
 Fri, 31 Jul 2026 11:16:03 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:f2:8f2c:d78f:adf4?
 ([2400:79e0:1203:64b0:f2:8f2c:d78f:adf4])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd9c93dsm8597394eec.8.2026.07.31.11.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 11:16:02 -0700 (PDT)
Message-ID: <ec11bd37-d1e9-4433-86e3-202290e3b04f@gmail.com>
Date: Sat, 1 Aug 2026 02:15:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Yizhou <yizhou.tang@shopee.com>, Martin Doucha <mdoucha@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260722054125.197919-1-yizhou.tang@shopee.com>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260722054125.197919-1-yizhou.tang@shopee.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

Hi, just checking. Would this patch be ready to merge?

-- 
Best Regards,
Yi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
