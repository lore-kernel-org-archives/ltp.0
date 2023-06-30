Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A77EB64DC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 12:49:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FD4B3CC0FC
	for <ltp@archiver.kernel.org>; Mon,  3 Jul 2023 14:49:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DD573CC301
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 05:33:04 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F7A01000D0B
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 05:33:03 +0200 (CEST)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b816d30140so2745125ad.0
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688095982; x=1690687982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3XBHvQH3uIxxLS8CwCiNAKUehD17JfQCMoxGtmhztUI=;
 b=DjiI7a7Z4SMhThUzxj4J8G/r4g1noxCpcWXdJWVB4NChhRaqJB90q5HrWL4sxhHQ/n
 ay23CgSzaTmcdeZBGHOTQZ8YFdAWnqSPO0BwLaG0S7D7eOp2/bA1sRPW4nvCr6VYnFnl
 QAy6ieOQuk3nfS0QOZg+SvW12OGVEl9VB9Awf7SfyVqecid6mfLUnGPhQQLLeEbJ+3XR
 WCjVS7QV/DyoAjXQA1/IvL1ghHFSgOQLjURH7XEgb4clFvuK/MormuQcGpM8ZRgs7URo
 k61+eLggmyk3Ir3wqa/2g4rLsZvkK9eAGeugc9bLFqdefFyTYNO/hScENjbAC7XKXMzv
 RHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688095982; x=1690687982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XBHvQH3uIxxLS8CwCiNAKUehD17JfQCMoxGtmhztUI=;
 b=jmxVrhdJO8N1f8pHEf4Eu3x2RR59SPjlHWkpMWaeCb11XPKmFGuLCqquVI53PSSTCM
 KdEGgRDnTe78qJYGGRAQJOdSLqoYdNu5JYMSxc2Sx3pQeMbrnHDp+G4xyloIhvHsTFGU
 kQ+lrI1rSo9VuRNY1wN0zyCyw8Kw3Qg9/lgEFkDS208VSCQOXis1IRTaOMKV3pFe773l
 6UDTA2ZJvKMVMFCFbBtuThHJsJrZxg34oKPFJNhLzXM475G26XMXR6UhP3gpxpC08hm8
 NI3njGHWwzxTBsN8zABpe9SUnOFP+YMulfmtzQ0mh3ykhIsYxNX4ziFqyaiwGj+oVhQV
 /HKg==
X-Gm-Message-State: ABy/qLaOsTexbh6liCU90xokWQIcl1HVHQ7Ubzkv5kFkKummhHJ9mMmj
 VZTnH2e/GqZzgn/7N00KaG0=
X-Google-Smtp-Source: APBJJlGnYbpWF/mVBqUVpFhoz3G0FuzKKS2ZRpro5B95NAOqOAgBcYD/fjnE/xfJ5h07hwIm1pPmzw==
X-Received: by 2002:a17:902:e74b:b0:1af:a349:3f31 with SMTP id
 p11-20020a170902e74b00b001afa3493f31mr1158367plf.3.1688095981881; 
 Thu, 29 Jun 2023 20:33:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
 by smtp.gmail.com with ESMTPSA id
 jn22-20020a170903051600b001b3eed9cf24sm9777459plb.54.2023.06.29.20.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:33:01 -0700 (PDT)
Date: Thu, 29 Jun 2023 20:32:58 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <ZJ5M6rGjZuimL06F@hoboy.vegasvil.org>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 03 Jul 2023 14:49:15 +0200
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs
 device attribute invisible when not supported
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, lkft-triage@lists.linaro.org,
 Nathan Chancellor <nathan@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 27, 2023 at 04:21:39PM -0700, Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.
> 
> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/

Acked-by: Richard Cochran <richardcochran@gmail.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
