Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6752DC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713344665; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=OYoOkmWKpbJd2hGp9vQ+OBsX1HbJz1cQiG1R5rj+eg0=;
 b=qevVR2/9zjuy4z9EYruh9tMdIVm08n8PtCGrRG6g1HZYmBjEYaBWsILfBp3Xqdfp1rq4s
 O43rMSPxekvEWnXn93EJmYJC5N+q60sRrbPIY5vmLXJGhWBZhE+KABdfbGulDx/kpuV9Vwr
 5YztLO7l/8L5YCwK4wLg0CluskiwqCY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0D1B3CFB7F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 11:04:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 922063CFB16
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:04:04 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF6201A0BC31
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:03:59 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-343f1957ffcso350165f8f.0
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713344638; x=1713949438; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3hSETLNSR9fBYRC2Bae3WOHxh7NpdrNwPPMCVaiJHE0=;
 b=aEmvYG8kKpK8glLvkB2NKRP9XzOUNHVxkZORlvWYQDqpSTUIGmfYuSvOkX1XZvFLlQ
 qJSS7LvWhcndcH8Gm4kkC8YB/r4C0XiuxQfJsCQzyElVBNqpP4uaAGfBBhMBHJW5HEKf
 2dDg9i5rx/6SMv8eIknVNbGhWyKI1NS9DkFx+2AhZ2sDX0lvvvWoJWKUSGR6a2zGH07D
 NBjJN3ztBwTB+DvtPYDYJjb7EgS6K71/z+Avp8MoyYq3MDoK9pKt2uksyra/xZE7MCvC
 lPbEjqJgd1aUjl8mJqFvY0C4dbD9tMR4JSNSCYPvAi9PoeFsTWZeOpzD+VzwgoI9a4nN
 S+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713344638; x=1713949438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3hSETLNSR9fBYRC2Bae3WOHxh7NpdrNwPPMCVaiJHE0=;
 b=sZ6ryw92EQ3jWPUEfN42/UDosnBQWVWZrERvPPVPnt9WcHdpP7ivFzdin1VxPV8zpB
 b0fhY/T75FxJ3focaemWpH/NrM8+H1pKHUOL671blnx920EKnw++pEybI92dFQBVJ1tu
 h8pTjL+uvsEtH9sVKmFk1LFQVYY0R8Eq2frh1UaKGa9K5M0J6x69Rx+LwhLfTt26yTQ9
 pd0GGKruJ45Fh4zA/7NVYdt9YbkRrCluEITdy5YxndFJQQc7yIhtuSxx5TOO6no2NUYI
 /9Jw2NjBViN6WnhRqm2JzxcI6LIJkPyJ5ddiktoEne7MxfTzcNEJGcZ3HGBDEuMXdT6c
 nADQ==
X-Gm-Message-State: AOJu0YyILwab5u03N07L5kr2uEHJAZBoajU5DYo32dFypGybWbl+jqBv
 Z+N+JEPubbu3zuUBoun8zi5+J33YeYmkOkaEx0mbkiQicT5YR7Pe4cBBfNkGApP3VYzyZceG11K
 3oml4sg==
X-Google-Smtp-Source: AGHT+IGQvxwqVICFn2+vcJV8vttMrkGBuWmBDMptH+aWvm44eFVF7DZKQVupMNEwhlmWV9CwAffkRg==
X-Received: by 2002:adf:ce8c:0:b0:343:cee1:cbc1 with SMTP id
 r12-20020adfce8c000000b00343cee1cbc1mr4546180wrn.14.1713344638371; 
 Wed, 17 Apr 2024 02:03:58 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.72])
 by smtp.gmail.com with ESMTPSA id
 bd14-20020a05600c1f0e00b004182fab5098sm1969341wmb.20.2024.04.17.02.03.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 02:03:58 -0700 (PDT)
Message-ID: <1cc3a7e8-5706-489a-a13f-62fbd5aa69db@suse.com>
Date: Wed, 17 Apr 2024 11:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240417090222.707302-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240417090222.707302-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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

Hi Petr,

On 4/17/24 11:02, Petr Vorel wrote:
> This is hit on systems with 64kb page size (e.g. on aarch64 with
> CONFIG_ARM64_64K_PAGES=y or on ppc64le with CONFIG_PAGE_SIZE_64KB=y).
> Using TINFO causes test not "failing" with non-zero exit code.
>
> Fixes: f987ffff5 ("libswap: add two methods to create swapfile")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   libs/libltpswap/libswap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 313a15f24..6d4184ef9 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -160,7 +160,7 @@ int make_swapfile_(const char *file, const int lineno,
>   
>   	/* To guarantee at least one page can be swapped out */
>   	if (blk_size * blocks < pg_size) {
> -		tst_res(TWARN, "Swapfile size is less than the system page size. "
> +		tst_res(TINFO, "Swapfile size is less than the system page size. "
>   			"Using page size (%lu bytes) instead of block size (%lu bytes).",
>   			(unsigned long)pg_size, blk_size);
>   		blk_size = pg_size;

Are we sure about this? TWARN wasn't a bad choice, considering the 
meaning of the message.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
