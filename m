Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D336D44D42
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730888969; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CLrrwRx1Le32Nw5FEggg9jSzsM8Mcy8GFN//8v6VpLU=;
 b=Aa0/JUaqnBpgtpE7eHGiBL1JpfMF/arSGkimQTX1Ufe7+HU3Kp+vHt+zbZIXRlaoGFL/0
 aHu0LK2CKjrN1IafWzpwECRywFk0PzGoME06Rj6LbOutwvtT9Y4nBj603wi4THG732kgduT
 lo9omoOZUOBsELdD75mp7Cz7fAJn0oY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2B843D313D
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:29:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B923D30FC
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:29:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B70BC1A0B54A
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:29:05 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso76488475e9.0
 for <ltp@lists.linux.it>; Wed, 06 Nov 2024 02:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730888945; x=1731493745; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOXjTgd/ENeuqHnc0kjVAdnZAv1DiX+T10SSyFMIzc4=;
 b=Twg+UO0I+TcVVVwzf6KtNmz21LtTGGSWHikSIbkspjO6ZZHKeJ82InKNxVJBg185K3
 bNhO2b9Y2YUq2cHRuqq1vuxg2ydWi09x4og/JNVrTmR1SK9I6xHwZ7cEjNlTks/P+muz
 h+HDytJ59EK6o5MIHeGi+qLca6sI64xatAzsroMGdhVlw6jGgEIYHGl7lPanLZne6XIo
 FRf3XM/wtn/DLG/cbNh9ZkBXKrtgv5c8zxPtLozrqC6+qEwCyMDAf1VsLVhV4+xNOqiL
 JmgCertM2WVUBG4fHZTfNA+1df90iAGGmaeaQEZ2/IUCWGlcarzibWuvheawMag6EqmB
 J3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730888945; x=1731493745;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aOXjTgd/ENeuqHnc0kjVAdnZAv1DiX+T10SSyFMIzc4=;
 b=GB22y0iiMXPxdzbZw+QVhU3RRvpsHxy3Qp/V2Mh9U7hRkUFJlRH/FKlF3bpN+utden
 +RNjigOxNy0d61oH+6E2ENJGZukV+aQk7GlL0icbs6okQE4fsAwK9mIRic+OuFm8KjLE
 0/fYaL1bF2YWbnG1Kn1ztxH2m2uFaLCrprXkCUKbpcuPujTqFZaELl6vSDdwHhgg2xwH
 IIMSCdV07tDPTiq4BTBn2Iv+5HX/Y6FFzL6+S5I6siupYFx24A6ZgXL8H67EbIFYuMRy
 IZCEbmE5trbC2y7wgN57W62vKDZXyIy/wlQQj8rBL5I6ZQKJXjYa8D/p3dmKoLk1v5Ps
 K7/Q==
X-Gm-Message-State: AOJu0YzStHhYbrq7dbN5T5yfkeZvyRRIO2OCALQnZ5vmysx3QL1m0unP
 WBA35J4IXHxuEuGchT4Zc1diFgLXLGVFyG1fBkiAO/qtALeHarJ/AEpkucc3mp8=
X-Google-Smtp-Source: AGHT+IEPw7sgWy00JT4OGEG7y1hgjsQKnGhc7zX3oo4AA+sKOusfKBZHw4uKECOXotiYPS93SiNLHg==
X-Received: by 2002:a05:600c:3148:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-4328327ce1fmr200752355e9.27.1730888945141; 
 Wed, 06 Nov 2024 02:29:05 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10ea7a1sm18504014f8f.62.2024.11.06.02.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 02:29:04 -0800 (PST)
Message-ID: <d3f0719e-a1e3-4eb1-8613-1506d137351a@suse.com>
Date: Wed, 6 Nov 2024 11:29:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-4-d58791487919@suse.com>
 <Zyo8I-32MuJz_EFw@yuki.lan>
Content-Language: en-US
In-Reply-To: <Zyo8I-32MuJz_EFw@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 4/4] Add error coverage for landlock network
 support
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

Hi Cyril,

On 11/5/24 16:39, Cyril Hrubis wrote:
>> -	verify_landlock_is_enabled();
>> +	abi_current = verify_landlock_is_enabled();
>>   
>>   	ruleset_attr->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
>>   
>>   	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
>> -		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
>> +		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
>                                 ^
> 			       This should be abi_current otherwise we
> 			       will fail on v1 only system.
>
>>   }
>>   

In what sense? abi4 is already the last one. At least the last supported 
by LTP.

Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
