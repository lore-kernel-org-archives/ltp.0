Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D113C4345F
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712910756; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=fZivYTkn0jHHEQcdmBqj3vwdgKvfXqxquq+4ZgtpiAQ=;
 b=GiQezgW52+SxH8FMgRqt1sdoMn4BY+Z+Yq3wNuJT57e7OmZs9OTpp1FNIAGBbGZbg+2Bs
 QtLG+jv5siTSEMnu+PytuCGSLkT65PU7lbx9P5/+vA1XK9mZaulTw58Azstr/UY9NclZH0u
 AWnx7gmSvzSEv4noQBK5DsWUsZ/l0qQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADB8D3CF8AC
	for <ltp@archiver.kernel.org>; Fri, 12 Apr 2024 10:32:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E913CF865
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:32:14 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C06A960110B
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 10:32:13 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso432038f8f.2
 for <ltp@lists.linux.it>; Fri, 12 Apr 2024 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712910732; x=1713515532; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fWwMOhCN+SaAb1p5cOs+UPltkVUyN5pwU9ilBriq3DE=;
 b=CNjHia1JMtBCibnOYYMUEYQ2T+UBW+ThnghwH2N7qd7ciVVeZpAaZcN5nXi6EmHi1k
 XxJRt016+opmrCIG/lgZj0dLvDyrKEUvHIk54NzcPlzfrbDEf4WolC00edv1dnS/Jtpo
 iEJP2UKnW02/gjLMehRf/KTXbpDUTm79SmjrJs68/y6bpiVOFfP3BW4PY9kniWQUXgDg
 SHYnBBO1K5kGaI7T3yZQQUordIE77Kfo5jukySTC9LdMThTjfbd0x8ebRB0eM4ikJz7w
 1kd63gWMRQbDGE2Y0a/qWwPzY04hRFmkeFs1k0lka2O2ur9FfUPG5lpPHhK+bBTcvchQ
 YWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712910732; x=1713515532;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWwMOhCN+SaAb1p5cOs+UPltkVUyN5pwU9ilBriq3DE=;
 b=IX7Hv1IihI5S3ZzjKzCW2OH57qeAQHNApQm8vnOFe7yntKZhphxN9e1SMrbmNJBzfP
 zXc999VzUzFxwdeiRN4FoxFQ+jvD05qRKSqH3muKcOFGKRFRLRpMB8kNcZyRM7KQZbVE
 cuHMjL/QomWq4v44iP/PDoBk7uOaQbfV44Mqti5zlt7JmyszAzjX8jdAA1kAD3IZWXNa
 EDvlnugbioD1GqMDzl+KV6ewP7JIcOtq7r0eHkmkYOzVHUL1bJHs6kcFpxXW8yHlvlo2
 PGvP39zalne5Iwy91Zt5H2W/rNcj/KKd2PV/3R4D8E4Gb3ytH+E73icF0T/Edarj1Uvf
 c53A==
X-Gm-Message-State: AOJu0YzEbQHXoD8P3jdzOjIB/yrQp2PfWVk9A3abZnlMTcGuRz3TTPAB
 ThwxW68Hwg9KU1uERe7TnYq7UijBogckHR2AsD7cvtoM+OOWZnPFMGFdBQQ/hxMayOE8es81WDB
 GtV6aow==
X-Google-Smtp-Source: AGHT+IHmnvA9x6gYA+AeOFjYk8ra0a/flre+hzWeqXS5HSlo/oSAcYtSLWghTvq3hbBkocizkmE3Xw==
X-Received: by 2002:adf:e706:0:b0:341:c270:208f with SMTP id
 c6-20020adfe706000000b00341c270208fmr1184747wrm.20.1712910732516; 
 Fri, 12 Apr 2024 01:32:12 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.50])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d6a50000000b0034403ee44b1sm3735355wrw.14.2024.04.12.01.32.12
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 01:32:12 -0700 (PDT)
Message-ID: <617829ec-4b79-4147-9c64-b53adc925c77@suse.com>
Date: Fri, 12 Apr 2024 10:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-8-pvorel@suse.cz> <Zhf6wC7Cxa4-Zs--@yuki>
 <20240411204631.GA368229@pevik> <ZhjkZ7PP5vS12Cvb@yuki>
Content-Language: en-US
In-Reply-To: <ZhjkZ7PP5vS12Cvb@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 4/12/24 09:36, Cyril Hrubis wrote:
> Hi!
>> IMHO you are wrong here. IMHO uCLinux-ng [1], still used libc (used in Buildroot
>> and openembedded). And log in e5e938f4b7 (2009) suggests that it's about libc.
>> But the question is whether it's still needed. I could try to remove these and
>> test, but as a separate effort.
> You are right, these should be converted into configure checks later on.
>
> And the tlibio should probably be rewritten completely. So let's keep
> the patch as it is.
>
I started to rewrite part of that library when I was working on 
growfiles test rewrite, but the complexity of it, the amount of nested 
statements and macro directives made me crazy.
Waiting for a better moment to restart rewriting it, but work is on-going.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
