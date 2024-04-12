Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70D3C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712912918; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=MQHsIug0o7wtqyI2xRVUheU9q/1+nRjdU/qr8cqTjgo=;
 b=dKUDfPwwFad76Ki+W1hRYxpr9Ka4jYWoCmF8nYWXjrIkMfuaMar5LPMFbMrmEZ702dEKC
 iyXTt0Qh4lXytdEp0vUO55ACT9ccqUDCux+qH8jpsCLk3jdvhpDpa76Gn1yRh2eQfrWqz+U
 LPXA3Egua6wKkd1UTu9lR8iku1p5K78=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01D393CF8D2
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 11:08:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90B623CF874
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 11:08:16 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C3EEB1B60889
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 11:08:15 +0200 (CEST)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2da0b3f7ad2so4557091fa.2
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712912895; x=1713517695; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbLI2oje4mgMHsaY6DryRSgnbn9BuziabK7sVHsl4js=;
 b=Pw+vyTh4vMqUok8GZQIX850EngW7Ma3+IZWd2oZM7FJSd3lrv3FNu8LyvboqxuDmI4
 BS582/TpqxPZMS8DVYI7iXtcJYi5nHbgYKOhESeo6NI9CWcnIAW6e7efVh0z3HOAK4ix
 36uvJjXaDtqCj3zRFiGidHvwYNfT/wKyTS5X/ioGJ5jVpr8u12ErvwAKSEGRWJQTFAUD
 HcP6DvQ2ASQgJGWHrsK/FcTBQfJWD/EUhNh/11QlbHN/3taOv63wMv3yD60dznHKlKrd
 Ghsgc72AC/K6crIGHNhaOKLdp5NbtGD9CThpXDD9dvKsVowVGqr13O4cWKEnNzn7hEsC
 mCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712912895; x=1713517695;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbLI2oje4mgMHsaY6DryRSgnbn9BuziabK7sVHsl4js=;
 b=bcgHZ5VVUbDWu4N14dyy+LkTbJhgq0TEsvLDFrPvKp3TF0w2hb4gqhQIju95p7N2+L
 fpmcoQNTWoBJCB3whpnTazh2xlZWLoQGa+kNvnYeFTYtVbJMo4/nYXm/8TXLaUex6h61
 LMG79p18QafgnvgXu540nl6D+zjWAvtf7V4ayGe3gqTl3Ruq8uWHISjqzFxq2w+qqhjm
 f5H5/+wiI5P9k35cXc1aPr6sUvMNrzkQNiVk3xGs9pF1gx56iiqEKJUIq1E2PXV9TlZp
 A4lSFjxrmA4z6Q43TNUwbP6fCec3vTuTds4FidivxCueJzUlkjT9rjVzeyxYCmMIb4LL
 M/nA==
X-Gm-Message-State: AOJu0YzsmvppM4jsJrKG/ajZGH1ryF0nyWEHCyX8kqbC9MPnOtCcOoyQ
 HQ4htPmTbnexaUuKwv0umHvFqDaiJU9j5dyMxTOulfoHlH86QCWFmx++y6qKK5I=
X-Google-Smtp-Source: AGHT+IHZDS7a59qFAMTfy2Skh0rhLYWyxkcsP7MPeOLuNKvZYLjA/e4z+QZapd12gBbSgAB/P1XffQ==
X-Received: by 2002:a2e:b70f:0:b0:2d8:6606:9e61 with SMTP id
 j15-20020a2eb70f000000b002d866069e61mr1252896ljo.48.1712912894926; 
 Fri, 12 Apr 2024 02:08:14 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.50])
 by smtp.gmail.com with ESMTPSA id
 iv11-20020a05600c548b00b0041665b6e111sm8212484wmb.12.2024.04.12.02.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:08:14 -0700 (PDT)
Message-ID: <2edd5dee-77c3-45c7-a195-3fa5ff38282a@suse.com>
Date: Fri, 12 Apr 2024 11:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-8-pvorel@suse.cz> <Zhf6wC7Cxa4-Zs--@yuki>
 <20240411204631.GA368229@pevik> <ZhjkZ7PP5vS12Cvb@yuki>
 <617829ec-4b79-4147-9c64-b53adc925c77@suse.com> <Zhj3laSMKRVUyg7C@yuki>
In-Reply-To: <Zhj3laSMKRVUyg7C@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 07/31] tlibio.c: Remove UCLINUX
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

On 4/12/24 10:57, Cyril Hrubis wrote:
> Hi!
>>>> IMHO you are wrong here. IMHO uCLinux-ng [1], still used libc (used in Buildroot
>>>> and openembedded). And log in e5e938f4b7 (2009) suggests that it's about libc.
>>>> But the question is whether it's still needed. I could try to remove these and
>>>> test, but as a separate effort.
>>> You are right, these should be converted into configure checks later on.
>>>
>>> And the tlibio should probably be rewritten completely. So let's keep
>>> the patch as it is.
>>>
>> I started to rewrite part of that library when I was working on
>> growfiles test rewrite, but the complexity of it, the amount of nested
>> statements and macro directives made me crazy.
>> Waiting for a better moment to restart rewriting it, but work is on-going.
> Maybe it would be better to do this in a steps, first remove everything
> that is inside the ifdefs for hpux, sgi etc. and only then start working
> with the actual code...
>
Well that's the easiest part. growfiles has a really huge amount of bad 
code, it's the biggest in the whole LTP suite and (unfortunately) it's a 
really important one.
It will take a bit...probably it will be incremental.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
