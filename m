Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B726CC02188
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736932245; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=KSEvrEB/P/yhzzDe4OCyymTXuBWV33V5XxeY/Bj7zMQ=;
 b=OVR41wCltZ658XNdWUoQlgYVAxPVWXVMkcTxpshfxQL9olglu1gpBCLM878hMGOOTDzKc
 GRrqd71e3XOwJdshzILNYXqvB9TZzn1LNuR2nz/xF3GuD/ShZ/mzw8NGjuQ8ZOVP/CgLMOW
 xDv+/KBnNb8/FMjClTethJxvsNK44Z0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C1223C7B58
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 10:10:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F2253C1D15
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:10:23 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E6FA51000C30
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 10:10:22 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3291120f8f.2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736932222; x=1737537022; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r5NAIMa9PDhqlykNBJc9hBarzpMLMVPvg8mAtYNQxiU=;
 b=R85bWDulccXGzgxY8T8f/80PzfKOG+MODvuejcFVR1+DyCli+ikl5H08BLPhmuLIk6
 y08QbhcpGlB/W1TKGFBNRsCLCtYZJWgGKFSkus+rgaDvrtGVMwBBARgPL+LmjWDQ0XWb
 HAn0TkpBSWqOsZFmklyDyxIIC0vSm2KNY9y2qFfru7YEKH/ldOtFRmO8/s+PxWth3d/g
 mlhFwYOQyWtXsHOhGRRC5XtBdcelWEpE0lz1nKSj0mRKFhChhEf+o/EQUwY30LRSv5Xj
 +N1RmrB9mDwoqDzj7WlY4SpRsyV8jbjWQ6n+nt2UJUZPgjbMSaR70aUsp5tA0TykAh9M
 kcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736932222; x=1737537022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5NAIMa9PDhqlykNBJc9hBarzpMLMVPvg8mAtYNQxiU=;
 b=Sz0+ijnYlbeotJGu2vu+qpLrbRy4jNhIfOob05EcnSpPDxjfCMHHNrH3zudUv1pbOn
 9Vm5V/E2NaTM0HwotlIVn+QM/cotRrAeHSGUDWmLxd/CttYFEERZ76z9Hlk/VmZYMISW
 fa73nK+Bb0PrGrNKdArUJKvWhLGV5HWyo504CmUvQRBOjF6MrYqVSnTgutndccSM4juU
 zN+f8GpYeJVhh4yKNpQkLvTYr7QBjeZIlVYUhWsnM9wvAES2nMHqQDtQrQiW22xChpHM
 1XxGJxAHlzIhuOOivOwmfudQ7ac9PUce1CMA7MEynnXOUg9hnkG2obF5AfYhClhrOB1p
 /CTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6a1AMjwW+oWyBHWU5QIJ9mJTeLQhVlTQkRNNJkv6mnRN0bveMKOef9pRoh1dOFVZZkIo=@lists.linux.it
X-Gm-Message-State: AOJu0Yzdxt9TcJQSPLJzyp3bQ4eez5/xmcfYiOmj84qWVf0TPen+om0c
 Eh1QJn3RkmcchaNEmkHkWUQWZF9P9mzIZC0hk576EA8yai2Nxx6LqgQsYrKJ7FE=
X-Gm-Gg: ASbGnctkkfsQrMWCLliDU/YQmJf/1E5AELKnFDQEz3ugE+5zvQNmwzkxYTZvq/VpC1c
 NocVUK2aSWJBP8Ughx0vvYM9kVcSz3O8nr8t6EqFFsmjE1C052pNSWmcUoEz9MC8o+QcUmDycPO
 ruk1225IyE8+h0Nw8plcNs9bK7ptY2Dl1fFccPvKOLYuuz90wo3KwH0aHhJBXtcKdXfRmau0EQ3
 OIkQEsX+o3pTy9Iz2poj5RmtguBgDDYudYpq8ML/CMRgjC8sTrTGpyK+Z+Dvm5bqLjXWAYdm1KD
 D5dUB2fnt1wHdUJpq0r36Ck/9QRhKr+x0W0HIp4C3nUPF/BNUtSLVno0tyinDt6EEdBz5X479S5
 5ZR546Hj+7jihxjmw6dY=
X-Google-Smtp-Source: AGHT+IFtLXk0i0kxkN+6Odg58Hz4ZtGVK8jijYrTWF1txMh3SyNW62vs92cAtt2MZ6WuimRekKdH7g==
X-Received: by 2002:a05:6000:144f:b0:386:3b93:6cc6 with SMTP id
 ffacd0b85a97d-38a87303dd6mr26165368f8f.15.1736932222296; 
 Wed, 15 Jan 2025 01:10:22 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3834fbsm16864296f8f.26.2025.01.15.01.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 01:10:22 -0800 (PST)
Message-ID: <78aa2033-384c-4e15-9bad-2c104526bef9@suse.com>
Date: Wed, 15 Jan 2025 10:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
Content-Language: en-US
In-Reply-To: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] .b4-config: Add checkpatch.pl default commands
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

Hi again,

On 1/14/25 23:43, Ricardo B. Marliere via ltp wrote:
> From: Ricardo B. Marliere <rbm@suse.com>
>
> Blend b4 default checkpatch.pl flags with the ones defined in
> include/mk/env_post.mk in .b4-config so that a contributor may use `b4 prep
> --check` and `b4 am --check` in his workflow.
>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>   .b4-config | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> index 2efdf2273240dcf57bd5cab174ff6c7a1952dd5b..5a16bd64ec98b91e17386c0eadc7ef0de54d86f3 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -4,3 +4,6 @@
>       send-series-to = Linux Test Project <ltp@lists.linux.it>
>       pw-url = https://patchwork.ozlabs.org/
>       pw-project = ltp
> +    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
According to checkpatch.pl documentation [1] , we should probably ignore 
the FILE_PATH_CHANGES here, since MAINTAINERS file is not splitting any 
responsibility towards LTP folders and maintenance. After disabling this 
check, warnings around file add/move/delete disappears.
> +    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
> +
>
> ---
> base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
> change-id: 20250114-fix_b4-config-1ab84320000a
>
> Best regards,
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
