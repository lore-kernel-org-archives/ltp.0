Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D26E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733737780; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ilXQusO7yAozQgtw63mcEX2ZOocjZoCv6x64AhXFF6Q=;
 b=TlSCMdVS/7svrc2IxHZlSyUwXr3m4NDFfu4vX6bMyoUmXGwUzI2z2tf949dB9qzR/36Vx
 ZuXL2o+r8ujjz+UJ3ten5LzBMEcVnrtlBrPREktHXhm3LzgPHLLdsgbLR2llUXTdNH2hTd9
 ivbFzEigdmPBL9ZS8Nn9LMzJDowjw6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C0D03E6584
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 10:49:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86D893E6584
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 10:49:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=zlang@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A702B1A0238A
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 10:49:17 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9398A5C4323;
 Mon,  9 Dec 2024 09:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299DDC4CED1;
 Mon,  9 Dec 2024 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733737754;
 bh=u8Cd12/TMbjiaXBHWRxFcN8fIB8hlGZD9DP89axi9vQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o2OLcEusFZXjuMgRVx2x5NpbahWGUUrF75ZWgFgFTPp52UytkuYvWsBdOnYRgX0x6
 CwA/tuBfXIylZ4uHqG9SI09+3k3ercFGh2QRB4M5d+3pXPBk0CwB1eg0J51pNLzKwj
 7AiUq0tEWrprEpaEG+5bJ5KlXU80VORYS7rYxA6F5ZJJiquz7vj+g9w6i3gHDzrZLv
 vpZfJuIeeVojffx0ZqCy8gSFmF/OqJz7Qeve5NUUgOEYCILJGx9lCTKdJnyTAcCCrp
 OXK6686ObDrmwa/q0dZt2tq6nbzn7eEbWK9f/GQXNgUUe/c4vE2ussGsBZhX2ZAI40
 eJ9qdYCSIfBNA==
Date: Mon, 9 Dec 2024 17:49:11 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20241209094911.ugpcoshtuj5l2n25@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241209061416.GB180329@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241209061416.GB180329@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 09, 2024 at 07:14:16AM +0100, Petr Vorel wrote:
> > On Mon, Dec 02, 2024 at 03:42:08PM +0100, Petr Vorel wrote:
> > > > Hi!
> > > > > The code to skip filesystems in the case of all filesystems is in the
> > > > > run_tcase_per_fs() function:
> 
> > > > > static int run_tcases_per_fs(void)
> > > > > {
> > > > >         int ret = 0;
> > > > >         unsigned int i;
> > > > >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
> 
> > > > > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > > > > function which filters out them.
> 
> > > > Perhaps you mean that the skiplist does not work with .all_filesystems
> > > > _and_ the LTP_SINGLE_FS_TYPE environment variable?
> 
> > > > I guess that we need:
> 
> > > > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > > > index bbbb8df19..49b1d7205 100644
> > > > --- a/lib/tst_supported_fs_types.c
> > > > +++ b/lib/tst_supported_fs_types.c
> > > > @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
> 
> > > >         if (only_fs) {
> > > >                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > > > +
> > > > +               if (tst_fs_in_skiplist(only_fs, skiplist))
> > > > +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> > > > +
> 
> > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > be skipped without need to manually enable the filesystem and recompile.
> > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > Therefore I would avoid this.
> 
> > > @Zorro Lang or are you testing whole syscalls on particular filesystem via
> > > LTP_SINGLE_FS_TYPE=xfs ?
> 
> > Oh, yes, I always use LTP with different LTP_SINGLE_FS_TYPE. So that's might be
> > the problem?
> 
> Thanks for confirming your use case.
> 
> Well, "Testing only" in the help (-h) was added there to suggest it's for
> testing/debugging LTP, not a production testing. But newer mind, I'll implement
> Cyril's suggestion, real usage justify it. + I'll add LTP_FORCE_SINGLE_FS_TYPE.
> 
> We could allow more filesystems, e.g.  instead of running LTP few times with
> different LTP_SINGLE_FS_TYPE value: e.g.
> 
> for fs in ext4 xfs btrfs; do LTP_SINGLE_FS_TYPE=fs ioctl_ficlone02; done
> 
> we could introduce support for particular filesystems
> LTP_FILESYSTEMS="ext4,xfs,btrfs" ioctl_ficlone02
> 
> (Probably define new variable because "SINGLE" is misleading when supporting
> more filesystems. Also when we touch it, I would consider renaming variable
> FILESYSTEMS is more obvious for newcomers than "FS_TYPE".)
> 
> WDYT?

I generally mount a known filesystem on /mnt/ltpdir, and specify "-d /mnt/ltpdir"
(to be TMPDIR). Then set (export)
  LTP_SINGLE_FS_TYPE
  LTP_DEV_FS_TYPE
  LTP_BIG_DEV_FS_TYPE
to be the same fs with the one mounted on $TMPDIR. Then run ltp more likes:

  for cmdfile in fs fs_perms_simple syscalls fs_bind fsx mm commands fcntl-locktests fs_readonly ipc io containers cve smoketest syscalls-ipc dio ltp-aiodio.part1 ltp-aiodio.part2 ltp-aiodio.part3 ltp-aiodio.part4 ltp-aio-stress; do
	runltp  -p -d /mnt/ltpdir -b /dev/loop0 -B xfs -z /dev/loop1 -Z xfs -f $cmdfile ...
  done

I do this to test each filesystem in different test jobs. Each test job test one fs.
I think that might make sure all system calls/IOs test on same filesystem, no matter
on TMPDIR or someone device. Am I right? Or I missunderstand something?

Thanks,
Zorro

> 
> Kind regards,
> Petr
> 
> > Thanks,
> > Zorro
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
