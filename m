Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA330C021AA
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739881971; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=BywzhKE0aQiz4rguIhHf4BQlBAZWELZym6KBiOS/qs8=;
 b=TpkkojaXzY3wYA78cYsaVI9ocIS70S0P56iGjPshxpa8On5xg1+c0c7wB/e6bycgGcUm1
 PTaQWh8cUjALiIMwjo66eTkln9y57AwE3Uk1KizqsoMdnJbmTUJ7V2FSExZ0Z5vs1tlriX7
 /GOz5n+07Ua6VUO8JmswQu8qjMYAjeE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CBC03C9C90
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:32:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBD183C7D10
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:32:28 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E2D11000B0C
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:32:26 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so56416635e9.0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739881946; x=1740486746; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KLla5T1G0XROk5YWQywTOAClW4MaWNbkR7QkSOJp8k=;
 b=WKDC6Uvhcku3O/+d2kxaxpVQHkNETBxMTTwnKjycI3RA9y2jO+OpQ2+Eth14qJTEYH
 RD//XoetSso+V+qhgwobn5OHsYv1ags/uMMWifXRIL3eghkF3XKSXOTO2eq/8ZPvZq+o
 EbpFKF/YHzrVJyI9SJ66gzkpc0oqsiSBav1OQFmPoPZ9oEZHlNqmARoIOteHEhbJQvsn
 0I8VTfHYHmGhmVOaBaVkb7F17BZPWz8XD3/phBKuh9/eYdCgEC4XHcqGsV/4JWJ//W3H
 E90UApLCIl5FpJOFEh8UomjDAmr4Vu8u0jxctA/4jly9KOqY47R+/C1wNtr349ypA5tV
 oeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739881946; x=1740486746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KLla5T1G0XROk5YWQywTOAClW4MaWNbkR7QkSOJp8k=;
 b=eOio8WN0S4SB4EDAGsvHzwb+pakapaxeqBj0b2sY2VAaeED4c48/PGuQl6+jv1VSmk
 PlIfGDC/KjgaanOS9IA0F3bNgQp0FDaHJJ8ftAY9No0v+WafyUcqX8MJEOeW+Qa5uZEN
 ICg+Om4xQmmVNqOsqIawu/W9i6eqKTTX0fEhqWOSGpB10H266+0YdwcXy/vdXGcCiGD+
 HVGsbVpCZEC3//mkrzFuFXpBu1v1olJq4ljPNE1Lr2BkzK30hglPIxiwJWOUFGMXP1RR
 QrYMITnQZdREX70fR9Ht485nyGKzUtuJLc0TGmZ/SegiGyFRU7PdJfMwUzNFyizJw0Si
 eRbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd5gf+BpwCixu3duew74zLi7LTa6bc4tZ121G8PL/J9MSBWEmEat2/u7T1A458GIl3pT8=@lists.linux.it
X-Gm-Message-State: AOJu0Yy8wbkhM/E8MqFrgch1XZ4AW5/Drei3Smat2LlQaiKRCsIojzKS
 /fMcdJ9n6b2tNsIuXLAXDE//S9WbkMkBWnRaoL/K3RzlK6DiQB9srMjzEKNpTEq0bqNpfqrcY1j
 G
X-Gm-Gg: ASbGncv2aCscpoiE581e82Zsfdym02mqy9X5VZQuVY3uNPSMC4rX3AwXmjOXG8MOmVF
 s/N8Wii8SAjDoFgLD2KCcxX+rlKNdb+AWWTbgRvWy4MLNX9avnVKzjE1t2gZnRXuO8Ww5/E3Rzr
 e0hSlmU1UBrBuVWU2kH3krh3Wq1bZxRQKp931lT+BBYcSgRoBiqzW8RYKf9Im2daLvyQdAv5j1R
 vdjF/IblG5vCaQI1cGkeuCKoH/lMAU+7LqAC0mT67PyRrvyMJoKFzfSA1OsPX11dQeTWTAHg1Iq
 HWaAYW3oxzOgks0Sq6vP41qN2A==
X-Google-Smtp-Source: AGHT+IEDuxPYqnpBTEh40GSOCiZ0m1ntfmrZEpO9+bxs22/YKa0gAu9FJdmXgQeLXzJWXvT0xGIMrA==
X-Received: by 2002:a05:600c:3b07:b0:439:9543:9491 with SMTP id
 5b1f17b1804b1-4399543ed7amr12974935e9.25.1739881945924; 
 Tue, 18 Feb 2025 04:32:25 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43992cd8ca3sm11478505e9.2.2025.02.18.04.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 04:32:25 -0800 (PST)
Message-ID: <74a3b1f1-922f-4f5b-9265-879ca926dd05@suse.com>
Date: Tue, 18 Feb 2025 13:32:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250218121553.2470592-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250218121553.2470592-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/conf.py: Replace all titles
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

On 2/18/25 13:15, Petr Vorel wrote:
> This fixes titles like "[Race Description]".
>
> Fixes: 1bf344a3db ("doc: add tests catalog page")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/conf.py | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 03fcff67e8..e1d02d63e8 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -455,12 +455,8 @@ def generate_test_catalog(_):
>           if desc:
>               desc_text = []
>               for line in desc:
> -                if line.startswith("[Description]"):
> -                    desc_text.append("**Description**")
> -                elif line.startswith("[Algorithm]"):
> -                    desc_text.append("**Algorithm**")
> -                else:
> -                    desc_text.append(line)
> +                line = re.sub(r'^\[([A-Za-z][\w\W]+)\]', r'**\1**', line)

The idea is good, but the implementation can be optimized. We can 
"re.compile()" the regex __before__ reading all the lines, then we can 
use the compiled object to substitute the string. In this way we won't 
compile the regexp for each line and the string processing will be faster.

https://docs.python.org/3/library/re.html#re.compile
https://docs.python.org/3/library/re.html#re.Pattern.sub

> +                desc_text.append(line)
>   
>               text.extend([
>                   '\n'.join(desc_text),
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
