Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB5ACE7A8A
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 10:30:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 240C13CDD55
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 12:30:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3ACA3C9A39
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 12:30:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58CB31000DEE
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 12:30:42 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1B35560A3D;
 Sun, 24 Sep 2023 10:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4142CC433C8;
 Sun, 24 Sep 2023 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695551440;
 bh=4b+v0jL8cZPOJtS/KSdvZ2Dmw74ePGjMhmS5Bo2Dw7k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YvwodIrvH7IcGWXoRIjZwmKnnRMspG5tGG0lUoYcj2fq+kBkZqBWrtI1o141seFWT
 oASXn3EyjLIvrwfD5PSpb4R3QwCj4r165mE/7EQb5bBwOJd7zftVtaF4QTYcp+R0zq
 mVh6ur0SyWJzUDfPSjlgnqIlWTWqXgimEDW+/p0Z03JD6apa4b+64xv5C3Lib4202u
 zqXe8qfkv7Ip1cZQ48cm5FlJjSUZntiu6xFcO6t7xvpp0tDqvNnrKvKRl27o6kmY3I
 SIINivz5TwNZqdHkJQp/e4sFPBIhG4BFgT35W0lb9CpgOBrMp4LdwTZMPw2ZaJGHWd
 Q/xEO667Tgfow==
Date: Sun, 24 Sep 2023 12:30:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20230924-umliegenden-qualifizieren-4d670d00e775@brauner>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ/hGr+o61X1mik9@casper.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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

> This ad-hoc approach to testing syscalls is probably not the best idea.
> Have the LTP considered a more thorough approach where we have a central
> iterator that returns a file descriptor of various types (the ones listed
> above, plus block devices, and regular files), and individual syscall
> testcases can express whether this syscall should pass/fail for each type
> of fd?  That would give us one central place to add new fd types, and we
> wouldn't be relying on syzbot to try fds at random until something fails.
> 
> Or something.  I'm not an expert on the LTP or testing in general; it
> just feels like we could do better here.

I honestly would love to see such tests all go into xfstests. IOW,
general VFS and fs-specific tests should be in one location. That's why
I added src/vfs/ under xfstests. Having to run multiple test-suites for
one subsystem isn't ideal. I mean, I'm doing it but I don't love it...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
