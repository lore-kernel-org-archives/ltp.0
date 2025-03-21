Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF0AC36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742573952; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MgwatupNEZtWdJ0URiVClCHoCrFoNZ/NDKVwsuPvTm0=;
 b=mEQ4CLnP8ubMXVd95RcNVMCi/RdGJWN0ymyTOeeIQSjmlSLyAi2vwaYJwg+CGfwGfacXT
 ov8dRnQ8X9QT1FDIX1uP7DdfoVSv3uCOoVR+OED7Qh2hhd3EUzhAO4t9WPd8BlbRpGD3pvZ
 YhlR9k4iWuI+ztGpYCfNhnlQqM//rh8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 677ED3CAE82
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 17:19:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C48113C0732
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 17:18:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=djwong@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A80A1400DA8
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 17:18:49 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9F7E0A49117;
 Fri, 21 Mar 2025 16:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D83C4CEE3;
 Fri, 21 Mar 2025 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742573927;
 bh=DwRKLtbDRxPFh80TV0iuQKFtLNQUyPAH4/roK7qMEJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JgN/Kq3Ml/oM5k8p9EPp7vxpr9XfoeVAlpdfmHtas/sgseXzJ/NoZVJfuVyh11FVB
 DD+fjMw5bG20j7jSONan0v6UZODfIXucWAgiEHPgp86afAvtL8z0jg+haG4xoRCTAA
 ZlxqwkN5gnreHTyT5hU+QuhZWDZLenYx6ebNNU/6NRyRqEqu+1tc5rVE1hxpS6lZ1K
 oO638cNblYA+36tMuLpc9SO0hx5xZQXjU1qMJMe9tnFU0JMLWvEw0pLbavcNQwWGTI
 102LNKn0Wv1M8JtaoPanvQvjqdUKCqCOeH2o/2FyQ7hiaoYtHKJLA5HuEb80XVgR17
 Si1ouPD0ouKKA==
Date: Fri, 21 Mar 2025 09:18:46 -0700
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20250321161846.GM2803749@frogsfrogsfrogs>
References: <20250321100320.162107-1-pvorel@suse.cz>
 <20250321152358.GK2803749@frogsfrogsfrogs>
 <20250321160633.GA177324@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250321160633.GA177324@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] ioctl_ficlone03: Require 5.10 for XFS
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
From: "Darrick J. Wong via ltp" <ltp@lists.linux.it>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org,
 Allison Collins <allison.henderson@oracle.com>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 21, 2025 at 05:06:33PM +0100, Petr Vorel wrote:
> > On Fri, Mar 21, 2025 at 11:03:20AM +0100, Petr Vorel wrote:
> > > Test fails on XFS on kernel older than 5.10:
> 
> > >     # ./ioctl_ficlone03
> > > 	...
> > >     tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_ioc6ARHZ7/mnt fstyp=xfs flags=0
> > >     [   10.122070] XFS (loop0): Superblock has unknown incompatible features (0x8) enabled.
> 
> > 0x8 is XFS_SB_FEAT_INCOMPAT_BIGTIME, maybe you need to format with a set
> > of filesystem features compatible with 5.10?
> 
> > # mkfs.xfs -c options=/usr/share/xfsprogs/mkfs/lts_5.10.conf /dev/sda1
> 
> Yes, XFS_SB_FEAT_INCOMPAT_BIGTIME is what is missing for the test. Device is
> formatted with: -m reflink=1 (I'm sorry to not posting this before):

You could remove reflink=1 from the test specification, reflink has been
on by default for quite a while now...

> 
> tst_test.c:1170: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=1' extra opts=''
> 
> I thought it would imply XFS_SB_FEAT_INCOMPAT_BIGTIME, but when I tried to remove it
> it did not help:
> 
> tst_test.c:1909: TINFO: Tested kernel: 5.0.21-00005-gb6c47615d7bf #211 SMP Fri Mar 21 12:23:18 CET 2025 x86_64
> ...
> tst_test.c:1833: TINFO: === Testing on xfs ===
> tst_cmd.c:281: TINFO: Parsing mkfs.xfs version
> tst_test.c:1170: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1183: TINFO: Mounting /dev[   75.418676] XFS (loop0): Superblock has unknown incompatible features (0x8) enabled.
> /loop0 to /tmp/L[   75.419683] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
> TP_iocO8VAIk/mnt[   75.420629] XFS (loop0): SB validate failed with error -22.
>  fstyp=xfs flags=0
> tst_test.c:1183: TBROK: mount(/dev/loop0, mnt, xfs, 0, (nil)) failed: EINVAL (22)
> 
> Well, I tried with mkfs.xfs from openSUSE Leap 15.6 (tested via rapido-linux),
> probably the defaults add it.
> 
> $ mkfs.xfs -V
> mkfs.xfs version 6.7.0

...but mkfs.xfs 6.7 enables y2038 support by default unless you specify
otherwise, which is why it still won't mount.  Hence my suggestion to
use the config files if they're available.  If not, then either run
xfsprogs 5.10 on kernel 5.10, or create per-kernel xfs opts that
override the defaults to put them back down to whatever were the mkfs
defaults in 5.10.

> Also I noted that test works on our 5.3.18 based SLES15-SP2 with xfsprogs
> 4.15.0. Maybe I'm just wasting your time with wrong patch.

<shrug> QA configuration for a bunch of kernels is irritatingly hard,
we all need to compare notes when we can. :)

