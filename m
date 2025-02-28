Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAC4C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740733978; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=kC6edA63b7uKlSxaHfbEq3QI3qCtYlmNGjZ2cP9MHOM=;
 b=Opg9UcaMPGr9BaEuEx61G+PK2CRPs7Z8TvaxvEBRqsvgVZy6aJxght90YSSYFcM3spASo
 bHfZrdCtm1g1QYIoYd6ebyX8+BY604etdxVCSuI/FXIAbbGnYjx/MnlL7bxu+CVeW7dGGht
 veyXmJsTu9HcjW7Am/FRfB7tf30iyM4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 994353C9E08
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:12:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAD993C262F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:12:36 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 26D3B1033AAB
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:12:36 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so11891185e9.0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740733955; x=1741338755; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sza73Hrvu0yOJxnFsXJ6MupG9xRdGrW25J0cu6KKzuE=;
 b=R0ijUnF+BpMKdotFIZh0CkdPRYJIMfDCYDTcfvBkNIba9EhVWsjcVla+oG9dpb5eKS
 NTLyXDOA1ECxru1nw9e3BaTsyUd6kcRFHrUzmAvaqKmvTneGwBEZ0NC6Of8YF46S0XH1
 4ab4Qh4f2E4aOQmQXDay7VZ9aRAFTWVskaZ8OnnvAr+lPWZiBrvY+fwxl6wqzWjgK/24
 H+h7RSu7qFdu0ePyFZVinzp2mnEQMg7xhCaWFC2C16cHWF9FMIwmptqscFIbBwcMnXUP
 ZbY0MsLwM+izI3EJNoAPGShjvSfzmDikyaNNnopBhDY/EWXMpZ54871lngQvCM530UVT
 cGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733955; x=1741338755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sza73Hrvu0yOJxnFsXJ6MupG9xRdGrW25J0cu6KKzuE=;
 b=Vdd7NmsRA6hdyPOsEquK+9qtSrcMVAAgZSazUp/UbQFi+Q3nbzGAO0M6dkTbgfwXSf
 lzxS/TQwSSELcxzsFSh2NZjw3Fqp5AgA6pVigM3m6ahtvmZS/zxrYDDx25jHfdPwMxNW
 cHdC4GH0KHWEOb+kVjFiWRvI2IBTsDgM76tjHAPano42O+rl37joTqeq2QzKwnxbyhgb
 UXipz51+D1PDQp2YNjxlWmLEq/XTJkv9xSmSyUqEg/Cjl7PuG6NLFpt2RP0mvrFP0rv1
 3AZDyha7InYZxNuFXMUpVQF5tgEfSDC9LskKShF/aGVDoUmtfi6XDmEIVy/NJMzTfp0Y
 cGUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOrOHaES3r2i8sHdDZ2NVko/qkkydZcX03EctqQ7xZ0EMWrwK11CdgqOMuJeVC47gkwpE=@lists.linux.it
X-Gm-Message-State: AOJu0YzCidIJbZ2aUNjC+fu7Hc/E6I2ynat1oi3Ql/YcTXtilJodoTXG
 jzFwh2akdByfBTrF63Q4A6/f2ZNIscFmUSnRdPFDHL03IP/WyLKLkrNmo/XPQLU=
X-Gm-Gg: ASbGncvAzM43U2CGzKZ6ZE76zVfdgs9vwfWrPgtJTh39x9liVlT+fn1wDcUt3CwIykJ
 xCwIvN/pSi+IXI+TgU4VY5kDZ3pe6f6mvM2Px34ueRIhxw0LW+i0keqeXdDh0ShMZ/dkPsU6OcF
 SKvwe9UtnNdaIQVHScEjHZYdKzgcSqrK5yO5XLrAVkExi++oYiKeQXIru6G7LaPOHsnPyaFkObP
 qRxftaZ52T+dBEXfUFC+CPOsp6TQNhtMLg7FeY//wf6aGneKXszu8elUSL/CrMVRCpz2LZCeX2S
 51u+TvkiHElcu49gW9iqcGdFJ8zDVAM+aG0=
X-Google-Smtp-Source: AGHT+IHxX33M6F0pnjK/1RQ5TrvIWgt339jYs5MDdZYAk3uBdMANzIYZn7TqGZ0nhB/p8pMhDV9NLA==
X-Received: by 2002:a05:600c:4f89:b0:439:9951:1220 with SMTP id
 5b1f17b1804b1-43ba66fa281mr19275015e9.13.1740733955526; 
 Fri, 28 Feb 2025 01:12:35 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2c4051bsm84278655e9.0.2025.02.28.01.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 01:12:35 -0800 (PST)
Message-ID: <bc291e1d-54df-479d-ae21-595cb658db1d@suse.com>
Date: Fri, 28 Feb 2025 10:12:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
 <20250207-mmap_suite_refactoring-v1-1-d006d921e4d5@suse.com>
 <Z7yfsrxtx5LeU40n@yuki.lan> <20250227142727.GB3130282@pevik>
Content-Language: en-US
In-Reply-To: <20250227142727.GB3130282@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] Refactor mmap03 test
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 2/27/25 15:27, Petr Vorel wrote:
> Hi all,
>
>> Hi!
>>> +/*\
>>> + * [Description]
>>               ^
>> 	     This should be removed now I suppose.
> Yes.
>
> Also, unfortunately Ricardo has sent patch to rewrite this 2 months ago:
>
> https://patchwork.ozlabs.org/project/ltp/patch/20250114-conversions-v1-2-7869a9f786d0@suse.com/
Yes, I already apologized for that a couple of weeks ago
> Usual problem: we flood the queue with patches but nobody wants to review :(.
Trying to change this. I will slowly work on reviewing as well.

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
