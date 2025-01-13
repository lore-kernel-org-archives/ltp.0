Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0807C02180
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736777169; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=JW+2BqEXdhlyEdrCKyZOato3euxZpTThKYftMyUgM5w=;
 b=bE7glrjAVIu81rWtMKpD7yB30Ejg8lvJCrwIpqBN6HwmenjzXb3uIK7Hp90pDYmD+ciQh
 KzIy1FRmAgkbkEHMQTOIucRGN9u9yFexKiXOcQHnbkQ08U/AtyknzVKOeAHStzeBdFKlS3O
 Q8X1R9do+c5FDY7pz7uAQkVzKzx/9R0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE2BE3C78CA
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 15:06:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 183B13C78B5
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 15:05:47 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B117510175E7
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 15:05:46 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so2354131f8f.3
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736777146; x=1737381946; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFhveAuJAB6QCP/NjfQwEzRl15NVppQ7acmcclS5JWQ=;
 b=M0u3RghXo6xQAWnlAg/zeESj/FsmvR5nJX1aeT29O8mBHF+EimgZExkSMTKv6UNMhm
 9TwO7TZFy4KNH0xO/DpXwnAxXZer1SRU2HsOqXi6ujxmtoq8+/c4L9UJryGXCLjFB15J
 ZpEXmHRsyaxYJ+WsoLApteFXdY8+jrichLqOWFcX9KunGrB2V4MM/pTOQ346feju7yyK
 O0XF82IzmUxSCXZkNk7k3Si/LyFQomDCs17ACQzFOQA/FHe9vbfOzOhDW+NBHAKQFChZ
 8PdwfDg6bCAiC4yW0f2H4ufDQbxxussFIATpBplJodrhLmhl97y2AE81JN9Yb8AMasPl
 QM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736777146; x=1737381946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFhveAuJAB6QCP/NjfQwEzRl15NVppQ7acmcclS5JWQ=;
 b=SfirZ7OguPW8IkZ/fe7oAoUAmbIyx51hV7w10NLK0GDgQ013JrXgTsLgd6FppvIdTX
 f+ZGH0hIvFpR6LXYtcdQtL6ETUYoIM3BGkCsSLO9RJcFmN94u/a+bhvfrgvfxIdOHKZa
 ebts7OICt3B0zcPOEu5lLqsLfzjxECNN6aThZ/ohMJQLkSjbEUGC2OeH4pRrJGkZpTJt
 EdcHc/JXd0IPnPPDRNLFhC0R08SCg4pEqXwHMppXfdJ17fVDk8I/oOHAP2aGOXaPt1jT
 BMydjEMtPvcKcgc0YjE61GCt8cOz0PAF0KCDWzdYWYegIsqvNbN8roeIsIZcAnLJFqE8
 IPuA==
X-Gm-Message-State: AOJu0YzqSmVe6/8WeUY1c1UGrDN2/eGV4yYSlZjQg5+CrEpnJSm2Ntrn
 9WLOIxW1/BE4+7Qt5oqrBNGpEMXlblFX+a36wtXOGeIurnmudpVdTT1SSREUu4c=
X-Gm-Gg: ASbGncuQZggb0hMKu8wr5q/ZwzFz90MbpC96glelCHSQBKHpmIb/op3QVj9QwznYcf2
 q8e/zuUOVxBaVYfLCv/MinBjz3R7fWvtmmIn+TIuiaoUXfU8uh780F42uX9mPoXX7C7DJOqTTf2
 jpuSkbfLaMpdoPhdrcu+x50JUVoBCOYvyY42UHrfSeOg/XS8uuUy4XdcaYzcggyREQ/FnJ30yJu
 y8rzb/blDt08enmUeVzjOGD3ZmifIw4px1Obj/kXcxSqN6sdL0LdAuoxcrJow9I1g==
X-Google-Smtp-Source: AGHT+IFCvuIqDPjW9YNgUJwMPONJYtL53GchM7KAlGRDQG8V5CpMDwaiBwslxKRSVVGMApoSci4K6w==
X-Received: by 2002:a05:6000:178a:b0:38a:4184:1529 with SMTP id
 ffacd0b85a97d-38a872d2aa5mr12558276f8f.12.1736777145739; 
 Mon, 13 Jan 2025 06:05:45 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38378csm12185984f8f.25.2025.01.13.06.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 06:05:45 -0800 (PST)
Message-ID: <9fc8d352-b74a-4493-8336-bb3de7908815@suse.com>
Date: Mon, 13 Jan 2025 15:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
 <20250109-fix_setsid_tests-v3-9-2ce60c904019@suse.com> <Z4T-0Xk9-sKfPfR-@rei>
Content-Language: en-US
In-Reply-To: <Z4T-0Xk9-sKfPfR-@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/12] Add TST_EXP_EQ_STRN macro
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

I guess this is affecting also TST_EXP_EQ_STR then.. I will need to fix 
that one as well.

Andrea

On 1/13/25 12:53, Cyril Hrubis wrote:
> Hi!
>> +#define TST_EXP_EQ_STRN(STR_A, STR_B, LEN) do {                                \
>> +	TST_PASS = strncmp(STR_A, STR_B, LEN) == 0;                            \
>> +                                                                               \
>> +	if (TST_PASS) {                                                        \
>> +		tst_res_(__FILE__, __LINE__, TPASS,                            \
>> +			"%s == %s (%s)",                                       \
>> +			#STR_A, #STR_B, STR_B);                                \
>> +	} else {                                                               \
>> +		tst_res_(__FILE__, __LINE__, TFAIL,                            \
>> +			"%s (%s) != %s (%s)",                                  \
>> +			#STR_A, STR_A, #STR_B, STR_B);                         \
> Passing these strings to printf-like function is not safe at all, since
> they are possibly not nul terminated. If we realy wanted to print them
> we would have to copy them and nul terminated them.
>
> e.g.
>
> 	char str_a_cpy[LEN+1], str_b_cpy[LEN+1];
>
> 	strncpy(str_a_cpy, STR_A, LEN);
> 	str_a_cpy[LEN] = 0;
> 	strncpy(str_b_cpy, STR_B, LEN);
> 	str_b_cpy[LEN] = 0;
>
> 	...
>
> 		tst_res_(...., str_b_cpy, ...);
>
>> +	}                                                                      \
>> +} while (0)
>> +
>>   #endif	/* TST_TEST_MACROS_H__ */
>>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
