Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E319ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 15:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3C5F3CAD3B
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 17:40:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C23013C93EF
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:40:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A21661A01182
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 17:40:33 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C171862C71;
 Wed, 21 Sep 2022 15:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88621C433B5;
 Wed, 21 Sep 2022 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663774829;
 bh=688IZWc7fGLBzJtdorVtdxJD93CcGZk9lM7ZFPlt9eg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eNRouAEA1yeHVP81COFtLtWFLVLrNaCadqivMehUGFipJMAanOE8589MTAAokBwtI
 MVplWZSyTzME6favrVm9rf0wJNug/AXSlxPhKvfklPeWi3kXhnE2gftYAao8gzVhmi
 LROlwSdzUTvcDLJSXQcfoZvfQrwIT4gerDcket7bIRPLpyreb8wvJqrj/JuGEUdunD
 6oEqyE8qNHHqKyK2ZAAJrG3aER6TIFWdIyjI4pp4wtHPQk7PXmkNwEeqIwXXDabG2K
 c2iR4cvkdqjiwjFWhXZ28ZZg/y+VAR+l/PktLn66r6ytXykmSRbMHkIMp60PzTJq+8
 RNftg5gt3EJkw==
Date: Wed, 21 Sep 2022 17:40:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20220921154025.kek7drx67sx2mpub@wittgenstein>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YyG61JHO7iDAfJ1N@yuki>
 <bd50a9da-0b32-2318-31ec-67a78155cc25@fujitsu.com>
 <12eff5a1-bf6b-59bf-bfca-7a1d4f3ca009@fujitsu.com>
 <YysX7FVAHO6HkLLZ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YysX7FVAHO6HkLLZ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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

On Wed, Sep 21, 2022 at 03:55:56PM +0200, Cyril Hrubis wrote:
> Hi!
> > > Yes.  Please apply it with fix the messages. Thanks.
> > 
> > I guess you miss this patchset. so ping again.
> 
> Sorry for the delay.
> 
> I just did quick test and I got failures on XFS on kernel 5.19, wasn't
> this supposed to be fixed in 5.19?

No, this is fixed starting with v6.0-rc1 :)

> 
> ...
> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:112: TPASS: mntpoint/testdir/creat.tmp: Setgid bit not set
> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:112: TPASS: mntpoint/testdir/open.tmp: Setgid bit not set
> creat09.c:120: TINFO: File created with umask(S_IXGRP)
> creat09.c:106: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> creat09.c:110: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> creat09.c:106: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> creat09.c:110: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
> ...
> 
> $ uname -r
> 5.19.0
> 
> $ git describe 1639a49ccdce
> v5.19-rc7-3-g1639a49ccdce
> 
> 
> Is there any in-flight patch for v6.0 that fixes this for XFS?

You're looking for
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=426b4ca2d6a5ab51f6b6175d06e4f8ddea434cdf

Hope this helps!
Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
