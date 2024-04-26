Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85549C04FFE
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714117442; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=V7dlmEsC+GVYDKWyYZsoBvRvYsmDP2zgMU9eWWLTtYg=;
 b=XJNwesWxtCrjahweRyI34DCQWFWhRhWw+l5Xf5lU0OzK6Jk7II3fSORhiC9/sK1rfv2Yp
 rpcM5lBKeR6MkJNIvq0Y+ie8y763IueZRH+QKZ7o14xkp9TFsSVlnmMqFtLnI1+1JhWeAfv
 O9i2uBJfx7pN3hMiiBeOqwemFCVKWcc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE4943CFFBC
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 09:44:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50DA23CF615
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 09:43:39 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3AAFD1400F91
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 09:43:39 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso202852466b.1
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714117419; x=1714722219; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6lwh6dTmLaB1c3XARoXPYVD6m8/JQtoQHy29rb5RD8k=;
 b=GXf7jnWJT8bMtLhZplPPWRwxUx7vTEtNi+GD67dziCUZQO372aPFwbAbkQuYh35PKE
 Pc73oJtLfuuZVwjYbI1QD264sDJahSarDSda0M1QlTR0/mBPebJQrF4bUcuEAL1KoY4Y
 w0hkmRD966JN3cyFNtnwuCqzzZPAjHQO3CEn5SHJ84iIcyVVoVUU+liMc8ugUcjJ1WNp
 Bo1ICt/ef4c1Md76S38YcXddnFO2tUOJr45SHKYvih4RISItagIbLME9HZk5k6w6C82O
 VSZTAhKZT7IyivnD2tabuvimqCbqUYWQiYqidDc8a4FARdRzgBY1r9ZaguUWRwtCPFN1
 PjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714117419; x=1714722219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lwh6dTmLaB1c3XARoXPYVD6m8/JQtoQHy29rb5RD8k=;
 b=rj3gdNjGeaqkVf32Bgp22gIDndHFl26rsY6+V3O/MQ/rcM5OWqlkFq+NspgjlMfR/S
 qmz1K9u1a7KhrJmo3P91QRtKVSWAkgDG+weEKd1MWnZmcqPrT9faFkJpZb6pDJpspodY
 x5CHQiimebWva6k2KZ8I9mSjR9g9Pwty+/mZy1GG9FPM157qKP9fEzIllY3AxefByLIn
 4gZ7YjJkmvAewQ7WZs3sy8CIglGPs23pup3e4dAdtAZWngHEzGDHBpfOTMS1HthJxngF
 D44eNH1s5FUV2EYvqb9NabZJLpJ+phVmo1dj0b4PYCU5MYHTVo5CVQN4jmBSYicjIt1V
 fMIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnGkULqCFsm2583yu7WsAI1VkZTwvd0J4wZeAC8gtWkVJJtrNKvAsBfweoa6Xp8U9C/O7Q0ymLO841gASFm4aTc94=
X-Gm-Message-State: AOJu0YycMCjCtNGx2YcZE8yTvSGdxJoavjak56ALNr93tgquyobq2CkS
 k3qzl9tOwzogU4jvYraFdndjqfPr/2eDIbAtV7ZMzHNPulSDSeNvOviZxCDSnME=
X-Google-Smtp-Source: AGHT+IFghqQmHsGr8XLwBqieLN261ES4ODmcF7O13mzRTWIDZn/Ug1+Dv1a3HvBJon1WJgYO8R5l3Q==
X-Received: by 2002:a17:906:abce:b0:a55:b039:58f6 with SMTP id
 kq14-20020a170906abce00b00a55b03958f6mr1778776ejb.17.1714117418572; 
 Fri, 26 Apr 2024 00:43:38 -0700 (PDT)
Received: from [10.232.133.119] ([88.128.88.8])
 by smtp.gmail.com with ESMTPSA id
 cf5-20020a170906b2c500b00a587868c5d2sm4331073ejb.195.2024.04.26.00.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 00:43:38 -0700 (PDT)
Message-ID: <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
Date: Fri, 26 Apr 2024 09:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240426042851.333269-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240426042851.333269-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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

