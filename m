Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95CFC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718029404; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=x/mtkZp1/pCHl3DLwNe8+drfxiy8eejBQNYl8Cfu9Cw=;
 b=ikhB1hKKt817xon20QXI/NfH9tMW3zo4Ima9i6r/BpAMf0DY8I74cXG71hNQgqTWYakqh
 ZDgEuQLNZh7/XYkXtQA6gdoX71EmSlEXac9pps+WA95wmxZpV8Fi4w8GTalq7xQ7/IOV0QB
 lNxxrewa61OgJMnuD9bBYubsxOl2JnA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DA413D0B46
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 16:23:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE8B93D0B23
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:23:03 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEFBA1000448
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 16:23:02 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c68c3f8adso2711274a12.1
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718029382; x=1718634182; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3E3yEOdaKs645rZ/ppz0FEove45xIkIjeplJY4R/9Qo=;
 b=XyW26nDB7jNvUP5xlERJvpeDWbuL5vYQSTX0QTz4DhhlfiwDUxUbIuVbBbP+Zygben
 HfiK1DoPjUr/DzftrSecg5ErCbh2hLzp9k0Vfrkuu+mGzvs6oJudHaoY3Yhh3/QuFnmN
 F6tYMMomRJwdNtdgjcMPMqZHyuNNTgcGHrn5QjX6cuXREkQkCKE/LlG3SbS9++B9Joja
 OqN/vWPmgXKSE7XeHBshwzN8cLQOq5YPF96QCm7R21YXVzcgumh0P9dPkGRN/LW4D3/w
 Z43q6B5zKrMzVsyyfAjgdUmqboBRzSPTA5+3GgCdZWSapRyEuaobr7lP3tR6LeLhRadB
 kYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718029382; x=1718634182;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3E3yEOdaKs645rZ/ppz0FEove45xIkIjeplJY4R/9Qo=;
 b=HERBAOE0rXyY6mSbFxGoSnS+VMg8A0yNiN3ocxGmCLPYMhiUHb8tdBGMRKiuT67t3v
 wzkBMtANZ4vaNXRBIIpFMeF92pb7JNWZ4zRPiKH0FAPChzUTG8+xoKD25X43xIOZmgkD
 WQvSyTZ7j9ZcRMMppaq8dRsc4sd9cL4oQSV/bk+pIOWeA8hSwJ3sk4NJ+Y71fIgXElh2
 fR9IVaS56nnH55tCUL5sYVYCRya70OyokV/ADBrvXf/vhh9hfkgT1n6+hvKps8i908RI
 gHhYTH/ppGe6rys/SaernWUMfLQFyJPj/xK4HSKt5GDMIDz+jLiOcUsY+l6SAw8L9b5a
 oOlw==
X-Gm-Message-State: AOJu0YwpeB5T4e94qpMs9hG2Mxw6BbhvSL4oQi9iFvK4+cZ3+co28End
 1+YH9RvyIdUik+W+2jhr2snVk3qL7xc3AJSrGb3KWbaKG5uOKDaszyA1wwNPkyUAvJ5rbFD1cOL
 Cm88=
X-Google-Smtp-Source: AGHT+IGZvvhW5hmkDESr/lwJv4lQugFOB+Kfzrv8zsNIUE4x2Tm3P2qR4Ay0Uf9seE2Aah951cLU0g==
X-Received: by 2002:a17:906:c099:b0:a6e:7719:e4b1 with SMTP id
 a640c23a62f3a-a6e7719fdeemr633388866b.29.1718029382279; 
 Mon, 10 Jun 2024 07:23:02 -0700 (PDT)
Received: from [10.232.133.65] ([88.128.88.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0b5371d2sm324040666b.39.2024.06.10.07.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 07:23:02 -0700 (PDT)
Message-ID: <6416f2eb-73a9-47d1-9071-5576dda4631b@suse.com>
Date: Mon, 10 Jun 2024 16:23:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240607-seccomp-v1-1-70063fea55ba@suse.com>
 <20240610140743.GD746646@pevik>
Content-Language: en-US
In-Reply-To: <20240610140743.GD746646@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Move prctl04 in seccomp testing suite
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

On 6/10/24 16:07, Petr Vorel wrote:
> Hi Andrea,
>
>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>> prictl04 has been renamed as seccomp01 and a test variant has been added
>> in order to support the seccomp() syscall, that is currently equivalent
>> to prctl(PR_SET_SECCOMP).
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> It'd be nice to update test description, that __NR_seccomp is also used.
That can be done easily
>
> And print info what is being tested, based on tst_variant (see chmod/chmod01.c).
Ok
> BTW the old test was broken on musl:
> prctl04.c:212: TFAIL: SECCOMP_MODE_FILTER doesn't permit exit()

I don't know about this. Maybe it requires one more test. Is there are 
reason for that?

>
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
