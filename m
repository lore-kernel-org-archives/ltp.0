Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA69DC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 13:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738933866; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=eEaScaG2Hbfh2++USzRhubdHQRAtp9au4dExrWFDGC4=;
 b=F/oPdKfAqldyWTGsMjFfUbSgWpKgxp8dKOSkNvqY9WxEzQN+sFkKn3i8aJtxj2IxvmFQL
 w5NrlRiCc2FAKJ1JUMkR/FnsvQvwj33LvXKqBU4JhXCyfjcA4evXpSbBnPIo+HerXauvsxO
 oRYb8brrtumov4/9l+Yf5Ca3EHkAHY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 299753C9388
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:11:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F30063C006A
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:10:45 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83A5121BD9C
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:10:44 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so20152005e9.1
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 05:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738933844; x=1739538644; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WUd7jGrew7PCytx/cY7mIS1U4lu6HWCko3u8PEskSt4=;
 b=Ba8uenIWORrjDKnZ+aL2QUYGTJiL27Ki+belYFltbNJTkKa1DjRAxwehOTMUboIwhA
 Fh8kF2yN/PRP7qKP2bOkdMo+kNcaN9JUBgZQrxRbjM8qISVjQwyBN+Opg7r/F23eLhZU
 xlyeFCVxqHQDoda82droSvq7OQ6MzJ9nscldRKc4y7+JskjBw/0ujloTjFWq+OyT0IO0
 ypDe6ATW/oYMS2+YISDqptsnzAIQkAxRZcPCfnEn9TBw9zOCrMB7dw/xQI5V/XRO1r6m
 oXE0utef7P2yYG20cL5F496gMcrl/inuHVHzhBaj9Y+JWz/gdb5Ssq9wFy9gQUw5gHIN
 MyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738933844; x=1739538644;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUd7jGrew7PCytx/cY7mIS1U4lu6HWCko3u8PEskSt4=;
 b=Ge4XM/zg2zbKsIEotNADqwcjR7lCRSKdoDKd/lmhxTZVgOX2oUSB7hEixqzLppQg/P
 Jjw4fKq8zhND/lvIHRmX3invZXRrWiiWk3Mn5K3nlAE+lm5jLBfD9M+buuFn9EoVS6As
 9+7/XjIw1eoiRu3FZogBGCm0qHypnXf45UP4BsyqryhvbCfjQUZL4kp9FyvU8mIObwWH
 BYKKw8unC+RZuEATK9TwjgLdaUpEeYi1XoS7W2PGR3VCS9eDslAPixpYW3ZqsgKQxnLO
 AgBEU3uGvkWKrR4Ann66BMFJTLY1r0jgFi/WAG5/C2amC6acs5mVq77y/pRcJc8TbGb0
 W/8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyk+VWalL4DosJURqAThBjrOsomXv/e/oSDoHB5zvkbinIb45lEN44kjLYIEiMNJv0kg0=@lists.linux.it
X-Gm-Message-State: AOJu0YwGxIYRRYxXViLwpsYBuK74GgJePqxng3FAgtqdDsAvDX0QT62w
 tNMQXyLJ2Dkz2Cy2YLNPL6ZLZyH9r84ZKDhBOwRBlM8KRB8L2lIbwPyvG0GevaNCzmwWKfpEtvn
 HMz9jDA==
X-Gm-Gg: ASbGncuY5PMOOjuGdcLsEEcPJurHtx10eb93klzRStmRS9i0PmE60nB7UkD1BAw3yls
 1h/HSgqpc7BijlvHfh2MmCTfcLsXof9DZxsnMrOjOBmR6cGN/AgKYayKyWeH6jReOk91y4JoDj8
 m81e+H71LD3djoCKKGFMpCVYCBS7Qvg0LH0hYPdIdgiAYFDb8rvP1nddYGzaXo8dckZANKHULpu
 97ZmvZPJzUrrkiYw/5FQ9OOmsRHRTPR/lV6zjKp7SWDS7CHmV3l3X3wDvFLRDiV01dZpqNF+Hn5
 BAjC0/cmcq9cRuish9JpjE/W/w==
X-Google-Smtp-Source: AGHT+IGg1dXWrfG5DPAxYcP30LgYqofRAWs/mLdQTCOzs5iE7p24ZST1iEeOJZ1FSLhU6vbachJmhg==
X-Received: by 2002:a05:600c:1e25:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-43924972ce9mr24872485e9.6.1738933843932; 
 Fri, 07 Feb 2025 05:10:43 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc88989b5sm2201562f8f.65.2025.02.07.05.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 05:10:43 -0800 (PST)
Message-ID: <59449e14-d91d-463a-948a-3d728f075df2@suse.com>
Date: Fri, 7 Feb 2025 14:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250207124830.1765318-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250207124830.1765318-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/documentation: Add tip for debugging
 .readthedocs.yml
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

Hi Petr,

On 2/7/25 13:48, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/documentation.rst | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> index 27c847e125..2308010006 100644
> --- a/doc/developers/documentation.rst
> +++ b/doc/developers/documentation.rst
> @@ -18,9 +18,9 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
>       # run configure to be able to compile doc dependencies in metadata/
>       make autotools
>       ./configure
> -    cd doc
>   
>       # prepare virtual environment
> +    cd doc
>       python3 -m virtualenv .venv
>       . .venv/bin/activate
>   
> @@ -39,6 +39,14 @@ Once the procedure has been completed, documentation will be visible at
>       older Python versions were causing issues. No other version has been tested,
>       but it should work anyway.
>   
> +.. tip::
> +
> +    For debugging :master:`.readthedocs.yml` (can't be debugged locally) it's
> +    the least intrusive to set in `ReadTheDoc settings
> +    <https://app.readthedocs.org/dashboard/linux-test-project/edit/>`_
> +    different *default branch*. This allows to use ``git push -f`` without
> +    polluting master branch.
> +
>   Validating spelling
>   ~~~~~~~~~~~~~~~~~~~
>   

The English is a bit weird. Maybe we can just write "To debug the 
readthedocs.yml configuration, push modifications to the [insert branch 
name here] branch. This will trigger the Read the Docs pipeline and 
generate a new website, allowing you to check the results before merging 
into the master branch."

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
