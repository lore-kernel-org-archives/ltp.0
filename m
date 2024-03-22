Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F5BC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711105019; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Kjqhu1o5fzqexyiaMmYUa7wZRdKDq72aIup9fYHbHW8=;
 b=nPGHqtgtnBdFP/redJv5+Z1CG8/DcyT1oD9uLCPj+WZYgSJf+dD104rXSwT4E4q3vTg8J
 VqwtReJlwINcVJFoEFLoQ9XFop4C2YLF329Tq2abbBU1r1XZxhWPhSZ6kyEy6emTe/48m3M
 CVjW53n47Bk3VCxb2vlUjmV/lzm/nDM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C37B13CF22E
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 11:56:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05BB73C997A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:56:36 +0100 (CET)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DE72600BC0
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 11:56:35 +0100 (CET)
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a46dd7b4bcbso261665366b.3
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 03:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711104995; x=1711709795; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9ZhzXoym+aCKXyU5nMQkcuoGCicKqhzM7i0G8ctovzM=;
 b=cgt+Nq4DfvbgyfYMskr4b8ZHnr/zH8bvUBcx7U6mv604QHY5R4zODJQG1YBRWoIaf5
 06u8u7sR//9kXOTN8GoPpg9bz65CtDMH7fbn91/sU2scO4pjtcY25GV5anOym8QXFynF
 uJWljNFZJAWtla/bvZ4Bgozle1EOQBTRh2s71NMDVUR7jqE2TcNNoTyywy1BAlyu9/DZ
 HXRTNxclA2j41RXJMXwBxRqQEfFlAoC1DIoMBt0ZY22CR+vRWE4iltbPJNnnFbizBnzu
 mZVzex5RmPw8EZzH3/kZrdovHUcGhFaYfR01I6/gzZiaNK05hZ578kvnJnfF333oJKtV
 IvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711104995; x=1711709795;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZhzXoym+aCKXyU5nMQkcuoGCicKqhzM7i0G8ctovzM=;
 b=XvBuTnyce6lR2QxSLG1kbAbHsIy5Bgz0XtyNVY3QBd1pBgZpVx3ZFiDvquYUA6l3sv
 oysOpBvV6H4yd7qLwDiaOfy7SE+QKMWHJ/bJYhcydWPjzaXP/vk9kAwN3jZ3rB78K/td
 j8XCZ9cMcjEds6OORX0P831yGsmM7xaCo7EBA2X3Ekueidjd/lLxOcV+m8chG2xh2/Hb
 T2LcrFjDFGFF2tSsHcnliVS4A8oLgj3BmMl4FzqW7gD0QIAwy+NvhQI6w1x36QvHBfkx
 mClsjOLUNIIDYr8ldwRiH7m6h52m9UqWSb4B27c0TZswtfMo3kMbvtDAogcPnXOCtF0D
 k32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/+qFi5cZnqirh2eWC/ld72JtRIY+TU9tq0lLr4drKy3ml7gp4vxvTWFUUBKK4mFIxEzcwEopWtx/e1pXzCR2u2qw=
X-Gm-Message-State: AOJu0Ywyqp/g0IANKX7kTaNArABYmL4UeuFzgw7ZULV+Z5MZBS1xQxIx
 knBIE2tOir7fI/ewFEakokGXeLjM/byRDa38/U55QgXx7F5UcYPgVhB2/6L4OR3qxdIOUgL0Zi0
 xysNIpKlmQOA=
X-Google-Smtp-Source: AGHT+IHXOxtVLKy0Nkw4ok/wFELWIoll42madPTd0cw5fksAvdBsXzyMlq4ipfFl3UbsfLojUgE8mA==
X-Received: by 2002:a17:907:9850:b0:a46:ec44:477c with SMTP id
 jj16-20020a170907985000b00a46ec44477cmr1370784ejc.41.1711104995035; 
 Fri, 22 Mar 2024 03:56:35 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.144])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a056402032b00b0056b8f6e9386sm890446edw.68.2024.03.22.03.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 03:56:34 -0700 (PDT)
Message-ID: <bc843793-6d09-4a9a-8cf3-69a02bfa891e@suse.com>
Date: Fri, 22 Mar 2024 11:56:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
 <20240321082559.GA535362@pevik>
 <593a7a6a-f4dd-450e-9fbe-6f77ef62c6ff@suse.com>
 <20240321085656.GA543531@pevik> <Zf1htmFkRl8BIFOX@invisiblethingslab.com>
In-Reply-To: <Zf1htmFkRl8BIFOX@invisiblethingslab.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/10] New LTP documentation
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

Hi Wojtek,

thanks for your suggestions. I will take a look at it.

Kind regards,
Andrea Cervesato

On 3/22/24 11:47, Wojtek Porczyk wrote:
> On Thu, Mar 21, 2024 at 09:56:56AM +0100, Petr Vorel wrote:
>>> On 3/21/24 09:25, Petr Vorel wrote:
>>>>> https://ltp-acerv.readthedocs.io/en/latest/index.html
>>>> Out of curiosity, we need to register LTP on readthedocs.io.
>>>> Then we need GitHub Action hook (including some secret for auth) for publishing.
>>>> Correct?
>>>> https://docs.readthedocs.io/en/stable/guides/setup/git-repo-manual.html
>>> readthedocs works with any kind of git server. The only thing we need, it's
>>> a .readthedocs.yaml file inside a specific branch (i.e. master).
>>> So we need to create an account for the LTP team in readthedocs.com, then we
>>> provide the git repo to readthedocs and site will be published
>>> automatically.
>>> ltp.readthedocs.io is available, so maybe we should create an account
>>> already.
>> ack.
>>
>>>> I guess you now deploy to your fork manually, otherwise you would add GitHub
>>>> Action config in the patchset.
>>> It's automatic done by readthedocs and we don't need Github actions.
> If you're on GitHub on GitLab, may I recommend pull request previews:
> https://docs.readthedocs.io/en/stable/pull-requests.html
> https://docs.readthedocs.io/en/stable/guides/pull-requests.html
>
> RTD will build partial (HTML-only) docs for each push to a PR. It's very nice
> for online review, you won't need to push to your own ltp-something.rtfd.io
> variant.
>
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
