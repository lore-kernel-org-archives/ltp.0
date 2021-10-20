Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F9C433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 07:20:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F7160524
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 07:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55F7160524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA4393C4F3B
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 09:20:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B3FA3C2DF8
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 09:20:00 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 795AE140124E
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 09:19:59 +0200 (CEST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9603A3F4BA
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 07:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1634714398;
 bh=2v5fNAS3OWGSp6MUIf+vmmGeZc0DxgDPci+kwDEbXr0=;
 h=Subject:From:To:References:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=WqCcB2dJ9t6gcy+poi+KP+K9SBha0GQoXeni4m/DOQzjhuu9Xqgm7PwcCoCJ64ffY
 6kj5EuP8v33jhp8alqbjlVQ0bQpjr0XeiDq+D3IXm3kC4jP952fPRo5NXHFgWF9F/4
 5L7d89s5/Mk2eByPuh99myiRg7BDVYLUYO8W8Bow2T5XwkyCI6xn+TXfsA+MEJc7bC
 YRcc48RkRKEhzw0kw6OYabnFlpRWwZ8VWgwNbsS/Ybq/4gdgk3/yLFrrEMIZ8bc23w
 tOJqP0061xf8lEX5AdCRHdT45XmbZOK7N7sHs/IAGR3HHMqXiUr/Gid+0DM+gHVKIh
 j96VeOb5u0udw==
Received: by mail-lj1-f198.google.com with SMTP id
 f13-20020a05651c02cd00b00210dee0c36eso1421528ljo.23
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 00:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2v5fNAS3OWGSp6MUIf+vmmGeZc0DxgDPci+kwDEbXr0=;
 b=ymEIqDJEWU+3vpovAkLjaylA8o13/m5ipfnZpI7aeQEjRf9ksJS7GbtSxLVxx9iw1f
 n0fFuqwN5WaI2Db+gf3QulHU3hWzpVYQb3uQshC4d9IrUUf5PW3LBZJkYQdUyd+ZRgCC
 brRSzBgVp4E0KfJcVbvP31CmZN5l4I75yivrqKBJE0/F2Y3BgHI3lsrGbISJZez6be9G
 EkKW4rSa4Z2ehFlkAoyfEZMh7b0R1gfNUQ47t2ISku8QnwlVT8UOk5QYkrHG103k9XGX
 aorRPk9fqXySPpc6NJvihgBXtKHkg+MGvdNi4VrH5D67ek0UJvqwQPnIPF9Tmru/YsTj
 liMA==
X-Gm-Message-State: AOAM532EQ9A+8SaJTlidlGYyiNxviZ3jIF9qYPA+HyOuLJavHB75PSdQ
 tqimj+5eAHpofWMcs0WdkdkTLMGWDtRz+LFN7tJVl17SjjVmcpfgGngkUW5oaAORXaDtHEB84kc
 zffiL/nTD60P4Wu8CmY/zaQ9M9DhL
X-Received: by 2002:a05:6512:39c4:: with SMTP id
 k4mr10382704lfu.322.1634714397610; 
 Wed, 20 Oct 2021 00:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2H2QgMS823wUimVVwrtPVJxFrZeiHEHH3TZJtCjZZsEu0HLKBK4PXyrPG8nw0J6xoV+qJ+w==
X-Received: by 2002:a05:6512:39c4:: with SMTP id
 k4mr10382688lfu.322.1634714397447; 
 Wed, 20 Oct 2021 00:19:57 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id g7sm129690ljl.83.2021.10.20.00.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 00:19:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: "liuxp11@chinatelecom.cn" <liuxp11@chinatelecom.cn>,
 ltp <ltp@lists.linux.it>
References: <20211020063220.5885-1-krzysztof.kozlowski@canonical.com>
 <202110201459177524146@chinatelecom.cn>
 <9f9105ac-a544-2caf-f88f-c9529cf81119@canonical.com>
Message-ID: <d7d80943-0010-2220-1d4c-19281f5c4da6@canonical.com>
Date: Wed, 20 Oct 2021 09:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9f9105ac-a544-2caf-f88f-c9529cf81119@canonical.com>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: memutils: respect minimum memory
 watermark when polluting memory
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 20/10/2021 09:07, Krzysztof Kozlowski wrote:
> On 20/10/2021 08:59, liuxp11@chinatelecom.cn wrote:
>> Hi, 
>> Why not to directly read minimum memory watermark from /proc/sys/vm/min_free_kbytes?
>>
> 
> Because it has different purpose, different values and won't achieve the
> same result as we want to achieve here (pollute maximum allowed memory)?

Hm, it actually looks it's the aggregate of all low watermark, so I
misinterpreted the documentation. It indeed solves the problem in easier
way, thanks!

Best regards,
Krzysztof

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
