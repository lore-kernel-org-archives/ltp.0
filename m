Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737DAC71130
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751904317; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0F7ANV1XptoS8UMoVTHvOdTm08tLd7oKLN90ffjRSms=;
 b=dzc1pCWD+8vZh9HwrGTqbSeOLuWR/PMd15URpbV62fogI7OoT8Ivhx9JYCodDotdRFuWU
 4FuVIFTs3JG/p3MFXYXBGDHbcPV8eZX1ltTIUl93fLZvpjRAiv43NA0df9kpmNTN2Cb0xUT
 mZYFE+s1XgKvbeN6suY8WYrw2PMvboI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB063C8BA1
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 18:05:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8F213C8BA1
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 18:04:56 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC0281400BDC
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 18:04:55 +0200 (CEST)
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so7333738a12.2
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751904295; x=1752509095; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nd7VYO8A4+2mfjLIcjiHYVYMYU2NX6MvKOorWXPJdOY=;
 b=ADzAEfWxEW+gSdB0irjMJ6uhyscuXYkWHSeQM8R0ay4KYcOoRHxgMvd7oT1HW+Ph6h
 39D9ESVitP0rgknDDjBLxPFPrjfVR1CopKbCPXBJy3oqevpnv6JnK/tpIVBePHolmpV5
 V7YdKWdJYJvSiWanWmSCEyJhY6y2AGxV8UbDS4Uof72TOYnLid6gHSpOQcNLaoLhImxN
 jyyH+gx/p4h5Fm28ShbvP28El+JRMmcmqNAbyhbUrSYvfdQHm72JDzyxWOiVnyu/zMH+
 AjhMSbAH8n9NrzSUp+nLb1feKJbYfrujUrxIFIwvIKkKpq5CiGUa1+kjw61UaqZpnOvv
 DPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904295; x=1752509095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nd7VYO8A4+2mfjLIcjiHYVYMYU2NX6MvKOorWXPJdOY=;
 b=Af/aN7cRV1/tJuHIqN2vzhbLLpO/jZbkXW176xLwkYRA2vh1TDPgICe/eek/8YggsH
 FlVm5mXz4at5ZXUWWhURvlCwHNZ2Kr+t10YAIcBxknKfm4/HFTWOMe4uBi0I4zoB1j9I
 xBo/sTUCsD8k13wZK6RqfygCQ0IVAUji487fEizpylAefcEbaXZZku4cnL1yGfibYY30
 25SD4gJ8nBcBVoHFHQ/gqT6RHEvFi9HH2c3Vt3mhm3+EJ0pOW2LNjqgjCXoCoVUa0bEU
 CD19YIyq1aXHM+lNldOlyqTeoeM4I6r5gWeTGWmdvuyY9n8qpI88nF9Bga7Xj4V5kPXU
 TLTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzZQi6ztzWC/OCHIGUzvLmnkbPD0XqsrNfs7x3CxmW9ZG/55xrkbLkzG5JPRUaFnc1fSw=@lists.linux.it
X-Gm-Message-State: AOJu0YxmwO/e5IYp9ee6kvb5VVYESZbDLxkb8xfnq5tYyH3lT2MMc1uU
 WFv2uAQCbwgzAj/YydoGTv6pTJYEPsCGQ1/gln4lkAYA43O1hq+JqYt3fl8mlrye7P8=
X-Gm-Gg: ASbGncu6EjnTH9kYUkSE/W/RSLDd4C/pB9CDsIQTt0T+JlfFM31nsIhI3UXHzGVGLI+
 BjYz3ZyjNJNbcxW5wpe2+7GScxG+YFrCEgz28MhxQumKJ9gi5EgpnWhmWCTpNAkeZXNOdzr9eO+
 QUEX2PMsIQSyH07ErEzYdHOjl/0LlMuK6MKiFA1no25jLoL2DFd3M0Qz2ZQJxJfDSUAc5BOLhWL
 OG+eqDzIP5LIowkgFdNxoWprmXwOgTRSdttdIjdPNPpp/ZDqxe3LtGY/bL/pv0USysXUCpUcl6q
 WbEVqo23vhjOGqB4M0BtNzQpEqRECQVUjZpBmAxOlZsoYY9vpIkY2sm4vH6FEzmXFWMO+gQTVyr
 8T07Q7W4zQXLml90C4uOIXE+/6c6g9ss=
X-Google-Smtp-Source: AGHT+IFJBZhS2ICc4m7uBUpwN0JZy1Q08lXNqBPSXscHp6nMM4+C+dnGVxWHtS/TN2Hvbyi1P8JG0A==
X-Received: by 2002:a17:907:7205:b0:acb:abff:a5b6 with SMTP id
 a640c23a62f3a-ae4107c644bmr920126066b.13.1751904294783; 
 Mon, 07 Jul 2025 09:04:54 -0700 (PDT)
Received: from [172.20.10.10] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f691a084sm733394166b.38.2025.07.07.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:04:54 -0700 (PDT)
Message-ID: <af6fa38c-7c2b-4d8e-af1f-dedc12199c84@suse.com>
Date: Mon, 7 Jul 2025 18:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan> <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
 <aGvptwZtV26Dj7e_@yuki.lan>
Content-Language: en-US
In-Reply-To: <aGvptwZtV26Dj7e_@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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

On 7/7/25 5:37 PM, Cyril Hrubis wrote:
> Hi!
>>> Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
>>> supported we will get ESRCH in the second case. So I suppose that better
>>> fix would be to allow ESRCH in the second case if kernel is older than
>>> 6.15 instead of skipping the whole test.
>> Maybe it makes more sense to check PIDFD_INFO_EXIT is available via
>> configure.ac and eventually check for this support in the setup(). So we
>> avoid weird runtime checks. WDYT?
> And if you think about checking PIDFD_INFO_EXIT in the test setup() that
> may be doable. But there is no need for configure checks in that case,
> we just use PIDFD_INFO_EXIT fallback definition from the lapi headers.
>
> I suppose adding a check for support that would be called if kernel
> version is older than 6.15 would work as well.
>
If PIDFD_INFO_EXIT is defined, then struct pidfd_info.exit_code will be defined. We can verify this via configure.ac.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
