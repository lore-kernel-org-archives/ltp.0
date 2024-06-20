Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BFFC2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:03:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B350C3D0F1E
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:03:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 382733CB74E
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:53:27 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7064E6013D4
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 15:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718891604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PNBVAgBh1qUdde5v1fyOGhK2OpFLFOvWHKPem6oZyJM=;
 b=iAWXOVWDKDuWNk9Uz/KEcSEt/rQYC9yV/CS8/g+VDFc6OVVCIv9q7QNxjVEXgclFfa+k/V
 aw4uvZLIx+4rWJevaOBgLT3uhDRMTwkkNRYMSt2Pv5eVBeo2Ci7do/wSdNbQIUqBQo/7VM
 uR4/XZZn2QY20/EUi+udApuM9ILWITs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-DwbfPGoCP1ukSe_zP2AxOw-1; Thu, 20 Jun 2024 09:53:23 -0400
X-MC-Unique: DwbfPGoCP1ukSe_zP2AxOw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421811b92bcso6980205e9.0
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 06:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718891602; x=1719496402;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PNBVAgBh1qUdde5v1fyOGhK2OpFLFOvWHKPem6oZyJM=;
 b=qBqwR5xWdEqYOOQkfIhxsksu3twrBnePMCi+ZyX3FMMu4B2dDaynfUBhxAXsDY62Zj
 /vcL0TFdP6I0z4Y8YLPhyKerGCfLvKpY2pNSbK5n4FsvmLx1mB4HyHm46AQs0TmoxXJ8
 +L5orC2fPmYiAxoNO1KTWfdwjoiSbMV2d4sJPjwpmffPBpM9BHNtIfoRnylPGddR2LiF
 x8cHttPRtb2p6TFgpKEvBKWEUMPhvXZ2jFxzDAsJ4Iyaq0j5Q2G19BKKo+U1SnN72Ww4
 /U0ddlDmxzwlptk56HroYIBVaeNL1cDxvMgY1AH4sCt0einh4HAvsi7VEiMOjLgDdhxi
 L2VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ7ea2p9FGB2ROBBsWRsOrd0RZKvgAEFuoptggh5lKT4pZoQyEAQ1M35w1+428jk/8vxjKJiRt/grXIsebGWkFRMg=
X-Gm-Message-State: AOJu0YxilxNWjYZby4oh8+HS1l9wwD5B7hfL2F9dezdnH1KoOzJ3oVDM
 8IyIg5QiLINYFKyNkwSIRyheORKo7ciNxcD/QWi2xVLlBqQ9L5eNTIyQjRjSK+Mby/1V/CZFEDq
 Gc2JEv4DOdvuyAxMqInAWJveRe1/aLu6+mD2rmy6VUt8ckWJ3
X-Received: by 2002:a05:600c:4b19:b0:422:fdae:b687 with SMTP id
 5b1f17b1804b1-42475184342mr40094115e9.17.1718891601885; 
 Thu, 20 Jun 2024 06:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUrpDltGw0aYmrvP64jp8sAeYweHTuRQ1JJCRsyM56PxufV1oTqD+YVHKFqzFB9JfU965xsw==
X-Received: by 2002:a05:600c:4b19:b0:422:fdae:b687 with SMTP id
 5b1f17b1804b1-42475184342mr40093895e9.17.1718891601373; 
 Thu, 20 Jun 2024 06:53:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3?
 (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de.
 [2003:cb:c719:5b00:61af:900f:3aef:3af3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-364a5b38996sm2003695f8f.3.2024.06.20.06.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 06:53:20 -0700 (PDT)
Message-ID: <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
Date: Thu, 20 Jun 2024 15:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: Re: [LTP] [PATCH 6.9 000/281] 6.9.6-rc1 review
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, lkft-triage@lists.linaro.org,
 patches@lists.linux.dev, linux-mm <linux-mm@kvack.org>, stable@vger.kernel.org,
 jbeulich@suse.com, shuah@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Cgroups <cgroups@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 20.06.24 15:14, Naresh Kamboju wrote:
> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> This is the start of the stable review cycle for the 6.9.6 release.
>>>> There are 281 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
>>>> or in the git tree and branch at:
>>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> 1)
>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
>>> on arm64 Juno-r2 with
>>> compat mode testing with stable-rc 6.9 kernel.
>>>
>>> In the recent past I have reported this issues on Linux mainline.
>>>
>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>>>    - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
>>>
>>> it goes like this,
>>>    Unable to handle kernel NULL pointer dereference at virtual address
>>>    ...
>>>    Insufficient stack space to handle exception!
>>>    end Kernel panic - not syncing: kernel stack overflow
>>>

How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).

Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
