Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A5CC4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:18:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFA783CBCE7
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:18:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC293C8960
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:18:35 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 70BCA204B42
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:18:34 +0100 (CET)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ca03103155so8093961fa.0
 for <ltp@lists.linux.it>; Thu, 07 Dec 2023 04:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1701951513; x=1702556313; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwIuVvbJc6fMjsvaTFlWzaFV2U7A38o7zH2GluGuPJ4=;
 b=GSBVS92NiCXKez1nXFr6m33V9PUjsZPRcsnApKL1Rp7BmoRm24D9g2RkoCWWAHWSPC
 zErT09+go9ZW3+FvmAD2dFh2G2lEZUBn/nOKKS85qRPyPtz55GP+l2ilMimbXfH6LyN3
 qkzOIeQd5X2Oq4wuX6yZbEemxvbTDNU1NsgTizER3vpL0/BS077ZeMXlkCWjrGhYNWR9
 2AgXEdmqeyxh7CFx5gOsYF30jpso1WlPg7Umav+ZhhUAys4/qTKDxh+X2NKVk8+E4qYf
 9mS2GeqcAN6Q3yCUATjArqz/vX80TGGtebf/NZQ6aihDHrVv7WqDbNg2oZOYsqSn3EtU
 6LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701951513; x=1702556313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwIuVvbJc6fMjsvaTFlWzaFV2U7A38o7zH2GluGuPJ4=;
 b=cuE48fez1LMIXKQeeutgZbdD/dk3cQupz2m2Mc85ET3k01BAxJieNvh3UuJ6o8EDX0
 GKEbDDuF3y15esAAoPp76Xm+YrktW6fIXev80bpEFjiXFI0Qi2ItYYYz8+TbApCUoBaf
 byd0065lKD/8iSSbfIvNoM97ZuKpl1OZQvp379j07QdCdAJ4iNzpFJA8E1EgAP/Ys61D
 aGXCVt6fz/jeTZrOcz36nZ7TJo2oChypeU4uMVvMJerh7PsogpdZL04bvCCvyOaeqDwO
 temhTSYUuT6leoPuvvNOPkYON++Wbolihuy8DBUsA5yu67MXLSR1xgXFgpmVzYjd73Qf
 ye1g==
X-Gm-Message-State: AOJu0YwXuPRL2wfR7SWKkdIRICj8m8Pg5TFB3r1K+FSJfizIRzdthU2Z
 s0Loc5QxUY/dFhbvSoGU26kJ5A==
X-Google-Smtp-Source: AGHT+IFnY2v4UVxPzIcF5UBhoXppjZZFZNScu94+fUl0U24FJC4CqaVnXThb2Qninb7EiCW7DV07iw==
X-Received: by 2002:a2e:9649:0:b0:2c9:fa22:b611 with SMTP id
 z9-20020a2e9649000000b002c9fa22b611mr800224ljh.68.1701951513592; 
 Thu, 07 Dec 2023 04:18:33 -0800 (PST)
Received: from [10.232.133.55] ([88.128.88.38])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090301ce00b001b03f208323sm1249810plh.64.2023.12.07.04.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 04:18:33 -0800 (PST)
Message-ID: <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com>
Date: Thu, 7 Dec 2023 13:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
In-Reply-To: <ZXGrB76MCu0-0K0y@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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

Hi,

more than TVERB, it would be nice to add a "verbose_flag". Something like:

tst_res(TINFO, "my message %s", my_param, verbose_flag)

And then with a -v we filter out messages which are verbose or not.
In this way we don't add T-flags and we can handle any kind of messages 
in verbose mode.

Andrea

On 12/7/23 12:22, Cyril Hrubis wrote:
> Hi!
>> IMHO output should have been only on error (test run 10000x or 100000x or even
>> 500000x, that's a lot for a regular output). Also logs get huge due logging.
> Generally tests should print a few lines by default, having too much
> output can easily flood serial console or any other slow output and slow
> down thigns considerably.
>
> Verbose output may be useful for debugging though. Maybe we need
> TVERB flag and default test library '-v' parameter that would enable
> such messages.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
