Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5372AC4332F
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 03:39:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0A5E3CADA6
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 04:38:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6EAC3C9354
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 04:38:48 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE0E11A00981
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 04:38:47 +0100 (CET)
Received: by mail-pl1-x62d.google.com with SMTP id k7so13038839pll.6
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 19:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJJ/TD9RV9JaKtvk0kwczu0pphHpbPSlRzf6zTYhVH4=;
 b=3irR9bBBCeHJOD9SSAR0JAUWASQCAzX0aNJjg+tTvVR8a479DobEt+BuOilSdeFEZG
 zH1eiAMjdMoHeJE9ZcWGV/p+5ulHIcdXWWr5f5hOrtprzYOvDvyvAbNHa1Z0WtkerC5X
 9Ygo9PAKrMrJk3bu6cZMtZUN+HugyCxUSWCxxxTtvOmIuOcz/8uEXCVj08mzAFbWZeKD
 bcmzRtKQkrlPuFiZj0qPzNsTP6Jxez+3OZ3Lhv6GwkQc3dnKaV6HffJBfBitgoT/QBRy
 GQMpVMSpVytQ1KL0WnZX7sONnWtnhnUA+6ZctJgMdcoTdPf4BFJKICPRf2YIWHLUCMsX
 wYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cJJ/TD9RV9JaKtvk0kwczu0pphHpbPSlRzf6zTYhVH4=;
 b=EmmAYfpMKEO63K+MK/fBzu/VMAaDZGXzgWjhOrfIh0WTQLrmPJB0Or5vPmixKP2i16
 2wFKogzx0fGW/MjyoXOFJxariEpUr5A2s8LM0pfcs2r984nfgndp8IwS/H3zNJRUPpDC
 0aS3ruTzoYECQ+W9NJ7foDcCByJcV/fsbbFaEkVnRdCTN3vNpt4CVo2mC6hL76RD4i4E
 GvyJrMjhq4HaCasJun9UmfKzyRvphQlJMeufKXHDmnIgalnDpkO+6Yah5B5escCBJWN8
 zMgZQDmys5+/TyjbLivngFdf93yolcLJ78h0p5lnACz85+/JQgE/+MXWE5LpVHPvqJbB
 ycJw==
X-Gm-Message-State: ACrzQf3UvcKhMaWOiTzj0b3Rzanh9HiwOnnLKQY5KTFxFQrYLPKp8nmt
 WiCFFl0ti8yNAEVlxPwl11ucaw==
X-Google-Smtp-Source: AMsMyM4wq7dV49IQdqGM8Z5M6fBBbcQP87xqJi6TcTUFPlhX0MkncEiJPmGA90GaNHCz0JC6ju055g==
X-Received: by 2002:a17:902:f20c:b0:188:51c0:6eb with SMTP id
 m12-20020a170902f20c00b0018851c006ebmr27765866plc.128.1667878726291; 
 Mon, 07 Nov 2022 19:38:46 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a17090a7acc00b002139459e121sm6850037pjl.27.2022.11.07.19.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Nov 2022 19:38:45 -0800 (PST)
Message-ID: <aaae3524-1d04-2879-973c-8542cacb1447@daynix.com>
Date: Tue, 8 Nov 2022 12:38:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20221107145453.25262-1-pvorel@suse.cz>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20221107145453.25262-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: set LC_{COLLATE, NUMERIC}=C,
 unexport LC_ALL
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

On 2022/11/07 23:54, Petr Vorel wrote:
> to have reproducible builds (no locale dependencies).
> Get inspiration from Linux kernel, commits:
> c051346b7db2 ("Makefile: set LC_CTYPE, LC_COLLATE, LC_NUMERIC to C")
> 07105202bdeb ("Makefile: do not override LC_CTYPE")
> 
> NOTE: we don't care about messages not being localized.
> 
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   Makefile | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index eb12b9d69..cb80622d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,8 +1,14 @@
>   # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2009-2021
> +# Copyright (c) Linux Test Project, 2009-2022
>   # Copyright (c) Cisco Systems Inc., 2009-2010
>   # Ngie Cooper, July 2009
>   
> +# Avoid funny character set dependencies
> +unexport LC_ALL
> +LC_COLLATE=C
> +LC_NUMERIC=C
> +export LC_COLLATE LC_NUMERIC
> +
>   top_srcdir		?= $(CURDIR)
>   
>   include $(top_srcdir)/include/mk/env_pre.mk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
