Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DEC87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755001895; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zz/frjX6jBDvRz2iDxR14dTb0KmKDkPvLo1QeRzm7LQ=;
 b=dnmuawcWX8Egh4RyLRcX9iXhhDzdscFPrr7jFms8C1jUKw25T14XDBR83OKOmHTdt5cDe
 2oUgFc1UVhH21uTpFAS8i19LUd517h+u4HicjIzo/6p7KITwGItCDomXA8xrfD/XcUPQT5W
 57MneGlvHY2z39rSCL78MuAIXhS76Qc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 303273CB35B
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:31:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6CFD3C8E87
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:31:14 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 335EA2003BA
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:31:14 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a11a138faso3573315e9.2
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 05:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755001873; x=1755606673; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HKohlPsqX9yIdzM27h8Uc+G8sv8wqX/t4nKkZl5Cm5M=;
 b=XQJALvImKIL4/VWLXBqyq8DP3JZZwhjHv+Cu8ODYBlA6MR4SSiGvJlZXED6Ye+vbY9
 TEboprN/hegUvSQ5ZUlM1jxbLqXTY5fNKRwWFG2GKr7/pK7lpTWlQ303jMhFuUssw5uo
 qRHvSV2YxEV10itiyKbhCw/PYG57MCKpK5KOzVdA+P9x+Dz1mAOmtlg54CZ3Heo8OvyR
 Vc03Loq4hz8VOYo0NVUn/+p5iUIAk/GUlVeOIF5SuNXmJ10/+/leFedhbPs7G0IeaQil
 TyLO4vJWS9v1QE3ROcUWuzzZvJgbogn8iQ1qWLSiBO3XD6KitZG3FmhL0VkDr0T1mQE6
 HfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755001873; x=1755606673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKohlPsqX9yIdzM27h8Uc+G8sv8wqX/t4nKkZl5Cm5M=;
 b=mFXRMkbXL4c6ZfRF6OOrmnG7zVwa4ChSra7GPZ8RnHQ8H6KsPiUNHkwbWhT6xc9vPo
 Q1DDph0OpHm1H0HCx6lP3o298tJ8EbN8i8CZAI7z6RgD//zqCg7elLJ34qyJXyj5m7P3
 mfASdx309qfxNTyc45WSV51uhbhe6Stxzd1TNoVAj6XzTL4yWgkuBKuJlPjBZ9NlK4gZ
 moVWIToRaFNrhTbcVx7iMeVkcv00ZWmAPdLuglDjapy/ui85osLQp8DG4PLhBsGgO4jh
 VMr8p/MfjhlsGpOe6+ID5d2JOzXfe8bfaSnOA/4PljimRmxbD8jWP2HaxIqynYb1JDOD
 pMKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh+19BNum1CLu7REykST0vbCC8e8I7Ljd6yVeDkNcsjhFcaNhz2sIG0K+BzG9L9Da7oeA=@lists.linux.it
X-Gm-Message-State: AOJu0YwXEJnbZ1ZPnjHtjj7RRpUFZkRSfl88YesUaAsaAs0QuHgMYrFk
 NTf6LfEBIr+SDogk4JQVCr1AKI1TMWaNpWzuZP3VLYe+rXeSDtXGJgDoMOftzJTUhJA=
X-Gm-Gg: ASbGnctUxenSTJTotfnYkKx5a6bDUmIIxrBg2uW+D8TKeo4hZVr4UuDk8PHflZjnGpB
 m6JQvsjbqjiwwlv8peqO0faFSKQoR03mlqr8pRA7MCe2tn6wC16zIh0hXQXFpRRgJMO4M355hz9
 viInc9wZYmiSTolDopQ+6MfXZyrk13bg+7DJqOp8pawhfBNpv3n0zqpZeGb5rHawo8NytPEegNa
 hLI/p+hVbRUkQ4SDyQy/lnq1RcWICS9P97PpxBfAk5EITmfxykN3l/daWiEqbgmYQAnnZyl8/pn
 WUPeZALPUR6NndkRen2kpel5Aa2voRM+OlyWW+NUIsNz8wqOM7UubzfJmThGkhCaVoL7P5vq59B
 qH62IwAs7pdYXXK0CGn/bKqYhP+uoFpbNLw==
X-Google-Smtp-Source: AGHT+IE+3OLT8tJPBk7v+IhSADpClwK3EW+NXhDrAMmQFqFR50/42vqkrSoVi74qCzvWEYDJuvB7ZA==
X-Received: by 2002:a05:600c:1c27:b0:456:eb9:5236 with SMTP id
 5b1f17b1804b1-45a10bb6cb7mr35758795e9.15.1755001873412; 
 Tue, 12 Aug 2025 05:31:13 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e6867193sm299800775e9.6.2025.08.12.05.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 05:31:13 -0700 (PDT)
Message-ID: <d20c29a5-1852-4eec-964b-5b8f9d1eb851@suse.com>
Date: Tue, 12 Aug 2025 14:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250812-cve_2025_38236-v3-1-48ce90adc216@suse.com>
Content-Language: en-US
In-Reply-To: <20250812-cve_2025_38236-v3-1-48ce90adc216@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: add CVE-2025-38236 test
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

I can merge v3, should I add Reviewed-by tag for Cyril and Wei?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
