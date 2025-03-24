Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0BC36002
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 11:33:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4D333C91B2
	for <ltp@archiver.kernel.org>; Mon, 24 Mar 2025 12:33:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422313C1008
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 12:33:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FAC4600D5A
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 12:33:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 323C51F38C;
 Mon, 24 Mar 2025 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742815982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4Ee+0ED0/MIsOBAmD+9Bgdn7KSEbAKXU+UdpTeh0sY=;
 b=rF5G5u5oBu2vtI3BpokXtkTko31uw+Mbl9Fa+eKxmmnnnxk4NetsQVl740TQ0fiGz6PVz8
 cREo6DSoZAJNN5/XCr7xUNUHcqFqv05OSO6+SebRrSTDTs59ysIqvH6MKYyO83ONOlt0u/
 dETomakkFTz5CxqQk4sls1B/t83OuU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742815982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4Ee+0ED0/MIsOBAmD+9Bgdn7KSEbAKXU+UdpTeh0sY=;
 b=HtN/dsSdzINSqhocWTcDwRpuV0OgWn7gv7F4H1lA354UCNHbrNrntuErES+i91h55+yxXH
 FSVSf9VbE/V+Y+Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742815982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4Ee+0ED0/MIsOBAmD+9Bgdn7KSEbAKXU+UdpTeh0sY=;
 b=rF5G5u5oBu2vtI3BpokXtkTko31uw+Mbl9Fa+eKxmmnnnxk4NetsQVl740TQ0fiGz6PVz8
 cREo6DSoZAJNN5/XCr7xUNUHcqFqv05OSO6+SebRrSTDTs59ysIqvH6MKYyO83ONOlt0u/
 dETomakkFTz5CxqQk4sls1B/t83OuU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742815982;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4Ee+0ED0/MIsOBAmD+9Bgdn7KSEbAKXU+UdpTeh0sY=;
 b=HtN/dsSdzINSqhocWTcDwRpuV0OgWn7gv7F4H1lA354UCNHbrNrntuErES+i91h55+yxXH
 FSVSf9VbE/V+Y+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 446D1137AC;
 Mon, 24 Mar 2025 11:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nwKJC+1C4WfHDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Mar 2025 11:33:01 +0000
Date: Mon, 24 Mar 2025 12:32:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <20250324113259.GA205363@pevik>
References: <20250321100320.162107-1-pvorel@suse.cz>
 <20250321152358.GK2803749@frogsfrogsfrogs>
 <20250321160633.GA177324@pevik>
 <20250321161846.GM2803749@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250321161846.GM2803749@frogsfrogsfrogs>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,redhat.com,suse.cz,suse.com,oracle.com,gmail.com,lst.de,vger.kernel.org];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-xfs@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org,
 Allison Collins <allison.henderson@oracle.com>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Darrick, all,

> On Fri, Mar 21, 2025 at 05:06:33PM +0100, Petr Vorel wrote:
> > > On Fri, Mar 21, 2025 at 11:03:20AM +0100, Petr Vorel wrote:
> > > > Test fails on XFS on kernel older than 5.10:

> > > >     # ./ioctl_ficlone03
> > > > 	...
> > > >     tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_ioc6ARHZ7/mnt fstyp=xfs flags=0
> > > >     [   10.122070] XFS (loop0): Superblock has unknown incompatible features (0x8) enabled.

> > > 0x8 is XFS_SB_FEAT_INCOMPAT_BIGTIME, maybe you need to format with a set
> > > of filesystem features compatible with 5.10?

> > > # mkfs.xfs -c options=/usr/share/xfsprogs/mkfs/lts_5.10.conf /dev/sda1

