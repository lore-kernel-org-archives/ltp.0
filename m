Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB3EC7619A
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 03:06:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64DD53CDD20
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 05:06:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 015A33CC8A3
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 05:06:26 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D05761A003C0
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 05:06:25 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2C8A8B80A4B;
 Mon,  3 Apr 2023 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD58EC433EF;
 Mon,  3 Apr 2023 03:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680491182;
 bh=MBbn8J6mmBKTSe3QhXByJ+vpY2xIGcaSb/+d0U7YOqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X8pEy8RqiuGvPkCSo6CcywwxWqGvRDuXs7WBOVU/xpBb8Vf/4OszhkqSgngklP9De
 Ejzdpi6aGgGCBd+2IB0/XPJWzAylrNScb9GazEAe0cPnYi26URfQZU2keT753q+kL3
 6+NHLZON2i0zLFw7/eOY9rtc9kl5Fq8WihZKzQQ8CO8R3bt4zoYQV09Iw6h+Rs0uTL
 z/x01MOJ5bQ23o2QZBx3Qq9aO10ciAsSxtCgB5cMIdHmb779JrJkwgMOBrhpkK976C
 3H3T3PUIwOBykaAY5kGKMlkhSRpmWFFiNtwveu+V7LkzxxB+lWli1BqfjlXioxsc80
 gHH+HYz2e/q9w==
Date: Sun, 2 Apr 2023 20:06:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230403030621.GA2745@sol.localdomain>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230330164653.GA881@sol.localdomain>
 <a9a441b0-1774-a15c-14ec-b155bfe88152@fujitsu.com>
 <ZCc0gyy9QvGLlUPv@gmail.com>
 <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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

On Mon, Apr 03, 2023 at 01:24:07AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> Thanks for your explaination. IMO, ext4 and xfs should supported DIO.
> 
> I think I can test STATX_DIOALIGN only on ext4 and xfs (xfs can use 
> XFS_IOC_DIOINFO ioctl to verify dio alignment information ) instead of 
> all filesystem.
> 
> What do you think about it?

ext4 supports direct I/O only on files that don't use any of the following
filesystem features: data journalling, encryption, and verity.  Also potentially
future filesystem features that have yet to even be envisioned...

But, I suppose that if you create an ext4 filesystem with the default options,
mount it with the default options, and don't call any ioctls to enable features,
it's fairly safe to assume that direct I/O is supported.

> 
> > 
> >>> Filesystems aren't guaranteed to
> >>> support DIO, if they do, they aren't guaranteed to support it on all files.
> >>
> >> In this case, I only test a regular file.
> > 
> > It is possible that on a single filesystem, direct I/O is supported on some
> > regular files but not others.  It is also possible that files on the same
> > filesystem have different direct I/O alignment restrictions.
> > 
> > Likewise, this was part of the motivation for STATX_DIOALIGN.
> 
> Understand, If only test ext4 and xfs,  except for regular file, Which 
> file type does I should test?  device file, link file...

Just regular files.

You could also test block devices, which are unrelated to filesystems.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
