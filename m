Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D59CE7A88
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 14:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF3033CE29A
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 16:35:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B029D3CDDC3
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 16:35:26 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 49CA41400153
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 16:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M5pObT5z3Mwip+WvbK3iOt6865GE12uJP5gsebp/nnQ=; b=AwwueGpZKCnMTC75hg8M4rqwUv
 sl51v7yKGpM6sivDirVYrWXe+pyUwwFfBeigYQse2mVBdmcllpAZ7WgHEwAepL/S1VhA67XPmWK38
 Ly7/T0glDgOiDMQK14E593EZcPiJScsCLmJ5oQHx6y1737mCIO31EUzbbUs4vgfz2dT4Cv9OXJV9s
 ROhEACJ0VA/Wt1y3TDzV9z8rUwKgoFyRO+9I1jO8+NLdfmNYxwpWphOAzmZucZfVdWB6DxU5Y10ef
 6dV+yQ+Bi/QHGZFJS5uHEA5JJDvArnqFiXqmhhpf2BK86fplrjNGMZSWBTRyjxemI+MmMVfb9b9DG
 YTGoaS+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1qkQCc-00DSFC-34; Sun, 24 Sep 2023 14:35:18 +0000
Date: Sun, 24 Sep 2023 15:35:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <ZRBJJgwFl/0NwQ6W@casper.infradead.org>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
 <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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

On Sun, Sep 24, 2023 at 12:30:30PM +0200, Christian Brauner wrote:
> > This ad-hoc approach to testing syscalls is probably not the best idea.
> > Have the LTP considered a more thorough approach where we have a central
> > iterator that returns a file descriptor of various types (the ones listed
> > above, plus block devices, and regular files), and individual syscall
> > testcases can express whether this syscall should pass/fail for each type
> > of fd?  That would give us one central place to add new fd types, and we
> > wouldn't be relying on syzbot to try fds at random until something fails.
> > 
> > Or something.  I'm not an expert on the LTP or testing in general; it
> > just feels like we could do better here.
> 
> I honestly would love to see such tests all go into xfstests. IOW,
> general VFS and fs-specific tests should be in one location. That's why
> I added src/vfs/ under xfstests. Having to run multiple test-suites for
> one subsystem isn't ideal. I mean, I'm doing it but I don't love it...

This may well be a subject on which reasonable people can disagree.
I'm going to lay out what I believe the positions of the various
parties are here, and plese feel free to speak up if you feel I'm
mischaracterising anyone.

The LTP people see it as their mandate to test all syscalls.  They focus
on getting the correct error code, checking corner cases of the API, etc.

The xfstests people see it as their mandate to test filesystems.
They focus on testing the corner cases of the filesystem.

These are quite different things, and I'm not sure that forcing them
together or moving test-cases from one test-suite to the other makes
sense.  I think it's reasonable to have two separate test suites for you
(and the various bots) to run, even though it's slightly more work.

At the end of the day, I don't much care, it doesn't significantly affect
my life.  If I could see a clear advantage to converting one to the other,
I'd be all for it, but I don't see a compelling reason to put much work
in here.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
