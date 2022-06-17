Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42493C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 12:13:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14AD63C889D
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 14:13:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F683C0F3F
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 14:13:14 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8705C10011B3
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 14:13:14 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id z9so2219890wmf.3
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 05:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=hnlyRioGpxx+rbPm2S0jS6ADUAhgKmqzSuVKtSCygKE=;
 b=DtNHpfpHlFlaeqXduwx0230ymigZwE3YzhrDwapDz6K7xjYWim1sOMYwnNqiFUtIdO
 LtRUjjUdSifY8JlG/rs5SUmn3NvK1rDYkFwODdcErzXrabvUSYS6mj4qWre9UNA3jsQK
 xmj00Gg7lW4qkYffU+wUvpcHXY0opEJwW1UU+pRlFBzqK6r7gXx+2mrjZ7dHbiln8iau
 aA4Zxc0DzqPAg1WlyEPnvDkBb3KXdViTCXE2bjYWMqb00WQlM4W9FibqQv4HJ8ttXTET
 MHmzHNaZFdWHVCRulhu6KHWpPB1ewT73HoTPmPZwu6AvVbcPeALy6jsLwbHzpT6at+0U
 YiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hnlyRioGpxx+rbPm2S0jS6ADUAhgKmqzSuVKtSCygKE=;
 b=tFneBeu51NVw2AvrK/SC5ZOo9FA6zHRDtoCOAisDZpLkFmO5cj6II3Sk2q0JZFJlU9
 AnvcSYdihkpqCVcJfJ6VNMAe9ZKiXtDre2F2ywmQy4mvTq4YbKyooWCx8cscHHsAgncF
 /MUbOjK7ah0cjAssM1mekRtO0sJFnR6LhsHKEV9gg9DnJP/Mj1Fs2sHoKLakRsNm9qi4
 NJATMJGYczVq2oiMgES4bBuXnTf8tP4mcv7w6LOrfCk5LslLX5OOUyP1Z+FVfQPIl93e
 uXdxAYf+/F6lHo5xnZlgT5wvK62TpHxmCpx/iip60kpY+7MdizP1dJxxZt7Gd41o9go6
 FRFw==
X-Gm-Message-State: AJIora8dhV1jwi/qxuYzG4mnqPb/ZPgxRWLh2FEeDC+EiXrslMcCeJAp
 c3avugfyWvEcZu6DWEVi39s=
X-Google-Smtp-Source: AGRyM1tQeLWeg+xDGUA28c6lmAfKslWy7OeQwCiqFA+VwETfyXI6hxyyCo/pbQbUgFGCRx13Tp54qw==
X-Received: by 2002:a05:600c:190b:b0:39c:7704:74a4 with SMTP id
 j11-20020a05600c190b00b0039c770474a4mr9806897wmq.92.1655467994150; 
 Fri, 17 Jun 2022 05:13:14 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
 by smtp.gmail.com with ESMTPSA id
 d8-20020adfc088000000b00213ba0cab3asm4526185wrf.44.2022.06.17.05.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 05:13:13 -0700 (PDT)
Message-ID: <fe7c52f9-5ff3-95a5-2692-20f81d6decf7@gmail.com>
Date: Fri, 17 Jun 2022 14:13:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <b8d6f890-e5aa-44bf-8a55-5998efa05967@www.fastmail.com>
 <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
 <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com> <YaTAffbvzxGGsVIv@yuki>
 <CAK8P3a1Rvf_+qmQ5pyDeKweVOFM_GoOKnG4HA3Ffs6LeVuoDhA@mail.gmail.com>
 <913509.1638457313@warthog.procyon.org.uk> <YbDQW6uakG3XD8jV@yuki>
From: Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YbDQW6uakG3XD8jV@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Ping: [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 libc-alpha@sourceware.org,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>, David Laight <David.Laight@aculab.com>,
 Zack Weinberg <zack@owlfolio.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 12/8/21 16:33, Cyril Hrubis wrote:
> Hi!
>>> I could be persuaded otherwise with an example of a program for which
>>> changing __s64 from 'long long' to 'long' would break *binary* backward
>>> compatibility, or similarly for __u64.
>>
>> C++ could break.
> 
> Thinking of this again we can detect C++ as well so it can be safely
> enabled just for C with:
> 
> #if !defined(__KERNEL__) && !defined(__cplusplus) && __BITSPERLONG == 64
> # include <asm-generic/int-l64.h>
> #else
> # include <asm-generic/int-ll64.h>
> #endif
> 

I'm very interested in seeing this merged, as that would allow 
simplifying the man-pages by removing unnecessary kernel details such as 
u64[1].  How is the state of this patch?

Cheers,

Alex


[1]: 
<https://lore.kernel.org/linux-man/20210423230609.13519-1-alx.manpages@gmail.com/T/#u>

-- 
Alejandro Colomar
<http://www.alejandro-colomar.es/>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
