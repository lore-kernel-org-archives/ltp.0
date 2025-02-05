Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F994C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738770147; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=t5Myj5Vwc7JvbdnYxza02UnePtlsN8TV8yqMnqVOVZQ=;
 b=LLJ0NoKFuiipKPFeXnHj3hjBEs3ce5QjNYeuj/t1XT2zRG++liOrivvrzeBa6CklWc6Mm
 2aMO7C6RI10D0lDwoS1k+dCNexYcZOqB5kvNSXIWP5IU1LdZErE58UchuH35BZa7C0zJW/5
 icWGkyY9hp6FGQK4vPMDlbQn5bUQ8Ss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 563E13C9252
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 16:42:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72B6E3C813C
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:42:05 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3A67F60D487
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:42:05 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab7515df1faso335644966b.2
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738770124; x=1739374924; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mGntErpLPtLo73ui61kM4k1qg/LP/BbUdVpyCbGgvwk=;
 b=PyiGw+sOcej4uVDeG9GiNek3XxBvKiZuJGHI+PMCI4DZFrjrnk60zgi2+lg23xXwES
 7rNC3Q94bVvc2TtaRpbbnkxmRT9uh1pYpd/y56tBsk85MU0EgQovDuBJyvscRLgfaM0Y
 A6Hwj7SXiM3ZkUyao8L6KSFDM5T02y2Ek+hofzOvRimXGfWYpbXbqDBdnWh4aV2rXfxa
 hIvzhe+oyEvjXQrRYQRs7+7kyPsca4qa2IGbxz7i6OdKSIqcInvlLWXfxOVBj0ShSjxO
 g2niYdsQMcbKTTGMtW7FZ5yg2ou5buTGoUhNaXEDp9P/R3WKIEHfDEqmFceXCbxzUqYj
 fH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738770124; x=1739374924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mGntErpLPtLo73ui61kM4k1qg/LP/BbUdVpyCbGgvwk=;
 b=YTgzW8VOQRdcQHd5rJ645LSXh6H6AnDv1LocwlVLsgZsINI2y6pB06mJWDHCHj+xBe
 j8jGaolxa/j8kpilbyz2sNeXBu1o7iA2fnlIdeKPQEHO0/8zLQfMD+oSPTf6II2JigZk
 k8E2R8k+eM8L9SplfZ4OkT59KsdlF30UzgHwEigqv+eo5eIsaG/QmbPfh/wr22YIcp/7
 Fw95iuZGDbv/uE08cRD3vMD+IN6/iJ+GGtF9tHmFAdkdOwewiQqqQjd4VC30wFRpLbKu
 0l8ls/gv3gb1y0pgVAw7Aq/Qco6kM12C3mE3JtJsYJBCgCg6eEURk+NyouCcneOcCFyK
 yqGA==
X-Gm-Message-State: AOJu0YytRmOSRb1JkGaTbk+BaWThtQkjN50UavTjIqWjcbSvGYrilBY3
 RNJ0DEE8aSCVmp9vtvDhDomowsyRVHTcEUbqeVSnHR010YcUHcLXpovrdOqFWdY=
X-Gm-Gg: ASbGncukJUJTIUKrioIUo8nA0NXvARYouNJV+ZPKPM1857FBAeqlg/WtWZKMCCgXUFP
 DJgXr6dbUR8d1iGpTgG4ZcjVA5xByctRCfOGiOrSy2aw2g3zqfU/6urDRdxIgWolLRPa8Xupi97
 BGNsJh0uEoqPz0J8NPznKXP0+wPIu3mduzqR0glliCsO57lcKvYn7OKW4zOLRNc7WWbCgaAFgF2
 5Gavkol6cnZ0KETl7lhUpv0Sk40IlbPPdZFcwJ4tNjKzsO188QtsPof8GF7Zdi5/9p12FZB9ijv
 ypjmzBxsQwCDJIlZGpPCaVzvWA==
X-Google-Smtp-Source: AGHT+IFiTHjCdSommOGNP7tDyNcB66wbTwyhNyWQCH4ff7OGNitF3EzfVWsWtC5HFe75rY75bMik8Q==
X-Received: by 2002:a17:907:6d01:b0:ab6:7d0e:7ec8 with SMTP id
 a640c23a62f3a-ab75e27f2d0mr349151366b.19.1738770124620; 
 Wed, 05 Feb 2025 07:42:04 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a2fa50sm1112570066b.128.2025.02.05.07.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 07:42:04 -0800 (PST)
Message-ID: <ffebb289-c096-438e-8f22-6b61321e7615@suse.com>
Date: Wed, 5 Feb 2025 16:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com>
 <Z6ODH83RmqUtEDxv@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z6ODH83RmqUtEDxv@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: add tests catalog page
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

On 2/5/25 16:26, Cyril Hrubis wrote:
> Hi!
>> +        # timeout information
>> +        timeout = conf.get('timeout', None)
>> +        if timeout:
>> +            text.extend([
>> +                '',
>> +                f'Test timeout to {timeout} seconds.',
>                                    ^
> 				  is
>> +                ''
>> +            ])
>> +        else:
>> +            text.extend([
>> +                '',
>> +                f'Test timeout defaults to {timeout_def} seconds.',
>> +                ''
>> +            ])
> Maybe it would make sense to add runtime here as well since it's
> logically connected to the timeout.
Probably yes. I will add it and correct the text.
>
> Otherwise:
>
> Acked-by: Cyril Hrubis <chrubis@suse.cz>
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
