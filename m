Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D3C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BAF73D0F40
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:04:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9D0F3D0E23
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 16:20:22 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 103C5206C3E
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 16:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718893220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5YwJR1NKRwN4fL5jNH9a/kXcG9cHy+5EzEQU+rHMO3I=;
 b=bkjd4igGrxs8b9iMZAJG059Ckg0kwewrRbZ0q6mYlLofEo//5qQ1tU/bwYhHLqbyqRI+cE
 QVoMUh2qqvOuFKVyo1GWmgCzTwPdnWvBG6dHtJht9Vqt/m+bj9pZFu6nSO4QAVoJ524mKr
 7MRjn9fJ3PPMN1VVLR1jnruOMSCWXeU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Y2qvOx6rNCKoRuc6YgtCIA-1; Thu, 20 Jun 2024 10:20:16 -0400
X-MC-Unique: Y2qvOx6rNCKoRuc6YgtCIA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52c983f4285so786234e87.2
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718893215; x=1719498015;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5YwJR1NKRwN4fL5jNH9a/kXcG9cHy+5EzEQU+rHMO3I=;
 b=JrFrQQWBC5gFpZhOcZFEYDhT29uL5fsDJp2jdCSXcdBw3OpMdNFZzZrVU1kmI/EyBO
 r034noSwSaX8yLa+ILP+qQkkWE8UbgiKocbcGb8CEZxpzg1SyBeckX7uc02E1fZHXk0N
 WufuOtqysdgpbj5GhfsubrMYfBDEu9yep1ekpGUHm89I2rUhIiUDGsGjS4bY+SOejwDr
 zzvq2ZL7WBRD6LN2aefzlajz9RU3Na92RhtNR/QRmqzmrrKShtDtn8825li1AzWU/Qoc
 +sPt/AeKjYJ5+RCJfRi/+NnpQCLo/p3/zckTIWcH/AdNO2S6gmkGgzcTZXMbb7WATHc2
 Dj1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG5dQaSXxdky5yYZVmuyHRwkBaaE+OjMNkmu6V6UQ9AyBJpZLhKLz81jykdPNHvjHz44ycZ+OT81fltFfbsVYWD0A=
X-Gm-Message-State: AOJu0Yx/nFLgjheZEQoBUJUI9xbLrVsrJ9N4x/UPmccjPb8xFTDidIY4
 nJIdQMvoaXyVO0P+mQrkL+O0kHKmRml8BWtJURD9QT08tHbXztT835hn5ZLcvLdvWM6DzmALUx6
 AUPAEmcpg6eOS6Wzxu+6V5GYHYqIVfNt/XsgnqGixhg0Lnu9o
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ccaa5693emr4100935e87.11.1718893214980; 
 Thu, 20 Jun 2024 07:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeTQL8Yco26PVM8D0V3en6/5afdIHWF/18NOFXb2mr5OHhn1CZokrSB4RjI8WqqCIc8xXp9g==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id
 2adb3069b0e04-52ccaa5693emr4100901e87.11.1718893214477; 
 Thu, 20 Jun 2024 07:20:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3?
 (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de.
 [2003:cb:c719:5b00:61af:900f:3aef:3af3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b63b5sm27811365e9.7.2024.06.20.07.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 07:20:13 -0700 (PDT)
Message-ID: <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
Date: Thu, 20 Jun 2024 16:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
 <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sudipm.mukherjee@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 20.06.24 16:02, Naresh Kamboju wrote:
> On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.06.24 15:14, Naresh Kamboju wrote:
>>> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
>>>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> This is the start of the stable review cycle for the 6.9.6 release.
>>>>>> There are 281 patches in this series, all will be posted as a response
>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>> let me know.
>>>>>>
>>>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>>>>> Anything received after that time might be too late.
>>>>>>
>>>>>> The whole patch series can be found in one patch at:
>>>>>>           https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
>>>>>> or in the git tree and branch at:
>>>>>>           git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
>>>>>> and the diffstat can be found below.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>
>>>>> 1)
>>>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
>>>>> on arm64 Juno-r2 with
>>>>> compat mode testing with stable-rc 6.9 kernel.
>>>>>
>>>>> In the recent past I have reported this issues on Linux mainline.
>>>>>
>>>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>>>>>     - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
>>>>>
>>>>> it goes like this,
>>>>>     Unable to handle kernel NULL pointer dereference at virtual address
>>>>>     ...
>>>>>     Insufficient stack space to handle exception!
>>>>>     end Kernel panic - not syncing: kernel stack overflow
>>>>>
>>
>> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
>>
>> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?
> 
> I request you to use this link for detailed boot log, test log and crash log.
>   - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314
> 
> Few more logs related to build artifacts links provided in the original
> email thread and bottom of this email.
> 
> crash log:
> ---
> 

Thanks, so this is something different than the

"BUG: Bad page map in process fork13
  BUG: Bad rss-counter state mm:"

stuff on mainline you referenced.

Looks like some recursive exception until we exhausted the stack.


Trying to connect the dots here, can you enlighten me how this is 
related to the fork13 mainline report?

> [ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
> [ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
> for Debian) 2.42) #1 SMP PREEMPT @1718817000
> ...
> [ 1786.336761] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000070
> [ 1786.345564] Mem abort info:
> [ 1786.348359]   ESR = 0x0000000096000004
> [ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1786.357434]   SET = 0, FnV = 0
> [ 1786.360492]   EA = 0, S1PTW = 0
> [ 1786.363637]   FSC = 0x04: level 0 translation fault
> [ 1786.368523] Data abort info:
> [ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 1786.387284] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000070
> [ 1786.387293] Insufficient stack space to handle exception!
> [ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
> [ 1786.387302] FAR: 0xffff80008399ffe0
> [ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
> [ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
> [ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
> [ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
> [ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
> [ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
> [ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
> [ 1786.387385] sp : ffff80008399ffe0
> [ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
> [ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
> [ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
> [ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
> [ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
> [ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
> [ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
> [ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
> [ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
> [ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
> [ 1786.387542] Kernel panic - not syncing: kernel stack overflow
> [ 1786.387549] SMP: stopping secondary CPUs
> [ 1787.510055] SMP: failed to stop secondary CPUs 0,4
> [ 1787.510065] Kernel Offset: disabled
> [ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
> [ 1787.510076] Memory Limit: none
> [ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---


-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
