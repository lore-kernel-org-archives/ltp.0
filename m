Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA4C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737108303; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jCSijuBSp/qYZms3Swj4sqPChVYUbEFheq/K5MLCd9k=;
 b=Os0l7EAGUZsUUGUHQwCog2+W7QypNscD6Z8YjPiULE7GEkUvQF3LHbhdoTM8Mz2gdm1lH
 SMAuwkNo0DszbFDY5+8/MSyE06uUoNkNj9E1DLrtwqSeb5J+h0lUo2fkezBy5bzzXF5rNta
 diY0SgZphkVgcC5YoTF14ufZtZ3HOTU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 497313C7C3A
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:05:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8102E3C1FE9
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:04:42 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9AE01001187
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:04:41 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1006122f8f.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 02:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737108281; x=1737713081; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OiKaVXd948jM/uk1e2qljiHD7ee21nIcNcgUGMzAue8=;
 b=DYXV1XJE7SmOlLgy1XNuo27ZGwI9DDOU+0siXrpUrB9auRz6tCPXCCV1VWSl6TJXK/
 hdUM6EPVIijdTl5p6wcCYnrTlRJhGxCoTdrRn12jUPLsJadxWs8OtI0dr1kvaz56mj/6
 6GFNQ6KJ0WKsSndyeP5JZv8AjCn0rsApu9oQicoqBm0kMR8CwqfycxvltROBDoNuONqk
 0zgNg/yG95BNNtllR7GjfbnJHQuPFqUiyAceufp1i4ESTcrV4+WE0yym7raUpbkVcAeG
 jvCI8j7XYhpI60GloYSmH8yFtX6Wkn8feKpTJGxMQILN9C7LB5hWWBNkheWtgIjgu10s
 f25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737108281; x=1737713081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OiKaVXd948jM/uk1e2qljiHD7ee21nIcNcgUGMzAue8=;
 b=QyHTleSuP7PXMoboakEl5VGeVTvyO+sbswHSu9tOuVciiIJsAezEbmUU9gn+Smap3y
 ZR8pSE4pMOMbs61kRIZ0BsTCy3ndj3OCMl+j+4ptP6O9HfmUFRcLqiO8AYD+/6kDD2iX
 Ne5p9USsfHcDJhyNluzjtDkSdGTSz3vPTm4tmHdmJRjJ3jd66vqbZFb9T6+HY+d8eAKn
 3AvKx5Mbn86fBcRzRgb7pexO3snchBwGKpoLmYpsbHePTvCXIJl10d0M0OxIaGuSsSZ5
 OZZtni81WYWSxu2HNjQKPksYPxsj930F60uhnfL9xwgm8VrLHO1sCUtJMEK2XIPnxw94
 tn+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHBfnvW6ZkAobEaFQoQIFo9qV8F7f/hnoACo4gZz1Ovm0cXHCzYw0uv4LFq2mxzqKwmhY=@lists.linux.it
X-Gm-Message-State: AOJu0YxvYVh0V/UNwBsxIF5VmX3EGMS4k5pDZEgkt6zwct5Gz9Fp7L31
 hO8zc89mNOx1hrHg3R4uPrjSBrlDWGOONxaL0GIVhwuul+L9GL6wosx4F3Dl2zY=
X-Gm-Gg: ASbGnctSfz4zVlWVlZBBImhCr76XkLJaDEQpfrVoPEB9XwXDRUmwd+blUXRiR5DJ/H2
 aCOkpq0uVPMZQGRKAdc07frxN+jCeB6MdGF3kLQ1CBB2Q/k7wLXTWyVSlLo/LjwtjjCLTAYxtty
 qf+dPSbN1x9WaPCi2vlZUPedbh45gXKrcCBYlsI8aNpUEZ4R0c8QHCGjf1YHqaOqprQjKQbLS2/
 1QaA36EYKP9XWCU9Bxl54lUi3bUX8nLc1r4OMZadtRrPGKyd/FzKI12FXDyELxlHyXKRSdp/gNT
 hVsuuQ9V62wx+arFyu4u2CEm2fbosX+XtOwRs8s+8IbiNjZpgoWeLWYWF9Yr09AH9pTrn3zdImJ
 +8yqCQdsDzuLeiLJ6RIU=
X-Google-Smtp-Source: AGHT+IFadKEPbu3H/akDoFcvb6f9ey8jtn2Fn5ncYXpcFezVhTCtHorgEl+9JmIeotu+jGlqaqd+rA==
X-Received: by 2002:a5d:5512:0:b0:385:e8aa:2a4e with SMTP id
 ffacd0b85a97d-38bf57a1eb7mr1294776f8f.31.1737108281014; 
 Fri, 17 Jan 2025 02:04:41 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c752935csm87046095e9.26.2025.01.17.02.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 02:04:40 -0800 (PST)
Message-ID: <fa07cdde-91f3-4981-a7b2-c4715b408280@suse.com>
Date: Fri, 17 Jan 2025 11:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
References: <20250117095345.10259-1-akumar@suse.de>
Content-Language: en-US
In-Reply-To: <20250117095345.10259-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: NULL terminate .needs_kconfigs
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

Obviously correct. Gonna merge it.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 1/17/25 10:53, Avinesh Kumar wrote:
> Fixes: 6fe8aa186 ("fix make check warning: using .needs_kconfigs instead
> of ENOSYS")
>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>   testcases/kernel/syscalls/acct/acct01.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index cfd25c665..781d62261 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -149,5 +149,6 @@ static struct tst_test test = {
>   	},
>   	.needs_kconfigs = (const char *[]) {
>   		"CONFIG_BSD_PROCESS_ACCT=y",
> +		NULL,
>   	}
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
