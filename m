Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC59C36011
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 16:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A37B3CA52E
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 17:26:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2E83CA013
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 17:26:17 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=91.218.175.184;
 helo=out-184.mta0.migadu.com; envelope-from=kent.overstreet@linux.dev;
 receiver=lists.linux.it)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [91.218.175.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58DF0600C5F
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 17:26:14 +0100 (CET)
Date: Fri, 28 Mar 2025 12:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1743179170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/qa0edAWMlranoyL+nTInr92sFi6AEqh1M+j4KdVPI=;
 b=jKlnddoYpmjg9phx+tRf0Scr2nVY6PxB/rX7rK0bqICrPXOdGTZxgRHFb+70t4/lwALSWt
 iTcR0iVt8ngqj2e+yvamJcJNd4jwcYCApBjAd9TqlS0VrmE+CvGKKJEdk+XuFLeN0T5MJF
 GSr3p1jBf2Pwsu2cgYvjqjt/ibTi34o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <7ltgrgqgfummyrlvw7hnfhnu42rfiamoq3lpcvrjnlyytldmzp@yazbhusnztqn>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
 <Z-Sgj_XOVar8myLw@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-Sgj_XOVar8myLw@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
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
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 27, 2025 at 11:49:19AM +1100, Dave Chinner wrote:
> On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> > Hi all,
> > 
> > [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]
> > 
> > > From: Andrea Cervesato <andrea.cervesato@suse.com>
> > 
> > > Make sure that capabilities requirements are satisfied when accessing
> > > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > > following error due to missing capabilities:
> > 
> > > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > > ..
> > > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)
> 
> None of these are -EPERM, so how is a missing capability that
> results in -EPERM being returned cause -ENOTTY or -EBADF failures?
> 
> ohhhhh. ENOTTY is a result of a kernel side compat ioctl handling bug
> w/ bcachefs.
> 
> bcachefs doesn't implement ->fileattr_set().
> 
> sys_compat_ioctl() does:
> 
>         case FS_IOC32_GETFLAGS:
>         case FS_IOC32_SETFLAGS:
>                 cmd = (cmd == FS_IOC32_GETFLAGS) ?
>                         FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
> 
> and then calls do_vfs_ioctl().
> 
> This then ends up in vfs_fileattr_set(), which does:
> 
> 	if (!inode->i_op->fileattr_set)
>                 return -ENOIOCTLCMD;
> 
> which means sys_compat_ioctl() then falls back to calling
> ->compat_ioctl().
> 
> However, cmd has been overwritten to FS_IOC_SETFLAGS and
> bch2_compat_fs_ioctl() looks for FS_IOC32_SETFLAGS, so it returns
> -ENOIOCTLCMD as it doesn't handle the ioctl command passed in.
> 
> sys_compat_ioctl() then converts the -ENOIOCTLCMD to -ENOTTY, and
> there's the error being reported.
> 
> OK, this is a bcachefs compat ioctl handling bug, triggered by not
> implementing ->fileattr_set and implementing FS_IOC_SETFLAGS
> directly itself via ->unlocked_ioctl.
> 
> Yeah, fixes to bcachefs needed here, not LTP.
> 
> > I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:
> 
> Because they implement ->fileattr_set() and so all the compat ioctl
> FS_IOC32_SETFLAGS handling works as expected.

thanks for the analysis, I'll try to get this fixed soon

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
