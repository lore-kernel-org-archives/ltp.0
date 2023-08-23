Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D2FEE49A0
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 09:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6763E3CC5F8
	for <ltp@archiver.kernel.org>; Wed, 23 Aug 2023 11:37:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAA083C98FC
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:36:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E3B3600F29
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 11:36:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 897951F390
 for <ltp@lists.linux.it>; Wed, 23 Aug 2023 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692783416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LagXcM75UhwjzI/wYRxbCAb42inSYspJy/V9kbGNwss=;
 b=QgFyEiy5arLyrzcgNy96mGZB1Jl8gpQ9+K7fDgWNV2guegEyjXbpP7G1MXKjgV1hw8VGob
 KCRntLUlGAkUt5oS94j+TtMdyuQxrNA1UFGjOHj2U6yJ6VcgxAdyLkvbO2vc15iEf84ZyR
 5fDNNboHA5OjdX2/2woW8i+JFVL9RXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692783416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LagXcM75UhwjzI/wYRxbCAb42inSYspJy/V9kbGNwss=;
 b=3KfShZ9Kq3vxrGX4gBmk2PSWuhrKy3SFTMSf5Lvi+bjoEFUR+OgzZfXl5hmZ1sWtCq39OJ
 cEa+t8NV3j4lJJAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B596F2C142;
 Wed, 23 Aug 2023 09:36:55 +0000 (UTC)
References: <20230315155650.12469-1-akumar@suse.de>
 <20230516115841.GA7742@pevik>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Aug 2023 10:21:07 +0100
Organization: Linux Private Site
In-reply-to: <20230516115841.GA7742@pevik>
Message-ID: <87wmxmumkr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mknod02.c: Simplify and convert to new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Avinesh,
>
>> Simply test when parent directory does not have set-group-ID bit set,
>> new node gets GID from effective GID of the process and does not inherit
>> the group ownership from its parent directory.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Few comments below.
>
>>  testcases/kernel/syscalls/mknod/mknod02.c | 316 +++-------------------
>>  1 file changed, 36 insertions(+), 280 deletions(-)
>
> ...
>> +/*\
>> + * [Description]
>>   *
>> + * Verify that if mknod(2) creates a filesystem node in a directory which
>> + * does not have the set-group-ID bit set, new node will not inherit the
>> + * group ownership from its parent directory and its group ID will be the
>> + * effective group ID of the process.
>
> @Cyril I wonder if it'd be good to test this on all_filesystems. Are we trying
> to use use all_filesystems = 1 when subject of testing is using VFS or the
> opposite? (kernel docs mentions "VFS system calls open(2), stat(2), read(2),
> write(2), chmod(2)". It also mentions locking [2]).
>
> BTW looking what has mknod in vfs, it's just nfsd and 9p (none of them are used
> in all_filesystems):
>
> $ git grep  mknod $(git ls-files fs/|grep -i vfs)
> fs/9p/vfs_inode.c: * for mknod(2).
> fs/9p/vfs_inode.c: * v9fs_vfs_mknod - create a special file
> fs/9p/vfs_inode.c:v9fs_vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> fs/9p/vfs_inode.c:      .mknod = v9fs_vfs_mknod,
> fs/9p/vfs_inode.c:      .mknod = v9fs_vfs_mknod,
> fs/9p/vfs_inode_dotl.c:v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
> fs/9p/vfs_inode_dotl.c: return v9fs_vfs_mknod_dotl(idmap, dir, dentry, omode, 0);
> fs/9p/vfs_inode_dotl.c: * v9fs_vfs_mknod_dotl - create a special file
> fs/9p/vfs_inode_dotl.c:v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
> fs/9p/vfs_inode_dotl.c:         p9_debug(P9_DEBUG_VFS, "Failed to get acl values in mknod %d\n",
> fs/9p/vfs_inode_dotl.c: err = p9_client_mknod_dotl(dfid, name, mode, rdev, gid, &qid);
> fs/9p/vfs_inode_dotl.c: .mknod = v9fs_vfs_mknod_dotl,
> fs/nfsd/vfs.c:          host_err = vfs_mknod(&nop_mnt_idmap, dirp,
> dchild,

It is defined for all major file systems on the directory
inode_operations struct (e.g. search btrfs_mknod, xfs_vn_mknod, ext4_mknod).

If you setup clangd and provide a reasonabl compile_commands.json
(i.e. relatively large kernel config) you can search for places where
struct inode_operations.mk_nod is set.

So I'll go ahead and try to merge it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
