Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE540CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755498688; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2RFDvd1vXgjzmeLiwAkeVDHC5lQzOBFqo/ytBUoMJoE=;
 b=Bf8jG+dq3WlpJbtoprUqqvGGRhp3JBZDlyaoKfIdAC/iFIjghpBbYEYXzUNaGCJ0a2vld
 2JbaN5/6UV7eRKjVswHZu/r1gKfwWhkJ8HwId+koj0ugsxv17TIYqQ+3eVZ6tm82729pCtk
 yFN+hpRx5Wi9G+KG84WhJ1b8VxoRLOI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A8333CC8B7
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 08:31:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 002A13C9F6C
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 18:24:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D0EE6002CF
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 18:24:08 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 212E1419C9;
 Fri, 15 Aug 2025 16:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B60C4CEEB;
 Fri, 15 Aug 2025 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755275045;
 bh=4W3MexmDLIj0LLuVBsUoXVIfys/oLMGtURiFQUEH13U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUphFxrWKV+6n7KpkD3VVRbo27xzyyN/vWebfUiwoAS3RvQSWcpYef5mbG32vq0xD
 Hj0/e3bePcSFamI9nK1ma1Z1tJgmnKrGZNeX7nNEd7c2k/TECv6Usta5G6k2J1kTXq
 LsLm0KSBqNf5NIpDJGBe/pMGF4IRBd7RfiQ0AFAHXmAiB/AdFCFFEAZWTG5KJ1UEeH
 gx7uzJLw+iJTkPJ6nbo75iUvpli22kP4Ea4eVzyFa0QL+rwrRi3uUMsyrZOzUynbnX
 vzx4mQ8pLbKA4C23C8MVuQVsKobT/zIxnc9HN1TNS3GmfWQ6VfTQjsBHkx+jBmRUuP
 bmqcMI4Wr142Q==
Date: Fri, 15 Aug 2025 09:24:01 -0700
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <aJ9fIUkM04HhRgSR@google.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh> <aJ5EupUV9t0jToY3@google.com>
 <2025081536-resonate-wafer-6699@gregkh>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2025081536-resonate-wafer-6699@gregkh>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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

On Fri, Aug 15, 2025 at 07:33:41AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 01:19:06PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > Thanks for the report!
> > 
> > On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > > Long story:
> > > > 1)
> > > > The perf gcc-13 build failed on x86_64 and i386.
> > > > 
> > > > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > > > fallocate failed.
> > > > 
> > > > > Ian Rogers <irogers@google.com>
> > > > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > > > 
> > > > Build error:
> > > > 
> > > > arch/x86/tests/topdown.c: In function 'event_cb':
> > > > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > > > function 'pr_debug' [-Werror=implicit-function-declaration]
> > > >    53 |                         pr_debug("Broken topdown information
> > > > for '%s'\n", evsel__name(evsel));
> > > >       |                         ^~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > 
> > > Already fixed.
> > 
> > Are you sure?  I'm not seeing the fix.  Can you share the commit id?
> 
> I dropped the offending perf patch:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=4199b872a5585e025f62886724f4f9ae80e014ae
> 
> Did that not work for you?

Oh sorry, I misunderstood you.  I thought you have a fix.

Thanks,
Namhyung


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
