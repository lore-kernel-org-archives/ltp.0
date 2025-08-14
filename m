Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BECCA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:30:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61A8E3CC848
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:30:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B30873C6994
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:30:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 735306008BD
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 17:30:52 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8B0775C5575;
 Thu, 14 Aug 2025 15:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51789C4CEED;
 Thu, 14 Aug 2025 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755185450;
 bh=cvTYcOO2SFOCDjwerP1KEOTUieXi4c8bDV0Z2qhr2s4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jTOR52cELhkyDE+NrphwZYdLWf4cfJAMhSsdNkjjGXFVbnh3vqBpW91wVEGUkEYtJ
 JRwUwCFEaf4x+OyYrdf0R9Ua1H5/GNFbwLX4h6vwnDEiIka6iFvJzrjB6meClf4B8X
 WkXh/Yp7lXXwYtX1kgmHJ7Jz6UEKqS9UWLtHT8Mc=
Date: Thu, 14 Aug 2025 17:30:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <2025081436-upchuck-shush-adba@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
 <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
 linux-perf-users@vger.kernel.org, achill@achill.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 14, 2025 at 09:27:49AM +0800, Zhang Yi wrote:
> On 2025/8/13 22:53, Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> >> Hi Greg,
> >>
> >>>> 2)
> >>>>
> >>>> The following list of LTP syscalls failure noticed on qemu-arm64 with
> >>>> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >>>>
> >>>> Most failures report ENOSPC (28) or mkswap errors, which may be related
> >>>> to disk space handling in the 64K page configuration on qemu-arm64.
> >>>>
> >>>> The issue is reproducible on multiple runs.
> >>>>
> >>>> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >>>>
> >>>>   - fallocate04
> >>>>   - fallocate05
> >>>>   - fdatasync03
> >>>>   - fsync01
> >>>>   - fsync04
> >>>>   - ioctl_fiemap01
> >>>>   - swapoff01
> >>>>   - swapoff02
> >>>>   - swapon01
> >>>>   - swapon02
> >>>>   - swapon03
> >>>>   - sync01
> >>>>   - sync_file_range02
> >>>>   - syncfs01
> >>>>
> >>>> Reproducibility:
> >>>>  - 64K config above listed test fails
> >>>>  - 4K config above listed test pass.
> >>>>
> >>>> Regression Analysis:
> >>>> - New regression? yes
> >>>
> >>> Regression from 6.16?  Or just from 6.15.y?
> >>
> >> Based on available data, the issue is not present in v6.16 or v6.15.
> >>
> >> Anders, bisected this regression and found,
> >>
> >>   ext4: correct the reserved credits for extent conversion
> >>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> >>
> >> Report lore link,
> >>
> >> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> > 
> > Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> > :)
> > 
> 
> Hi,
> 
> This issue has already fixed in 6.17-rc1 through this series:
> 
> https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/
> 
> 
> To fix this issue in 6.16, it's necessary to backport the whole series
> instead of just pick 5137d6c8906b ("ext4: fix insufficient credits
> calculation in ext4_meta_trans_blocks()") and 95ad8ee45cdb {"ext4: correct
> the reserved credits for extent conversion").  Otherwise, this will make
> the problem more likely to occur.

Thanks, I'll just postpone this one for now.

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
