Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02E9C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740744294; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=oln5JfuuWhAx5kkdaT8YtzKs/31igKKhrcAFekhLr9g=;
 b=h1kSHrQQGzEKGykCj/z4hkBFOva7UKIExFQejH3YDOFUJHGZcOECGnnbRcK+9695y8/gu
 5Ooz+XIbp8kNTsiaSOObdrUI2ip1MVZ1ZRANPrPVfWA6wgGi2a0dOHei8ZbohNSZCIWDeDh
 hWq3CrSE2zdjKPPimkjTKeUxhx+BQB8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9A553C9E1C
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 13:04:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510BC3C268C
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:04:34 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71769610874
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 13:04:33 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-439a331d981so18729815e9.3
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740744273; x=1741349073; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OpYnV/ZU/Bwn+2gc20NBKNvm2kMCLQapqmPlkMVJPAU=;
 b=JNzntrmdtKa1F/IvrZr3v6ZN+vy1+MlyTfohlNGk6+Nuh0iTB8bRHbvLDzVMC+u+T+
 kBAg/aziXLViT4GQy7Z93aeLdZdzUJNtbc9B791cSXsTR0pzHopnO3akGtzwC9Ryn8Z1
 yvg+UZnybpq4vh8ZiCGRK7DHPzZQIcoJx/E1+3/GeoGx9RrCjsHcl4ngngOXudKnb5xk
 cAWNeBcHipPMo2QaRhVI0/TB0PJnO38m1HfDhH4KtGYCjP4aySP9Ez/Q3E/huOtGye5R
 ViHUjtj5QndnpaEIGosJ3Vvt0SB/csA8Xz273fNpip3JnltDxzJrWUUXYes8Wp8JarO1
 Iqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740744273; x=1741349073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OpYnV/ZU/Bwn+2gc20NBKNvm2kMCLQapqmPlkMVJPAU=;
 b=fM483hpRlZJXMRyDwvq47onlj4+t6sPSD18jQHxLpyaG8jsRtTrAJG+JRM6MszA/Sf
 YtXyrBiex438O2Dyqa4iZEKmLptO99K849My2lb40wUqiPX30HSOSSGcu7P7eyBxVszK
 Py4GYWJ/ird6L0AKLp5MZpdk5VLmc0w7MMEVpSiC2u72uFodz7F1zMM9eQ70w+rt9EG5
 JIB/ZtaZTk0zOGpFpHLQ04rMGpT/cBJFRRddyA610AnOfoUymmDIrN1j13LO3geE6hJB
 9reHlPPe6RgW1n3jO0gKttLdI+WypBnvrXZBZCKuo6V1TVvGpefT7rmld/35xmJ30JdE
 LtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuxLYB3bljAe6joNo34Lao7msbnrbRcBLHsLb+QYDFwVfqoa6Lc/v3V37DWhdKf/zZcQI=@lists.linux.it
X-Gm-Message-State: AOJu0Yzcj4DzBnMDSXPWnA8ThC8h4mi4tkXQ4deye8vmP12WkKAzOZE5
 ZQ/BVbzJzMI8rZ2ckGyyhLKm1WS74Qb25PoanbnxOmeOczjJEACtQDWG6FTEupo=
X-Gm-Gg: ASbGnct49FYpJfGpF7C5Gp1eURXU7w+xnUnjAgJINTb8M7LtP9O8TiHAX7+v0JfZZJl
 dr5OmnN9NcBhw/g/gFVHhvi61L/4QbrJDMxYJ/wtpgbkFqd6lKyuskvu/ByFBgOQj3boVl2pSwy
 zYMHW34Dk3fYoHSYLAuDriWE3f+SaKkjqtNedv7Cg73/5po2UydXATOhQrATGW0VVWUILSw6ins
 DwnceKbLGWpIVmEeHYF0gtMJLz3W5zf2Yk6u319eFjzDIouTGawCziGs2VufSkO2tGrd3o+8mUw
 cd1+OTRcvczsKoTTS0NXCxxFzBfh5r6nZiE=
X-Google-Smtp-Source: AGHT+IEicKN8BOp5pj+25LFfICilwauZZVN3ggURjlZ+LhZBUKWwosCNNkGuterVV/nN6vzDoZwNDg==
X-Received: by 2002:a05:600c:3c84:b0:439:8ada:e3b0 with SMTP id
 5b1f17b1804b1-43ba697f093mr22300075e9.19.1740744272626; 
 Fri, 28 Feb 2025 04:04:32 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73717230sm53310245e9.19.2025.02.28.04.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 04:04:32 -0800 (PST)
