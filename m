Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795E3C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744796173; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4O4mLvXd2GKWDk2X3kF4EiSqFuvMvJDNe86FEOBURQA=;
 b=WJiO6YyEW5EtCN9JzDfPr2dP46WvuUc3Gqq+hS6OtNo9xcF87aUBOOI1js8I/7qA02Rf2
 slW0Qil4Ys11MfjvpHfBcsG4pSzVivUwVdL7eRujkI+vR/G9MnbhTXYDiaqaR5TMVIDUI7p
 Rh6QcP7ZeZDk1p0KtfrzvFH1RU7HpbM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FD13CB965
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:36:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CB3E3C05D1
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:35:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5949C1400445
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:35:52 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso3946532f8f.2
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744796152; x=1745400952; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BftzhJJ3ZDHeJ6SmRn1/H+dNh9xHxvkCd0Co6HC82Gw=;
 b=BumpwSNxw81y4uc5U9Lrrr8tlhvYzf7GAGwx4i0uEJyQODHmvd38kVTOfmmTcZgCFb
 pO+kv+dh5N/F1YHMtsHoo7XXRf/sgg84cNzrfU8zAyHNDlXbaKHw4ifYmGdHRBPSJuRZ
 uWhR8QjVmUqCHUNUqgSZIDjFtVT5AH/FUnTMOwRWilVc+RqvCqUwTzl2QANrwG7TVWox
 lIJfycFvk4mwstYjG4g+gAqcMGBSeSVWbFZQZhzD4Bmw0Saf2JBGpDvP8+umwJC2ZTDA
 2Jk0BDotElkJoD3A5JQdloOc572sR3wyPilEg3kKT5a7siyOYMBCMhpP+OwRGQ4gk20L
 0oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796152; x=1745400952;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BftzhJJ3ZDHeJ6SmRn1/H+dNh9xHxvkCd0Co6HC82Gw=;
 b=ii2zuoCuwvylXR7hLCbp329gVgC6YJxl6n39XExWPQXPeoA/CSRQR0LBtV14ybKxHf
 B+ruKeAXxtb/zdoThsYB67THlzG+d2SmE8sNLEwvqto66w7LhbMpdnbQP43U0+INru8+
 pkngIdvO1LhCYwrb/edcIUPgbzU/aJnNFZA5LbNIhTQY+gLo88kniBZxkzBpgXATPxTk
 GqhxcVCQU9Y3ekby7CwlhBrcFjBfaPK6if3iT3hCR5zmhQPindFwgeeGXAk4sTU0cu/n
 4WH5m+m2j7gIjWQYSBPdZYv6RJcaw8VQBUnWEo0unYjA7CxP6INDEMHXooEYCFpqEZ1V
 aRmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrzSFJpeBHk1GyA69yoZe+eRVk9iN7iMk1W1usqNcrgxEu7wrcgtmePLIVicZZF+Eh4Kg=@lists.linux.it
X-Gm-Message-State: AOJu0YyigoWaF36IZPq1YqwrTqQxq67a3jLC4cczVFWxOx+syKZKYzju
 3aRnEWB8mrKbL9/jYi9UNRVtHxCJyXftmL/Oc2USSR/axf+ewd2SC4eA+/tCGotxr4s5dERNkoz
 h
X-Gm-Gg: ASbGnctuN9wWUjqqd0iCSyGJ6EPVwWA/tKu8a0zgT3+YYXNGVYTBOSupOjWYS+UsNvE
 3U3j37WTKCuLdC2JVDKmm7M76g2ebgHHAHjuNRKKP1OYluMIITyx+eOxu3SKolvMQGJnepFUemc
 jdI8PwFvwx+aqQePMXQfL3lwWiLO05Ue5lFLxC/SBwCHuwRtP48nLmNl4otADhXwAGwkGNtdmKQ
 g4ldpOoYDIq2fZgGSbRJRz4CS4Tx5YYFODOzwRXMCgG6nA7q1q5wkU1kbH/63lIt7YEtUtbbB9x
 tgNn+VlLz1tr6ySOXHWqD/UkPq/xV85Lx3mBD5Lw/WPmSr+0gcoUlBbape35kxpx9MBealGpxGp
 IWe+BEREWCwC0ujFDTNgS3pHTy1gqGHXrYzFTsmuliaAxikDyi9x/+fwvAzQT8wF1eElVfu/Itv
 wI0bc=
X-Google-Smtp-Source: AGHT+IEG49QLYVQpGYoHcURIg6tN/mLVXRMzkUOlY3dUi3AZhUv7GM1bCzQps6vxDtgAN8EcF0aH7g==
X-Received: by 2002:a05:6000:188e:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-39ee5b2f0c6mr1120349f8f.31.1744796151672; 
 Wed, 16 Apr 2025 02:35:51 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae964048sm16705226f8f.2.2025.04.16.02.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:35:51 -0700 (PDT)
Message-ID: <5f2d652b-64f8-45a6-982c-7131b323ba31@suse.com>
Date: Wed, 16 Apr 2025 11:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250411070217.36799-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250411070217.36799-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol02: Fix the doc to fit RST format
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

Hi Ma,

I merged this patch as well as all the others RST fix.

Thanks,
Andrea Cervesato

On 4/11/25 09:02, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   testcases/kernel/controllers/memcg/memcontrol02.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
> index 2d47e5042..101b4e1bf 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol02.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
> @@ -4,6 +4,7 @@
>    * Conversion of second kself test in cgroup/test_memcontrol.c.
>    *
>    * Original description:
> + *
>    * "This test creates a memory cgroup, allocates some anonymous memory
>    * and some pagecache and check memory.current and some memory.stat
>    * values."
> @@ -12,11 +13,11 @@
>    * file in V2. Besides error reporting, this test differs from the
>    * kselftest in the following ways:
>    *
> - * . It supports V1.
> - * . It writes instead of reads to fill the page cache. Because no
> + * - It supports V1.
> + * - It writes instead of reads to fill the page cache. Because no
>    *   pages were allocated on tmpfs.
> - * . It runs on most filesystems available
> - * . On EXFAT and extN we change the margin of error between all and file
> + * - It runs on most filesystems available
> + * - On EXFAT and extN we change the margin of error between all and file
>    *   memory to 50%. Because these allocate non-page-cache memory during writes.
>    */
>   #define _GNU_SOURCE

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
