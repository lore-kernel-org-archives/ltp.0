Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE45CE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 12:48:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E4033CDCE0
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 14:48:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573A13CBDB4
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:48:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE53B600048
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:48:02 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 31B9161069;
 Mon, 25 Sep 2023 12:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7558EC433C8;
 Mon, 25 Sep 2023 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695646079;
 bh=xEzUWpxdpxDLFGdAOLXyF8mvCulJHKo60CFRsd+bafo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G3JYTjMAmkYZzbYOqHOpqf3PI7U5DNq40sDrQfcsgwRWyZcKpjFrA+ZD6FMcrut/U
 AjA20FV6TfWsVTBqrzsRut5hunvB+JnXNMql86gdXXiOhCEtyTtzaIzMHJwYxOw58W
 a8pRP1aOpHDi8+x3SV1czvber2Ba8//3jazmpCeft5b4p1sVmU7TEmrOWrG52Rh6hA
 5TsMy+bfmJWuCzs8XqTBmb6FqgkFuaYXeEQl+safsYIFY0rdQXajxk+XK1oBidWEWP
 5npVQTL0pWm6jQSKzfjAuPKfo7iWOl2rt17XikL4y/1gD4CWg59+IEhuzy09j1ZWYD
 p4l1XvZG3ZmQA==
Date: Mon, 25 Sep 2023 14:47:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20230925-altbekannt-beunruhigen-972926d9d89f@brauner>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
 <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
 <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, Jan Kara <jack@suse.cz>, lkp@intel.com,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Sep 24, 2023 at 03:35:18PM +0100, Matthew Wilcox wrote:
> On Sun, Sep 24, 2023 at 12:30:30PM +0200, Christian Brauner wrote:
> > > This ad-hoc approach to testing syscalls is probably not the best idea.
> > > Have the LTP considered a more thorough approach where we have a central
> > > iterator that returns a file descriptor of various types (the ones listed
> > > above, plus block devices, and regular files), and individual syscall
> > > testcases can express whether this syscall should pass/fail for each type
> > > of fd?  That would give us one central place to add new fd types, and we
> > > wouldn't be relying on syzbot to try fds at random until something fails.
> > > 
> > > Or something.  I'm not an expert on the LTP or testing in general; it
> > > just feels like we could do better here.
> > 
> > I honestly would love to see such tests all go into xfstests. IOW,
> > general VFS and fs-specific tests should be in one location. That's why
> > I added src/vfs/ under xfstests. Having to run multiple test-suites for
> > one subsystem isn't ideal. I mean, I'm doing it but I don't love it...
> 
> This may well be a subject on which reasonable people can disagree.

Oh it sure is.

> I'm going to lay out what I believe the positions of the various
> parties are here, and plese feel free to speak up if you feel I'm
> mischaracterising anyone.
> 
> The LTP people see it as their mandate to test all syscalls.  They focus
> on getting the correct error code, checking corner cases of the API, etc.
> 
> The xfstests people see it as their mandate to test filesystems.
> They focus on testing the corner cases of the filesystem.
> 
> These are quite different things, and I'm not sure that forcing them

Yes, I agree that they are different things.
But the lines are quite often rather blurry as most vfs changes have an
immediate impact on fs testing and testing them involves validating the
vfs interface and the fses implementing them.

I've mostly just described my ideal world where the two things would be
tightly coupled even during testing.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
