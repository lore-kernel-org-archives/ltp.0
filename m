Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3933DC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706610929; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=YwQUnMUs7k402RhJYOUt8kbXdjPH0pTyg/wnAFBlcF0=;
 b=pCgAmjss9EO6Mj7+RDNNM1K/JZ6xZLmupMlJRZ6cFy4MPnQdxB0khbyd3rVDZEiKqjzZU
 nOXs952YkM8KYusy5/XjKnh5O/KW3wr/vL38wCqxiEBxm3KhWplE60RXplJlYABXbCZv9Kc
 x6sQCaTNKDUIuhgEpztOfdnUhq6+MBE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D1D3CF96B
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 11:35:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE59D3CE0E9
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:35:06 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3086F1A0118F
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:35:06 +0100 (CET)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2cf1288097aso50503371fa.0
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1706610905; x=1707215705; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8rDyjiJqMXlOhv5qbyuAXrIHwecA57YjRCzr/vp4fY=;
 b=OAEGPMGD3mRxL7+CFsV7UowV3ejrZRW226/QAfzT01INtxaaPThl4/T8TRmIERwpxn
 n3T8whEdQr6uBsdw+LJnJbcPo36RnM9wR9E5Pdq1MU95QzQI+yq0UT66/HDk2jBg4i0n
 G29lZh65gNBUsklUxv7kcFcBvMXhzMY6Rgc0TMvTSLDMY4o+/YDRNfJNeMS6lKfpJ2h9
 eX+JpxtebwXRo/wEFZoKpihHwTTorBE8WATzUy08lMXiOi+aVFeeVFMjIuAJjQehfW3C
 4pOzUxryTSGsSPzWOybASVNOk4v2R7MC3sx+WphvjTFK2BbujMaL4S+r6+CQ0zWxlTcX
 GN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610905; x=1707215705;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8rDyjiJqMXlOhv5qbyuAXrIHwecA57YjRCzr/vp4fY=;
 b=jCTpwyp/YvVlLusJfHPplgkQYjO2EX/Iu7MB+FgzxSxDaR7yvary4VlcuhDuyRdvwG
 LsaderjlPYXPCKLJzzBvrkN+jcvEhJlxrtKjwHb4TmlKQulPmOsYj/z95iP7XFcik8QF
 YOifuyWf4ir4kkZPiP2vwIWO2jNvAEsKgFegyHT4ih4uPtlM139t9FzAD31dvx4PTuAZ
 eLsQsQD0bITKsWVRwS/6HnRQi3cIyP/Irrcf2OQxNmaBfNiNmswGzRQKHpBdafXdMmlf
 iUkAV77wTVHzeV7CQuaWVzPLY19Ns50zyjKHnJApOcoY+V+I5+cLoV5yFkYe3oB1eokh
 tZ7Q==
X-Gm-Message-State: AOJu0YyvvXp5/AXICzic65hbp8VcJLUbzlrO5/Pv7YJX472lRH+byrOg
 Odnks7qFhwmTQJD1k6Cb0tDWcvZl0nOVTAFb1xAFMXgt0tAy4kejdIHvWjUdUok=
X-Google-Smtp-Source: AGHT+IHrkEw6f75bz3oJnTLrUTbW4QTnU+4flomE5nXJ+mPdMJUz7NWepx2tFaGRWQicNsncZT+OrA==
X-Received: by 2002:a2e:8ec1:0:b0:2cd:f7b3:5218 with SMTP id
 e1-20020a2e8ec1000000b002cdf7b35218mr5195742ljl.35.1706610905467; 
 Tue, 30 Jan 2024 02:35:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUTCaV+bdRwr/wJB2tD3D++gSQ4srEU0FNa95RhAYKBPmTMY2tNIMlLAyBqk/GHqUglyZaANOTTbrHef2csvfjY5bQ=
Received: from [10.232.133.56] ([88.128.88.134])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a056e02074500b0036376c3a162sm2047395ils.79.2024.01.30.02.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 02:35:05 -0800 (PST)
Message-ID: <e1de0831-8cd5-46a7-a064-5fc0a36bf86d@suse.com>
Date: Tue, 30 Jan 2024 11:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240130103319.22763-1-andrea.cervesato@suse.de>
In-Reply-To: <20240130103319.22763-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix dio_append/aiodio_append tests
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

Hi,

On 1/30/24 11:33, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Ensure that dio_append and aiodio_append will end all children if
> parent asked for it. The way we have to do it, is to ensure that
> *run_child variable is checked before opening the file to read.
If you can please mention that append has been increased by 10000 in 
dio_append, once patch is merged.
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/io/ltp-aiodio/common.h     | 12 ++++++++++--
>   testcases/kernel/io/ltp-aiodio/dio_append.c |  4 ++--
>   2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
> index 200bbe18e..9a2d27166 100644
> --- a/testcases/kernel/io/ltp-aiodio/common.h
> +++ b/testcases/kernel/io/ltp-aiodio/common.h
> @@ -62,8 +62,12 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
>   	int i;
>   	int r;
>   
> -	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
> +		if (!*run_child)
> +			return;
> +
>   		usleep(100);
> +	}
>   
>   	tst_res(TINFO, "child %i reading file", getpid());
>   
> @@ -102,8 +106,12 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
>   	int fd;
>   	int r;
>   
> -	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
> +	while ((fd = open(filename, O_RDONLY, 0666)) < 0) {
> +		if (!*run_child)
> +			return;
> +
>   		usleep(100);
> +	}
>   
>   	tst_res(TINFO, "child %i reading file", getpid());
>   
> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index 057ae73d9..bd48a8252 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -33,7 +33,7 @@ static void setup(void)
>   {
>   	numchildren = 16;
>   	writesize = 64 * 1024;
> -	appends = 1000;
> +	appends = 10000;
>   
>   	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>   		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
> @@ -97,7 +97,7 @@ static struct tst_test test = {
>   	.options = (struct tst_option[]) {
>   		{"n:", &str_numchildren, "Number of processes (default 16)"},
>   		{"w:", &str_writesize, "Write size for each append (default 64K)"},
> -		{"c:", &str_appends, "Number of appends (default 1000)"},
> +		{"c:", &str_appends, "Number of appends (default 10000)"},
>   		{}
>   	},
>   	.skip_filesystems = (const char *[]) {

Thanks,

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
