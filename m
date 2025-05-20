Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34918C3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747760708; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=wHqGpCVGa8Es6JQifXUZg+lzQfzLqXTaSoC7dbWXlC0=;
 b=Br2kfsSvQHJeoxrCyHaVk5CUImmqtMXT+KV5zuF6n309M7RCx0RcrgZxkFmpw31vRBJNq
 ivAzTCBWu3BYtOfg6CuPKPPdp1OaROuv10JqkpBwKv7t+VHq3mYY23wqv3bgZVtPAachOYm
 DGvAHIKLyDEzPJv5Pz+BmH0iBUmgBKk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2498D3CC77A
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 19:05:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853F43CC6D4
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:04:46 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3E281B601BD
 for <ltp@lists.linux.it>; Tue, 20 May 2025 19:04:45 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso47402275e9.2
 for <ltp@lists.linux.it>; Tue, 20 May 2025 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747760685; x=1748365485; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+a+8BX9YT0qjz+BLED1eWlgRNhUCzzB/6FQ3uzJYS/4=;
 b=al2WDUIxmf3leTyHQRW4ky+oLMaaFLpyphCpcs6gvQvpQq+delZqbHMwHD7HmFyOIz
 DqyWe0SlECMSUwlCu/MBbq78COZA862cnl1BumnElI/+luYhrWExYb1h7blDX3X1BmGf
 9TIZahlgMrmT9I87/qcXmC0PP1dn0oRfouBz/hhcfkWdGlgdefHQx+odMoeGEJbJk3dD
 1111EVNyfTkMLhq9DBrUiNkQZ5O7uu4tytyszgngSzD9hwrvCPosDCpZr/6jbT+DC7cF
 w6f/igx+sJtAGf2ewAmWLBP4ySnnQnZNv+QyjHlMeEQaZ32jW2Vm/PXn2OGwlC0Aj6dY
 if5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760685; x=1748365485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+a+8BX9YT0qjz+BLED1eWlgRNhUCzzB/6FQ3uzJYS/4=;
 b=WEMM/nAygwB9e2SPTVtgYinr8/A/AK9TTMquCH/0R7meHU0rH2LViJ9mEPAtRNItpZ
 xJxqN4CbSCT5wYou+fY1oWSpZplGHkCaJe/fACoWXU2ZSHEOG1TNszJ3MidJRanfyLtU
 dvTXBEBAxMETTlJH4lQEEku+bgoqvL8qV9N/wVi/eZidADduF5G1RpX0ja33zzqm2kPB
 paDWy5MUTlyP6YzPXGpVB8aKPh5vLrgqSMgxuhqqDISoz4SPiF8x+CdHtoqjPye9Jxj5
 s/yY0UTiog2R8X3qU6DM7dL7vCbPc1jJPIThdiIT4faGvhQt8coxuHSwtRCLCf3AS3iJ
 5paA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4WXW0MaRqEaVELj5SkIc3UmuIhTJ0lw2kWWvH+zApa1SB8tkQI6dyI2cdng/qeaZy8OM=@lists.linux.it
X-Gm-Message-State: AOJu0YxMklGHPAuFCl6bqdMGwy4GxUXJ23cp2ym3kKv5TOY+exZuMSI5
 SsaikOy0CvuQKwSgL9t6EMREGIoEsFdugFvQ5SutC0vaYCoFJJOKrcVPyQdL9TMJJRY=
X-Gm-Gg: ASbGncsx8f7VdMOv/Uc00JHLos1FumX4yqx/HOr3L4tEeOtm7f0/aDDiSP3SyBwEIuR
 Cr5GAI0cix0V9vBPw5IOKe9PO9NvIz7IAilyfLvvv34JMI4g+n+XippMvq6tBgfKaNWyyN+caZ4
 xP+/6g335Njtie/0dQ0O7/2MJmIQAjElR9Rg0OG+x8QzIOEF526jWwVJfvaV75E33X0WpXA9IbB
 ex/n1B6ZGrRWY4fJtCH/fZ48CQ+ngcxpt/7NWzq/QSN1wcpogV8YP4RV6kUr1R+cLEeaXxmfgud
 53U/xtnbvjizL75DJ81TLNhxdD3BWwmWsQpq6yfOZlgiFo3rhYye//d+GLHlwDYo1k2+61VaV5Q
 asP9yIEgw93j+GMLdDxcvf4qVLlga2UESRdhbbudpiJ3SOy0E65R2tk9RTp3+z0ZRPUU4cXrfCW
 IJWtlozNeRtTh15g==
X-Google-Smtp-Source: AGHT+IE5R5mb9qYdsd/NTVLZEljht9oqB16fhIWSwmUTRuUkahyfAcZmvSKfMCvJCLc7mEBLds9atg==
X-Received: by 2002:a05:600c:3c82:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-445229b431cmr93379005e9.8.1747760684853; 
 Tue, 20 May 2025 10:04:44 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d?
 (p200300ef2f169a00bba9aeb9310bcc0d.dip0.t-ipconnect.de.
 [2003:ef:2f16:9a00:bba9:aeb9:310b:cc0d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1825441sm39796405e9.8.2025.05.20.10.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 10:04:44 -0700 (PDT)
Message-ID: <71939c74-0ddd-459b-a857-b62002ecc71a@suse.com>
Date: Tue, 20 May 2025 19:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Linux Test Project <ltp@lists.linux.it>
References: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
 <13b3679f-ca6f-43ee-a56d-865544c2474b@suse.cz>
 <084e07ac-61d7-435b-a5d5-1512bb57b2e5@suse.com>
 <ec0593f8-980e-4e9f-bc61-3e9eb1f0ba01@suse.cz>
Content-Language: en-US
In-Reply-To: <ec0593f8-980e-4e9f-bc61-3e9eb1f0ba01@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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

Ok, merged.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/20/25 16:17, Martin Doucha wrote:
> On 20. 05. 25 14:23, Andrea Cervesato wrote:
>> Hi,
>>
>> On 5/20/25 13:34, Martin Doucha wrote:
>>> Hi,
>>> safe_modify_ldt() should not allow any errors. Let's merge v2. 
>>
>> What about the other tests? This check should be applied to them as 
>> well eventually.
>
> That varies by testcase. If the test expects any errors from the call, 
> it should call modify_ldt() directly and handle the return value 
> either directly or using one of the TST_EXP helper macros.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
