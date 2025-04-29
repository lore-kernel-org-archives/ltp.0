Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F85CC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745938554; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=2yKkK3o6J1LI5qC63bmclHGpws7/qoTb+lRjmmQqxWY=;
 b=eui9znim2hu1sX7DO+Q7lzeXfQA7MX3i6TyM9Kx159odw5NxYTozayjp+DOG9pioqo9jF
 TEZ+CQ2+/WAnkf87xM/mjcNBw/7Se6TS4uTLC9QegAIftob0D0UO/Ik1rAhPtpOwx7sVKsA
 K8n5t+WGuQPJ4czIdRwcWGJUVAw4RnU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E5A3CBC0A
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 16:55:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742EB3CBBFB
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 16:55:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 855D714002DE
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 16:55:30 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so63325095e9.2
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745938530; x=1746543330; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7J3A3G4dHiF1Ogck9b1mVfo90RCB3TVrn6QudA8xvoc=;
 b=g+5qJYO1h3Gw58Y/em3uKcn/aoscHwJjsbowGcWUrZ8Ny3MGi+PvwHJ/n5JqpMNgfn
 VzuaXc0miQiNo64YXiCSVu1a4hQItYUKqN5It7ye7dPiwafiBsTD5qIsyTxC8KiMg8vR
 7sbAHWcIjk107wFUPo+WMB6dTUq+P8UHKwEkQ0mkYL6vOTyHpIjOGTvYbL0jUdIK5JVT
 zu2cjh+gTyVdylV/E0a+v0iG2cWvVU4Pfu2ucv5yMz5zmNLeqgwe0zAS3TuV9xncU0yB
 rX/r5hEkmRYgdxKrcgEb4YN7wMinQMBukWRM04gXDSizaTbBK7Id/1er/3CwJg/16PWe
 S+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745938530; x=1746543330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7J3A3G4dHiF1Ogck9b1mVfo90RCB3TVrn6QudA8xvoc=;
 b=MWHTzZz5C3MYWvW2VZlHGZ0zrNPInyOZUpR6ZQ7H07E7DyGX0IRcSBvGvQVj+vRmNX
 4qsmGjTs9eSOMVpgjeUDFD82Ln/VF/gVTcopF/p4WAHgEzY+FD5+JVO30Vh0Ge9EL3pf
 U3zT8T4QdjZwcuku4tFO9ySLBarfHZgT12MloW9KmZsZpqTENcY/0Oi0otqGorI7YiNx
 QImEdZNadt1/+yljHB4ZUv8aQDF1iHyeMXw1+rdrNmT+ZTxELckcj31o5BMJ7Hj9kFme
 B4K8Av+zXsbxlQ1kYtdfWnJzUDIjWEbNkZDlTfjopypPThkC4bkIbAit2M6hIZlArjI2
 UWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRe1peHBlfhipwh+b7f8foADnD4lp1W6TpvKhGi6ohcfroAZT4E2F+4gXdVgQhqGq3OoI=@lists.linux.it
X-Gm-Message-State: AOJu0YyynQike8VIlBBTgEmj1AMwEu4PqucjIbU0/ialAUfQI9EaSbMG
 ZaHVeX44t4V55E4tzrkn0uCHIWhXb8tPxMaK9w0lL9EKIo4nltNnPe8QV7nafyUwM+6PjYZ2Jwq
 m
X-Gm-Gg: ASbGncs2PNuNEMGiAxQ0x2PYTOZM8Fr5sHjUoIycekrQ+T5fZnooTgcCpVdEq0PMK8K
 aSBAhC2jjkUrJlAkkbzIaXokv8xWVcwBK+nFAHXbysI4QLd2r+ISzF09INCb6+7I293rsXZqO1Q
 p4g9kWSJWrxe/IX9N7qpIltIXjqwXiIWrsQAFiCIjZiCppg1uj4zL/lD8RkS4vLKPLIr0uvGRmr
 MWmuaS0/LmwGDdhOnUAwOh8mZnjXP3NSSnMvLZhuWWi4BhE0ulavVKBoRt0XFRuELqooBfmRS39
 XFyATCU/tIfppjcjHzvOywnFRiHkkD6gbPETf7yVU/qwYUDkI4MHHMrjLLuoHgjpRqm894LfuYn
 2Lw8dqWOjOmPAqTa3eqETXarKW4n0cgiLzZFJubMxyjJUwGm2aysy2rvuitNO3qDHlf9m2iB3OE
 jWVeXP6geoRNNWww==
X-Google-Smtp-Source: AGHT+IFEprEZaH2UitfCtyAHER5J5LOvaDa8tvdfev8PZWZvsCAqjsqKILqEa06BSNU5husuY9c3lg==
X-Received: by 2002:a05:600c:8012:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-441ac84b1dfmr36921785e9.2.1745938529776; 
 Tue, 29 Apr 2025 07:55:29 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2d8343sm194431545e9.28.2025.04.29.07.55.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 07:55:29 -0700 (PDT)
Message-ID: <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com>
Date: Tue, 29 Apr 2025 16:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250429135542.19680-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250429135542.19680-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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

Hi Cyril,

On 4/29/25 15:55, Cyril Hrubis wrote:
> This commit moves the check for supported architecture before the check
> for test function existence. This allows us do ifdef out the run
> function pointer initialization and properly TCONF on unsupported
> platform.
>
> Example usage:
>
>   #include "tst_test.h"
>
>   #ifdef __x86_64__
>   static void run(void)
>   {
> 	...
>   }
>   #endif
>
>   struct tst_test test = {
>   #ifdef __x86_64__
> 	.run = run,
>   #endif
> 	.supported_archs = {"x86_64", NULL},
>   }
>
I guess the reason is that we want to skip code which is not compiling 
for our architecture, right?
But do we already have TST_TEST_CONF, so I'm a bit puzzled on the use case.

Isn't way more easy to use:

#ifndef __x86_64__
...
#else
TST_TEST_TCONF("Test supports x86_64 arch only");
#endif

And eventually combined statements can be used, so:

#if defined __i386__ || defined(__x86_64__)
...

is still valid and it looks easier to use.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
