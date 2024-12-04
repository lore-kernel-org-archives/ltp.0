Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E9DE7716B
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733296679; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=aTprEnrv3NJ7GkYBUi2BAFi0D28VegWgCfh3FWI7MHU=;
 b=K1Igy0c0NFdBVW8y9dlSjpHSe2jZ4Plnoj4ZCEMoHAMwlUIB5LdNlYLe63u6sEpzxuIaZ
 q27dYVzruKpcEJttIu6joB7ikiEE3XrjELBkpNyhC33rXym16+EVH2QOAVHbv2qsZA+z4kA
 opVFHEkHHmljnqRvl0yyJoeEG+e7+Tw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6BC83DECEC
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 08:17:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9938E3DBE23
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 08:17:38 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02D4E65198A
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 08:17:37 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso107667566b.0
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 23:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733296657; x=1733901457; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zy1Zsst6ECOhhHv2xZCzSWEOGBApQkwxoyExw0lzB9c=;
 b=O3coA+jecL85UwjRt/CmfFERtM3XfbeCzvbGk2VC0GpMZDuPwBxRn7N2NLeRoOKtl6
 xaTzsKguSS3Fw7tcA44AdOgDwLaMbqUQRC4hzcUfYcE2ZeWwfQi5GbAU3JpUgYTRcSQ8
 LgfeXmGp9Mf1RPG2DWtnG+9VoHvjc6NCUgavO/AzYfF9MBLxD/acfSgazclvDByJanaj
 pM3BxhglkvNU36QkvJdKjZOV4srbX3zztGRVJUmoomy7PuHLg7tzxWNnkhTt26hzxewC
 z4DT9n11pK3pNt2hi8Sb41ZQrkexhc8IEkRRSGVOrLquu2djQ3tkU1yL7cSz06CWEGEt
 o1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733296657; x=1733901457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zy1Zsst6ECOhhHv2xZCzSWEOGBApQkwxoyExw0lzB9c=;
 b=lRn9KF1Dl+lY5CrT6fRjUlryb9h1xP0Mj1E95r6DPCz/ZxFfywqIntzG4uCTVBzIJn
 3d35h4E3lhUXPABXsJCNKTLfvttVpiFrLloSqLqKzejlXWLXW6K9+Pd5K9YZtjMRTueN
 aixVsV5QaxN2WOWVXrkYyZkZRrflOOLMBww9pdpJTZHC2MwLhEBEJ9J4Y76o9zqQy6cD
 w0V+8XLzM5BL5xhr3mVnNxI1zXwOjRlCvgPd0OTGoY7WMxORnwsoiQA9nK7c1XIKuw0t
 YQt/ImGvHkv6Wue9W3oH8P71xKpWWg9z9clVDwMeZPJGvwwXy4o/ztjQksf6RvRhxz+L
 tDww==
X-Gm-Message-State: AOJu0Ywxi3jkQjAN2LHmY3kBLHG0fbzf+cQCpq7OR24Fs2O3ZWlEObrk
 8rS1akKRrqOraTXw8FeX0YR9jUd7A7D4uKhZtouLV/J3gQ6WCywFhUmTTsN+l81asnDhB8tNz6Q
 Bvkc=
X-Gm-Gg: ASbGnctOGqVCFLFvnSATMLcAiMag9qbYY6B84+nYLXb6rJOBDn/0PITkM2gEztEtmxa
 1HLXxl63daR/zKurWz96XzBlDFLHzhF/Y3nF9Bf7xOAWSlK9eaUZcXnpEUEIHj/ziTBTLcTJjeS
 8UTz01gxLn75ogzYamgPaHOCFYBTsLluSdl+/y6OrmK69wjCjFRXAw+wOsrt22WCg1vWtiAfS9+
 7MDMNKEM3K88R+TsKnL4k7uaEkVX6t7jgZrL78P6hP7puSqLvkqgG7aa8/13iDftke9ZUBcBuwm
 IgpvKfYYznonsiim7Czvxzksy9kWTSjR6YM73ozzY6seSRAS8mtjZ8jRUgD5VefpPoWtixkIYnP
 xnOXLr/4Owber
X-Google-Smtp-Source: AGHT+IFCMUAk+MXFMg7AFcyML9EVlxdW5LhghLevBTsBi2fVL0kAOz/BgCrhPA5Y5JqpNDNicdxAaw==
X-Received: by 2002:a17:907:3e95:b0:aa5:ef1c:9dfc with SMTP id
 a640c23a62f3a-aa5ef1c9ee3mr886998066b.8.1733296648468; 
 Tue, 03 Dec 2024 23:17:28 -0800 (PST)
Received: from ?IPV6:2003:ef:2f40:8100:6dd4:7858:e1d3:156c?
 (p200300ef2f4081006dd47858e1d3156c.dip0.t-ipconnect.de.
 [2003:ef:2f40:8100:6dd4:7858:e1d3:156c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e69besm707741266b.124.2024.12.03.23.17.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 23:17:28 -0800 (PST)
Message-ID: <837a4218-4513-40af-8d2a-bc29817b0fcb@suse.com>
Date: Wed, 4 Dec 2024 08:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-6-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20241203151530.16882-6-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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

On 12/3/24 16:15, Cyril Hrubis wrote:
> PATH=$PATH:$PWD/../../../lib/:$PWD/testcases/lib/:: ./vma05.sh
Is this an error? It doesn't look like a correct commit message.
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> ---
>   testcases/kernel/mem/vma/vma05.sh | 97 ++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 47 deletions(-)
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
