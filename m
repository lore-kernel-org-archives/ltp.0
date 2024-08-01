Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8295CC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 06:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722492228; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=7ZA9G7uCShtr8/LJ2Xl8iB8/vQm+hk/ITjLTuxdzkjc=;
 b=J1TW3rfakLQT81lPiZI7M/MOmeCg1NhS3+tya91GuZRsXsUgICKSdo5mAoD+1tj06vAsb
 Jzdzf58tbukAYvYDLQ+Ti391MSgShuepsRc0rty8QK+rxYfGz3ZVOrHjecx62VsQ0WZRTTq
 cLJVXiMR215oDUdWVqpe8QYGtltCl00=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF1033D1F16
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 08:03:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66EF03D0B2B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 08:03:25 +0200 (CEST)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EFFCE100C212
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 08:03:24 +0200 (CEST)
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so9669784a12.2
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722492204; x=1723097004; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k90sQu3RF//naW4PS/H2Bi0+6gkwx6s6bC9QZ2DBqkY=;
 b=T5P4+RjpHWWA9Q0Npk0c8rUtArvE6ua+xuk6DvolntA0v0VH0X9zDqfYU/8t9CiSxC
 qzbLx8FI9taactxLCgEJjXD4IRBj9FC47AEGVyUk0/+MTGlwsZpD8CT0PtHf8sE3ZTTE
 yReAuLsZmvlJkOQSci3H/Ng0Kh1qKjunC+2BDnrEEmL8Y8KVlbB3Q1vtKv4pBbF0c8U5
 X3tr5gYJFPLbcEscTjCHz8QOUx/x8IhH6/ajKvbbdH83rfiTI8SEXY/HD6VLrNn9T8CD
 PWWCGfg/QakKkAXor+3jvt0l1FQvfnU2JjiGYi5EhaQdMaMifWYeI0HOI3Qbqmy3kWs2
 RJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722492204; x=1723097004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k90sQu3RF//naW4PS/H2Bi0+6gkwx6s6bC9QZ2DBqkY=;
 b=nQhWLHctGWGrhxlqr4FTNlKxgJgpKsbUk+qcsJ7fzZyQw8RdDE8OYt7PoGyBnGtfZH
 tWS2lIJRRG91kPOQHWJILbFZBlzzLUf5Ud+6Y9szJgQQJ6aYjZmC6tsbxQhETIOkAm/2
 XokN+vA4HC8vYehoTTWtfJN2Sn1muYDrcfapNMHgGz5FeZjK7HBy/aE2IRoZ2lTvp2pd
 OIhryEcjDjcw+/RJLSkXpOMaHN+H/cSN/Su7w+PeSZxTH304yJulWPFEWxsg1uvGq8rF
 9sEERM5i35lX0szJCzZnfMfpTkWQQi1ntvCkaZZRmfSfoUpyup+zgMILfNhpB5gamizX
 LQyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwvAYCjhG6RIV39x7XTha5hvLPkFyNDdlICG/u0g2hFHGHlAQrgORxXdAT9BH5Xo74Wrk=@lists.linux.it
X-Gm-Message-State: AOJu0Yy3IZvjxt54Afn3o6svICpGFZgpj+eOewx3B+Q/H/aDFy4yL6RF
 gUvsgHXYNyal9s2tnphc2xitVAneICxAvNZ6ASWO1viINNrrkPJFAGi/yFC+7btGeHvC4APcEBm
 soB12Kg==
X-Google-Smtp-Source: AGHT+IHR0SCUIVl51Nk/sYI12boZe0VoE25ftO8h4ISJ52Jqetx8KzSWhotVgcR2/lYhyyH6tABIZw==
X-Received: by 2002:a17:906:caea:b0:a7d:a25b:31be with SMTP id
 a640c23a62f3a-a7daf51ccd8mr99764466b.39.1722492203762; 
 Wed, 31 Jul 2024 23:03:23 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab5359bsm850004766b.87.2024.07.31.23.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 23:03:23 -0700 (PDT)
Message-ID: <f8f93c16-639d-4550-acf8-56010f5f26ed@suse.com>
Date: Thu, 1 Aug 2024 08:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240730124604.1393978-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240730124604.1393978-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH 1/1] kirk: Update to 1.4
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

Hi Petr,

thanks for this patch. I was about to send it soon anyway

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 7/30/24 14:46, Petr Vorel wrote:
> Nothing really important, just fix version and sync with what is in
> newly created pypi https://pypi.org/project/kirk/
>
> * 6d419d4 ("Upgrade release to 1.4")
> * f3b977f ("Update setuptools developer information")
> * aa7d693 ("Refactor setuptools script")
> * 81c49ee ("__init__: update __version__ to 1.3")
> * cf73030 (" __init__: use __version__ instead of VERSION")
> * e04ec1b ("main: display kirk version more pythonic way")
> * 08fb2dc ("Fix setup.py license")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   tools/kirk | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/kirk b/tools/kirk
> index 5e8c8064a0..6d419d419a 160000
> --- a/tools/kirk
> +++ b/tools/kirk
> @@ -1 +1 @@
> -Subproject commit 5e8c8064a0b2cee465f2a1dca1cfebef5ade36a2
> +Subproject commit 6d419d419a416238c785f626212d35d1940a0df0

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
