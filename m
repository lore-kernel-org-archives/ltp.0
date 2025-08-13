Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016FBC87FCF
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 15:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231CF3CBA38
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 17:14:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 756333C63E1
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 16:53:44 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8B141400429
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 16:53:42 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 81448A57250;
 Wed, 13 Aug 2025 14:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933ADC4CEEB;
 Wed, 13 Aug 2025 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755096820;
 bh=qsIzK3FQVmuwp376IvkIc7QaQl0+eKfxluiwZGuycJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h9Z1b9DhPWIV6cS+bkMlZk/eNbU+HdGphYtWJcvDnCd4mHNW6LGz0PAzq4S3sz/bQ
 Qu6Q/zr1uSLN9QG07lhIO8zKvSK3b5B2d7wMCY+FxzL+PtVIheklfnv+CxHDBiqwKK
 HH28jaOUNKO4S5N8tA/MsLvV3/5lSRVuQ5L0TQBQ=
Date: Wed, 13 Aug 2025 16:53:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <2025081311-purifier-reviver-aeb2@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 17:14:17 +0200
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
 Zhang Yi <yi.zhang@huawei.com>, qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joseph Qi <jiangqi903@gmail.com>,
 patches@kernelci.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>, rwarsow@gmx.de,
 pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 achill@achill.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> Hi Greg,
> 
> > > 2)
> > >
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
> > >
> > > Reproducibility:
> > >  - 64K config above listed test fails
> > >  - 4K config above listed test pass.
> > >
> > > Regression Analysis:
> > > - New regression? yes
> >
> > Regression from 6.16?  Or just from 6.15.y?
> 
> Based on available data, the issue is not present in v6.16 or v6.15.
> 
> Anders, bisected this regression and found,
> 
>   ext4: correct the reserved credits for extent conversion
>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> 
> Report lore link,
> 
> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
:)

thanks

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
