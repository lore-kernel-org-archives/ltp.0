Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC9CA0EE4
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755498649; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8SqnAK4ydrAOThI9rveJs66jw4jvrF6R196baqfCQsk=;
 b=Oykfqi6L4ufjjku6wDp2K+P9Gko3XJ0c+1YQZwNUdD0v3VeQCLs3z7cq+uAkSXQxgtg/S
 0GqGRqFCh0EHjN4p42lm7zhm6Y9ftkVn0WNZCyX9qwTEi7OWKzm8FHrp6xSZJaZYEGqi+7b
 3xRB047CFPLMzjCevRYPCOglUrAlKxw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70FE53CC81C
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:30:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E82613CA75E
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 22:19:12 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 173F71A001E9
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 22:19:11 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AB33601D8;
 Thu, 14 Aug 2025 20:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F9C4CEED;
 Thu, 14 Aug 2025 20:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755202748;
 bh=OHrO9CYBzmjrP66VACTYaSpcj8ifkdq3OgNAHusx3JQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y7hyQGZy4wJOUZwphyJ1zqJnMhPkpykp6rMI1llau9JN9K1hTU9fbXk1wEcwcEbkX
 thotSCZ6wWOIJ6Q3j7XV7Ipv4F1k/8BPo50sKt3VlEn4bsSFVgAfTvuu/YqmfX906f
 Fwejtesxl1N4j1RXmgcq+cxUTA/Okk/knKVrky/3YwePFuRnpaJGrgE+LcjYr6GvhW
 Ep7GoSvIwOFQmRKGuuoh7Y1etIbuMCtDGntHuouK0da3/w6NUql4AYBeV96G5cppxB
 FQUr5dVHSAsM3WkIK9MormninvpPwy/jO+OOi4HKo/Dj4AwDU3czKZglNBwMrs7R2x
 xVbdtOshIOa2Q==
Date: Thu, 14 Aug 2025 13:19:06 -0700
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <aJ5EupUV9t0jToY3@google.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
From: Namhyung Kim via ltp <ltp@lists.linux.it>
Reply-To: Namhyung Kim <namhyung@kernel.org>
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

Hello,

Thanks for the report!

On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > Long story:
> > 1)
> > The perf gcc-13 build failed on x86_64 and i386.
> > 
> > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > fallocate failed.
> > 
> > > Ian Rogers <irogers@google.com>
> > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > 
> > Build error:
> > 
> > arch/x86/tests/topdown.c: In function 'event_cb':
> > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > function 'pr_debug' [-Werror=implicit-function-declaration]
> >    53 |                         pr_debug("Broken topdown information
> > for '%s'\n", evsel__name(evsel));
> >       |                         ^~~~~~~~
> > cc1: all warnings being treated as errors
> 
> Already fixed.

Are you sure?  I'm not seeing the fix.  Can you share the commit id?

I don't see the failure on my machine with gcc 14 but I also cannot
find what's the fix.

Thanks,
Namhyung


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
