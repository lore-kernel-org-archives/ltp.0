Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E378C02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736862185; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=bezPlG7BUmWsMxnsYXSgx3DKqvYhFqAU3v17EyyRugc=;
 b=Lcgwg1FJzmC/9NvXDD97yO2wdHjQ825nIx2ODU3POMhX23Wu3YqB/cn5kMJdVnhZSd80J
 zD+h2tReWgOzR0xo45NwXKJaEDG0voUn050HeGsJR3PeWjAT4rpsVYF/mc0jYheuEKuT8FM
 bL30fBtkt2xJvecg7f0h+tlIy2669aM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B283C7AC9
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:43:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B42373C7AAA
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:42:43 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D5238600490
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:42:42 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab2e308a99bso196423266b.1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 05:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736862162; x=1737466962; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F6GF+oqoKuNbm0W+dgRlgguumXVMZnyIPngBjwd7DLM=;
 b=bvkueKgL4YqgaHyJvgq/K4SOkTqiR96CTQE9cTX7KFfWGMdeemCaHmkmKiRwBzcujg
 Ho8buR7lA6zFWT6OZf/+146Xn68tYr7txOk7uH4oa0rC5/qFZJKdcHvn4019YoPRYOE7
 h+y/9mm4NZRjqV9LWcPMoPPSfvbPhS9TNyqq4+VFBQlo1pYCM+MDdyC/3GRF9BrnFNzf
 Hkr62Lx+3sJoTp/xjXQj4RLfU5YbnHw//MwcbSUIRkKBUCdqhHjQ+x5HwnQ1bqP2ndEn
 FukjstaP2XE0rp7i7FzCs9B8P0pzyw9nZKHkyUGTl6q4nHoE8MX37Hrj1s1W+Sc/9Hn7
 bW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736862162; x=1737466962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F6GF+oqoKuNbm0W+dgRlgguumXVMZnyIPngBjwd7DLM=;
 b=feg1B4H1TgOxmeTXPt5IeCwMd+oaeL7P011j6lK/91ri/4xUTjz7gHBmIT0RiS0Fzm
 VuJz9XmzMVCyxv7u7kp0UXIvNModVhnit1XP7XcVSdwCL+rU2KixB0vIJAZymdqljvW8
 kM8mLsO81dAFd/GrPCBGzzJW72daomLZPOSZstuMJGJsiII/oz38u33rUn0cYKYZ3kLI
 2jxKECop1R8Y0Cc0kfhniNDFIWsHAC4rRZwNXYz3J1pkqRAiirxx9yWziHLQh2szkrEf
 xTnvcii182ka4o/g7WSWmkAquy9RviFpkzLD14TVCOqxTCeRkpRgUX9efyo5cPLtoOyi
 ZmHw==
X-Gm-Message-State: AOJu0Yz6nTxMmfnUnGNYvGDmkxTcc//ZYaZTSgG3GW6ceqOl0z3i3VX3
 tubjiGqocEm8sW/rOYp8r75Ckebr0+QcoH1Q47uMX5k64Fl9e9J6V4X3/zFmxkRuObFZ8K4TVDd
 PUiU=
X-Gm-Gg: ASbGncsmQbBuqhMsdFrcS09ji19spL720cpa0lQB2ruPdG7r+ilYl2TyEly7paeeeTm
 UJb4JEd6vsSMBVkHyjgrgVA2DT0404zRudqHWE2YAaJUb7j1L/2zoU5XsDg8yESMQQgdC5h6afa
 CQjDp0vHIHTO64ZaSCFd7degd0iu5wBeWkS2pNNiXNm4XdigAq0tyqzLkXMQbs4DecLKC18k5Ua
 cM9alXWEFilXhh97r3kAxBPyp/k1vP+TuDsVSd6hT9I1cSZvK/s4yyxH6WEWnKLYNs=
X-Google-Smtp-Source: AGHT+IF8bCMoYeCIJBr8JPROwA5g8qyO69Gz4IPXOWxvnJETDONUb5K/R0Euy4o/Iooy3wjQb57ICw==
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id
 a640c23a62f3a-ab2c3c7a0c6mr2051176766b.14.1736862161958; 
 Tue, 14 Jan 2025 05:42:41 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c956258fsm636585866b.107.2025.01.14.05.42.41
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 05:42:41 -0800 (PST)
Message-ID: <47b29622-05c1-4eb1-82d4-fa530bc8314f@suse.com>
Date: Tue, 14 Jan 2025 14:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20240425020308.25367-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] lib: Add TST_EXP_PASS_PTR_{NULL,
 VOID} macros
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

pushed!

Andrea

On 4/25/24 04:03, Wei Gao via ltp wrote:
> Wei Gao (3):
>    lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
>    sbrk01.c: Use TST_EXP_PASS_PTR_VOID
>    sbrk02.c: Use TST_EXP_FAIL_PTR_VOID
>
>   include/tst_test_macros.h               | 45 +++++++++++++++++++++----
>   testcases/kernel/syscalls/sbrk/sbrk01.c |  8 ++---
>   testcases/kernel/syscalls/sbrk/sbrk02.c | 17 ++--------
>   3 files changed, 43 insertions(+), 27 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
