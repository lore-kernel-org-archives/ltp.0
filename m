Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C76C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 12:30:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8525E3CBCE7
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 13:30:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C06BC3CBB62
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:30:16 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05E7D140135A
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 13:30:15 +0100 (CET)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c74b3cd4cso1852163a12.1
 for <ltp@lists.linux.it>; Thu, 07 Dec 2023 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1701952215; x=1702557015; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f6F/YBHQV3eKCtI53B9hQiTir47trqYJ29ILs7bgsPc=;
 b=SbyCFa3zCN8rnM69ZpCCwwpTL9qGtPdej0sTv/n2YBCY5v4HaBWwyA0E40jKrJL521
 rXFhobOjTQ1QBo0/IxY8Qwo5pnv3U4qX+9Qrcc+UnZkQgkXx/X/9+X1dC4j6/1qbF/hN
 gljiCfwxli1oVerPOne7peT/+NIUKCvtkip8jAgqjPyecCTbroUiapf01YTIX0QIUjZt
 LvfjL8MEZTA1NU1FEuovlqybYyzqSk0R8bVG+wGLL8bX/DJcIXwpSmhedXsmj6Wjp2A7
 VDjuBPteOPvIYPABWVw19KQDrsWHT/BPbxZdUlhC7rQwpzyTOunBz9JcuR4Y1ZFSgXjG
 bWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701952215; x=1702557015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6F/YBHQV3eKCtI53B9hQiTir47trqYJ29ILs7bgsPc=;
 b=QhE/s1npp/J6ZoN482av+44R6pLkTJHzgAFLID+LmzGK65Tp5t4yQzhNkfKcEQoh5d
 pzTFgmoLFDxto295Vhu9CRJ6qer+37/0NsSsRwxgsRetWOMklmuixlXEZp0qoxEPUm3I
 +PZPusbyiuIswrR6z2/rR1IM2BY05eyXRgLbNz6OBppWVWhYgy2c6dGqE0UM0bnYzDGm
 A8YsXBjcDq+UthhKC2EImpqnwxNm8INWUf6c2p1aOD+xVwoHvba1LP6PFu7Cf+1WnQZr
 y03eB4gBlik+PADisAWtJfDEJlYvv7APu1FZSHYyaVLz1JZWyPIov43Z2bXXVKZKLVNd
 vaCg==
X-Gm-Message-State: AOJu0YynLLpiZHeIj1UM/UlNbD0IAOEqZWy3zaYAUDbn38qMK+ol3ImT
 nQSREuVyvOuqIHPnZ7ELSYMYWw==
X-Google-Smtp-Source: AGHT+IGIEVYPSE65G5H00raNZcuZHF7D/CZsBfsMakIfGuhBq1GtJRdMduBUiPl/m/gwVZ/p2BwqXg==
X-Received: by 2002:aa7:d29a:0:b0:54b:291b:9d65 with SMTP id
 w26-20020aa7d29a000000b0054b291b9d65mr5734684edq.17.1701952215497; 
 Thu, 07 Dec 2023 04:30:15 -0800 (PST)
Received: from [10.232.133.55] ([88.128.88.38])
 by smtp.gmail.com with ESMTPSA id
 23-20020a508e57000000b0054c5d3486e9sm735102edx.76.2023.12.07.04.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 04:30:15 -0800 (PST)
Message-ID: <164f3362-ef24-4bc8-a27e-56d28ecdb60e@suse.com>
Date: Thu, 7 Dec 2023 13:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20231207111223.234170-1-pvorel@suse.cz>
 <20231207111844.GA234785@pevik> <ZXGrB76MCu0-0K0y@yuki>
 <aecb0e4c-9042-463d-9888-7f4508e277fb@suse.com> <ZXG5x8R56fISvCLW@rei>
In-Reply-To: <ZXG5x8R56fISvCLW@rei>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

On 12/7/23 13:25, Cyril Hrubis wrote:
> Hi!
>> more than TVERB, it would be nice to add a "verbose_flag". Something like:
>>
>> tst_res(TINFO, "my message %s", my_param, verbose_flag)
> That's technically impossible, because the printf() like messages have
> variable number of parameters.
>
> Also it's really hard to extend the API at this point without really
> breaking it. We would have to also rewrite a few thousands of test if we
> introduce such change, which may be possible with coccinelle, but I
> would rather avoid such hassle.
>
>> And then with a -v we filter out messages which are verbose or not.
>> In this way we don't add T-flags and we can handle any kind of messages
>> in verbose mode.
> If you are worried about the output, we can easily produce TINFO
> messages for the TVERB flag too.
>
> Or possibly name the flags as TINFO with a debug level appended e.g. we
> can add TINFO0, TINFO1 and TINFO2 and define TINFO to TNFO0 for
> backwards compatibility.
>
What about mixing TVERB flag with the others ? Something like "TINFO | 
TVERB"

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
