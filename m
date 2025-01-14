Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8D9E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736865773; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=LHIAITM92bn/dxZVNphD7cBKN7LZemsIKAkjll6VUIs=;
 b=QzASydxt8EvoE+lK0oPyyUCDNG5JG+u3GsyS9g8js0Wq2OxbD9ZwnlySTvuf1hWPX9WNM
 hyH9ztCYM91SxFj5f+Tr/p8v76wne4r/rxnD4nUKKNzXrgdEjjCLlLoer+ADjI/5IPVswON
 Oa4bZhZgPSiT08W/ZM+Cln5ssfe4ifA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66C6C3C7AF2
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:42:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05943C7A24
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:42:31 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D5BD220C62
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:42:31 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so973570766b.2
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 06:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736865750; x=1737470550; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U+ykeCAoKkP+b5Km4FklGKjD3kLuEXEUiRZxhc4FrFk=;
 b=ffY7uOOaECKWMexClaSKLa7SWTDm8Z1QFciKskKGfhjTh+F3UjXDgHUpzwRafiv8tW
 Q2vAs04vx55Ls2wvJe2G5r5R8kVEde71hyViwgypKdpTdYj06yTCiq+SaDJNM073yRo8
 l5UYbQ7OkqY4F7p7dE6FEo9OibbGiq0qr+qH4p9nKJ6upSZpIQyD5nRiURIxIQAQ39UL
 tND9gihq6ftO+ttGKUMF3iCokzKTku/ZFtO+047cj7Ql2glYMfBvHF+3peMiihQIka1n
 aiVfRIdldoE4l5Uac44Mcp23pvVbagdicxEMsn8BnDFlZrV3KwiKKMSzG0VBsSDasfap
 m2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865750; x=1737470550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+ykeCAoKkP+b5Km4FklGKjD3kLuEXEUiRZxhc4FrFk=;
 b=qg/a4A72rta7J5mtAkMwTHMyMz9v0N/LDSfXfedPZmyZJ0ehnfHhLj1t1VgEmIJ0Oy
 HdIhV9YmYLOXwgMqXazMRKM01IATTXaDTsRKUZsAVH9N5aMb3sFU2wjcOcR7/jGebNd+
 P3LvHz7MAkXujEtpViZwlPHxuM5nU+CG+q8tAjhE9uF6YrfkaZi4rQFR/CXIvGq6mJuL
 TFWXK7a1leDGjvKeV6IqSqq8etlhI17qHLRFrT180pFiZmoVOWGuON9izgJMVNVa1rn7
 5tbNezo/xhCXDi+l2nqke+XjC8If4bCTYDnO6Ync4UMHQd+nBLPlUjcF+z8QJ6S7pen/
 OwuQ==
X-Gm-Message-State: AOJu0YzvH9B69bW69ptai3NAifMi4qQ6DG7LbgbgfcdDCnCn2jkJrYwP
 5NkvjmrUl517rdzjwg+GTayX1ULasTEQINYj+H9NkczFnz0tAzk2g4Pc8myiCmzCB5O6GbDcYq4
 1OFg=
X-Gm-Gg: ASbGncu6xO2zIeDFIqwC6tGyBanxBj+Jj7RnH9C8I08tilCZ7OF4e1iPPqToOcT/992
 JZG0EuzyyqwMziFk0WhIjnCJnsK2jaHJi27upWEOMk0TEL2XITA3V5EV6Vby7DqrVTvlYW4bZSd
 9Lqin0Y6U5p1q+sRQUs4n3KSFuNkd4lnmcEPo7iCJwvpm+1q5wFijU+AlUfNqTvaWnGQlSZsNny
 N9BxG4MBnQtyzl5qVl3ms/MgSFYvtTpW6YiOYsQDrW6taw1UsNJutVZAoxiGdkxrZs=
X-Google-Smtp-Source: AGHT+IE3dPdtciO9566Zc9Zv8uCL2w/lSofsQ6/bb4g47isCqucWUF7x6mk75gnvoQiyTYIumv/8pQ==
X-Received: by 2002:a17:907:72cf:b0:aa6:a33c:70a7 with SMTP id
 a640c23a62f3a-ab2abc8ecb1mr1639052866b.49.1736865750384; 
 Tue, 14 Jan 2025 06:42:30 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af24bsm640191566b.134.2025.01.14.06.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:42:30 -0800 (PST)
Message-ID: <5f644f30-e35e-430f-8659-3cfdabb31eb9@suse.com>
Date: Tue, 14 Jan 2025 15:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
References: <20241113151258.182353-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20241113151258.182353-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Update timeout related doc
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

Feel free to merge.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind regards,
Andrea

On 11/13/24 16:12, Petr Vorel wrote:
> .timeout was removed in bf9678782, replaced by .max_runtime
> in 0f72d519a which
> * added extra 30 sec safety margin (DEFAULT_TIMEOUT) scalable by $LTP_TIMEOUT_MUL
> * .max_runtime is scalable by and $LTP_RUNTIME_MUL
>
> Mention this in API comparison and in the user setup.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/writing_tests.rst | 7 +++----
>   doc/users/setup_tests.rst        | 4 +++-
>   2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 2293800a17..90619aebe4 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -396,7 +396,9 @@ LTP C And Shell Test API Comparison
>         - TST_FORMAT_DEVICE
>   
>       * - .max_runtime
> -      - \-
> +      - TST_TIMEOUT (not exactly the same, a real timeout based on old .timeout
> +        concept. .max_runtime has also an extra 30 sec safety margin for
> +        teardown of the test.)
>   
>       * - .min_cpus
>         - not applicable
> @@ -506,9 +508,6 @@ LTP C And Shell Test API Comparison
>       * - .test_variants
>         - \-
>   
> -    * - .timeout
> -      - TST_TIMEOUT
> -
>       * - .tst_hugepage
>         - not applicable
>   
> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index c5f82e6277..24b1f6384d 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -51,7 +51,9 @@ users.
>   
>      * - LTP_TIMEOUT_MUL
>        - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
> -       machines to avoid unexpected timeout).
> +       machines to avoid unexpected timeout). It's mainly for shell API, which
> +       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
> +       safety margin, probably LTP_RUNTIME_MUL should be used instead.
>   
>      * - LTP_RUNTIME_MUL
>        - Multiplies maximal test iteration runtime. Tests that run for more than a

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
