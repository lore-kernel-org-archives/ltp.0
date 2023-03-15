Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D9DC61DA4
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 15:17:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC833CD4A5
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 16:17:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F9893CAC8A
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:16:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03D2F1000985
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 16:16:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 537A91FD7C;
 Wed, 15 Mar 2023 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678893409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDbrrytY8RBmziCB4GkAbVgxxqVcNJQjHSNyGRbwNnE=;
 b=QHP4AOAOR+dtqL+8jVOYNkHlUToNmDJBIX95F0Cffp2EEjPo3Nj5+xH6yUhEOE8Yw7pDi2
 jly2p6o3d98npzC5syHyBu5q2U3y/2ivTAHhpWFXE4lPJA1LNdgYqS431yfo0Te4K7Dknw
 L+011adVqLqiG9f6/LO8ZQNroeU+Rhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678893409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDbrrytY8RBmziCB4GkAbVgxxqVcNJQjHSNyGRbwNnE=;
 b=gipHNq9/msFKNvgjhRamJjcE1sQ5KFZEEUEYKGFSzG9wOiQhqU061tBV83ZqRtHbbIJCgn
 hWWALqYPnarqtxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B16013A00;
 Wed, 15 Mar 2023 15:16:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jv2IE2DhEWT3YwAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 15 Mar 2023 15:16:48 +0000
From: Avinesh Kumar <akumar@suse.de>
To: chrubis@suse.cz
Date: Wed, 15 Mar 2023 20:46:45 +0530
Message-ID: <3740015.kQq0lBPeGt@localhost>
Organization: SUSE
In-Reply-To: <5670246.DvuYhMxLoT@localhost>
References: <20230224063717.32388-1-akumar@suse.de>
 <5670246.DvuYhMxLoT@localhost>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mknod02.c: Convert to new LTP API
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Wednesday, March 15, 2023 8:09:34 PM IST you wrote:
> Cyril's review of this patch which was send to another thread - https://lore.kernel.org/ltp/ZAEBOhm3nAExVfT2@yuki/#t
> 
> ========
> Re: [LTP] [PATCH v2 1/1] mknod01: Rewrite the test using new LTP API
> 
> From:	Cyril Hrubis <chrubis@suse.cz>
> To:	Avinesh Kumar <akumar@suse.de>
> CC:	ltp@lists.linux.it
> Date:	3/3/23 1:34 AM
> Hi!
> > --- a/testcases/kernel/syscalls/mknod/mknod02.c
> > +++ b/testcases/kernel/syscalls/mknod/mknod02.c
> > @@ -1,301 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > /*
> > - *
> > *   Copyright (c) International Business Machines  Corp., 2001
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > - *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > - *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> > + *     07/2001 Ported by Wayne Boyer
> > + *   Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> > */
> >
> > -/*
> > - * Test Name: mknod02
> > +/*\
> > + * [Description]
> > *
> > - * Test Description:
> > *  Verify that mknod(2) succeeds when used to create a filesystem
> > *  node with set group-ID bit set on a directory without set group-ID bit set.
> > *  The node created should have set group-ID bit set and its gid should be
> > *  equal to that of its parent directory.
> 
> I've read this a few times and I stil do not understand what exactly is
> this test supposed to test or at least the code does not correspond to
> the description.
> 
> I did look at the kernel sources for a while and as far as I can tell
> the whole S_ISGID handling is done in the inode_init_owner() function:
> 
> void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>                       const struct inode *dir, umode_t mode)
> {
>         inode_fsuid_set(inode, mnt_userns);
>         if (dir && dir->i_mode & S_ISGID) {
>                 inode->i_gid = dir->i_gid;
> 
>                 /* Directories are special, and always inherit S_ISGID */
>                 if (S_ISDIR(mode))
>                         mode |= S_ISGID;
>         } else
>                 inode_fsgid_set(inode, mnt_userns);
>         inode->i_mode = mode;
> }
> EXPORT_SYMBOL(inode_init_owner);
> 
> Which looks pretty straightforward.
> 
> - If the parent direcotry has S_ISGID we set the inode GID to the
>   parent directory gid
> - If not we call the inode_fsgid_set(), which does namepsace mappings,
>   but eventually we end up whaterver the current running process GID
>   maps to
> 
> So the test is awfully complex for what it's supposed to do, which is
> without S_ISGID on parent directory the FIFO gid is set to the running
> process GID. As far as I can tell all that needs to be done here is:
> 
> With .require_root:
> 
> 1. Create a directory and set the directory GID to nobody
> 2. Create a FIFO inside the directory and check that the
>    FIFO GID matches the root gid
Yes this seems simple and enough, implementing this in the v2
of this patch.

> 
> And that should be it. As far as I can tell the S_ISGID on FIFO is
> pointless in this case since for files the S_ISGID means that the GID is
> changed when they are executed, which we do not attempt here and I'm not
> even sure if we can execute FIFO.
Yes, agree.
`man 2 mknod` doesn't say anything about the S_ISGID of the new node being
created, so in which cases new node should have S_ISGID bit set? 
IIUC, in the above kernel function inode_init_owner(), it is being set only if
new node is a directory?

(looking at mknod03|04|05|08, these tests somehow trying to  verify the 
S_ISGID bit of the newly created node)

> 
> And the same should be done by the mknod03 with the difference that th
> S_ISGID should be set on the directory and we should expect the GID to
> be inherited.
> 
> 

Thank you,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
