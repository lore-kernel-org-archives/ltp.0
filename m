Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6100DC25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716293197; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=W1EwzCyEoE3YHkwWg769sJv/0VtadluwGDbyu33qYk8=;
 b=UIS0RVis0tx8B9mO85QEjloVoSM1zNCnbL18auS9n2BRpMh6t/jd9kmj24FxTPJV05YK6
 MmCGprFlyeINGaBdW/BWiSXqXH/gLtIF+Uz7/228TibBJynOLlwk5CtXoBuWCaRiE/uYTJx
 OCpEkbSG2qbSP2Ou9pdos1Eo2nfIWfw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E14623D0099
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 14:06:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B57B93CE539
 for <ltp@lists.linux.it>; Tue, 21 May 2024 14:06:17 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EFAA0600C74
 for <ltp@lists.linux.it>; Tue, 21 May 2024 14:06:16 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a599a298990so904849766b.2
 for <ltp@lists.linux.it>; Tue, 21 May 2024 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716293176; x=1716897976; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fwNTKi5egS/rjGjinZhQTiLgw+n5uoI6ueZSkgLbTCE=;
 b=aXG3PgyxbVSEn+DSBB8bKWNnvnrKAIaWOW5NYgKbi6mO1PRGFLw7zrZUi95Q0/RRHf
 uB24gcdYIAeN2c/m7uY+aalyG03NROFB1nwGctjvvxC49KOtX+zwAi/v+Aucd/3YSjb+
 K8pz7anlpvMehD3XhkSzRBOiaqLy7BGPdA0KvX/Zm882e+9PgU3EYn6aTgTX1TuKO8CY
 HGt12f0djrq8+f0raj1LuaGbRBrBfhnHT0063rkZjjKPKvBdL/ktmSgxMgOv2EJqtHAe
 a6xTgh3jTK9lvSpJyN6B4QkP6ZPark+KP2YYM6fG6XpjFTIBR8zUORPJnZ58AyfGRtkV
 Yt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293176; x=1716897976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fwNTKi5egS/rjGjinZhQTiLgw+n5uoI6ueZSkgLbTCE=;
 b=qbr3QjGgH3rjSfOY5/2TI97VAFaexq5mXZOotCzp1V2/jnIk1TcOCXBNtqB+Zk/uLr
 fVPqCjsHy1LmoymWJMFM9CLQIbDpb5bx4LXOgywv+sGiQpamasTQz67gOwBb+vVWgk9Y
 XxKHCZpdWeSy/cHrCb7D/35Ntbdgcm0UrEKZQzvsbmyTjUBux9JJ3/SnxcpDfsaIywxa
 zE0D2nhsLQXt5yWyE83DiSUTvBebEV/zIwOtSZ/L1q5KUJBg3ebGkt22Eyag9iPijr25
 JnUFKfT9UCA2GtGVpja3Jiy5e/jblw9ruYRNXlnYZ/HXzgionQU3StuNhKG9MSRfIehc
 c3Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuNu+Ya+e34A9jMHaGcmGEDAGbus7tVMWiYY+0FBakH4gbiueyDTV7MO+ab9qb711ovhS/2xpbXf4ANuZC/+/xTNg=
X-Gm-Message-State: AOJu0Yx4/peXqcCAZmVxjZKg80gxaZwQxC8mqzqmVGl0OZGmDcWVmcJC
 1hf435tdt8I+RWYa1VDY50sWLazAE3oAXQWfl2cHtemlLvG5eNeh07L7txmIY4Y=
X-Google-Smtp-Source: AGHT+IFr/wtZtEFvTW1LBXcxqD5G5sLisu3h+m3sy7/Ahm+xAkFR2r+bL1rExl/0qpXrn4WeIztuFA==
X-Received: by 2002:a17:906:1293:b0:a59:bde5:398 with SMTP id
 a640c23a62f3a-a5a2d536c98mr2090425166b.14.1716293176284; 
 Tue, 21 May 2024 05:06:16 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:843f:e00:d596:e8e:78c7:ff41?
 ([2a02:a31b:843f:e00:d596:e8e:78c7:ff41])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17865sm1592165466b.204.2024.05.21.05.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:06:16 -0700 (PDT)
