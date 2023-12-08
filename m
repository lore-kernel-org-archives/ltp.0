Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719F5C4167B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 13:54:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA1F3CEFBA
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 14:54:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE3613CBA02
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 14:54:35 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 36279200066
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 14:54:35 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-54d048550dfso3014810a12.0
 for <ltp@lists.linux.it>; Fri, 08 Dec 2023 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1702043674; x=1702648474; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fazAIKJDHECVmuP+NqdjB0UdNI0xmi7UDa8nIbtnvU=;
 b=TkBfwGuewWkngEVBz+LI/+66AN5nDZz4nrVwC13US9CPrF2pWY+CcT3K+X7LOQU4yH
 VfQEhK1/dTI0tuWjnQg941v2cL7YHUNg4Ql65tMOYqjikWfcFlCS+DWkVpzcX/oPIeBW
 nvVeIs0Z9IewYbFPGMvpGQsPvhp4wplkWrRY+8ooezUeX+jRg3PORdeY68ZuQyiQCJEY
 XZ3oMg1/ottDngcrOWkHmsPkNAeL437bT+ztcnLljQ9N8f89cC+QfRsG5FVQW9bDpon0
 8ZJ1mhuLBMxX3BH7a/jX2IrJWwpwN8hZn5EtBueV8u+mDHP31d5vuMd1W7FhVumPWUdM
 CEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702043674; x=1702648474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fazAIKJDHECVmuP+NqdjB0UdNI0xmi7UDa8nIbtnvU=;
 b=Tnii8oir86KYXdTRxI7FxBwNFinf5dax2rYqTnOu+gqOyqzi6lqp32x8M1cRR0Ea84
 BwVSgX2RD8u8L+4pDinKpP6k8dZxf8VkMGnsK2ex2MNoFZOoUBQuZ1eZ3ZJWGqQCHmEf
 qiTDAktgv+KdMM5TP4FAW9oQmZz8fQs1kqLor0tDSPK5Cb3Q7SoilYPNrc+snzpah1DT
 qPHQDBmRPpVhkYkFn35V5JetfDy2NSNe1hosqiyP6pikpSt83KXbO9GKl6g0noGxkzm4
 cVWjHce3RAg7gGbjnaTRukGG6UfxJyy2iskvbALaGQk57BHzHSqHsJJ42Sn/UamllFzE
 TwEg==
X-Gm-Message-State: AOJu0YwqcuztHQQfeQXMEtdw2dPqwBfsT/BM9I81M/4M6v1LOHK9JSE5
 xG6iY8CIGxbgFAV6TKZycPtrsA==
X-Google-Smtp-Source: AGHT+IFDAUWE2xt2clkKLR1GWNgFGZgO/3HA4I+dmu9kGuRHtSR3Ka2XCyqaNviE1KZSRyYo9w6XvQ==
X-Received: by 2002:a17:907:7d8b:b0:9e3:f24d:5496 with SMTP id
 oz11-20020a1709077d8b00b009e3f24d5496mr5311ejc.28.1702043674630; 
 Fri, 08 Dec 2023 05:54:34 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.125])
 by smtp.gmail.com with ESMTPSA id
 vc11-20020a170907d08b00b00a1ce58e9fc7sm1036618ejc.64.2023.12.08.05.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 05:54:34 -0800 (PST)
Message-ID: <7025cbd4-9685-415a-84ed-423a65e92f5f@suse.com>
Date: Fri, 8 Dec 2023 14:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20231207212739.302374-1-pvorel@suse.cz>
 <20231207212739.302374-3-pvorel@suse.cz>
 <CAASaF6yheXD4w07K1xUVXrqoS6jdX6PUjG64UXQbE_hQR9cW7w@mail.gmail.com>
 <ZXLRB46ZqzBN6laS@yuki> <20231208135305.GA351742@pevik>
In-Reply-To: <20231208135305.GA351742@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Add support for TDBUG tst_res() flag
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

Hi!

On 12/8/23 14:53, Petr Vorel wrote:
> Hi Cyril, all,
>
>> Hi!
>>> My first impression was it's some kind of new BUG type :-)
>>> I'd suggest making it TDEBUG or TDBG.
>> Naming things is hard, I suppose that the least confusing is probably
>> the full spelling, i.e. TDEBUG. I suppose that having it one letter
>> longer is not a big deal.
> OK, I'll wait for other feedback before sending v3 with
> s/TDBUG/TDEBUG/
>
> Kind regards,
> Petr

TDEBUG sounds good to me. Also TVERB was not so bad, but I prefer the 
TDEBUG notation.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
