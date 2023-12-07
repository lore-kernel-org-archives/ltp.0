Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA2C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027BD3CBD11
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E63C3CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:46:52 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37E2F60067A
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:46:51 +0100 (CET)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ca0f21e48cso8644821fa.2
 for <ltp@lists.linux.it>; Thu, 07 Dec 2023 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1701953210; x=1702558010; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VCg/Y7W7HmwOFEwtuWdT4v58aOld53YrZRM6+FS6KAc=;
 b=ZaehG9ZEFBeRM4popdy4pG+618omi/YHP/00zPmdS/dy5ftnc9IiXJVfVLQUCQN8NU
 1GDNWm8M7HpEpU7zMGn6NTXCyx4ExK5ABpMzZdnySbASlkp5iGZhWwFb9LHXtbhQqMu1
 0oWrXDzTT6sASeP/jzLhHFwcy0rbkJB92RtG9C1PCt2LNP9z1fxLJTOu9N5S7W7HDzrP
 5ZRjPInLdT898DZY00swbBLT/S1aOrKpr5sWsuMldpL3ltnfRxTIVAOFgJZ/c6oOJphi
 Ml1Cdi1RwZ8nKAO42P36DaFXSorqWYwIW6FEIC1JrLEZilliWPf4rg0MKLiXp9CLVynj
 jJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701953210; x=1702558010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VCg/Y7W7HmwOFEwtuWdT4v58aOld53YrZRM6+FS6KAc=;
 b=OYM1JsfiZJ0gZIl+mSDOEYBvlczuDG7dgPIi0xUxw47hqT7N24R7MR8U2OrvKIxDti
 okf6mSKCVzdxUPFxR6FO5n2+x6U3wI1/Q4MjIn07Bm9P0g+iR1cByB6x2tLWT4SAEpR3
 apmPWDKIr2c5qRfqzDIWWidleU2CE1Kfl2iYY/nDRt/edhXNk5H3jQKYbiFGrR4yKcKY
 CsRC1TBcpPs5V5n4Lmt6OuQfFO707TfDJWT+ZK1riaQWMC1+eOgGsXg8YG17fU1hPCQE
 sc5j+5jPG0C6FMlEXabW8NtqPeTWC1f06bj/k5BFaWWYjXwT6g/lZi09sxDiY4oicui3
 6kcg==
X-Gm-Message-State: AOJu0YzVB3KfoMPk4yMYvE10EAq0GaOZ9ZudyM/kmqAXkD933gJaKTqS
 Tu0Rjibzx4eRMftxz/h331uUkQ==
X-Google-Smtp-Source: AGHT+IHpa4rKGA8d8zeeNvXGr4r5YjiMH2Sk+9u4EcXKV3t+mBUUy6N3xLfZZ+/xGyJz4Jks8eXMig==
X-Received: by 2002:a2e:8699:0:b0:2c9:ffe6:6b54 with SMTP id
 l25-20020a2e8699000000b002c9ffe66b54mr1610470lji.31.1701953210487; 
 Thu, 07 Dec 2023 04:46:50 -0800 (PST)
Received: from [10.232.133.55] ([88.128.88.38])
 by smtp.gmail.com with ESMTPSA id
 sh6-20020a17090b524600b00285621515e9sm1247354pjb.15.2023.12.07.04.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 04:46:50 -0800 (PST)
Message-ID: <57a78c01-e46a-4ef3-b034-51eb1f9f8c54@suse.com>
Date: Thu, 7 Dec 2023 13:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com> <ZXG5x8R56fISvCLW@rei>
 <164f3362-ef24-4bc8-a27e-56d28ecdb60e@suse.com> <ZXG7d_ImcsTa_a0_@rei>
 <72e80847-aa5d-4180-8f55-fa2fd06aeec7@suse.com> <ZXG9EcGc60JGVnD3@rei>
 <6bee08e7-e57f-4d0f-b1a7-3c5441454d9f@suse.com> <ZXG-P2wOLjrt24Ie@rei>
In-Reply-To: <ZXG-P2wOLjrt24Ie@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsx-linux: Reduce log output
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

On 12/7/23 13:44, Cyril Hrubis wrote:
> Hi!
>>> The difference is that TERRNO is applicable to all other types such as
>>> TPASS, TFAIL, TBROK, TWARN. This does not make sense for TVERB, you
>>> probably do not want to hide passed messages and you certainly do not
>>> want to hide falures, bereakages and warnings...
>>>
>> I was thinking more about TWARN and TINFO.
> I'm not sure that we would want to add lesser warnings, i.e. TWARN |
> TVERB. We use TWARN mostly in cases where cleanup failed in test
> cleanup() and possibly the OS is in an inconsistent state. Also TWARN is
> used in places where we would have used TBROK but the test is somehow
> able to continue at least partially. I do not think that I have a use
> for TWARN | TVERB.
>
Ok, so TDEBUG or TVERBOSE are both nice for me.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
