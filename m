Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521D3C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:03:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFFE13D0ED2
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:03:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 087EB3D0E06
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 14:30:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4F6E02064F9
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 14:30:02 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1FEA1CE0F8F;
 Thu, 20 Jun 2024 12:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B8C2BD10;
 Thu, 20 Jun 2024 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1718886596;
 bh=TbXzmIvEO7TjjoHW3NdmWzbgPUbd6HxMNpznqg0zLUI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uyYxtf5f9af/GSBjoWdLh0kD+eKh3XfeErWbdm7wMgVmh8r0tFM3nTNhzKLG8PitN
 h+uA3y2BoOThihevb1dlLDH/vGEfgWNdggjpfzcP48aUZw52muSvTR8XMmI6VHu6Cy
 8IL8J8nDCkw5OkKiWYylDmD2Qv2/Yxs6uVMQLxQ8=
Date: Thu, 20 Jun 2024 14:29:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <2024062028-caloric-cost-2ab9@gregkh>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
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
Cc: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>,
 lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 linux-mm <linux-mm@kvack.org>, stable@vger.kernel.org, jbeulich@suse.com,
 shuah@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Cgroups <cgroups@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, allen.lkml@gmail.com, conor@kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.9.6 release.
> > There are 281 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 1)
> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> on arm64 Juno-r2 with
> compat mode testing with stable-rc 6.9 kernel.
> 
> In the recent past I have reported this issues on Linux mainline.
> 
> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>   - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> 
> it goes like this,
>   Unable to handle kernel NULL pointer dereference at virtual address
>   ...
>   Insufficient stack space to handle exception!
>   end Kernel panic - not syncing: kernel stack overflow
> 
> 2)
> The LTP controllers cgroup_fj_stress test suite causing kernel oops on
> arm64 Juno-r2 (with the clang-night build toolchain).
>   Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000009
>   Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
>   pc : xprt_alloc_slot+0x54/0x1c8
>   lr : xprt_alloc_slot+0x30/0x1c8

And these are regressions?  Any chance to run 'git bisect'?

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
