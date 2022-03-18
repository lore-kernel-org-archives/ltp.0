Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA851C433EF
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 13:40:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9C473C60CB
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 14:40:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9805A3C9435
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 23:13:04 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B50F200DDD
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 23:13:03 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 20E82B825D5;
 Fri, 18 Mar 2022 22:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3852C340E8;
 Fri, 18 Mar 2022 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647641580;
 bh=XdwPFWCLOqOp/DOpgX9TQgoYllQ5ntACf3oj7rI8TRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cwRL5RvJ4NoLuUlCoHasPJo1eE4J/M766xEAd4hb97cm9W73cxtTi9ciDsiNHhLEt
 +e9BFEIVMitUSUgW4DDthLigNHeRbuJSkAYNoDInedWW8qj11u4TJbt5J89lmrovVL
 bpI/aM/hOOzFtU4nEpI3dOKhi/N5nFPgYXMPzOX4IXr4QzekvxeqFmMO2kQte4vg83
 1VBM2QxCaV32zqA0J1oz7jhZC6CBwxfCcMq7qX7pp0PmgO7JCZtXswT8mIN/9XTK8u
 Wot5kgFvlYLn8sp+QIiu9odYMHElM8mO0sxERFbLZwvilzyhJo5GbHwu3mc0XgxKDH
 XiCwqO61gPG/Q==
Date: Fri, 18 Mar 2022 15:12:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <20220318221258.GK8241@magnolia>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62343BF2.1020006@fujitsu.com> <623460FD.8070500@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <623460FD.8070500@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 21 Mar 2022 14:40:08 +0100
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: xfs <linux-xfs@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

You really ought to cc the xfs list for questions about longstanding
behaviors of XFS...

[cc linux-xfs]

--D

On Fri, Mar 18, 2022 at 10:37:03AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Darrick, Jack
> 
> Petr meet a problem when running creat09 on xfs, ext4 doesn't have problem.
> 
> It seems xfs will still use umask when enable default acl, but ext4 will 
> not.
> 
> As umask2 manpage , it said
> "Alternatively, if the parent directory has a default ACL (see acl(5)), 
> the umask is ignored, the default ACL is inherited, the permission bits 
> are set based on the inherited ACL, and permission bits absent
>         in the mode argument are turned off.
> "
> 
> It seem xfs doesn't obey this rule.
> 
> the xfs calltrace as below:
> 
>    will use  inode_init_owner(struct user_namespace *mnt_userns, 
> structinode *inode)
> 
>   296.760675]  xfs_init_new_inode+0x10e/0x6c0
> [  296.760678]  xfs_create+0x401/0x610
>    will use posix_acl_create(dir, &mode, &default_acl, &acl);
> [  296.760681]  xfs_generic_create+0x123/0x2e0
> [  296.760684]  ? _raw_spin_unlock+0x16/0x30
> [  296.760687]  path_openat+0xfb8/0x1210
> [  296.760689]  do_filp_open+0xb4/0x120
> [  296.760691]  ? file_tty_write.isra.31+0x203/0x340
> [  296.760697]  ? __check_object_size+0x150/0x170
> [  296.760699]  do_sys_openat2+0x242/0x310
> [  296.760702]  do_sys_open+0x4b/0x80
> [  296.760704]  do_syscall_64+0x3a/0x80
> 
> 
> the ext4 calltrace as below:
> [  296.460999]  __ext4_new_inode+0xe07/0x1780 [ext4]
> posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
> [  296.461035]  ext4_create+0x106/0x1c0 [ext4]
> [  296.461059]  path_openat+0xfb8/0x1210
> [  296.461062]  do_filp_open+0xb4/0x120
> [  296.461065]  ? __check_object_size+0x150/0x170
> [  296.461068]  do_sys_openat2+0x242/0x310
> [  296.461070]  do_sys_open+0x4b/0x80
> [  296.461073]  do_syscall_64+0x3a/0x80
> [  296.461077]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I guess xfs modify its mode value instead of inode->i_mode in 
> posix_acl_create by using current->umask value, so inode_init_owner 
> doesn't clear no-sgid bits on created file because of missing S_IXGRP.
> 
> Is it a kernel bug?
> 
> Best Regards
> Yang Xu
> 
> > Hi Petr
> >
> > It fails because the create file without S_IXGRP mode, then we miss
> > remove S_ISGID[1] bit.
> >
> > But I don't known why other filesystem doesn't have this problem.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c#n2249
> >
> > Best Regards
> > Yang Xu
> >> XFS fails on umask 0077:
> >>
> >> tst_test.c:1528: TINFO: Testing on xfs
> >> tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> >> tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
> >> creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
> >> creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
> >> creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> >> creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> >> creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> >> creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set
> >>
> >> Thus clear the default umask.
> >>
> >> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> >> ---
> >>    testcases/kernel/syscalls/creat/creat09.c | 2 ++
> >>    1 file changed, 2 insertions(+)
> >>
> >> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> >> index bed7bddb0e..70da7d2fc7 100644
> >> --- a/testcases/kernel/syscalls/creat/creat09.c
> >> +++ b/testcases/kernel/syscalls/creat/creat09.c
> >> @@ -56,6 +56,8 @@ static void setup(void)
> >>    		(int)ltpuser->pw_gid);
> >>    	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> >>
> >> +	umask(0);
> >> +
> >>    	/* Create directories and set permissions */
> >>    	SAFE_MKDIR(WORKDIR, MODE_RWX);
> >>    	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
> >

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