Message-ID: <309b1ba7-9a22-4173-92a8-96ee12219f5b@suse.com>
Date: Fri, 28 Feb 2025 13:04:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
Content-Language: en-US
In-Reply-To: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix memory leak
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
Cc: liwan@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

This test is a thing :-) Thanks for fixing it.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/18/25 14:54, Jan Stancek wrote:
> setup_shared_mem() currently runs as part of run() function,
> and if it runs for too many iterations it can consume so much
> memory that OOM kills it.
>
> Move setup_shared_mem() along with the 2 checks for io_iter and
> num_threads to setup(). This way it runs only once and gets
> freed on test exit.
>
> As consequence setup_ious() also needs to be modified to no longer
> modify global variable 'aligned_buffer', because we don't re-initialize
> it on every iteration.
>
> And finally, at the end of run() function free also memory allocated
> by setup_ious().
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/io/ltp-aiodio/aio-stress.c | 45 ++++++++++++---------
>   1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index 469769d5a1f4..5cce92dfa44c 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -914,14 +914,15 @@ static void setup_ious(struct thread_info *t, int num_files, int depth, int recl
>   {
>   	int i;
>   	size_t bytes = num_files * depth * sizeof(*t->ios);
> +	char *buffer = aligned_buffer;
>   
>   	t->ios = SAFE_MALLOC(bytes);
>   
>   	memset(t->ios, 0, bytes);
>   
>   	for (i = 0; i < depth * num_files; i++) {
> -		t->ios[i].buf = aligned_buffer;
> -		aligned_buffer += padded_reclen;
> +		t->ios[i].buf = buffer;
> +		buffer += padded_reclen;
>   		t->ios[i].buf_size = reclen;
>   		if (verify)
>   			memset(t->ios[i].buf, 'b', reclen);
> @@ -932,7 +933,7 @@ static void setup_ious(struct thread_info *t, int num_files, int depth, int recl
>   	}
>   
>   	if (verify) {
> -		verify_buf = aligned_buffer;
> +		verify_buf = buffer;
>   		memset(verify_buf, 'b', reclen);
>   	}
>   
> @@ -1228,19 +1229,6 @@ static void setup(void)
>   			tst_brk(TBROK, "Invalid shm option '%s'", str_use_shm);
>   		}
>   	}
> -}
> -
> -static void run(void)
> -{
> -	char files[num_files][265];
> -	int first_stage = WRITE;
> -	struct io_oper *oper;
> -	int status = 0;
> -	int open_fds = 0;
> -	struct thread_info *t;
> -	int rwfd;
> -	int i;
> -	int j;
>   
>   	/*
>   	 * make sure we don't try to submit more I/O than we have allocated
> @@ -1256,6 +1244,22 @@ static void run(void)
>   		tst_res(TINFO, "Dropping thread count to the number of contexts %d", num_threads);
>   	}
>   
> +	if (setup_shared_mem(num_threads, num_files * num_contexts, depth, rec_len))
> +		tst_brk(TBROK, "error in setup_shared_mem");
> +}
> +
> +static void run(void)
> +{
> +	char files[num_files][265];
> +	int first_stage = WRITE;
> +	struct io_oper *oper;
> +	int status = 0;
> +	int open_fds = 0;
> +	struct thread_info *t;
> +	int rwfd;
> +	int i;
> +	int j;
> +
>   	t = SAFE_MALLOC(num_threads * sizeof(*t));
>   	memset(t, 0, num_threads * sizeof(*t));
>   	global_thread_info = t;
> @@ -1322,8 +1326,6 @@ static void run(void)
>   		}
>   	}
>   
> -	if (setup_shared_mem(num_threads, num_files * num_contexts, depth, rec_len))
> -		tst_brk(TBROK, "error in setup_shared_mem");
>   
>   	for (i = 0; i < num_threads; i++)
>   		setup_ious(&t[i], t[i].num_files, depth, rec_len, max_io_submit);
> @@ -1339,6 +1341,13 @@ static void run(void)
>   	for (i = 0; i < num_files; i++)
>   		SAFE_UNLINK(files[i]);
>   
> +	for (i = 0; i < num_threads; i++) {
> +		free(t[i].ios);
> +		free(t[i].iocbs);
> +		free(t[i].events);
> +	}
> +	free(t);
> +
>   	if (status)
>   		tst_res(TFAIL, "Test did not pass");
>   	else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
