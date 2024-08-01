Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A7DC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722522565; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=YcZ4gxFw6ffAutJpbp/eQUbY1Lx7zHvd8UewnA0vvTY=;
 b=Wo9UcBuX3w+OnAO3mUnBw+myu0rwOl5QYFoon1C9z2H2E0D8s2BxNWAqH2nHvIECx3PCK
 9QKlyGs2ipmpp9BFMsSP1Ypz1weO17RCuGzOjD5/q2aaiD+7aeOeTOPsiVDFSRN08oPFgmo
 IWinXSdPJxWonqlI0FyLDlrvAYGZMFo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1345D3D1F0B
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:29:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 399643D1EF0
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:29:03 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D4D0603A2B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:29:02 +0200 (CEST)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so38461475e9.2
 for <ltp@lists.linux.it>; Thu, 01 Aug 2024 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722522541; x=1723127341; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4d704xW13K3CF4XMEGf9i7OG03FBbL3cNgrZbXiTjQI=;
 b=S9kRQNNtXNnK+fQAzHH0vFTBaY93vyh3bFVaixVNvevSjBCZPjmC5z2d4qxz/HPu21
 fQKeFTdjIXFbvkO2ICJnLBm9dxOjn7Yv9j0kcdaat1/x8EAN0tZo0puIDqA18isSPPWy
 CgXgxNeRHrH8gri2t63Sb3KFQbUDPrOTih+T2tPdM57WYcAGZyon2Q3EwwDMq0foQXGm
 Hc4B2C7+nEenH+SzMJoV2fx/ZiekBjyXPhW3oRcSg25tL3HPX4lIfz62yquQW6c/z7YC
 KvONJeUCPizpwqCedghRXOxmVPvCTio/UL385RBK5agSN5sLI/O466SqmGyAJADwracJ
 6wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522541; x=1723127341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4d704xW13K3CF4XMEGf9i7OG03FBbL3cNgrZbXiTjQI=;
 b=BJXsrzwmBQdnCJdjLdynfAVEMIquTj3RltjhBRrWA9+SfYUVAYjkVhsWlobO5qv7L3
 ap5Qq0IptHv3NEdNniR2AnLU3JLiYhFp8Ie/mexwxkocyxJgGquFk9xxxBPn6Xr64xZy
 E79XnLMm4SAKn8kr99+Ihys9r12tXXcrLR70ox6B3Qqo15AjnVReoVPS5YZaeiV2sTof
 pK6KmNOaOiHonhZPB8xWMceV4ERhveRfiMDAql0FilXhFuaX8fMtQhtU+ELabam/Frbw
 n0z8xwVcFmnI5/T7lpoDfnR2ZGFl+vLTF1TKv+LWKV8Wd4Tuwba6e0XYg5Vvm1GH1Bh9
 pZMw==
X-Gm-Message-State: AOJu0YzcxRfi8jcVutdNyzHPtPdS79wfdranLy2SgMXSDcZyhvfcsVu8
 YuJ7373i7soAC/CCzBMSZzWXBAZLj4OtyvhbZVoA3iWlla5rMtPGA8HzZ0HNKjo=
X-Google-Smtp-Source: AGHT+IFG4UeaArqF4L9FVhvIlmzIE9winI8PzBLu/ykPmJCJPNG8j0zs/tstrXngp9tAOnvIczITyg==
X-Received: by 2002:a05:600c:4fc2:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-428e6b7cac9mr271165e9.26.1722522540851; 
 Thu, 01 Aug 2024 07:29:00 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm59961215e9.46.2024.08.01.07.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 07:29:00 -0700 (PDT)
Message-ID: <ebc31d5b-a284-44e8-b15d-9a3ee0ae863b@suse.com>
Date: Thu, 1 Aug 2024 16:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
 <20240724-fchmodat2-v3-4-1dc7cfc634b8@suse.com>
 <20240730090913.GA1337464@pevik>
Content-Language: en-US
In-Reply-To: <20240730090913.GA1337464@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] Add fchmodat2_01 test
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

Hi!

On 7/30/24 11:09, Petr Vorel wrote:
> Hi Andrea,
>
> FYI when testing on Tumbleweed 6.10.1 kernel the test fails on all filesystems:
> fchmodat2.h:17: TPASS: st.st_mode == mode (41471)
> ../../../../include/lapi/stat.h:239: TBROK: fchmodat2(3,symlink,416,256) error: EOPNOTSUPP (95)
> Also, file and line should be from the test (I'll note at the patch).
>
> Kind regards,
> Petr

I explain the reason why fchmodat2 is failing with EOPNOTSUPP on recent 
kernels in the testing suite cover letter.
It might be a kernel bug.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
