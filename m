Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D715CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C0AF3CC867
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:30:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0CE53C2CC5
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:35:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21FFD140005A
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:35:37 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2AF005C5B08;
 Thu, 14 Aug 2025 15:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644BC4CEED;
 Thu, 14 Aug 2025 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755185735;
 bh=gDxvjWIgXlyBLWgV2QQr23LJcSGf4vc5YOroiJL6BHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DJNPGlisvjw88EiXwDk2RuS15vYBkAcU5305MBsWPMCbM6/W7E4E6L+9JlKljpuRX
 zwzpCawOznOaYHkMchEhfqmMwpvf3R8wIoHWBbG1N63zmB6JfoOL8GnfoT0t/6j8PQ
 QQbPrxKsabXo4dWZwuKLd92OEcSIPH/lHm05gpHI=
Date: Thu, 14 Aug 2025 17:35:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <2025081416-wing-bakery-3205@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
 <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 18 Aug 2025 08:29:56 +0200
Subject: Re: [LTP] [PATCH 6.16 000/627] 6.16.1-rc1 review
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
Cc: Ian Rogers <irogers@google.com>, Jan Kara <jack@suse.cz>,
 qemu-devel@nongnu.org, lkft-triage@lists.linaro.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joseph Qi <jiangqi903@gmail.com>,
 patches@kernelci.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 Ben Copeland <benjamin.copeland@linaro.org>, LTP List <ltp@lists.linux.it>,
 rwarsow@gmx.de, pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 achill@achill.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 13, 2025 at 07:11:05PM +0530, Naresh Kamboju wrote:
> On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
> >
> > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > >
> > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > to disk space handling in the 64K page configuration on qemu-arm64.
> > >
> > > The issue is reproducible on multiple runs.
> > >
> > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > >
> > >   - fallocate04
> > >   - fallocate05
> > >   - fdatasync03
> > >   - fsync01
> > >   - fsync04
> > >   - ioctl_fiemap01
> > >   - swapoff01
> > >   - swapoff02
> > >   - swapon01
> > >   - swapon02
> > >   - swapon03
> > >   - sync01
> > >   - sync_file_range02
> > >   - syncfs01
> 
> These test failures are not seen on Linus tree v6.16 or v6.15.
> 
> >
> > I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> > still running but I suspect given the error message:
> 
> Right !
> LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
> with this error on LKFT CI system on several platforms.
> 
> >
> > epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
> >
> > that it might be:
> >
> > # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
> >
> > which already got tested, or something adjacent.
> 
> A patch has been proposed to update the LTP test case to align with
> recent changes in the Linux kernel code.
> 
> [LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
> 
> -https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

Great, thanks for letting us know that this is just a test-case issue.

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
