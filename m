Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8068AC19F2C
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 07:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73E883C93E2
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:50:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0408F3C91EE
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:50:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70608600960
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:50:02 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C83AC6153B;
 Wed,  3 Aug 2022 07:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6346C433C1;
 Wed,  3 Aug 2022 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659513000;
 bh=16HhrYZd+obXEvMvOW07XjKFfH/8O6zYJ2QvejnXOrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FPiRuKW7RNfuSFlOP/D89kPBNizxZiJ8wvpFsXX0yuxddSGZhVujGemdJSqZAKixG
 JpVc6bO0yrj5uKVWw7E8LfxTI8SGpES4T/WF3AF6R5eIo28r1292Ymoj2qiWXdQ173
 wwgVAIdqRLePKONsU74oUAMf+M5Wf8Tpp0JXdgwVzHVUV5Q9r2FB/Mgg97JjGXbJeI
 r2LwlL1gVFf/dfSUgNcXMxc5VO5TIIf24KTkIn+wnj3bCK+Zv5ECy6yY+RwAFLpn8w
 qM/b3BThNkbpLDBhvI3hNZpwRwus+ZtVCQBT9yMDetd17V755IWVDctU9I6g0hl4sp
 k4N/UZ7l9QwBg==
Date: Wed, 3 Aug 2022 09:49:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20220803074955.z7okyvrwqxkatxf6@wittgenstein>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/creat09: Add umask test condition
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
Cc: martin.doucha@suse.com, ltp@lists.linux.it, sforshee@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 03, 2022 at 11:24:22AM +0800, Yang Xu wrote:
> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
> this case has been merged into linux-next branch[1].
> 
> I will add acl and umask test[2] in xfstests because there is more suitable
> to do this.
> 
> Here I just only add umask test condition simply.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220802&id=1639a49ccdce
> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Fyi, I have this Thursday and Friday off which is why I haven't sent the
pull request for setgid changes to Linus yet. I only sent the ones that
I thought were less likely to cause regressions. I don't want to send a
PR and then not be around to respond to issues. So I will send the
setgid PR on Tuesday or Wednesday next week. Just a heads up!

Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
