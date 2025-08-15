Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB4CCA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:31:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A3F33CC916
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:31:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F31C3C8564
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 07:33:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EEA2C100044B
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 07:33:49 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D52B4593C;
 Fri, 15 Aug 2025 05:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C0C4CEF4;
 Fri, 15 Aug 2025 05:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755236026;
 bh=5pmEnpk4P+ndbonyan2VBiYanHohRCT0mNUzn8ef6Jw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1acX8gnFQCkziGbYVwXTdj9BgkJt06DgtflG9KQNRnqNIt+UE43nvvq7RtqS8j+TO
 DIT37U+VhXVk1Tmo2KjQJ/IaQC3QxZHPJnNumrOKk9NIFQf1jf3eWt9D8ct/fb16Pq
 xhXRyIEUjs6wiBS4B4K5vjigRUpIaLwvw1zT2g0k=
Date: Fri, 15 Aug 2025 07:33:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namhyung Kim <namhyung@kernel.org>
Message-ID: <2025081536-resonate-wafer-6699@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh> <aJ5EupUV9t0jToY3@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJ5EupUV9t0jToY3@google.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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

On Thu, Aug 14, 2025 at 01:19:06PM -0700, Namhyung Kim wrote:
> Hello,
> 
> Thanks for the report!
> 
> On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > Long story:
> > > 1)
> > > The perf gcc-13 build failed on x86_64 and i386.
> > > 
> > > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > > fallocate failed.
> > > 
> > > > Ian Rogers <irogers@google.com>
> > > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > > 
> > > Build error:
> > > 
> > > arch/x86/tests/topdown.c: In function 'event_cb':
> > > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > > function 'pr_debug' [-Werror=implicit-function-declaration]
> > >    53 |                         pr_debug("Broken topdown information
> > > for '%s'\n", evsel__name(evsel));
> > >       |                         ^~~~~~~~
> > > cc1: all warnings being treated as errors
> > 
> > Already fixed.
> 
> Are you sure?  I'm not seeing the fix.  Can you share the commit id?

I dropped the offending perf patch:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=4199b872a5585e025f62886724f4f9ae80e014ae

Did that not work for you?

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
