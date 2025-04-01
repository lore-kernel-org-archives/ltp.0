Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AD4C36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743507018; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Mu3OjnMixuytf1sPr9S4sgwi1ZdxN52nbsmiIQIZEv8=;
 b=htsOM9m45zajp64Y9AUqGBSNZqI0xOMBmxG9ja6QTVULMDkhDB0py41U5l4a2tLDckTFc
 /QBpg9JIVH60Q/vLVT/As05zrVm/AHT+1/wumgmR2tdlVtZr+PDwSY4/dsdZkrwZpq67FTg
 cML9uC+E3FsPO3Qh5+MhVb5XDQRmgZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E34E3CAFF8
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 13:30:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2965B3CAFC0
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 13:29:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C14E7600740
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 13:29:54 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so54402805e9.3
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743506994; x=1744111794; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9AvlU9Ld5bcQ+JL+EDSLQfD8c5T4bI4R/k72ZSzVDHE=;
 b=eY7nrRBly8Bmb6oVSo/DBaF2P3mhBYKvh1JzZCNaUnh1UcpqA8Arpk2C+TeqXdRhwv
 zOp/a984IHSdgh5qvttvHKau9+lNUDdya1Wofudd+Yjha6JULUiIMy3ETDxb7R4N2dVQ
 qJTI/JbLJjhVyZxpXdr/nW7EWl2tshrAlqvM9xVZ+IT9W9yaUGOLjAWhG8ZHjCgplU2A
 LxTiZG4OfnHfW31GZD6pZTxr4SWiFkwk9A0CmtcRrVvW2JuYw5yP8TKXg/EmMqMXd7V8
 TNVDOelMv8tonRpzdQ3r57Mprfnv8RU5kOfASwyo/kpry0rY+3w0J7SIwVBpi8MTKntT
 8lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743506994; x=1744111794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9AvlU9Ld5bcQ+JL+EDSLQfD8c5T4bI4R/k72ZSzVDHE=;
 b=iQtwQxeV06O55mikpBK46AjZqgzC4Ewj072r1dBGm/xrl4zrNSStRys4N2mRW/t4B1
 VVrYgJKpHlKVBRnMdYnzb9RkHeRhmoI6BTjw3/oehhaOCzHwKkLhluOMuUmIBKp1b6Pa
 PV1CGt7Gz9SdoZUSdTpWAN8RDQgp4ekc/qBaEwwTRPE8RIYoF0yhWL8vRBRGUfPM5Bqm
 fspzvF2xhH0oqu2X1nuaLbywG4i50+kfUwmky2dCKAfVu4AtLhKd/6nSi2sA5USNGl17
 eusqLZIUmZQKFnF6ll76sNC3Bl0dsxoTpT8e96w/GmICWH7mzQPIKPiYDzTrVck+bgbj
 +ikg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/SlaNb98xLd2Egi/QQI2vc2Xcrdrn9jKreDzox5wvUPtYiWCLjfzp++qev0MVtOpOwYc=@lists.linux.it
X-Gm-Message-State: AOJu0YwxRYrJV8wFeadNLzZ1lIv5ZMnMIaaQ6iKa9HNjX0L2EAnngNzv
 PQl6k1vBSFvKdn1nLIZvRaXUKgpf7McCCoqgWn8RWyQIQjp1jJ/CwD/pWc7D8IY=
X-Gm-Gg: ASbGncunTTEYuXF0O0ttD4591R8UrQWj1fSpiwZ9UlgY4wjlbWEqhnYKla1OIm3U5/w
 AEQ8PsbYWjRepqLlcjtEp9HDV8/ynjMgB7N0TDZ+/WAwKN+71Ovm0cIzzwdFvWciYjyJUf0Ujmc
 x0XJxtShrngibW8Edgrs9LEmYVrjPYQOaD3QWL2+jxYLUhc9FJuj2JoaabffR9+5Mm5idx0qBqw
 nDV1ss8WVJioBNk5+R8dfGdD95Pz28Mq3rFLmcfwoxdc4zD5+hicR4NfB9dFTwGZWjrkV3Z0BRN
 0bVClOdDR6dFJii4Dde2dTOmLM7M1zSnLnGz2fnAXkBRXTibNTqJHjLWe2w/XExcxc91hZd+7UM
 ACeo+N8a59+z6vmBEB4Q3I9mhl4c=
X-Google-Smtp-Source: AGHT+IGc2AHN/GeLXEsJJxVwj6P3sPnFsFRekPxQAA9Jan4XgqPkTXw8ZGlV9j2Lk2hda/5CkKsd0w==
X-Received: by 2002:a05:6000:4387:b0:39c:266c:400a with SMTP id
 ffacd0b85a97d-39c266c40f0mr1219358f8f.50.1743506994082; 
 Tue, 01 Apr 2025 04:29:54 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe678sm196175475e9.20.2025.04.01.04.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:29:53 -0700 (PDT)
Message-ID: <54c380d2-7221-4302-8fa1-ba280610cc4e@suse.com>
Date: Tue, 1 Apr 2025 13:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250401092913.135745-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250401092913.135745-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] move_pages04: Fix the doc to fit RST format
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

On 4/1/25 11:29, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   .../kernel/syscalls/move_pages/move_pages04.c | 28 +++++++++----------
>   1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
> index e1ee733f0..3a56cdaca 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages04.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
> @@ -10,21 +10,21 @@
>    *
>    * [Algorithm]
>    *
> - *      1. Pass the address of a valid memory area where no page is
> - *         mapped yet (not read/written), the address of a valid memory area
> - *         where the shared zero page is mapped (read, but not written to)
> - *         and the address of an invalid memory area as page addresses to
> - *         move_pages().
> - *      2. Check if the corresponding status for "no page mapped" is set to
> - *         -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
> - *         -EFAULT by accident.
> - *      3. Check if the corresponding status for "shared zero page" is set to:
> - *         -EFAULT. Note that kernels < 4.3 [1] wrongly returned -ENOENT.
> - *      4. Check if the corresponding status for "invalid memory area" is set
> - *         to -EFAULT.
> + * #. Pass the address of a valid memory area where no page is
> + *    mapped yet (not read/written), the address of a valid memory area
> + *    where the shared zero page is mapped (read, but not written to)
> + *    and the address of an invalid memory area as page addresses to
> + *    move_pages().
> + * #. Check if the corresponding status for "no page mapped" is set to
> + *    -ENOENT. Note that kernels >= 4.3 [1] and < 6.12 [2] wrongly returned
> + *    -EFAULT by accident.
> + * #. Check if the corresponding status for "shared zero page" is set to:
> + *    -EFAULT. Note that kernels < 4.3 [1] wrongly returned -ENOENT.
> + * #. Check if the corresponding status for "invalid memory area" is set
> + *    to -EFAULT.
>    *
> - *   [1] d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
> - *   [2] 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
> + * | [1] d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
> + * | [2] 7dff875c9436 "mm/migrate: convert add_page_for_migration() from follow_page() to folio_walk"
These two lines can be removed due to the presence of Tags table. If we 
want to keep it, then we should probably leave them inside a dotted 
list. Please take a look at:

https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#move-pages04

Kind regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
