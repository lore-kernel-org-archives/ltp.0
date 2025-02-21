Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CCDC021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740134227; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1iYXJiXKj7cpb5TNyr4ccx4+jQpfET3veGr9vZyTzdg=;
 b=B6umdNho826f3gtEJyLVT4xW+DYR5SyJrdKjT/brxlyPNBsd8m2lIz32b/oxQNVNQptJl
 dP+8Xn5aEWcE6CfUQGO8v3V02rRh4jHt7JT7qoZ/hAIBkekN81KUr1qY+dghTxqbbx2f5fn
 VAhZzXH5v1HGzpi/RUhRHKg2dXo3m3o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACEA83C8131
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:37:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 760A33C0430
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:36:44 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20DD11017B25
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:36:44 +0100 (CET)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5452ca02bdbso1844028e87.1
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 02:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740134203; x=1740739003; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AG6ModBdTqo7smiPm71FvR5wIHHVZRtjdDr8xJSMNYE=;
 b=SDIXzcHhGqNOYOHUoZVDkZUCb0b1ff5lzCUUK/Zjb8BpxCH8xvcRxB+XJRTcFmgtT2
 /ZSQ5rySNafhgouE3cb4yhh118D2S7QrKxVzJd1d0ef/r1ZptLDnEXzntQQl8Q0/DkMl
 CUvrbS8WzEo+fRvAbrFI8Ki1Ff8BY/8I2m1ojzRl4tIHkAkomx4RiMMU5hsVtTFzqHTI
 EdLZKmMuYVhgI9lfe8iVmnBhAQntHcpbZ7ob7L1Jro+vmFxhPC4po2kEBmSXM3tz8Egi
 4N2VqJ5eBJ/bDaXTpOuqPTGV6FLu47MCNQCBCWcw/gK6qMLEOaWphQJKekqkKqJwNJQ+
 WJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740134203; x=1740739003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AG6ModBdTqo7smiPm71FvR5wIHHVZRtjdDr8xJSMNYE=;
 b=BGP9R/+v3FOyLyz+LoYS8IaI7vapckSgQ1Y2+y5UoPbnLEUEC21AinltdwwdqVqzp7
 0yDr3H/WFaTPO2tgWXtuNjhBI4O7IO2LuxDCGqZXgRQ6jU/FiUjixyGZwAZkyxTfsEGL
 jwoSoNhpY/WHnvk2lBNy5BqRpPUtcZWojwv1DflzxT76kv0rLzYJC1VrKLuJvi9mP5Ow
 dsggg/dsy7uHojZcL/SdsW793Z4ArNdlCHewsSqD5lJaj/+fV2tDjRAamQgXldhHL20p
 /2advDswcqzP56HQii7vxFEBW7PteCV5Ned82YyQvnRt+Yjc24S+QfWphahZPrNdq7KG
 SwNg==
X-Gm-Message-State: AOJu0Ywr2XZV36uvJqLizzWb5UyzK7Gy50cDC5+tbLqUZl5zTSb6C3PK
 gSjG+7/+tfvhu0d3eI+eRTO66IJIG1Ltz/NJWi469RpuU0ZZF+ZlI5oVwOqpFuKosKeX1yKWW9S
 4ypY=
X-Gm-Gg: ASbGncuzyK5AfnMAaFBjAGkU1FXj1+P9n7zjFrp4uPsNJdZjXMUig1fDzQgLtl22LlP
 /uXsaCvFeEUqUrFHakjtUv/uZmr4tbF5vRlJPOmedBH+ELByn4hF9xSb14fTETqUhQjtrd0aN0P
 tHjhJlmSbMyCHCMgnG3/ioljs4IC+irwmwIxSYYy0UcjjHxlkg1iKbIw5l80FlUHl2+NxUiBIZh
 vS11m0RTwQcB5PP5x6i1+cWGt8wTKBYcW/yq1UgksaKTevJRaHWReWAmOTthYjYlGIlJ9JgqTKa
 wrlIlV4dA6KGLRMZ6wDiVmm4ezTY+9W7FV8e/M74BRaNDuf/2QoBXc4uUhtzlEIwvUN6S/HUs7p
 pk0fn5sFQ
X-Google-Smtp-Source: AGHT+IGcEf7bwIWPNwi1J6rOq0uDRZXphP1ZrMNtc1aXHcjIrW1Y5mJARhzDCGnfkAYpzzL1WTzKvA==
X-Received: by 2002:a05:6512:159b:b0:545:5d:a5c3 with SMTP id
 2adb3069b0e04-54838ee3412mr956823e87.4.1740134203348; 
 Fri, 21 Feb 2025 02:36:43 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54619e7bc2esm1778949e87.244.2025.02.21.02.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:36:43 -0800 (PST)
Message-ID: <8d5519ef-3255-428e-bb4d-4ece3b310c9e@suse.com>
Date: Fri, 21 Feb 2025 11:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250219160143.2589026-1-pvorel@suse.cz>
 <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
 <20250220230000.GB2726725@pevik>
 <8240dcd3-fc9f-4c52-bf16-8c7a940cb470@suse.com>
 <20250221092330.GA2745682@pevik>
Content-Language: en-US
In-Reply-To: <20250221092330.GA2745682@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

On 2/21/25 10:23, Petr Vorel wrote:
> Well, I disagree it's an overkill. It help people to quickly see the related
> structure. Also, structure members are just pretty close to the section of the
> link.
>
> Kind regards,
> Petr

I guess we don't have much other options with the current tools, so feel 
free to merge.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
