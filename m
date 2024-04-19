Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98157C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713532098; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=+711LgsSrNNjAvkI+wHkmvmQlX6FXdBG+irJmp6hFAQ=;
 b=C6zsGt/aNKNBiqxFoXuE+FGKDdB/CpiTtmq8fpaL3S/s/Xi/Jem/vjT7e+gh17y5Fcsk7
 N5V4Mkic73S6zUs9bKQ7BQkpCY0OfIis+XlKkK1pLQTc1JhI9tkjF3Hp2ewy7D0Ah3xDLnY
 3NzdjyjI3Gx3H7oP/WixOyxanroUhe8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC983CFD7B
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:08:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D58FF3CEFF0
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:07:55 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C177F14060AA
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:07:54 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-343f1957ffcso1158700f8f.0
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713532074; x=1714136874; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5hoWazsLl8MDoh98ez0sPHwRyIXeYbTWzMszfwUnBE=;
 b=B50xfx/Px3kYAVihowA/o/v4P0K3mn8B46tgndzJgZvdfWQw8hvTgbhHGqtFYT7aH/
 DjjPafQd5HrNDr5J0U2MqHGsHwFsD1EbR3wdn+wX51OMxD0FkKKt/Pcya/1xaHB5IsyK
 lPt09cE7vQJUj31NqqtzIWdTdHU5SsEJ2IBzhT4NMIY7BgO4Z8XJK+4GAQNXfzw0gQld
 VPVrtegBvE2a/8As3OgAWjcaNOcEbdLReBInMyOBhyUIr3QaCFM6EE0yWlaIypoD1jsS
 +B6bGH9+CEDc66oDXWDFm59jGR9rt+DitkEoiG+GHRpSIUASiEQxIWFQnz+13hq54r2x
 cadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713532074; x=1714136874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5hoWazsLl8MDoh98ez0sPHwRyIXeYbTWzMszfwUnBE=;
 b=oInCqnCcNJy8RLJ/ohwXbLTY7s9nZ9liHQtT3nviKtsFX92RABp+akqHbtB+nwajg9
 +Vya3PrRdQMAGZkD+pM/srAkSlHNs0P+6IU58gCGDlXXZDdoOkv/FuJYx2Jq3tQzKHCW
 TremKY3V/e38cMBzY3XHzQyfr5PKP0GgJD7i9W4rQoO+h1+zh3qe6bdru1iMiF2hYtYB
 h/Pc1rNaE/YbH7Oy1Gj1j/yNu3YcCNwE52GdylOU9WzGVu9qWa/yi5sIPwKbyVK6h4lK
 jfqJZUEPf2majogXizjERQrAodo3BOg2uaP/Zz2ghmkxI3k8A7T5/EI7wgGr8f/oC6h1
 RXew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR7WVgUeDdZydypuNza0lx3nLvODzqCK8z1cUjTYHhC60lFd/g4gZiKrMaaKLG9in8nrshh5TxKErpnmR/IoZ027A=
X-Gm-Message-State: AOJu0YwfGHNKe4xiPz+ugzMOOZNLRTYsYOCh0BEo5jXKp4UO0Jil4XA7
 WNpwWqF/lB7/273UQ5NhGG3xjE09jhDV2qfgiPauhgSkoiJEf3+C237L2kQesE/5xENd3rNgvvV
 3asBpIw==
X-Google-Smtp-Source: AGHT+IHkshOXv2x77n6jZRpjsnXFs2Ty/tES4EIU77agf8GYpLvMUgyP6Fcali+kKABopBWhb4c/ug==
X-Received: by 2002:a5d:4a8e:0:b0:343:ce15:fd3f with SMTP id
 o14-20020a5d4a8e000000b00343ce15fd3fmr4720451wrq.29.1713532073978; 
 Fri, 19 Apr 2024 06:07:53 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.180])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfa445000000b0034a572b6fd2sm1660228wra.14.2024.04.19.06.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 06:07:53 -0700 (PDT)
Message-ID: <2aab8a6d-c793-41f4-aaf3-585848631fc9@suse.com>
Date: Fri, 19 Apr 2024 15:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240419124221.207445-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] doc: Update building docs section
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

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 4/19/24 14:42, Petr Vorel wrote:
> * Use python3 as a binary (most of distros still have python reserved for
>    python2).
> * Mention sphinx can be used from package.
> * While at it, replace 'source' with '.' (shorter, although most of the
>    developers use shell which support source bashism, let's not encourage
>    to use it).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/documentation.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> index 825495c50..0fbf5d49b 100644
> --- a/doc/developers/documentation.rst
> +++ b/doc/developers/documentation.rst
> @@ -21,10 +21,10 @@ command as following:
>       cd doc
>   
>       # prepare virtual enviroment
> -    python -m virtualenv .venv
> -    source .venv/bin/activate
> +    python3 -m virtualenv .venv
> +    . .venv/bin/activate
>   
> -    pip install sphinx
> +    pip install sphinx # usually packaged in distros
>       pip install -r requirements.txt
>   
>       # build documentation

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
