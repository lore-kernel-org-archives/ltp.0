Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2702EC28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 13:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743166964; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=kIZREWkP6jABOBI6a1mSQUZwySUapuGLxCGSZBzqXj8=;
 b=SNfqti88tD1X/PTNpvgYEGBlqjh58lyzFtUuRj4B123JHhVazVQZBDKSZQvvo2GI/gvtB
 CYVgI7TL6KtSdi9CnikR4gr81ziycnqAXD1ssl8Js5YDoi8+3uv7+hPBhA+4R2Grq+1PU6W
 0R5OfpZpVgxhn3iCe8ODDVZ016eIv+U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C4953CA3B8
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 14:02:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4E93CA27C
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 14:02:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E48E600990
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 14:02:20 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso21788365e9.1
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743166939; x=1743771739; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3B4NcDWawYfDYOUY/ufsL0k0Bi13Br7sUjBsFrqu7Wc=;
 b=bb8WXejMXP7fcEvVkPGPrWhzPx87P3niGYGPoNLJTd4t7FG6DKmTjsKyl7cjwJINB2
 9qTEax1cdeCmm1SQGMIssNrYfCyWugHOCyiwn20xSd9xHmeBS34CSLayhLO+ITwVOVrT
 kMDSRh1M5EjZVf3SouwK23Vu/XWyWtVua5fSrE7jVQXrwAhGq3p00yNpslRSs9sMp0l2
 I2oEoK3TWhRNVKoZr/pdCgPivZEfEF5WSTTDZr+zbtNnTBdaK/l6HaHeZfd3ZvNK8Gqa
 p2PD9xNxml7tlOiddO31WlV3tlWQb/C3y9GjzBNGX4Ce7b8pi7vAG4ouc1Obr9R59fr4
 MASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743166939; x=1743771739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3B4NcDWawYfDYOUY/ufsL0k0Bi13Br7sUjBsFrqu7Wc=;
 b=SfBYnFkQ5yXHjZ7JmOUHel8igfdnWXeDaALBcAvi1CegikHTjN/4SaeVWe3T5YhkNV
 ugi9pFEIaR428cM+AqDsE+tA0GN9vTCsaBOuKFNKLwzf9arJImYjxjrgULCMgxs0cbPX
 b8W6UcAGkHMwT8qjSLCE2i5V+fFq+V5IZPMdXXiMRITagTMBmXd+oYi4Ca67LfIV61P2
 ctnemgQZhAG54fb3SfVx0cp4TFFXHSrJQ7MKmwdQ/On7CggE/ZCDCwU5LCejZLh/3RP7
 OPRhwFGzXy3vfPpHuyBj5idQZUq1L5bPk9ZfPuGA387zHH0l7k2fU6WQ97PV1DxXLlpJ
 GOPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzO/1iukY8IpWfD0pVdn5gzJfzinSoKATHuVo5eHRKs/EX1siX88T7pBZyLCm1AfCITFQ=@lists.linux.it
X-Gm-Message-State: AOJu0YyhzaGpyFAB9K9GUPcP5S++NHokNU38cD6teQcVGuuB0+uY26tz
 myP96l1rij745AS5HYPjF+zyfc3OqB62JIt7UoqIoVzqhpZ/LIhpBKmrJIrcKUw=
X-Gm-Gg: ASbGncvGu/ZGWhJZg0j+xlxLhv3YX+stdA7edl3Ko/ZTxjPHyLEPROjQYq6HwEO2Pjj
 h+zuO+WfoICcWRiOi6/1G0jtgQX+G3bsC61HmBrKSpS+Ano/jh3zgNrdKdP8W+sktQnpvh1xLHA
 Sdu/hsyhW0SHNryY1yZWWnD0kfeAJiZu1jvIy2k9SS2h6EZdLuGrVgBYPev7Gup93CYqnyyhB7D
 GvlBpjBUE5E9U9Bf3vutpkE5CmNuVmrtoMlnC61rHqMzAGRu6z1jO+MehpMHHhOTrtSmQuomYDw
 inptO/xMOLuFkxzfvDvaI0BpGnw67RHxE82nlxFkYotJpIOqHC6m+llPbjfrbDHotqipLOK1OG6
 5BhsfyWGCga8N3ZRgaRHFxzS3fPdD/lKfEpbgxJnnNHd2LH3qO/+Z6y3A0thUvNEO3MzK5KCu69
 c3h7MB4JU=
X-Google-Smtp-Source: AGHT+IFLDJDw8ao92bHrtna9micXUYN/4a7Jm32Qnl/JBYHrFWyxybRRy7WErFV8c18cJTidQjm3DQ==
X-Received: by 2002:a05:600c:35d1:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-43d84f5e757mr63399015e9.1.1743166939315; 
 Fri, 28 Mar 2025 06:02:19 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e83482sm72295975e9.14.2025.03.28.06.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 06:02:18 -0700 (PDT)
Message-ID: <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
Date: Fri, 28 Mar 2025 14:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250328095747.169011-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] doc: Add sphinx to requirements.txt
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 3/28/25 10:57, Petr Vorel wrote:
> Although that slightly prolongs creating virtualenv, it's probably
> better to handle it as the other requirements.
>
> Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v4.
>
>   doc/developers/documentation.rst | 2 --
>   doc/requirements.txt             | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> index 27c847e125..a303253693 100644
> --- a/doc/developers/documentation.rst
> +++ b/doc/developers/documentation.rst
> @@ -23,8 +23,6 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
>       # prepare virtual environment
>       python3 -m virtualenv .venv
>       . .venv/bin/activate
> -
> -    pip install sphinx # usually packaged in distros
>       pip install -r requirements.txt
>   
>       # build documentation
> diff --git a/doc/requirements.txt b/doc/requirements.txt
> index 742fb8b4bb..1f4cefb2c6 100644
> --- a/doc/requirements.txt
> +++ b/doc/requirements.txt
> @@ -1,3 +1,4 @@
> +sphinx
In requirements.txt we usually put the right version of the package that 
we want to use. We can use the latest, what do you think?
>   sphinx-rtd-theme==2.0.0
>   linuxdoc==20231020
>   sphinxcontrib-spelling==7.7.0
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