> > Yes, XFS_SB_FEAT_INCOMPAT_BIGTIME is what is missing for the test. Device is
> > formatted with: -m reflink=1 (I'm sorry to not posting this before):

> You could remove reflink=1 from the test specification, reflink has been
> on by default for quite a while now...

Thanks for a hint. I guess reflink was added in a5132d9b [1] in v4.9.0-rc1 with
default 0 and updated to default 1 in 23069a93 [2] in v4.11.0-rc2.
Unfortunately we still support testing current LTP with kernel up to old 4.4,
therefore we need to keep this until we raise the support to kernel >= 4.11.

[1] https://web.git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=a5132d9b3634fb6436d1f06642ceda82e64ea2f5
[2] https://web.git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/commit/?id=23069a9353eb8af30f3427feed6c92380d025a53

> > tst_test.c:1170: TINFO: Formatting /dev/loop0 with xfs opts='-m reflink=1' extra opts=''

> > I thought it would imply XFS_SB_FEAT_INCOMPAT_BIGTIME, but when I tried to remove it
> > it did not help:

> > tst_test.c:1909: TINFO: Tested kernel: 5.0.21-00005-gb6c47615d7bf #211 SMP Fri Mar 21 12:23:18 CET 2025 x86_64
> > ...
> > tst_test.c:1833: TINFO: === Testing on xfs ===
> > tst_cmd.c:281: TINFO: Parsing mkfs.xfs version
> > tst_test.c:1170: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > tst_test.c:1183: TINFO: Mounting /dev[   75.418676] XFS (loop0): Superblock has unknown incompatible features (0x8) enabled.
> > /loop0 to /tmp/L[   75.419683] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
> > TP_iocO8VAIk/mnt[   75.420629] XFS (loop0): SB validate failed with error -22.
> >  fstyp=xfs flags=0
> > tst_test.c:1183: TBROK: mount(/dev/loop0, mnt, xfs, 0, (nil)) failed: EINVAL (22)

> > Well, I tried with mkfs.xfs from openSUSE Leap 15.6 (tested via rapido-linux),
> > probably the defaults add it.

> > $ mkfs.xfs -V
> > mkfs.xfs version 6.7.0

> ...but mkfs.xfs 6.7 enables y2038 support by default unless you specify
> otherwise, which is why it still won't mount.  Hence my suggestion to
> use the config files if they're available.  If not, then either run
> xfsprogs 5.10 on kernel 5.10, or create per-kernel xfs opts that
> override the defaults to put them back down to whatever were the mkfs
> defaults in 5.10.

Yeah. For bisecting next time I'll tweak LTP to use config file.  I see you
started with 4.19 to support these configs in repo [3] end even install them
/usr/share/xfsprogs/mkfs/. Great. I just need to pass a correct file.

BTW it'd be nice to have way to mkfs.xfs to print this file under new getopt.

[3] https://web.git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/tree/mkfs

> > Also I noted that test works on our 5.3.18 based SLES15-SP2 with xfsprogs
> > 4.15.0. Maybe I'm just wasting your time with wrong patch.

> <shrug> QA configuration for a bunch of kernels is irritatingly hard,
> we all need to compare notes when we can. :)

Thanks!

Kind regards,
Petr

> --D

> > Kind regards,
> > Petr

> > > --D

> > > >     [   10.123035] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
> > > >     [   10.123916] XFS (loop0): SB validate failed with error -22.
> > > >     tst_test.c:1183: TBROK: mount(/dev/loop0, mnt, xfs, 0, (nil)) failed: EINVAL (22)

> > > > This also causes Btrfs testing to be skipped due TBROK on XFS. With increased version we get on 5.4 LTS:

> > > >     # ./ioctl_ficlone03
> > > >     tst_test.c:1904: TINFO: Tested kernel: 5.4.291 #194 SMP Fri Mar 21 10:18:02 CET 2025 x86_64
> > > >     ...
> > > >     tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> > > >     tst_test.c:1833: TINFO: === Testing on xfs ===
> > > >     tst_cmd.c:281: TINFO: Parsing mkfs.xfs version
> > > >     tst_test.c:969: TCONF: The test requires kernel 5.10 or newer
> > > >     tst_test.c:1833: TINFO: === Testing on btrfs ===
> > > >     tst_test.c:1170: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> > > >     [   30.143670] BTRFS: device fsid 1a6d250c-0636-11f0-850f-c598bdcd84c4 devid 1 transid 6 /dev/loop0
> > > >     tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocjwzyal/mnt fstyp=btrfs flags=0
> > > >     [   30.156563] BTRFS info (device loop0): using crc32c (crc32c-generic) checksum algorithm
> > > >     [   30.157363] BTRFS info (device loop0): flagging fs with big metadata feature
> > > >     [   30.158061] BTRFS info (device loop0): using free space tree
> > > >     [   30.158620] BTRFS info (device loop0): has skinny extents
> > > >     [   30.159911] BTRFS info (device loop0): enabling ssd optimizations
> > > >     [   30.160652] BTRFS info (device loop0): checking UUID tree
> > > >     ioctl_ficlone03_fix.c:49: TPASS: invalid source : EBADF (9)
> > > >     ioctl_ficlone03_fix.c:55: TPASS: invalid source : EBADF (9)

> > > > Fixing commit is 29887a2271319 ("xfs: enable big timestamps").

> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > > Hi all,

> > > > I suppose we aren't covering a test bug with this and test is really
> > > > wrong expecting 4.16 would work on XFS. FYI this affects 5.4.291
> > > > (latest 5.4 LTS which is still supported) and would not be fixed due a
> > > > lot of missing functionality from 5.10.

> > > > Kind regards,
> > > > Petr

> > > >  testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)

> > > > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > > index 6a9d270d9f..e2ab10cba1 100644
> > > > --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> > > > @@ -113,7 +113,7 @@ static struct tst_test test = {
> > > >  		{.type = "bcachefs"},
> > > >  		{
> > > >  			.type = "xfs",
> > > > -			.min_kver = "4.16",
> > > > +			.min_kver = "5.10",
> > > >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > > >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> > > >  		},
> > > > -- 
> > > > 2.47.2




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
