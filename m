Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094FFCA0EE0
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 14:00:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FAB23CBA30
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 16:00:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D95623C79F9
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 14:51:01 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1704600275
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 14:50:59 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BA50CA55C47;
 Wed, 13 Aug 2025 12:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B4EC4CEF6;
 Wed, 13 Aug 2025 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755089452;
 bh=1sFEp7tfTZsLqsEbQ6yN/DfqybrcqHWTfRSt7pluUnU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G/lvod9qaNFe8MgiqMNtSrnZl6ICr4ny7PsTyyOhzVZeCv/MZyhfDLlgNxCv37Z7r
 GYSIKBF/pteVt/vjuJB94/MdSefsCgRAQaRxWEIW2/awDVXuZZFSfXB+5rMnnQexLI
 cxOX0SSrpyCPB+x6DMMiVzgiv5VergRxG6Bl2MhE=
Date: Wed, 13 Aug 2025 14:50:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <2025081300-frown-sketch-f5bd@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 15:59:43 +0200
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
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, rwarsow@gmx.de, pavel@denx.de,
 patches@lists.linux.dev, conor@kernel.org, linux-perf-users@vger.kernel.org,
 Zhang Yi <yi.zhang@huaweicloud.com>, achill@achill.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> Long story:
> 1)
> The perf gcc-13 build failed on x86_64 and i386.
> 
> Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> fallocate failed.
> 
> > Ian Rogers <irogers@google.com>
> >     perf topdown: Use attribute to see an event is a topdown metic or slots
> 
> Build error:
> 
> arch/x86/tests/topdown.c: In function 'event_cb':
> arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> function 'pr_debug' [-Werror=implicit-function-declaration]
>    53 |                         pr_debug("Broken topdown information
> for '%s'\n", evsel__name(evsel));
>       |                         ^~~~~~~~
> cc1: all warnings being treated as errors

Already fixed.

> 2)
> 
> The following list of LTP syscalls failure noticed on qemu-arm64 with
> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> 
> Most failures report ENOSPC (28) or mkswap errors, which may be related
> to disk space handling in the 64K page configuration on qemu-arm64.
> 
> The issue is reproducible on multiple runs.
> 
> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> 
>   - fallocate04
>   - fallocate05
>   - fdatasync03
>   - fsync01
>   - fsync04
>   - ioctl_fiemap01
>   - swapoff01
>   - swapoff02
>   - swapon01
>   - swapon02
>   - swapon03
>   - sync01
>   - sync_file_range02
>   - syncfs01
> 
> Reproducibility:
>  - 64K config above listed test fails
>  - 4K config above listed test pass.
> 
> Regression Analysis:
> - New regression? yes

Regression from 6.16?  Or just from 6.15.y?

> 3)
> 
> Test regression: stable-rc 6.16.1-rc1 WARNING fs jbd2 transaction.c
> start_this_handle
> 
> Kernel warning noticed on this stable-rc 6.16.1-rc1 this regression was
> reported last month on the Linux next,
> 
> - https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

Ok, no real regression here if this was already in 6.16.

Doesn't look like it got fixed in 6.17-rc1 either :(

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
