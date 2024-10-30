Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7462D5CCBE
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730302464; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ivTm8hVEnY4T9f7HYbJUGfodcwplAcrlftn6Lflp1KQ=;
 b=Fa9zKA5lZXNZl3o23SZ921kr+xN5ywX3Qpjmdua/G1OJk0pSSV6DT1OAJwyoLCwG3aPdD
 Kgkx34vwwpRzjsFqWhjyTZEEI14mQlD+nD4HdTbQiAYIGhBcNR37W7ZxQ9UONK8PFKUrtj8
 wbC4pydjOdMiFw9ezJBgbbPw8OEFnT4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E12843CB2B1
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 16:34:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0EFD3C6E9E
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:34:03 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1EC3F7BFE3A
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:34:03 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso62637155e9.2
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730302442; x=1730907242; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VkKS1mkVrHegg3gEV1b+ko6PFggCOatuQzFEgANSkB8=;
 b=fyshEa5GtlNA5aeXFdtNCJQWFg6DNnwhjpvxHAZ8L9u7zY+pDiMTt9ZntwGyS9GB4q
 TGLU+nZvB0EerOnOF5exv8/xwRsKRebOhHvbx+kzFL7nGpnjIGbET87yDIJ9Re6jQ3rl
 zGif2bCoeJX9/cNZdzMyfreZRVVG9DEltUgC+hV8acZsl2apEKqVhOC40euHYIouetZ3
 KZpL22WifGv+dr0XcfjT2LdqwrTUpkrf5Vk9/M8Bw3W/N8eOKgxFVflfX8IH5l782cKw
 Kl+eDbri9JR6HJDSoOdeg1zxebGmYIXdvJkTTvXKbc+jtNffP5NpwhRHqJxkTRVzBg7s
 /Fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730302442; x=1730907242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VkKS1mkVrHegg3gEV1b+ko6PFggCOatuQzFEgANSkB8=;
 b=DqFXnY/3eqXPAk9foYSaomnHWO4dD47Y/jR/WA7P7z5b51anBS2yIz3aU/EgiXPBW1
 H/Pq5riR6/5l8HloqgM3opED8b/GDi9bSKGxUMpkIWHrFwicBXkJlqlXM9sMkkVmO/Ci
 ydlZjDu7jIPO8djkHmX9r5HTrVsvW71R2+zG7CBrrGhNCDh3o9uG4S8PANIV2MiCUn6u
 DC0lGuZKgA/qKjsH1QiuzLfKoUmHuN/aOld18eIl8cUqb1STKvkE0lJA3F6lCg/0sRkf
 3A7BpZ2syygVNV1iaRp1rk4tnC8AwoYmwQU2XASCJc1A+mk5SharXuFpjHd21LJgJ33D
 Rxdg==
X-Gm-Message-State: AOJu0Yw3jOJC6lD/seAPvTjQrYlK7ljt/FvusWpPyzSuF19FbT5IB2HT
 BB4tuPGE1OcZhS6oJfbc2rEZ6NVahh9+Np1iuKiBa3KNOzsyhlja3LZB1vL94ng2xdlADPs5VWP
 iI/A=
X-Google-Smtp-Source: AGHT+IFTfTT5BsbelI0mzbs5PvqJkKnMjrj61kfXOHfiQVeJd3nYUv3E2XEiI0rPMN8HBWt0ClisDg==
X-Received: by 2002:adf:e0c2:0:b0:37d:940c:7391 with SMTP id
 ffacd0b85a97d-380611e75b9mr12074157f8f.41.1730302442468; 
 Wed, 30 Oct 2024 08:34:02 -0700 (PDT)
Received: from [10.232.133.6] ([88.128.90.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bb4724sm15615617f8f.115.2024.10.30.08.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 08:34:02 -0700 (PDT)
Message-ID: <fa37b53b-51c8-4ea2-b95a-c6248b5bc4a3@suse.com>
Date: Wed, 30 Oct 2024 16:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-1-eed6a87dc787@suse.com>
 <20241030144908.GA915191@pevik>
Content-Language: en-US
In-Reply-To: <20241030144908.GA915191@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Refactor regen.sh script to generate
 syscalls
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

Hi Petr,

On 10/30/24 15:49, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/include/lapi/syscalls/generate_syscalls.sh
>> @@ -0,0 +1,115 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# Generate the syscalls.h file, merging all architectures syscalls input file
>> +# which are in the current folder and defined inside supported-arch.txt file.
>> +
>> +SYSCALLS_FILE="$1"
>> +
>> +if [ -z "${SYSCALLS_FILE}" ]; then
> nit: I would still replace ${...} with $... (e.g. ${SYSCALLS_FILE} =>
> $SYSCALLS_FILE) as I noted in v4 - readability. IMHO there is no need to use
> ${...} in whole script.
>
> The same applies to include/lapi/syscalls/generate_arch.sh in the second commit.

This is a bit debatable. The reason why using ${VAR} over $VAR is the 
readability in the first place (i.e. when you have `${PATH}/bin` instead 
`$PATH/bin` or when you use characters which could mix with PATH var 
name and it might create debug issues), but also the fact it provides 
${VAR:-default} syntax which can always added afterwards.

I usually prefer this method for these reasons.

>
>> +	echo "Please provide the syscalls.h directory:"
>> +	echo ""
>> +	echo "$0 path/of/syscalls.h"
>> +	echo ""
>> +	exit 1
>> +fi
>> +
>> +SCRIPT_DIR="$(realpath $(dirname "$0"))"
>> +SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
>> +
>> +echo '
>> +/************************************************
>> +* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
>> +*  change your arch specific .in file instead  *
>> +************************************************/
>> +
>> +/*
>> +* Here we stick all the ugly *fallback* logic for linux
>> +* system call numbers (those __NR_ thingies).
>> +*
>> +* Licensed under the GPLv2 or later, see the COPYING file.
>> +*/
>
> nit: fixing space in /* */ comments (correct in the original regen.sh)
> + replacing old note about COPYING with SPDX in generated header:
Thanks you seen that. Now I know I can't fully trust auto-refactoring.
>
> +++ include/lapi/syscalls/generate_syscalls.sh
> @@ -17,18 +17,16 @@ fi
>   SCRIPT_DIR="$(realpath $(dirname "$0"))"
>   SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
>   
> -echo '
> +echo '// SPDX-License-Identifier: GPL-2.0-or-later
>   /************************************************
> -* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
> -*  change your arch specific .in file instead  *
> -************************************************/
> + * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
> + *  change your arch specific .in file instead  *
> + ************************************************/
>   
>   /*
> -* Here we stick all the ugly *fallback* logic for linux
> -* system call numbers (those __NR_ thingies).
> -*
> -* Licensed under the GPLv2 or later, see the COPYING file.
> -*/
> + * Here we stick all the ugly *fallback* logic for linux
> + * system call numbers (those __NR_ thingies).
> + */
>   
>   #ifndef LAPI_SYSCALLS_H__
>   #define LAPI_SYSCALLS_H__
> ---
>
> Kind regards,
> Petr
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
