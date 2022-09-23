Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D52ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 10:28:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DB203CAD69
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:28:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 526FA3CAD4C
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:28:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A459100136B
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 12:28:00 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 908C861177;
 Fri, 23 Sep 2022 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D651C433D7;
 Fri, 23 Sep 2022 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663928878;
 bh=iHwiSOEbv/xrD1FIxY4311byEWh77P3rXLFSGcj4gAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oAJq+AwBBW4pb6ZC0SwlcVepPhqve9YTVHSSGDsdw1iLnNbhejMMf02ZKUp3y36s8
 dZji0JWcDk0vf+NBbdWG28b+cWZa441LxVpNN3ZYcMTWhh++nnpR0un/b6FQMswwsx
 JMvKAKt259zTJKIpVZVyxqTOi8s5LzjeSTXI5rUBzG5O9Mtn6dNdqff5Vsfmmq0Vho
 OQS1MYVe/vN4lZF57cASx8xIC+zKcliYAhpE+i7SEFMuqUjygX69WBftcZH+6rP7Ov
 jruBgieuwvs8hfAy7ApC0NbX/qESbrqYvHUB2EdPtYO+DOAXuSsFZolDfpvDQH+zhv
 nh6f/cJahpFRA==
Date: Fri, 23 Sep 2022 12:27:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20220923102753.4vu6id33obfi34qa@wittgenstein>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YywiZckfyJIk1/Pf@yuki>
 <TY2PR01MB442734C41B2B574CF05B8AE1FD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <Yywqj0orkajkDZt5@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yywqj0orkajkDZt5@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 22, 2022 at 11:27:43AM +0200, Cyril Hrubis wrote:
> Hi!
> > > And this one is probably missing some kernel commit tags too, since the only that that is attached is supposedly in 5.19 but the test still fails.
> > 
> > > I supposed that we should add the 426b4ca2d6a5 to the test tags here as well, right?
> > 
> > Yes, BTW,  I usually use git tag --contains command, so I know this kernel fix is belong to 6.0.
> > 
> > git tag --contains ac6800e27
> > v6.0-rc1
> > v6.0-rc2
> 
> Now I'm confused, if I do git describe ac6800e27 it says that it's a
> second commit on the top of 5.19-rc7. So shouldn't the the git tag
> --contains report 5.19-rc8 and newer? What do I miss?

So, ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile") has been
backported to kernels since before the dawn of time. But the the all the
pieces that move setgid handling out of individual filesystems and into
the vfs proper are only >= v6.0-rc1.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
