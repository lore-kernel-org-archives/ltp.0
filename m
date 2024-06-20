Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8818C2BA1A
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:03:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155543D0F39
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:03:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82BC13D0E21
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 16:03:04 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9FF3C60048D
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 16:03:02 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6fc30e3237so93249466b.1
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718892182; x=1719496982; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DivZWPPAJboyHT631bWOCfrq3h9RoUn6v0uBNxSBQyA=;
 b=SeHHtOfvdqCnm/pWsORuWX9UVpsV4gnjtg/YDQBSJOp8m+CLgpN7oiX4WSMmOaTOWW
 0ifrEUsjmvxcgMxdj5MyccqAjf+JEXyc6Gg6/5VZ2y/bM0lJAECMXW1R1LLxtoQXPc2Q
 m87HRVOrKUiw0ckoE2WMjEaG7vhakBgldU2Ujxrbo32V1jltCcwoYjjvyfMBqlcWbqLk
 G2vvJdfjRR8Gac0adr/k3M/wa0qkLtKVbp90EPebNI7Ljhe6ItNVdD4xneNb3XEBt5v+
 oDzeWwMXBxYbzonrJr0vPMtqsv2M7sOlPEdfgJK75Ce3NwCeuPrdHTgwuP453dzpcWvd
 t/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718892182; x=1719496982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DivZWPPAJboyHT631bWOCfrq3h9RoUn6v0uBNxSBQyA=;
 b=qSY9V5MmDwnifcEL//KJ/rO2nc3Gd0MB2m7N/1t8hnQlYPixvG7FJtS70MN9+i+hrs
 WB/8Jl9OGRpPzHPbctFvueN01lkvJKoj6ehBFtATaAx3fMjsLQx1J1VXjNbLViGdqwc2
 Amq4KdCpgW1DX1UvSsr2TLjDCbqPg++DdAb5K8evM9zSAxTUtypzqtj41uSJ2aqdJA3x
 oKw7mW6W7HTuQmnnoMf7NjzskKftxsa2t4Rb9bHdJ9iom+bPwPZ69YcSxuaX/YpO8Gwy
 kSJgxeotG++uZE2ErgKTMVROzSJiOuaMv0Y0Z4ri/m6yfSDu/I2hjhcymF1w48oCgtrG
 l7dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsxitv36BGtNO8pKzlOoCBSTq+cVVFPLgWooXWZ/5Y3y7mbgkETEEicE6x+L7XLyG9ubZ/LMk0j50lkWSRrZAFY9o=
X-Gm-Message-State: AOJu0Yx/oJ3ytjyqTRNmgNqnj3dbNJozL5t8P80VoS41G6ZNHT0W3XU/
 Wo4O3R9fxLXkOMCml+eTpFQyKoT0oXpfS0s9vwAfMqkw+9syk7FdUynfi6TSq9xD3AuYyvz7MqI
 4Q60Q6PPEDbLkFscwNy2M4I8quSBCQLNasvN4Ew==
X-Google-Smtp-Source: AGHT+IE5IRidUBv1Rz0+z0UgilsHsNZAP3E8TZx/Yqczpa77Xl1ZAhegOmt9dztWkCt7PzES3N0d2ChrSeAxTflAWLc=
X-Received: by 2002:a17:906:b816:b0:a6f:5922:54e7 with SMTP id
 a640c23a62f3a-a6fab7d0bd8mr334461966b.65.1718892181739; Thu, 20 Jun 2024
 07:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
In-Reply-To: <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 19:32:48 +0530
Message-ID: <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.24 15:14, Naresh Kamboju wrote:
> > On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> >>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> This is the start of the stable review cycle for the 6.9.6 release.
> >>>> There are 281 patches in this series, all will be posted as a response
> >>>> to this one.  If anyone has any issues with these being applied, please
> >>>> let me know.
> >>>>
> >>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> >>>> Anything received after that time might be too late.
> >>>>
> >>>> The whole patch series can be found in one patch at:
> >>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> >>>> or in the git tree and branch at:
> >>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >>>> and the diffstat can be found below.
> >>>>
> >>>> thanks,
> >>>>
> >>>> greg k-h
> >>>
> >>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >>>
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>
> >>> 1)
> >>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> >>> on arm64 Juno-r2 with
> >>> compat mode testing with stable-rc 6.9 kernel.
> >>>
> >>> In the recent past I have reported this issues on Linux mainline.
> >>>
> >>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >>>    - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >>>
> >>> it goes like this,
> >>>    Unable to handle kernel NULL pointer dereference at virtual address
> >>>    ...
> >>>    Insufficient stack space to handle exception!
> >>>    end Kernel panic - not syncing: kernel stack overflow
> >>>
>
> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
>
> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?

I request you to use this link for detailed boot log, test log and crash log.
 - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314

Few more logs related to build artifacts links provided in the original
email thread and bottom of this email.

crash log:
---

[ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT @1718817000
...
[ 1786.336761] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
[ 1786.345564] Mem abort info:
[ 1786.348359]   ESR = 0x0000000096000004
[ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1786.357434]   SET = 0, FnV = 0
[ 1786.360492]   EA = 0, S1PTW = 0
[ 1786.363637]   FSC = 0x04: level 0 translation fault
[ 1786.368523] Data abort info:
[ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1786.387284] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
[ 1786.387293] Insufficient stack space to handle exception!
[ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
[ 1786.387302] FAR: 0xffff80008399ffe0
[ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
[ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
[ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
[ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
[ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
[ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
[ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
[ 1786.387385] sp : ffff80008399ffe0
[ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
[ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
[ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
[ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
[ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
[ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
[ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
[ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
[ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
[ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
[ 1786.387542] Kernel panic - not syncing: kernel stack overflow
[ 1786.387549] SMP: stopping secondary CPUs
[ 1787.510055] SMP: failed to stop secondary CPUs 0,4
[ 1787.510065] Kernel Offset: disabled
[ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
[ 1787.510076] Memory Limit: none
[ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---


1)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic-a44367e5836148d6e94412d6de8ab7a0ca37c18d2bfb6a639947ecd2704ad6b1/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2i6h1Ah6I8CP7ABUzTl9shfaW60
 - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314

- Naresh

>
> --
> Cheers,
>
> David / dhildenb
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
