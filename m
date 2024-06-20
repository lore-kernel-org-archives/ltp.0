Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3DC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:04:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3AA13D0F4D
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:04:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 626CA3D0E1E
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 17:39:55 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 212152001AA
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 17:39:55 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80f59ebd021so304488241.3
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718897994; x=1719502794; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5GUJPV8yOp4RRoYY7LVY9TGkg0HQmwQOmVMKijpbR4g=;
 b=TzpSOGL+akBVHcvseX5pii2E74WjR5uikavCLkWsxqGj4r+HTzxGc3CC3pUvEjEH0C
 j5UKwasL/7G7yaOx9sYwmbrYuim0ULJXOMervzVJ38wjdl+JPQmFH39P+eJbHfJkGKZo
 jOhBHIyoqP5KaZf9T2lV/UOpJqRJQCoI/ran0TRgTpabydzxiyKlIYYX9RiY3gql04Eo
 5x/d3H+cw/QA5Etfp6pIBsYDt/+mTasMpVeYSOxkdsO8inmBDmyBbAJDzDV0mJT5Vo/p
 OmUjbOxKjnH5XPNgd0RcLbdoUT03AAIIe7S6ZnFmcDnLLTzVFTL1oANrXNCfNoBwA0tK
 h5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718897994; x=1719502794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GUJPV8yOp4RRoYY7LVY9TGkg0HQmwQOmVMKijpbR4g=;
 b=h6YqTrCyH0BAHrXrvRbP+NOiTgcQznPpg43wcY90U6arHzUWyHYlJuWvJDjZV3jbtt
 fGRlxy2qiZF1AbS6h558h3LwEDOM1c68kVPVufPJH9ypZMHVbj2xLPs2FMIml4QL4yZ8
 KM+o1QQYuWNjni5ELgs3buS2KqP6FhiNAGkiJQoSTq5KAl0FIt2IqS83esGCLbKZcrLG
 XyiVRQswNQoG9+VrJKVSM3AZqw5p+YkXNg2E3cYsxDp4b2mwYTYGt2dT7tALeB9hCv0L
 Ixdg1HrsD+MBvWzMY/fSpyO5vRi/Y9BoeYmezk2xovPjFkaiRJVK/H6UFUdxoHGZ/Ihc
 A/hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa7fKAU/Ah2ZR+3pZ9++kL9sV1U1FI3w7TVRFhTNdzwVw2jv/UVSwQqx/s9QqPe8bZvzQx1iLht6wHAlRFJhOcuQU=
X-Gm-Message-State: AOJu0YwIlgkVfgTxJf1JgKV9zEUjElfhJ/iFzdHPo4SZRm+HwsdM+ibR
 laTPlTkXhAELLGDA4luIHgyTjLmj7Pad1/b0zsltJiJb9VlLhtqDbx1tJtsFLROh8jkQaheaLC/
 AtvJL0IAxNX1aEUZUXtNZ5laFwCqQ1c3Gd4MSDw==
X-Google-Smtp-Source: AGHT+IHACjMP5RzFgepii/qD9qtk0+p5mwa6jnpfKmdaSdmp8lLICvVkXdDPSiF9XM3Dus6YHP7t5X5+bwf7WLuWK+4=
X-Received: by 2002:a05:6122:1346:b0:4ec:f27b:ee9c with SMTP id
 71dfb90a1353d-4ef276c041bmr6506472e0c.5.1718897992229; Thu, 20 Jun 2024
 08:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
 <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
 <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
In-Reply-To: <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 21:09:40 +0530
Message-ID: <CA+G9fYutNa9ziuj7aayhukaMdxKFU9+81qKAjZbQ=dQa3fwYYg@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 20 Jun 2024 at 19:50, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.24 16:02, Naresh Kamboju wrote:
> > On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 20.06.24 15:14, Naresh Kamboju wrote:
> >>> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> >>>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> >>>>> <gregkh@linuxfoundation.org> wrote:
> >>>>>>
> >>>>>> This is the start of the stable review cycle for the 6.9.6 release.
> >>>>>> There are 281 patches in this series, all will be posted as a response
> >>>>>> to this one.  If anyone has any issues with these being applied, please
> >>>>>> let me know.
> >>>>>>
> >>>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> >>>>>> Anything received after that time might be too late.
> >>>>>>
> >>>>>> The whole patch series can be found in one patch at:
> >>>>>>           https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> >>>>>> or in the git tree and branch at:
> >>>>>>           git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >>>>>> and the diffstat can be found below.
> >>>>>>
> >>>>>> thanks,
> >>>>>>
> >>>>>> greg k-h
> >>>>>
> >>>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >>>>>
> >>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>>>
> >>>>> 1)
> >>>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> >>>>> on arm64 Juno-r2 with
> >>>>> compat mode testing with stable-rc 6.9 kernel.
> >>>>>
> >>>>> In the recent past I have reported this issues on Linux mainline.
> >>>>>
> >>>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >>>>>     - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >>>>>
> >>>>> it goes like this,
> >>>>>     Unable to handle kernel NULL pointer dereference at virtual address
> >>>>>     ...
> >>>>>     Insufficient stack space to handle exception!
> >>>>>     end Kernel panic - not syncing: kernel stack overflow
> >>>>>
> >>
> >> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
> >>
> >> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?
> >
> > I request you to use this link for detailed boot log, test log and crash log.
> >   - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314
> >
> > Few more logs related to build artifacts links provided in the original
> > email thread and bottom of this email.
> >
> > crash log:
> > ---
> >

Thanks for investigating this crash report.

> Thanks, so this is something different than the
>
> "BUG: Bad page map in process fork13
>   BUG: Bad rss-counter state mm:"
>
> stuff on mainline you referenced.
>
> Looks like some recursive exception until we exhausted the stack.

You are right !
I see only one common case is, exhaust the stack.

>
>
> Trying to connect the dots here, can you enlighten me how this is
> related to the fork13 mainline report?

I am not sure about the relation between these two reports.
But as a common practice I have shared that report information.

> > [ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
> > [ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
> > for Debian) 2.42) #1 SMP PREEMPT @1718817000
> > ...
> > [ 1786.336761] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000070
> > [ 1786.345564] Mem abort info:
> > [ 1786.348359]   ESR = 0x0000000096000004
> > [ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [ 1786.357434]   SET = 0, FnV = 0
> > [ 1786.360492]   EA = 0, S1PTW = 0
> > [ 1786.363637]   FSC = 0x04: level 0 translation fault
> > [ 1786.368523] Data abort info:
> > [ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> > [ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [ 1786.387284] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000070
> > [ 1786.387293] Insufficient stack space to handle exception!
> > [ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
> > [ 1786.387302] FAR: 0xffff80008399ffe0
> > [ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
> > [ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
> > [ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
> > [ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
> > [ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
> > [ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
> > [ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
> > [ 1786.387385] sp : ffff80008399ffe0
> > [ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
> > [ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
> > [ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
> > [ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
> > [ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
> > [ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
> > [ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
> > [ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
> > [ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
> > [ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
> > [ 1786.387542] Kernel panic - not syncing: kernel stack overflow
> > [ 1786.387549] SMP: stopping secondary CPUs
> > [ 1787.510055] SMP: failed to stop secondary CPUs 0,4
> > [ 1787.510065] Kernel Offset: disabled
> > [ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
> > [ 1787.510076] Memory Limit: none
> > [ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---
>
>
> --
> Cheers,
>
> David / dhildenb

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