Message-ID: <7067ae56-9bf8-44b0-b9de-308de6878b2e@suse.com>
Date: Tue, 21 May 2024 14:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240521105348.126316-1-pvorel@suse.cz>
 <20240521105348.126316-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240521105348.126316-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] tst_kernel.h: Convert docs to sphinx
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/21/24 12:53, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as in v1
>
>   doc/developers/api_c_tests.rst |  2 ++
>   include/tst_kernel.h           | 43 +++++++++++++++++++++-------------
>   2 files changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index ec53ab33c..2a9f3e7b9 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -1,4 +1,5 @@
>   .. SPDX-License-Identifier: GPL-2.0-or-later
> +.. Copyright (c) Linux Test Project, 2024
>   
>   .. Include headers in this file with:
>   .. .. kernel-doc:: ../../include/tst_test.h
> @@ -11,6 +12,7 @@ Core LTP API
>   
>   .. kernel-doc:: ../../include/tst_res_flags.h
>   .. kernel-doc:: ../../include/tst_test.h
> +.. kernel-doc:: ../../include/tst_kernel.h
>   
>   Option parsing
>   --------------
> diff --git a/include/tst_kernel.h b/include/tst_kernel.h
> index 89de79928..e0ce7ce46 100644
> --- a/include/tst_kernel.h
> +++ b/include/tst_kernel.h
> @@ -5,33 +5,44 @@
>   #ifndef TST_KERNEL_H__
>   #define TST_KERNEL_H__
>   
> -/*
> - * Returns 32 if we are running on 32bit kernel and 64 if on 64bit kernel.
> +/**
> + * tst_kernel_bits() - Detect if running on 32bit or 64bit kernel.
> + *
> + * Return: 32 if the test process is running on 32bit kernel and 64 if on 64bit
> + * kernel.
>    */
>   int tst_kernel_bits(void);
>   
> -/*
> - * Returns non-zero if the test process is running in compat mode.
> +/**
> + * tst_is_compat_mode() - Detect if running in compat mode.
> + *
> + * Detect if the test is 32bit binary executed on a 64bit kernel,
> + * i.e. we are testing the kernel compat layer.
> + *
> + * Return: non-zero if the test process is running in compat mode.
>    */
>   int tst_is_compat_mode(void);
>   
> -/*
> - * Checks if the kernel module is built-in.
> +/**
> + * tst_check_builtin_driver() - Check if the kernel module is built-in.
>    *
> - * @param driver The name of the driver.
> - * @return Returns 0 if builtin driver
> - * -1 when driver is missing or config file not available.
> - * On Android *always* 0 (always expect the driver is available).
> + * @driver: the name of the driver.
> + *
> + * Return: 0 if builtin driver or -1 when driver is missing or config file not
> + * available. On Android *always* 0 (always expect the driver is available).
>    */
>   int tst_check_builtin_driver(const char *driver);
>   
> -/*
> - * Checks support for the kernel module (both built-in and loadable).
> +/**
> + * tst_check_driver() - Check support for the kernel module.
> + *
> + * Check support for the kernel module (both built-in and loadable).
> + *
> + * @driver: the name of the driver.
>    *
> - * @param driver The name of the driver.
> - * @return Returns 0 if the kernel has the driver,
> - * -1 when driver is missing or config file not available.
> - * On Android *always* 0 (always expect the driver is available).
> + * Return: 0 if the kernel has the driver, -1 when driver is missing or config
> + * file not available. On Android *always* 0 (always expect the driver is
> + * available).
>    */
>   int tst_check_driver(const char *driver);
>   

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
