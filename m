Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD85CA1010
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 06:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757053375; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=LMT3uXxdf8kTqTSL6SPaeIIw/ljUScGztAAj0UBs2OE=;
 b=Novki+YTssEpFmzHtxxcAV5fcjXPNlLTOHlyUoD7LhBwgZnlXMw9T6IZAkkiEnbFC9VuV
 +zzFUzld+suukWIIlJzgvaUCKCRV8mA0CICXP8ffwGYLa8+fmmv3VQklSMcMD31RlXvDgPQ
 SbbNkk0Ea9ncxg3GuCDeB1SuFV4cfwg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30F453CD4DF
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 08:22:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E517D3CC3B6
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 08:22:34 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73152200973
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 08:22:33 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62205eb63f9so42637a12.3
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757053353; x=1757658153; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5RZ/9H2x4zJ6dTJHTszpqAcDw2ihWOgXobkOB2WS7wA=;
 b=Iawqcy+0K6P+NZGOWSqcTHIucL4i3XnXUmwBVCAGz8HTMM2P//w6ymXneUdPYRKuLg
 qjgmdrzSfH5f7mfpkSlY7ifu3dA6Wa+a8DJ/6gPIOrH+SiRuooWErLBZihemoqv7i/UL
 o+FS6Mb+eOoOIIEg7ztBeLy+h+MU3gx4bJlISc+B4g00t7SsYfPC0T508sjfbvCJzMhb
 s27q3uIk8qa6OlR6IvkMaESWLdv5eevg4q3UF67ufoP4BC6YokAh24NbymLYT8OF8KWd
 j68BO0PuQMKkZk+igt8tWnnRokpFeBzxVJRxLe5fVXtNM4GguHItAvoc7i9BLd0NYbj6
 sCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757053353; x=1757658153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5RZ/9H2x4zJ6dTJHTszpqAcDw2ihWOgXobkOB2WS7wA=;
 b=Mm62rFvqjFOuFZOxAtTngTcZCSef8AcCTxqrvp7p234J6lTxh4Yh/Pr75tcY11UEnD
 Dmd6JHR70g2AIm4P3UfCyhqKfJPZqPoBKGtSeKhsVzDC9QH9kOqqEk53uIE/DXKdaX67
 LcR8rx/DsQjjlMorpp1hNyTOhfcm0VWBJVAZyhNveklKf5r1jeVHORj6dFE2q3SiyJzF
 YwY2oMHASt0QfLcTsba35H4noOmWTR+3rNL9inArAxqVAJyaCpXFEnr+mRRQcUXP31jk
 S5JYb/VyXH2qZDIJ77KxzXQsPgM/phPdQPEWv0qNmifqkS2kFh/u3s47kZqHaIN42Bm2
 VjBA==
X-Gm-Message-State: AOJu0YxDqTst60CAqBQrXf/g91hZRyShJLd/h8shmyUvh3QPaWSxmv7L
 1/0wyzM8XNnNfBmcgN28bxkBUMyy/WkatlbS4q/ReDj7Y7G+uascLXKGYg/WIJtCuNQ=
X-Gm-Gg: ASbGncuFHuHz3kh+VVRieQMSCwNHOwXd38iYN13RHX4pjuwJzdLlIezQz4HBwHOS95T
 ScncdV1jTcLg26Skt8stABFeMyukCQjiOyvOkYUtSHahZ27YgvgRpiLMCAPn/X0nHTG/PeeDXaM
 fRC93+0Pow2cc90S3CSGvIktDHVLcjQUUbrnC6qkFIDaUQDFZtd1ECrZRRZQ9meAq0eScbtxM5L
 HzhzY3jI+Yd/5PRZTIdRanaAC+2GNRx1UEosTpqGecQJureYjRGN2XIkZMq/tBOSr9Z+bvhTP7x
 EWM9txsGS7QjyxoEVpJvOU8JtRdgxwPaBXdaolQp2u/VtOpu3iSLdVPkHU3vUt3v2ZYVMHlkHY9
 5eKkf2Jv6YZitUKbzJdXfFwJDD93S4FZnpwqgj2ufErheXmCVxyM+o9z3kQRvUrcgWLzu08/jyY
 lSYuiPTQBlMqYRxjoU
X-Google-Smtp-Source: AGHT+IE2cBkvG9D914KFEb/gxJexL+1LdgfGCHLGdLGx9zEMXND7JVL6xvVAA2rdq+1EcAOLcFMOWg==
X-Received: by 2002:a17:906:fa1b:b0:b02:8bf2:3fa0 with SMTP id
 a640c23a62f3a-b028bf241e3mr1831215466b.58.1757053352628; 
 Thu, 04 Sep 2025 23:22:32 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-620e3289db2sm1457098a12.4.2025.09.04.23.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 23:22:32 -0700 (PDT)
Message-ID: <b76eda70-8f2f-4e17-a15b-655f1271d306@suse.com>
Date: Fri, 5 Sep 2025 08:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, Cyril Hrubis <chrubis@suse.cz>
References: <ZQF5J0UJ25_QLwcQ@yuki> <aLpGnKpwkgF-rxIM@localhost>
Content-Language: en-US
In-Reply-To: <aLpGnKpwkgF-rxIM@localhost>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi Wei,

On 9/5/25 4:10 AM, Wei Gao via ltp wrote:
> On Wed, Sep 13, 2023 at 10:56:07AM +0200, Cyril Hrubis wrote:
>> Hi!
>> As usuall we are supposed the release LTP at the end of the month. In
>> order to get at least two weeks of pre-release testing I would like to
>> freeze the git starting next week. I will try to review and merge as
>> much as possible till the end of this week. If there is anything that
>> you think should go into the release let me know so that I can have a
>> look.
> I would like add fix for current openqa failed case cpuset02. Futher
> more fix is simple and should not trigger side effect.
> https://patchwork.ozlabs.org/project/ltp/cover/20250904015920.7432-1-wegao@suse.com/
>> -- 
>> Cyril Hrubis
>> chrubis@suse.cz
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

This is an old release topic. Please check the emails from 2025.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