On 4/26/24 06:28, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/api_c_tests.rst |  4 +++
>   include/libswap.h              | 61 +++++++++++++++++++++++++++-------
>   2 files changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index 2c0c8419d..ec53ab33c 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -31,3 +31,7 @@ Capabilities
>   ------------
>   
>   .. kernel-doc:: ../../include/tst_capability.h
> +
> +libltpswap
> +----------
> +.. kernel-doc:: ../../include/libswap.h
> diff --git a/include/libswap.h b/include/libswap.h
> index f757073cc..681849166 100644
> --- a/include/libswap.h
> +++ b/include/libswap.h
> @@ -1,11 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2021-2024
>    * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>    */
>   
>   /*
> - * Contains common content for all swapon/swapoff tests
> + * Contains common content for all swapon/swapoff tests.
>    */
>   
>   #ifndef __LIBSWAP_H__
> @@ -27,60 +28,96 @@ int make_swapfile(const char *file, const int lineno,
>   #define MINIMAL_SWAP_SIZE_MB 1
>   
>   /**
> - * Macro to create minimal swapfile.
> + * MAKE_SMALL_SWAPFILE - create small swap file.
> + *
> + * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
"small small" sounds weird. Maybe "really small"
> + *
> + * @swapfile: swap filename.
>    */
>   #define MAKE_SMALL_SWAPFILE(swapfile) \
>       make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 0, \
>   		  SWAPFILE_BY_SIZE)
>   
>   /**
> - * Macro to create minimal swapfile.
> + * SAFE_MAKE_SMALL_SWAPFILE - create small swap file (safe version).
> + *
> + * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
>    * Includes safety checks to handle potential errors.
Same here
> + *
> + * @swapfile: swap filename.
>    */
>   #define SAFE_MAKE_SMALL_SWAPFILE(swapfile) \
>       make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 1, \
>   		  SWAPFILE_BY_SIZE)
>   
>   /**
> - * Macro to create swapfile size in megabytes (MB).
> + * MAKE_SWAPFILE_SIZE - create swap file (MB).
> + *
> + * Macro to create swap file, size specified in megabytes (MB).
> + *
> + * @swapfile: swap filename.
> + * @size: swap size in MB.
>    */
>   #define MAKE_SWAPFILE_SIZE(swapfile, size) \
>       make_swapfile(__FILE__, __LINE__, swapfile, size, 0, SWAPFILE_BY_SIZE)
>   
>   /**
> - * Macro to create swapfile size in block numbers.
> + * MAKE_SWAPFILE_BLKS - create swap file (blocks).
> + *
> + * Macro to create swap file, size specified in block numbers.
> + *
> + * @swapfile: swap filename.
> + * @blocks: number of blocks.
>    */
>   #define MAKE_SWAPFILE_BLKS(swapfile, blocks) \
>       make_swapfile(__FILE__, __LINE__, swapfile, blocks, 0, SWAPFILE_BY_BLKS)
>   
>   /**
> - * Macro to safely create swapfile size in megabytes (MB).
> + * SAFE_MAKE_SWAPFILE_SIZE - create swap file (MB, safe version).
> + *
> + * Macro to safely create swap file, size specified in megabytes (MB).
>    * Includes safety checks to handle potential errors.
> + *
> + * @swapfile: swap file name.
> + * @size: swap size in MB.
>    */
>   #define SAFE_MAKE_SWAPFILE_SIZE(swapfile, size) \
>       make_swapfile(__FILE__, __LINE__, swapfile, size, 1, SWAPFILE_BY_SIZE)
>   
>   /**
> - * Macro to safely create swapfile size in block numbers.
> + * SAFE_MAKE_SWAPFILE_BLKS - create swap file (block, safe version)
> + *
> + * Macro to safely create swap file, size specified in block numbers.
>    * Includes safety checks to handle potential errors.
> + *
> + * @swapfile: swap file name.
> + * @blocks: number of blocks.
>    */
>   #define SAFE_MAKE_SWAPFILE_BLKS(swapfile, blocks) \
>       make_swapfile(__FILE__, __LINE__, swapfile, blocks, 1, SWAPFILE_BY_BLKS)
>   
> -/*
> +/**
> + * is_swap_supported() - Check swapon/swapoff support.
> + *
>    * Check swapon/swapoff support status of filesystems or files
>    * we are testing on.
> + *
> + * @filename: swap file name.
> + * Return: true if swap is supported, false if not.
>    */
>   bool is_swap_supported(const char *filename);
>   
> -/*
> - * Get kernel constant MAX_SWAPFILES value.
> +/**
> + * tst_max_swapfiles() - Get kernel constant MAX_SWAPFILES value.
>    *
> + * Return: MAX_SWAPFILES value.
>    */
>   int tst_max_swapfiles(void);
>   
> -/*
> - * Get the used swapfiles number.
> +/**
> + * tst_count_swaps() - Get the used swapfiles number.
> + *
> + * Return: used swapfiles number.
>    */
>   int tst_count_swaps(void);
>   

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
