Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49C8C25B4F
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715070536; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=D4mUkd+hQx810YltDxJj2JVITDLWyPK9Hp5SfJ1Gfdc=;
 b=e1MYD+kJ6H+8FxHhg4gQNJUiQN8m/3h+WFS4O9xXhR5JjjE9BL1JTogM+TvOH10NMyW+R
 ni2tiTUHENfAROnwNMoat7bW54iK5lrEWyyEuL/ZZxHIb/1+bJBcAz7MfEvRug7bDqZRi30
 crtaHq3USfk3/t1t26x6GE9KY6tT4iM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37F653CDB94
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 10:28:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B0243CDABE
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:28:35 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A0A1E1400BCD
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:28:34 +0200 (CEST)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51f0f6b613dso3528003e87.1
 for <ltp@lists.linux.it>; Tue, 07 May 2024 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715070514; x=1715675314; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cNVpo1DWv4BwcCAtDEXjGKYAiRwUAR/ewtRCVjor+HA=;
 b=UPLvlpF4riz2yqm5bIpTRwUxC4jMNeJLRDKADUVnnnU/uFL037tmD5JKLdwjp0yFZI
 x5j8OALibc3IFcS4+YSPcu/JbiguiyHtJl9lOG7ljFvvPPXMa4cBiWO45ISoWGLcXiix
 fdboBf2XvU3Stm0ubQBDO0nKWKPAb04hlIY7n3vgLA83fxX3VC1RIcUNi3Ht+iPfE8Qs
 h8c5A5iiJFjfkpoPo/v2n7KKLLy3QcErAXk5TcbmPr+BolyMUkfDHRpou4h2Xkl9dcxB
 7biGMF2ZX0szjfr9r7s4CEB5SzIlMiGbq58caHUzq7WPgXTOMlULYzDYdv7I1CLYScKQ
 3trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715070514; x=1715675314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNVpo1DWv4BwcCAtDEXjGKYAiRwUAR/ewtRCVjor+HA=;
 b=bR4zhlOSRTswBJEY8fnad0VR0YWY5SRmUbvziG+PuqYcuj80rv5IZNv32h3kf8HEJo
 etHZ4iJ1flNHGoCk0t5UWo3WCzmc0Zrs3Xzvt1zJKF7qDXV2WxlJ/5KyszP1sGjcFA4h
 HDDGKGbE4pZ1ibEUNd/4uCdkp1Gq58APQbaAmrrnlfiyfMJSy5CHZMu+KJb/uSqfZMVP
 lf8UFWIwhLrWdR23i9VlQeQy1N0ls34CXy7e7zhKKzYNSeK1dfXvfyC3Xqv4zkU+thu0
 O6IT/Oc6eOqSwjFMryhApll7wxOuNK/Z8KZlO7pHLanU3/H+wNxvzTCUgpnzGL4wuniM
 qgBA==
X-Gm-Message-State: AOJu0YyueBVnfr2pvrBivm4/8gK8R9PhKjtMA0E5mWGnbDYuCgMWbyD/
 iQNWDMgRTnluhJjTbOGkv/MGmg2hKF7f6gQGe2GXp2Ok0wiowsmqKxMzkAxdHxA=
X-Google-Smtp-Source: AGHT+IGdnzIihIzHwHSTo3z4JRgi6Zq4lcFHk5mU8TMF4mWsGbASW1l2sbdyncvbD8/7d7nxWtDMrA==
X-Received: by 2002:ac2:51b3:0:b0:51a:cafd:3872 with SMTP id
 f19-20020ac251b3000000b0051acafd3872mr7957594lfk.3.1715070513736; 
 Tue, 07 May 2024 01:28:33 -0700 (PDT)
Received: from [10.232.133.81] ([88.128.88.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f4d076679sm7426375e9.1.2024.05.07.01.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 01:28:33 -0700 (PDT)
Message-ID: <2a1c0336-c383-41e8-a42d-ba29511cdb17@suse.com>
Date: Tue, 7 May 2024 10:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Li Wang <liwang@redhat.com>
References: <20240426042851.333269-1-pvorel@suse.cz>
 <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
 <CAEemH2dzzZp5kMF5cQPQQ=Z-Eb55JkEtqvh2E8UOt6UOE7gr7w@mail.gmail.com>
 <20240426182557.GD6871@pevik>
Content-Language: en-US
In-Reply-To: <20240426182557.GD6871@pevik>
Subject: Re: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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

LGTM with fix

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 4/26/24 20:25, Petr Vorel wrote:
> Hi Li,
>
>>>>    /**
>>>> - * Macro to create minimal swapfile.
>>>> + * MAKE_SMALL_SWAPFILE - create small swap file.
>>>> + *
>>>> + * Macro to create small small swap file. Size defined with
>>> MINIMAL_SWAP_SIZE_MB.
>>> "small small" sounds weird. Maybe "really small"
>
>> +1 I guess that might be one typo.
>> Otherwise looks good to me, thanks!
> Thanks a lot for catching these (on 2 places, diff below). I'm travelling for a
> few days, thus I'll leave it for others to see before merge.
>
> Kind regards,
> Petr
>
> +++ include/libswap.h
> @@ -30,7 +30,7 @@ int make_swapfile(const char *file, const int lineno,
>   /**
>    * MAKE_SMALL_SWAPFILE - create small swap file.
>    *
> - * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
> + * Macro to create small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
>    *
>    * @swapfile: swap filename.
>    */
> @@ -41,7 +41,7 @@ int make_swapfile(const char *file, const int lineno,
>   /**
>    * SAFE_MAKE_SMALL_SWAPFILE - create small swap file (safe version).
>    *
> - * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
> + * Macro to create small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
>    * Includes safety checks to handle potential errors.
>    *
>    * @swapfile: swap filename.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
