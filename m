Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E748DE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736865915; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=QLHtkZcDHdaNL4xqBLvUs6hjQJ858XKDHMgalMyM34w=;
 b=DJbJINL+mqO6QWaxFoxeJY25SqstB/vwIk7yLwS1XhrtRXmpUZP643WGLXm8NiWuWGP92
 uozjEn9joRvCjR3jE4eXzmvTPL1A/4XyljOweoKULMJdi6wQDEXEtVuqq69S4Ikl6A36ztT
 q7vDzjK4u2O8uAJfZ3Ku0eNwCMqIHHM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60B1A3C7AFE
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:45:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D45F23C7A24
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:44:53 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A337204A5C
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:44:53 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so795091066b.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736865893; x=1737470693; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AubE1SRkpwOumBVnq8GQJcET0www0V8y+UZi57M1F94=;
 b=ObdxHBZKhJDQvo90bl2tM4bkKOb5Fk/XrIs6wCEJYqzJldvPhDKs0LPRzNmToITcAX
 Ei1czbk23eXd2zM+WRiwhZg/+mpGwgogCNlS8KtCWLneGvDL+aDHfOxXyq8VsPbvcMwI
 EpwnQRTZ3HThyOd4Ti9uVrDISALLuJeAGSZO34sqkpSwx9NUKtHxWYNjvADeBrE1Rc/B
 Iog+Yy0w1jpd4PKgbq1Cd5Tp7+lgoPcgmXT7g3JKrT6EQ54XMSjSdaJr0h0dyAKeJ3jp
 US9K3qVS1HsVEm1roPgT7qqeI58voV4A3P/H61Fg3Jc9Tn1lj5e4i0bIiaMh/mBmjGdL
 PU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865893; x=1737470693;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AubE1SRkpwOumBVnq8GQJcET0www0V8y+UZi57M1F94=;
 b=qOpe/JvCmRQ5BxrZWfO7XK6DNWsOpRT/GQgHV3HNbbzXu0d4iTXUhkAsW0+OQFhUFY
 D7drbKi7A+IYxuMzaHm1GGJ9S37PaBMaCSOveZZ3B9J6LWXGLz9KLblxi35FXkx3kr+8
 OCkttWFo7juq9ZGv+Ec3RkcUytxOGr0daMgOC6me2QtDWT/JTWSUo/FGD8X5jDTKHhmk
 rE/oOVHk9PrCOW9dNoqI2ltoy3BhnGRGhTMTcvkVOgsOpxw/yKvqVBz85M2moM+aWeUv
 XtHuc9ljwGrufq4j4crBk58XfmPsPtnj+i5LtbpFQbc/eeV87t4qv8y+kLDqX/YU9W3Y
 OyaQ==
X-Gm-Message-State: AOJu0Yz5SDxJ26t/4MYmQdBvma6RuJOKvpJgQeORxKudWYFcUhG5A+7v
 czk+OeHlf65MJHQL5BM8VU7jPkdqX6qwLPynSPqya9TPyIFM2ZgIETyMf8E6qBlA6QXxaUhj0pq
 xdkA=
X-Gm-Gg: ASbGncuML6bHfCqJVhqVxeRu4phabqHbTrFXExOYApWo9yPmMa8zolSzKNM2I5ZDX+p
 uYyFprRMYFowdWLJGq3XPZ8e8BN73vrus3NIHO1kNaQsD32IAvbkVHp34fZb0UZpQxs99eGJXj8
 6kbbQsSx2lT+Wb5WQ/YH6fVAGL8PfILzQVK2bXJ8af4aZyaU+IiRPqwu56PDLJTpeiaq+79fbFu
 rjhsknNNae8maNWsn+xnX9ym0xR+kGNxTluuKDFdKJLHvOXXcQr6QYsWfK+zjv7ufE=
X-Google-Smtp-Source: AGHT+IEN82BfB5MFeooB8ftMMz3XjBJJEFWuqEE1Uzty71T+DPqOmCv0r5GTIHC3zwdKJYdfFIfdhw==
X-Received: by 2002:a05:6402:2746:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d972e1c54emr64302965a12.17.1736865892834; 
 Tue, 14 Jan 2025 06:44:52 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9136045sm633552966b.89.2025.01.14.06.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:44:52 -0800 (PST)
Message-ID: <a359680b-733d-4a81-ae94-482996eca33a@suse.com>
Date: Tue, 14 Jan 2025 15:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250109132334.212281-1-pvorel@suse.cz>
 <20250109132334.212281-2-pvorel@suse.cz>
 <a8437881-a652-4847-9907-41922126bece@suse.com>
 <20250110145726.GA413134@pevik>
Content-Language: en-US
In-Reply-To: <20250110145726.GA413134@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] macros: Add basic docs
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

Ok thanks,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind regards,
Andrea

On 1/10/25 15:57, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi Petr,
>> thanks for this documentation. It's really needed.
> Yes, I had it long time in my mind. Thanks for the review.
> ...
>>> +++ b/include/tst_test_macros.h
>>> @@ -1,7 +1,11 @@
>>>    // SPDX-License-Identifier: GPL-2.0-or-later
>>>    /*
>>>     * Copyright (c) 2015-2024 Cyril Hrubis <chrubis@suse.cz>
>>> - * Copyright (c) Linux Test Project, 2021-2022
>>> + * Copyright (c) Linux Test Project, 2021-2024
>>> + */
>>> +
>>> +/**
>>> + * DOC: tst_test_macros.h -- helpers for testing syscalls
>>>     */
>> Is this really needed?
> Well, IMHO throwing just functions description to users is not enough.
> I would even add a short description about the goal of these macros.
>
> And because sooner or later as we increase sphinx doc in the headers the list
> will be quite long. Therefore for the start I added just a title (short
> paragraph with a description would be of curse  better).
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
