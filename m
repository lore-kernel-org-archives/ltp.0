Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B31EC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713345653; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Z0MKSjKigqIP8Y0It5TGYIpuCBo7QXb4TX9pGKBcZhM=;
 b=GQHiXV2Wx4Ln7pTop8okRW1zex3HNkmUg84qdAbXx56xx0sWsv+uElwb9+oz/oV6CslC0
 6bVC5bXtisgFjzLlCQiN04QdlupVjOik/i7WjwgIAB+PfIVOHZ93Wm26Ma75KwOid0z64yG
 7+qR5BxtPygaKA70+ek72gJkCU+PlhI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D3013CFB29
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 11:20:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0C7A3CFB17
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:20:31 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 976372095CD
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 11:20:30 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id
 2adb3069b0e04-516d2b9cd69so6584894e87.2
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713345630; x=1713950430; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QjSj5r7kwfCPIBcYE7vGjMYXa3NXcmLs6j01RUfUumw=;
 b=R0VmI0AdCTFc8l/yygOGDf82cXXPx8YN6xvyM+iQBHZGcwd0ZdhKbsM7j1ZHfYCPsu
 G/SDx9aDLsqSM6YodUeuClwBXEMO1xlR2Ij7+Dw1TrIc8QdXhaHxaNt1DiOzorgiNSlE
 rCgMZ0EfvlirneRyveGkD4yhz/PSRn8BbmYtsXV21uBtK+iLcu+IXc/TUmzgV+OXHspo
 f5FPJmmbipX+wbsQWN/VLDHSDUSS+PogOLRxQeCcmg3Wj8k47RyKCNQ/YQpKgL8qVYIv
 FpvHXZEKyhJolOlZnSy9RNGWgEZhV1QNaNAAw9vkY3GGTAHgosjH4frpzitk0uiK7Phr
 lsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713345630; x=1713950430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjSj5r7kwfCPIBcYE7vGjMYXa3NXcmLs6j01RUfUumw=;
 b=DqXJYZZHmDxJ+Y5ami6HFclDIlL1pgtKqy67ob5L+QbSX08afwZYWoLZZlYq6caNVE
 929Tbhg7PdHUILYnFyN71Z7/EQ6xf8wxXI6O4oY6T3hmEFOofOF6nvcfguyhg8NfeAT/
 tzJr5BmogY0wiOj18/47egAaVImrWlLw1h3pmeGUe3s99zFzl1aONlCBkwNIMBPzQYK/
 8dYIHBo1UQY1PHZN2eQPaluwK06P1fFQjkYyaLPTmEE4iskhd2pmO7lIePkJY7M9l+wI
 rsOE2v1POqIXOW+pFVH0bCluHitgHg5rpa19UIt11pzUN5hsWbd6hNZOGsbdkywYKzhF
 gw2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbmJVw2DifklZOYmmJbv1Pfp2ySCED80YyQiekdP3IiC2ss2G/D9pcLc3zYWa175Jt/q1awto2StbIPSZeqqQRsVM=
X-Gm-Message-State: AOJu0Yx4whP9UEj3Z/vYdwBhmull4Q8wc1lSz1Y0rk5UPMNRqiNgU3Tx
 ouNlXK934ZnqgcHjiOQQ4BSdu4D6de7eu3iXq0xnO0i+67rlNmwAIc20SrDK/qU=
X-Google-Smtp-Source: AGHT+IFwCPiLTj0W7cFQCZHEgHeCHsdqql4FH6hxoQyURJVYdqWIka/ISl13jS9x+0OZX5+1FsEU8A==
X-Received: by 2002:a19:640c:0:b0:516:cec0:1fc0 with SMTP id
 y12-20020a19640c000000b00516cec01fc0mr9231955lfb.63.1713345629827; 
 Wed, 17 Apr 2024 02:20:29 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.72])
 by smtp.gmail.com with ESMTPSA id
 dl5-20020a0560000b8500b00345fb949c28sm16994647wrb.100.2024.04.17.02.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 02:20:29 -0700 (PDT)
Message-ID: <75519d70-3295-4756-8fbd-eca241b5ed2e@suse.com>
Date: Wed, 17 Apr 2024 11:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20240415091806.18556-1-andrea.cervesato@suse.de>
 <Zh502b2hn9K8S4PQ@yuki> <20240417091914.GB708026@pevik>
Content-Language: en-US
In-Reply-To: <20240417091914.GB708026@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: Add section for C API documentation
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

On 4/17/24 11:19, Petr Vorel wrote:
> Hi,
>
>> Hi!
>>> +The C API documentation is written using
>> Maybe to be a bit more clear:
>> "The C API documentation is generated from headers using" ?
> +1
>
> with that change:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> If you both agree, I'll merge it with this change.

Sure.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

>
> Kind regards,
> Petr
>
>>> +`kernel-doc <https://return42.github.io/linuxdoc/linuxdoc-howto/kernel-doc-syntax.html>`_
>>> +syntax which is supported by Sphinx via
>>> +`linuxdoc <https://pypi.org/project/linuxdoc/>`_ extension.
>>> -- 
>>> 2.35.3
>
>>> -- 
>>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
