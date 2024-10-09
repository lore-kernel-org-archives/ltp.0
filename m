Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB0CCEE322
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728489162; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1pqkiP9rwk60l5Spe88cZrMISci3oqb/ecYUqOpRkY8=;
 b=N8K+KiB9TXqCuPuD/5MVL6dFZUYGxJEpG5E7mQolNgRTOo6T6qOTR1xhPq8VJbQfeX76V
 89UaiPpPLylPDnfwIJRJbH/SXej0+oUdOUAzrua23+uArxJiEPA7bFFjgrWIJMRiGS631lN
 zhnpAqM9bq5CJo6h2pJPjvoXl1t62lQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A090B3C30FD
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 17:52:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27F83C2F62
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 17:52:20 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FEB8600F06
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 17:52:19 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a994ecf79e7so116508866b.0
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728489139; x=1729093939; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=czbYAIyKotzhE/Rm6v+wDnbPI9AOPz033yudMX9UqMg=;
 b=fM6hfK0zynb4W2xpthTHe+hftaSzVIb2ufIi0ybzLqRr9fZlo8mzMM/BXUU+nKGFtT
 TKCeYBwZGSDkI3t3t1T5lEtWoPu6DyviqinOz+NNtKlz+FT8iOmJ7u2GbCQrELX9Y6dF
 AuhHGxmG1h4alIjZoTKCVeOwyBXYF+fOFXk/vj+/sS4xYwepZNTBZIwdk/v3CZwGa0No
 oscDfKLPZ3krD6waYynhrW5COjxRm9D4YTxdUJ32i0vJoOtb0kyrc83Q2737f7wylxS0
 4WxD08KHV7WflYke5kD60EvvoXrSlliPial/3l4BMwU8BlTgGiIqYhr3LWK8ok9d5GmE
 qcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728489139; x=1729093939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=czbYAIyKotzhE/Rm6v+wDnbPI9AOPz033yudMX9UqMg=;
 b=YFnpPclX1NzqkZjSetptQzEl8GQl68b73ht2W0iPD7/kT1MFTEKchv5CYi/1DkC5Oz
 4sprMzwyShhoq4AcWrePKnuQ8LMFN1q7AMZpljlkj+wubY/F/u7KENj3Lk8kQz0/Hu9O
 OPwPew4n4uPg2I/SwvF2mXFfGBhr31x6fiLzIeesX7uSs8q/ZPYe0U8r0FhFpGbtJGLV
 +gYkSWSUFCVHIJcsMPdCeBTuOHhdOZnaejjrkfGxiwRdlzDV40SJOidCg/qnVmjT1rU6
 NvquC58jZWGeqtzCjryaz8k/eld2yHLM1M4j90AVpdFiTaQ4Jn/fMXcFns88f4FRYAJO
 ZnDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkuwehAQ+OkKxzzvp+WafzNao+9OFv50wtcx9mKUkJXtODtK5ss4W1fp2day5Vr6DYXow=@lists.linux.it
X-Gm-Message-State: AOJu0YyO2aZtRZ8EcauLJlD4ATcnQq15VaNZuMv4xYX0lhzqZ6VvhSIM
 zxwM+RsKuPuvxVRS9jO6dKRJVacHIdDmZdTqXfVRymshAZwW6kpmGwWFBnfiSi1LZa/uGmQB2Zm
 p
X-Google-Smtp-Source: AGHT+IFODZsKdYVbMuZEXsczl+yswzAtahO7dqp7osZ25OASFcFE5PI2ovvRQKdoHN5RYqxpc1gzkg==
X-Received: by 2002:a17:907:f7a8:b0:a99:6109:8927 with SMTP id
 a640c23a62f3a-a998d117c1dmr300068466b.12.1728489138914; 
 Wed, 09 Oct 2024 08:52:18 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9940fd1c8csm587576266b.128.2024.10.09.08.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 08:52:18 -0700 (PDT)
Message-ID: <20610973-0bef-4263-98e5-9894e5e65807@suse.com>
Date: Wed, 9 Oct 2024 17:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
 <20241009-listmount_statmount-v8-1-182cd6557223@suse.com>
 <ZwZzkfidubD6tZJ3@yuki.lan> <ca65b84d-a75b-47eb-a219-5a37f4411b1a@suse.com>
 <ZwadMl_C4k8I-GP6@rei.lan>
Content-Language: en-US
In-Reply-To: <ZwadMl_C4k8I-GP6@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 01/16] Add SAFE_STATX macro
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

Pushed, thanks for the patience. It was a long suite.

Andrea

On 10/9/24 17:11, Cyril Hrubis wrote:
> Hi!
>> I'm going to push the patches since this is the last reviewed file.
>> That's ok?
> Yes please. Also thanks for the good work.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
