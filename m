Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437A2C77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750749536; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=2f4vv5iDFXgK9+BYwdCBJvviJAmz2LvEFU/ftBt771o=;
 b=QcthSXreWH+Z6TplyE08slQdF98OKO5svX+MdaJgfoMzv/w844hHEpURyrdHvOlENFhtD
 orq6ZiV3co9hjX/GprB7F5kx2pADMpMjwoOqOQetraZQl2zJtlplNTAhrw5kjcKueG5Gpzn
 qG5a1uSJi56eTrne4Xdq4xanjKuYHck=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6ACA3CCA7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 09:18:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09D1A3CAB13
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 09:18:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37481600D0E
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 09:18:35 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so57163105e9.1
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750749514; x=1751354314; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2KZdx4f3tP6mcRmyuG/mUFGWKmAc9s9OewKlNQ8cc0c=;
 b=b6guNeccP1JGhRBSsBFU9VRdByCB/GuE/XBAnRgMPPqGGSv2prATj7Y277uCr/HT4M
 c2Wm3jl7CA2IuIUN7Kpzeb0w/yxsWyk81KxgnF7sCuCGQgeqiXqcW0s41ILQ8XqCx9Pu
 jumnK2/adda03xAsT9+8gI5vG9Qu2xxjqCHILRuCtS7j9oA5ls8H9Dx+HeLrV6iyjmp3
 a5iUT06uCvhQK1uGJMV6/hhZdAeoSe41jf2SSDqlif5L+L9uQwOKDmkhB/G6wI3nPBbC
 iWFDPFW+RtY12iiHmjUPLc5B2XpGw3IlT96uqPhBG1InqobeLdn7EybasaUs0llxEBu1
 aOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750749514; x=1751354314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KZdx4f3tP6mcRmyuG/mUFGWKmAc9s9OewKlNQ8cc0c=;
 b=MQiPE3yl0175FaJca9fLYaBK8L37YRrpS2tArVrRjrSfjKA5bo/CdfsfaRf+LWEN/7
 vdWO3eUw4iOLCnAjPpcx7ygVcgdnD0+IV0k07C2Pt18dYkf9Frgrj79yxZTTSmrFcvcf
 HLZ88otnYVFkHXhjIk5m6tXQR4TAoojZu2xBVXCZqBz6hyTvlaBEHQ3VmOmurg9Ybsz3
 6RKSY1Ftpp/ussqcXiVHinTsCBTcO8g9QKrFZtGJKQDvmns20rAYHRR0EAS4NjxDc3Ph
 PXeMZmsdoia6nILB8WKNxvwQmiFwW2zN2fcmluaxnaYUYtElN+muEIGkGe1XRGsYuKhs
 a25Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9b6djreFZ4bpeLa70LzwhpWVk1M5EyGek1d9hAr9bplvUgCdgPuRPhWj71y6pJDZF79E=@lists.linux.it
X-Gm-Message-State: AOJu0Yx596T+2smFpyjSvHas/Si31DHw5MQEtoEu+4eo793kKgh/dRmm
 KYpHEDVQNFRfZoEEnILZqhRPMI1czEXlfYUsM+0b27Bx8gQkIjNXaIqhNc97pM0D+C8=
X-Gm-Gg: ASbGnctOtcnS4wjLzqHT5NlwzqFuLYBIOBKn70msosMd2F/2I/qavCKwxv05uqnYzKj
 pwXFYCDF0D9EoWTUdvpT57xZ1ctLb7avQ8agWDxVC75yQPdf5ZhTDn/zivc84Pva78nuKFaJQQN
 3/4nrApct2zUnI3iaIUjZCJ71QOG/5F5NQtDl0d6j/Qlb8i6rSOqWaht+3mS8SHDFFaturXO+ew
 Cx5duHH567dLtwzlxBCSjlPizJZDkxXIf0rcUdoSpNiqI8Vvy0WrIo7a/CC5NkHz4mt8e/FMFAU
 NWlIEwQt6hKWqJfFnVCtIeq0CVHfaFwZwL5lVVJDBp0jz5dEKVX2QF0QMc+bANuambxbcYUUrpd
 LoHfhnxNHjW97FkYbkI7HnbjCksvh1N5qPK4T7WgPzyoW7Dr4o0nS7GIIFJCHS/U54o9qAtlX1m
 SUdHJi1ALocpiKOAgGB30YXHN/0A==
X-Google-Smtp-Source: AGHT+IE2cZgsikye6P/tUShLVpOhJkw+uS5kMzvFm7jju+3xBdzmjfYwhiN6JP+Wgqg6JOxGx1WTvg==
X-Received: by 2002:a5d:584d:0:b0:3a5:2694:d75f with SMTP id
 ffacd0b85a97d-3a6d1331a3fmr12021312f8f.52.1750749514574; 
 Tue, 24 Jun 2025 00:18:34 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8695195sm102907465ad.187.2025.06.24.00.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 00:18:34 -0700 (PDT)
Message-ID: <d4eb5139-c01c-4a16-a026-a6d2dbeb2a8f@suse.com>
Date: Tue, 24 Jun 2025 09:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250623-conversions-set_thread_area-v5-1-7fb49fcf54d6@suse.com>
Content-Language: en-US
In-Reply-To: <20250623-conversions-set_thread_area-v5-1-7fb49fcf54d6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls/set_thread_area01: Refactor into new
 API
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

Merged thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
