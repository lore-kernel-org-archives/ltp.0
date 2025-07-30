Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36F1C87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753877118; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0lYqAohz8OStwQ7VnHrwkfp6jPO/HwVmrpcUd4I3Sug=;
 b=RE+cVs2KcOojtgDshjOE3VuF2pPfItbwX/CAhZtLUveBEjjLZCoSuldEqUxWR150P7W3y
 ts20y7dmgBeajkw39wVOSgd++chDOWBWxC43VTHWjG9TAcXeWS4LL8149TBIBSM4IkpQ2K7
 8+ULHFQ96UIGXTksV8Ryl5p8QmzPlVM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5182C3CB046
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 14:05:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00A743C2FE7
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:04:57 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C52BB1A009BC
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 14:04:56 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so408043f8f.1
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753877096; x=1754481896; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+JnAI7FLr1zRTdIoKUuHAwIzaYyCULhggvbMzYdrf4=;
 b=cG0ui/qFnLC1L/XL8AJok8z8jiiUx7TvXOIX7VwfDz5TckR285SYkz1tmln1vW0j+m
 OE5iSy+ZnGzbR0jlvC5yfn5jScSQk3v1AcziocTEYNPqS6uWwcaE1FTVn+ypYooPNiKp
 1GdH6aeMX1eCHAUfOhLfL1vcOT9UTwLDimHEupzuKUAcXrMqUPTKNJFc2aJaOOHPRUDL
 TUM5MAOSeZxgJntJwYi4SRHhnWsXOf8MM7SY5RIYNinHUORGVa2vXrgcFqXScBYK+9b7
 8sCZ4Bey5Ssa1a0RW8TNIS1Hr5oUZgKMU45XKMguKX5JuXVpaONqtPEKtEfD9wByr9jq
 UNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753877096; x=1754481896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+JnAI7FLr1zRTdIoKUuHAwIzaYyCULhggvbMzYdrf4=;
 b=LR1Egtwxytf1xmQEmsu7VgIwc+uDdKCitJIQGrn19zxoNFVSwnMHM5ukp8P241R84G
 SKvLLR9hSxT7cO8eH2aXuGgHoDPUQGOAYr6HtD9VHUHMGJj3bAR4BI4zt5G2jnkzrXoA
 WsDNvIk3z99NZHUbbCFqRbURAfghbPam3fj3yQ4/sPYPyTNRWusvXyQYz0NYsJSPB/KF
 swghhbNucc2bX0N2SKLzJPowbRBA+pO9tGiYYjoaKMhw7BGHpwV+Y8Kd+ljXURAao6hW
 lQDKYkDpO75i48sVwt/+87nhEaO65GoQXx/X0qEvdZXpNmEajSaLaXNy8CrmozHcPYqH
 I3EQ==
X-Gm-Message-State: AOJu0Yw9/+UY0tdq1VE42i6dJc7n2lOABBTwej1h0um62Q1MOg1s2WrD
 FoqfqVWSeZ7cuDiYhZr595+Zg3JRYvupUdjlWzb07V653JcSxTrBeCqGcByE5NZCLP8=
X-Gm-Gg: ASbGncswam1USGMkPcZDQzVfhOFklUpsU3akK64Z5ULHVi2eErjv+RzSScrUjjpX8rN
 SMxvXdHE2s9UaUCiIsCOjKquSSE/l8P+MAjS2t2KfDIHIK9epVJRFU1/F9de3Of66NKwyt/yw8C
 UuL2CjzPWYKhCDXi9jGHSOsH7E0nb+tIJQdsXF9+KlSSIPRYsPowoBxdDW6TDgJ/qYHHXREiQAa
 znqUBElk1/NE2HpM1HtaTHcIXT/xNDhS1bU4z3rcz2rhc7HdHPdwpq2LSq+rma1cMAzAYTdVS/A
 y07KdR5DZbOUBsZOuzwI1M4nywKE4dRW/USDX1EPCOnePdOuHfPAo6vhln2ArLcMjpoDHreAq25
 eCWEmQ4DhlT1eOmAWc9WBOPKaQIAtwEN0wQ==
X-Google-Smtp-Source: AGHT+IG+3y34902ek8pLvc5UqIbLgdg12cHcW7hSj8FJ03+TsHrHyv2QKELF2S89BVzbVBi4XnxFnQ==
X-Received: by 2002:a05:6000:310a:b0:3a8:30b8:cb93 with SMTP id
 ffacd0b85a97d-3b79501e4c3mr2374454f8f.32.1753877095920; 
 Wed, 30 Jul 2025 05:04:55 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b2dcdb4sm10428882b3a.100.2025.07.30.05.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 05:04:55 -0700 (PDT)
Message-ID: <013b634e-8d39-48c2-9e5b-e54f6f65da7e@suse.com>
Date: Wed, 30 Jul 2025 14:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250729-ioctl_pidfd_supported-v2-1-f9ef90134138@suse.com>
 <aInnRVfk3uR0cUIU@rei.lan>
Content-Language: en-US
In-Reply-To: <aInnRVfk3uR0cUIU@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Correctly check if PIDFD_INFO_EXIT is available
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

On 7/30/25 11:35 AM, Cyril Hrubis wrote:
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
It seems we need to add also a couple of errno checks more. 
ioctl(PIDFD_INFO_EXIT ...) starts to fail with EINVAL from a certain 
version of the kernel, after introducing `pidfd_ioctl` function in 
fs/pidfs.c, while before only ENOTTY was raised.

After the introduction of "cdda1f26e74b - pidfd: add ioctl to retrieve 
pid info" in v6.13, the logic inside the kernel changed and we get ESRCH 
error due to the introduction of `struct pidfd_info`, but the lack of 
PIDFD_INFO_EXIT support: at that specific commit, only PIDFD_INFO_PID is 
supported.

This is due to the implementation of `pidfd_ioctl()`, that is not 
validating commands before asking for a pid task.

I guess there's either a enhancement to do in the kernel implementation, 
or a lack of checks from our side. Since we are talking about 3 versions 
of the kernel ago, we should probably verify that kernel doesn't support 
PIDFD_INFO_EXIT by looking at the following ioctl() errno:

- ENOTTY
- EINVAL
- ESRCH

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
