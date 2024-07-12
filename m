Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA1AC2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 07:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720769809; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=nkwE6MpaRNG+uGoLZW/TkH0FZrB4eku94utME+uuDF0=;
 b=rjfFcQ98ReZ+f8QJbF8DJfFdaNdyt44sLkDmXM/tsXgi7Aj4LlAvmMhNVy0h6YpGX3kQM
 p/UGxLSpLffAhgqJZWaUb/vMnsauFt4uxh9YEmxILRXwWHnNFCRxq8Qni/gE/Cf++iiYToZ
 fCnkFU6wDoWl1Qg5ByhDjEsHOh1y6QM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D174F3D1962
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:36:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51FB63CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:36:28 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BAFB46013BC
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:36:27 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77c349bb81so203324666b.3
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720769787; x=1721374587; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jt0txpRij/jR/D4oT8QLo2LMD5y2Uhp0EfwbzVZV88M=;
 b=UIojBmnnkndfR20vsyJuaY9s+LizwJ8SseUYzhhfVK5flh3BAc9pgIah1/zenIeyNd
 rV9sJ4TVDZFlq9SZvn/r6xJk4eAC8shtTmuX0uzlBABNDVR4f4MiySdk2DgX5puv1oio
 Qo4X4tAaUqfoojchxAwX5yOr/JePsKghUbeix5OnzD/GLO6r0cVVEYDxggfBWw44T4Vm
 SS2zxoyrI+MigQX4iMSCmD0hFQOhMPVl9U8BfPFTBpadPzP/DHBYmouEM++pC1eXHVu9
 lHjESw9dKWqidQnV/1dWMJypf1NgEes/HDWZuAvtzPxBrDa7RbAC5HKSUTtP2e7b6+ke
 1l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720769787; x=1721374587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jt0txpRij/jR/D4oT8QLo2LMD5y2Uhp0EfwbzVZV88M=;
 b=kGAvP06OGVMR+TcrFr4Y0CBLz9P+/ic0ItXjfc61JdYeAQsyireG1grGJ5WVKPpGAR
 Qb1KjnqZjtVtCxnrEon0ZcCNy8wzV9hXabv0Q/OvNI2mQALi0vTtxJEjHizhSlCzT3Oj
 0NBbKIPUxtq70G1dxfEqP6dN+GMi9j6nAFmUTKIsI8sUAqAiXci3JuhgED0NOZDkBoXK
 g3rMmuaB922wiBBHbKYk2DJOWKgVrAhF2El2GIiiKUH+1t9NnzyA61e3ZVRQ6FP0b3Mi
 v1dhkPcmd+wMVhPzzePKYKWoWhsQ2KDNRb52VB7P5cujwlYM6um7cDH3Op2z7pmB4Fe+
 ldAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj56cRT+gtW4/jZLOYT3nVy2uX/IetYUe1Ibn1/Fr2CXrJujDeRLkRlI84qn2OWhuzqp71tcGtMrLRTxi6K67VSiA=
X-Gm-Message-State: AOJu0Yznb3hgMhzKNo3mC0UQ6k5QiSS3p8rX/JcgaPebaHIiAXmV7VkV
 AbEBogF/X5H3dF9bByr06IT4FMN+xCwOPUan616b21FX+reNDGlCLIm5+RewiEsvSknjpYoHrpG
 2mOE=
X-Google-Smtp-Source: AGHT+IG8wUANqui1J0Ecxga012FY6rr9VM1h8OBNTg5RJaP9lU4/C+2v62NADzcwx61j2iwylxdoVw==
X-Received: by 2002:a17:907:9711:b0:a77:e55a:9e7a with SMTP id
 a640c23a62f3a-a780b68a54emr912946566b.11.1720769786685; 
 Fri, 12 Jul 2024 00:36:26 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.47.23])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a6bc6f6sm318076366b.9.2024.07.12.00.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 00:36:26 -0700 (PDT)
Message-ID: <0383279b-73d3-4945-bb63-4337af063970@suse.com>
Date: Fri, 12 Jul 2024 09:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com> <ZlhacuOD8hYVLYS6@yuki>
 <82ac2455-ab1c-4bdf-b4e3-5ae56dfb9871@suse.com> <ZlmESfb2JbYbSG1_@rei>
Content-Language: en-US
In-Reply-To: <ZlmESfb2JbYbSG1_@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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

On 5/31/24 10:03, Cyril Hrubis wrote:
> Hi!
>>> Can we move these invalid_fd tests into a separate test and use tst_fd
>>> to loop over all kinds of invalid input and output file descriptors?
>>>
>> I don't know if it's worth to loop over all possible cases. Each one of
>> them has a specific test case.
> This was actually requested by kernel developers, to feed the syscalls
> with all kind of unexpected file descriptors.
>
>> Also, invalid_fd test cases would look so simple that it makes more
>> sense to keep it here.
> Fair enough, we can keep these two here, but we need a tst_fd test as
> well.
>
I'm trying to create a test using tst_fs but it seems quite 
unpredictable. For example, if the given paths are located on a 
different mount, EXDEV is raised.
But we don't have any control on it and it can happen with literally 
anything (signalfd, memfd, devices, etc) on the SUT we are testing.

So that ends up skipping 90% of the provided file descriptors. I don't 
know if I really want to follow this direction.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
