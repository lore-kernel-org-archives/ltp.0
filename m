Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64496C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 14:39:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508913CE61D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 15:39:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86ADC3CACAA
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 15:39:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E210B601294
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 15:39:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1583D1FD87;
 Wed, 15 Mar 2023 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678891178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycXIw1k+9pi5M6i0FOJDQAnKzSLTYe8MO04t/EWycTc=;
 b=09nb+UNfcSCeGcD7PDZSQR+ze6RGXOO1mfbWy+Iu+IUznLdaGLPE6i20iWUmHie+nQIfUh
 EYRwPkJTVtTMJ4pAJVwKDkdr5hKwIUleSxYeT0us75vTBwzp9ewz+gcMJjXL+WIqCSyrow
 IZHtoqp4iPSdr2+Wlv9tkudP+JFVZZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678891178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycXIw1k+9pi5M6i0FOJDQAnKzSLTYe8MO04t/EWycTc=;
 b=RFvVeBHFEUjwwV7zGzZhBaGWxUH+XNIiZE/B+wo6ZePe1SBHp44rU3VoaD3MAefy7cS7y8
 yZuq/RL5psik8qDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54E6513A00;
 Wed, 15 Mar 2023 14:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TLCEBqnYEWRjTwAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 15 Mar 2023 14:39:37 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2023 20:09:34 +0530
Message-ID: <5670246.DvuYhMxLoT@localhost>
Organization: SUSE
In-Reply-To: <20230224063717.32388-1-akumar@suse.de>
References: <20230224063717.32388-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril's review of this patch which was send to another thread - https://lore.kernel.org/ltp/ZAEBOhm3nAExVfT2@yuki/#t

========
Re: [LTP] [PATCH v2 1/1] mknod01: Rewrite the test using new LTP API

From:	Cyril Hrubis <chrubis@suse.cz>
To:	Avinesh Kumar <akumar@suse.de>
CC:	ltp@lists.linux.it
Date:	3/3/23 1:34 AM
Hi!
> --- a/testcases/kernel/syscalls/mknod/mknod02.c
> +++ b/testcases/kernel/syscalls/mknod/mknod02.c
> @@ -1,301 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> /*
> - *
> *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *     07/2001 Ported by Wayne Boyer
> + *   Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> */
>
> -/*
> - * Test Name: mknod02
> +/*\
> + * [Description]
> *
> - * Test Description:
> *  Verify that mknod(2) succeeds when used to create a filesystem
> *  node with set group-ID bit set on a directory without set group-ID bit set.
> *  The node created should have set group-ID bit set and its gid should be
> *  equal to that of its parent directory.

I've read this a few times and I stil do not understand what exactly is
this test supposed to test or at least the code does not correspond to
the description.

I did look at the kernel sources for a while and as far as I can tell
the whole S_ISGID handling is done in the inode_init_owner() function:

void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
                      const struct inode *dir, umode_t mode)
{
        inode_fsuid_set(inode, mnt_userns);
        if (dir && dir->i_mode & S_ISGID) {
                inode->i_gid = dir->i_gid;

                /* Directories are special, and always inherit S_ISGID */
                if (S_ISDIR(mode))
                        mode |= S_ISGID;
        } else
                inode_fsgid_set(inode, mnt_userns);
        inode->i_mode = mode;
}
EXPORT_SYMBOL(inode_init_owner);

Which looks pretty straightforward.

- If the parent direcotry has S_ISGID we set the inode GID to the
  parent directory gid
- If not we call the inode_fsgid_set(), which does namepsace mappings,
  but eventually we end up whaterver the current running process GID
  maps to

So the test is awfully complex for what it's supposed to do, which is
without S_ISGID on parent directory the FIFO gid is set to the running
process GID. As far as I can tell all that needs to be done here is:

With .require_root:

1. Create a directory and set the directory GID to nobody
2. Create a FIFO inside the directory and check that the
   FIFO GID matches the root gid

And that should be it. As far as I can tell the S_ISGID on FIFO is
pointless in this case since for files the S_ISGID means that the GID is
changed when they are executed, which we do not attempt here and I'm not
even sure if we can execute FIFO.

And the same should be done by the mknod03 with the difference that th
S_ISGID should be set on the directory and we should expect the GID to
be inherited.

-- 
Cyril Hrubis
chrubis@suse.cz
==============



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