--D

> Kind regards,
> Petr
> 
> > --D
> 
> > >     [   10.123035] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
> > >     [   10.123916] XFS (loop0): SB validate failed with error -22.
> > >     tst_test.c:1183: TBROK: mount(/dev/loop0, mnt, xfs, 0, (nil)) failed: EINVAL (22)
> 
> > > This also causes Btrfs testing to be skipped due TBROK on XFS. With increased version we get on 5.4 LTS:
> 
> > >     # ./ioctl_ficlone03
> > >     tst_test.c:1904: TINFO: Tested kernel: 5.4.291 #194 SMP Fri Mar 21 10:18:02 CET 2025 x86_64
> > >     ...
> > >     tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> > >     tst_test.c:1833: TINFO: === Testing on xfs ===
> > >     tst_cmd.c:281: TINFO: Parsing mkfs.xfs version
> > >     tst_test.c:969: TCONF: The test requires kernel 5.10 or newer
> > >     tst_test.c:1833: TINFO: === Testing on btrfs ===
> > >     tst_test.c:1170: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> > >     [   30.143670] BTRFS: device fsid 1a6d250c-0636-11f0-850f-c598bdcd84c4 devid 1 transid 6 /dev/loop0
> > >     tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocjwzyal/mnt fstyp=btrfs flags=0
> > >     [   30.156563] BTRFS info (device loop0): using crc32c (crc32c-generic) checksum algorithm
> > >     [   30.157363] BTRFS info (device loop0): flagging fs with big metadata feature
> > >     [   30.158061] BTRFS info (device loop0): using free space tree
> > >     [   30.158620] BTRFS info (device loop0): has skinny extents
> > >     [   30.159911] BTRFS info (device loop0): enabling ssd optimizations
> > >     [   30.160652] BTRFS info (device loop0): checking UUID tree
> > >     ioctl_ficlone03_fix.c:49: TPASS: invalid source : EBADF (9)
> > >     ioctl_ficlone03_fix.c:55: TPASS: invalid source : EBADF (9)
> 
> > > Fixing commit is 29887a2271319 ("xfs: enable big timestamps").
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi all,
> 
> > > I suppose we aren't covering a test bug with this and test is really
> > > wrong expecting 4.16 would work on XFS. FYI this affects 5.4.291
> > > (latest 5.4 LTS which is still supported) and would not be fixed due a
> > > lot of missing functionality from 5.10.
> 
> > > Kind regards,
> > > Petr
> 
> > >  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > index 6a9d270d9f..e2ab10cba1 100644
> > > --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > @@ -113,7 +113,7 @@ static struct tst_test test = {
> > >  		{.type = "bcachefs"},
> > >  		{
> > >  			.type = "xfs",
> > > -			.min_kver = "4.16",
> > > +			.min_kver = "5.10",
> > >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> > >  		},
> > > -- 
> > > 2.47.2
> 
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
