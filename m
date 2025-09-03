Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A05CA1009
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756901150; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=fyHNPG4CJS0b+LKhyEKQkQ+f5X2KzGJQSsS8WWRQQtc=;
 b=YuQP9ggmD8l4ISnWrHK4uwqdci/Y9eZ5MhepMiqrGxMUxHbs7QFkCOeD9BQPERN0lzUaG
 Eo/hG+rLYbeAXGWqAOIjZKLdFcWPfiO7A7ko0Q74ZrJy1ni+GyoeN5m2p1YgEtWHPto7LRz
 qHeQrwY1G7vKwTdNItQD5cK9dnTMFDM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E767B3CD3D7
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 14:05:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267743CCF15
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 14:05:30 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96F57200760
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 14:05:29 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-61cd1046d42so7897748a12.3
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756901129; x=1757505929; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MEYFrVhoqU2GN9ehJbPG19g55fyaIPsKHuTKKXfQBm0=;
 b=Fw3j6OcNNYlcRxP9KQpPG0VphzCIncq/DE3LTC+gsdCO+VvziEFlY9Zs4Q2USlB+J5
 j3u8yZz0U7HtKDgvOQSlJmhJnDI4usFX//OwREhcxhR2x9ZP6wgpoJY70e99HqWvb6O+
 2OC9RtjnsnRVBNVxzlhciry5ID0eimFS/FNk9SFwepuSrQTA4q4qK9qllnICadIi4PPH
 eIHB+2kcs1KsFP3gN7HPrUQYtmVnj+/JEoolXMXKy2LZ1oAwsdLHwgvYw3Ag2SzgWgX7
 H0gY1mDqce8KWskfGAouEr/pC+LqCCm2kdL7sBJc/fowkj7tRCqmy/8kCxvv3nRCrqwM
 Yk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756901129; x=1757505929;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEYFrVhoqU2GN9ehJbPG19g55fyaIPsKHuTKKXfQBm0=;
 b=TBE6tCjvA63aIp9CeWQjGStD6juxLfoquzyBIL5Q6XSt50BxaI23z7dWtIWDnzfNNu
 lKjcCoUAnUZAFBZQFBEvrdu7amkCbVLvJNwqSAVf+2JOBvkqyAylTXN7H7yxfze51Ot1
 pBPSct/3C5yGmJbfpQkW/1yali6Ag6nO+82WKfdZZTInAN/xxDBNLeLc4RGVPm4JgRnT
 KXzX+p8ntnSI7sOoP6XQQ6CaQVonORnKUNZdybhlU0pwq0/NxwPvMxkyrSHVyMNO3YRV
 SiVu4TVUqAhzCWa98JxgwN7uPPv6nw5i6All6BZtD/by4XRI2UchH1tUxsCjSKTsI730
 Thkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq2QZugrvMoBMiksaOe/gafGKRKJyAT5z5Vcn8iUrV2uBqRtFBfw6e01XyPcw+ioxrkko=@lists.linux.it
X-Gm-Message-State: AOJu0YwkWv7U71irn3wKNrVcSdljtBa+zVsMVHYypSmIPA2EGlizZkzr
 bEtW7e8HUcYtDCP6OGazRLyQvz/XAPTbWmiTfjmI4yR1sFCeyIBhu7d+JI7aRMHURL4=
X-Gm-Gg: ASbGncsjICrmII1L5Hnus0QW9RuN3qp/mFf+kUfTvMNbEIYBkA49ADsNPIW/EftXn0c
 FjaMhM0hYBxnjajhqU9yDlAFF/30v0dSyUk+T9MYomNXch6ISKeDQOM3BfVx4/o1AYy5YvQTeEV
 YJ90LBz6cvKVaWpzfIDPHDuCu84TD4wlskWKguLJyzgPC7KmsNqRiYtRzWlZ5tZ4eaMgqGi9LyM
 RjV1QbbhLvgygLh02SFW9c0kM+g3G4kIWC2LAi8Y1q8c/UIiex4Ef5QFtZSDJZLAB79B4iL149o
 RFHFOQsbXudolj6siHaAJp42Wfi7F0M358uioBOfZV18G3PNYKR1h5zOHKq2bws8oosRIEDxave
 cJzaaEyUz7rWJ5S8WgUR5a6NvZJklQ3vbaKJ7dVAe+iW1jiY8azj0mIJAL7EQrV6gqYnw2O3fjV
 HNV+7UcQ==
X-Google-Smtp-Source: AGHT+IG4IvXL6EZFWtxOftvAOhlPbUUQ9zxcpoJFw1fehqvpIxN2D4mjLLntk3rx5PkN6CQ5shSPjw==
X-Received: by 2002:a05:6402:5cb:b0:61a:1a57:31a with SMTP id
 4fb4d7f45d1cf-61d2689316cmr12737076a12.14.1756901128436; 
 Wed, 03 Sep 2025 05:05:28 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61eaf5883b6sm5224484a12.20.2025.09.03.05.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:05:28 -0700 (PDT)
Message-ID: <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
Date: Wed, 3 Sep 2025 14:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <aLVzVyaVhr4IHkyd@yuki.lan>
Content-Language: en-US
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On 9/1/25 12:20 PM, Cyril Hrubis wrote:
> Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
>
We are facing an issue related to sched_football test after the 
following patch introduced:

https://lore.kernel.org/ltp/20250829095635.193116-1-liwang@redhat.com/

Test started to fail quite often in SUSE distros, while before it was 
working fine: 
https://openqa.opensuse.org/tests/5283668#step/sched_football/6

After an analysis we are now sure that it's not a product bug but a test 
issue. There might be a need to fallback the patch if we can't fix the 
test before release. @Li WDYT?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
