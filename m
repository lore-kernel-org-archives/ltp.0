Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820B0C4452D
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 05:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B7B53E1F33
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:40:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60A6C3C0571
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:40:16 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 30C4A1A0120D
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:40:16 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ceb096e675so124362875ad.0
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784698814; x=1785303614; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b0lpOv5UqzhrVINq1UN+V0nYIv8pFcnXx9tLv0LTWoU=;
 b=MgQRthNOyo416Y7Z0GNpA/llA4J9X/ZgxPvOyseeg7JOzYll//R/rq04eRvzXgWM4s
 R5SAwZ1UZF28NtI0UYctlzyD8ifWTmhhmCrrCQT0CramqOxKPGg9FqHI4V8ozvyhbxGs
 uUVvlnIi9Nbpf/w4YzzS/41HDtJNHF8z+0HxaSebBEJYFyd646gjivs6xcwqlF8ibFZf
 ZLNTvIcQpq4tihKSktiOVJgS8/yfagD1LsvcdXS4uMpxlH40eDyc4F8yFN99PpbX4rdg
 WJN4spssqmrA0yJotp5+qVxtJGZAVwjrpOWTZDJR9dsQPlzfB1INPQODp4wA5lQaT/NG
 b1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784698814; x=1785303614;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0lpOv5UqzhrVINq1UN+V0nYIv8pFcnXx9tLv0LTWoU=;
 b=SGu0AG90yjTTp6PA2AYo2IXEM71bsEuTH8QzE/Yu4OfrLh9JAehnTFNeqxbxh4Bvbr
 dzqongjnx7Ap17PodtyaciXkxiCzfo3FivMi3XIF+pWMpQDAEiRESYYbCMqESw7lq2g4
 O06kcV9kIIRyVEk/6ok8AYJ0yMBC/AJSUzeLQgwipyOOccwBYOtKjkWeqJC0tcRMe8tW
 lM7TitVBXpjs/xwzBy8kAYRUiaph/OQara0Oy8YNbiPT0QaepmfeRKNHUsHrLlbY+zo0
 AVZvfJ0iUUqeEAfDqvoCz4ete2YHJg/4Zrc4wJV0KQBEiAxOdW+rE/2ltV5ymghEfBCZ
 K58w==
X-Gm-Message-State: AOJu0YzXCVTHGq4ZsvJJmp8jbv0Vk4JXubH4d6CHOrx+mjzso/47SKBo
 KF/HWiwBqxeJRGq/UkOrsc9kD8u5sSp6xEPk1MX07EXMD8d65NkNQDLp
X-Gm-Gg: AR+sD12+CN+YhZpJrenDawK0hYed7N+ObwQ/s3yk17gasd/W34IqOsYrPlhmetT798j
 r3MVTMlkdKtVL2q/fciD3HYZ9svyJLC5VDN0xAQy3Rw6BeHvWycNg8PIhyq7LKJvtDxD7MCqOir
 qpr0vImQpdRoi10pVqiMMRJK+myXa4dQ0aeF7iuHlD0PmrDu9kfeD0tQrqW2KqzZw8qg+qduXEA
 xnav5GgVFnqgiYd8N29O+oJpJguC3qlt0VjNny7HQExBpoouQScz/41reHz3swJHEZ5AYQ07wFH
 seeb0n/zV+t8rD9g8Clmfr6HdQocPFpAoXr4j/d1eHH1J1Tr8YqSNS98njw4sOKMT07TL6e2/xP
 6DnX/bcFQIZXbA+x4Se8y6TltTw1RFBSQfz1wGrMpyfRdQ4XrNC7WIfCDlMfHVCcFKXjOBwbwza
 uOoWisStXetLerLSdtZsEZLjc=
X-Received: by 2002:a17:902:f642:b0:2cc:fa08:eebc with SMTP id
 d9443c01a7336-2cf34831b12mr220709085ad.1.1784698814337; 
 Tue, 21 Jul 2026 22:40:14 -0700 (PDT)
Received: from [10.22.68.254] ([111.223.92.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f34eba1sm8211155ad.67.2026.07.21.22.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 22:40:13 -0700 (PDT)
Message-ID: <60b5ffe7-dc56-44df-8ac3-be020e033795@gmail.com>
Date: Wed, 22 Jul 2026 13:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Tang Yizhou <yizhou.tang@shopee.com>
References: <20260714111307.166205-1-yizhou.tang@shopee.com>
 <al92s67_X0D7m01y@yuki.lan>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <al92s67_X0D7m01y@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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



On 21/7/26 9:40 pm, Cyril Hrubis wrote:
> Hi!
>> -	if ((sample > 5) || (diff_total > 100 * 1024))
>> -		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
>> -	else
>> +	if ((sample > 5) || (diff_total > 100 * 1024)) {
>> +		tst_res(TFAIL,
>> +			"Likely kernel memory leak detected, SUnreclaim increased by %ld kB total",
>> +			diff_total);
>> +		tst_res(TINFO,
>> +			"Unreclaimable slab can also grow due to memory activity from "
>> +			"any other unrelated process. If this test fails, re-run it on "
>> +			"an otherwise idle system and/or confirm with kmemleak "
>> +			"(CONFIG_DEBUG_KMEMLEAK) before treating it as a real regression.");
> 
> I wouldn't be that verbose here. Maybe something as:
> 
> 			"Unreclaimable slab can grow due to unrelated
> 			reasons as well. You can rerun the test with
> 			CONFIG_DEBUG_KMEMLEAK to make sure the leak is
> 			real.

OK. Will update in v2.

-- 
Best Regards,
Yi

> 
> Other than that:
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
