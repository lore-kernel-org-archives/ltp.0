Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D679C52D6F
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 11:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724239759; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=l7NYkLr8FuT8kOB9rH0mgGKvnFrdi619gTuHYOg4ruI=;
 b=Bwq/2xMBLlQaYJJJOVHcWWSVIipyyothN9PldqZYuFofbIOznxOOOxujB7xJhT1zlmcOm
 HMkWPJzhxU5fABrSwgHZ60lepAMDkUK2ns3gG1xChWBxlz//H+8u+yP29LudO9zuwoIWDln
 LMz4rUAurLwd/tL05bbL7favy1k/rG8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99ADB3D226B
	for <ltp@archiver.kernel.org>; Wed, 21 Aug 2024 13:29:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E55C3D2174
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:28:57 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C67CE1A04346
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 13:28:56 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so120010066b.0
 for <ltp@lists.linux.it>; Wed, 21 Aug 2024 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724239736; x=1724844536; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RshLQzhzIdbHzbEk22vxDZO1Co4no5CUiEO7+Ruypx8=;
 b=XOvtsy5P43PK25QdvlfZoFA881AlqP5d+XpB5MNc2gdXhPHHwt3/m40/MGWgCvzAlN
 q1QMXkBKniH33vhLn32oZnV1eY6IJusUMpYyf7a9fvRxiEzRcqxoTFp/IaY/vm+f/hub
 Q+bP+mSqr5W/2lYVM3U+p2MK13bXlkgDqROPcIqI2c5EijpbSH7ab55pvrGpmLHSL7lP
 rc0e40IO44dA6wmxzpPidCjjW/75BIYE0IEc3mGEunaJ4J4LMrrAinIUu2GgvptpUGqS
 eTftC32bBVCmNLp8jyMtDuLlqpKnSZD5jw9NaID+0nD2ub/9w3g43N92MIZQKgZYgPgT
 CbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724239736; x=1724844536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RshLQzhzIdbHzbEk22vxDZO1Co4no5CUiEO7+Ruypx8=;
 b=IYdOZsQcK8HGqZCCs3UIAtn4Lx5QSePlRKdXHZKvphpmfS2W3rNmEtVpGeVo+dOcnm
 DEcBMQDa1WmkHbF+NgfRt5A62cCRbRMosHKu9lhNiyoC5n4z+fAaDg9FzrRFo1IAHFAw
 jnzA15tdiZ2Dyjufy/Z6WEygPsa8zyDXrCSZDThEI6MPOrAJtttmKfyUCy+SOh56Ye/k
 Y3nggWoLZ8/CTUW00zADgZZGEsA8DQ2MhlXCnFd8j0DXJDiEyDGwF+bs4fLJiEwax0XP
 2Xnm6ivjC4bKmgFxncckidOYgN4OE8f+1gkmbnrN5/3RCNrh4nr/bn2Tb/I+TBZN4iKx
 awmg==
X-Gm-Message-State: AOJu0YwnZlBUWFNZxMZdayRoEDImQTxrbfjTN1gZaWEjLsVwiqIiD7FL
 NVNbNvXGfzr/YDmnCqlqcb5N0m2WnK2uWl83ROiP7Tf00UOn30YMOxvJuMk4Jwk=
X-Google-Smtp-Source: AGHT+IFvD3GzxX5pVZIx+tPTgsQPZ7c1Sc7HlDyNifi/2BtebmMH7wGIEoiaGrlxgwqieRU/kaxdIg==
X-Received: by 2002:a17:907:1b2a:b0:a86:668a:8b28 with SMTP id
 a640c23a62f3a-a8670182bd0mr241071666b.30.1724239735621; 
 Wed, 21 Aug 2024 04:28:55 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.159])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c68e7sm886371566b.8.2024.08.21.04.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 04:28:55 -0700 (PDT)
Message-ID: <320ced97-9d54-4095-88e3-1ced8c0343fe@suse.com>
Date: Wed, 21 Aug 2024 13:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240820-landlock_houdini-v1-1-ff3bffc93eaa@suse.com>
 <ZsXO7J-uq0uDESKW@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZsXO7J-uq0uDESKW@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add landlock07 test
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

On 8/21/24 13:26, Cyril Hrubis wrote:
> Hi!
>> +static void create_keyring(const int operation)
>> +{
>> +	TEST(keyctl(operation, NULL, 0, 0, 0));
>> +	if (TST_RET == -1)
>> +		tst_brk(TERRNO | TBROK, "keyctl() failed");
>> +}
> This looks like we should add SAFE_KEYCTL() instead...
>
> Other than that the rest of the code looks good.
>
I can add that. I also noticed that I didn't verify if landlock is 
enabled inside the setup(). I will add it.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
