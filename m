Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F9EC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713532749; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1RyHBvAcjQwUImULq35gDU/vmL9R0hnjonghXVgpFHc=;
 b=eeDSH0IDwaZ43mZcMT9+mnNimIxdO+3cZviM3SxTPltEFJtnRRXzh/SvZtAtMwYMyRNYq
 1/CI0RleX40gWMcrx/LR0EFUIj6CGrEiZEzCMw7FoRJ4/qBFDdTPS35P01vwWkvTigFmTbt
 6K2mUzHiZy5YMQP9ffPq591IsiD3nxs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 000763CFD84
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:19:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31DCB3CF511
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:18:46 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE019101543B
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:18:45 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4196c62bb4eso3268375e9.2
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713532725; x=1714137525; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p7U/c6ikGpTuIo2U8GtLPK9bnOR48VNVUU+JSBJnRCU=;
 b=ERKIC04lk1lRq5nkxa55D3YO7f6rMmL6/HdoNNFGoGscYRl2y9ZLiu8UKZzAdvDd/v
 sJJB7tjlh+5Nsjy858s+lPo7U7Ha1wqzCfIC8RjFiVb3dj1lcNRmfKRL09X3ujA+NzzW
 8l41I8PVflaE02FBbjBtq/gMjdROZoUWfWZhT5HerxkuDPJYjibmMX23a+OroQmlIjA3
 FuJ8MavWn4ORscfqad53YJOCa4HZcPwlyN2C4Y+vFIlskg6JFNG59t2iL/Kxnlyl5AUv
 OdYzYOgxyjipgBPnlHna+uDIKt8Yz2ZMCG439UKzSj7Ybiukq2foBScKHUjm+Yi+UAKO
 jzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713532725; x=1714137525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7U/c6ikGpTuIo2U8GtLPK9bnOR48VNVUU+JSBJnRCU=;
 b=FtxoIXs31cql0jsRX150HVCGBRYxQyL0hfpWTXlvfUzrZRWtL1moloOPRbd/3BXbSd
 xXF4BnU42bWncp29KyTH1MoSSdDcDRYXB/SdmOuaJ9KbvTDRGRcjNx1a3Om6yj6KSx+g
 BTDpuso0OJbfvc32CAGcbSZXYfqGdQC279BP9MzPqRqx3AAC7g3zFP/WEAWsFKpkAutZ
 YrqIjNzNZMNcQKD6ggdRK87M7zw13ybW1PCzwwKDL9m5HYamfg4jpfgX+LDTb1YN6Zky
 jSc7QCrP9YT3YlPJbMl+B19NCFMeBbRS9pjnZi5jR3u2qwtCIPKBrLwYVWLpRoW/XTBQ
 z+Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz988qBUaOjtQNm9j5X9ofRGOSFPBxCNYrzG7/KjQ5BA4mZcVdbr4KTaT2S5Pg4AtqqJjO1Z7le1P64oZw+NNzWUw=
X-Gm-Message-State: AOJu0YzITnhBciiirtZkF3+1KAPSWCRiFqU3YWCyKEEI+XmE33/gnZDZ
 zXCZJCichXXU6kyYJNxpnwmQphCifl+sB2riro/8UD7zwaIIPYDP24InPMAOFgg=
X-Google-Smtp-Source: AGHT+IHLKo+CDscyJdqO+HZSce6m6BHHKJOhtlZm6HXa5G9MCNNu+gtrDiUy+o51x9yvOnNHSd8rLg==
X-Received: by 2002:a05:600c:1988:b0:418:bbb6:95b3 with SMTP id
 t8-20020a05600c198800b00418bbb695b3mr1701268wmq.0.1713532725225; 
 Fri, 19 Apr 2024 06:18:45 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.180])
 by smtp.gmail.com with ESMTPSA id
 ay15-20020a05600c1e0f00b004189a5ada3asm10340745wmb.19.2024.04.19.06.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 06:18:45 -0700 (PDT)
Message-ID: <0df81a8e-d450-4806-b425-82867ca8da3d@suse.com>
Date: Fri, 19 Apr 2024 15:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240419124221.207445-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Clarify that the only public CI testing
 is build only
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

On 4/19/24 14:42, Petr Vorel wrote:
> Also convert .github/workflows/ci.yml as link to github
> (unfortunately that remove code formatting).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/writing_tests.rst | 4 ++--
>   doc/users/supported_systems.rst  | 9 +++++++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 032fbcbd5..3db56a558 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -346,8 +346,8 @@ Testing builds with GitHub Actions
>   Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
>   to ensure LTP builds in various distributions, including old, current and
>   bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
> -architectures using cross-compilation. For a full list of tested distros, please
> -check ``.github/workflows/ci.yml``.
> +architectures using cross-compilation. For a full list of tested distros, please check
> +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
Maybe we can store github link into a variable and use it around the 
documentation.
I'm not sure if it works, but eventually take a look at: 
https://groups.google.com/g/sphinx-users/c/OitnjX8SIA4/m/7_kUL0TaCwAJ
>   
>   .. note::
>   
> diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
> index 82774c2ef..a9086f4d8 100644
> --- a/doc/users/supported_systems.rst
> +++ b/doc/users/supported_systems.rst
> @@ -3,6 +3,12 @@
>   Supported systems
>   =================
>   
> +Build testing is done with `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_.
> +
> +.. note::
> +
> +      There is no CI testing of the actual tests run.
> +
>   Kernel version
>   --------------
>   
> @@ -38,6 +44,9 @@ Oldest tested distributions
>         - 10.2.1
>         - 11.0.1
>   
> +For a full list of tested distros, please tested distros, please check
> +`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
> +
>   Older distributions are not officially supported, which means that it
>   may or may not work. It all depends on your luck. It should be possible
>   to compile latest LTP even on slightly older distributions than we

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
