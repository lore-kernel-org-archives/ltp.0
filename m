Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C54C77B7F
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 16:32:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43A573CB8F4
	for <ltp@archiver.kernel.org>; Wed,  3 May 2023 18:32:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9067D3CB18B
 for <ltp@lists.linux.it>; Wed,  3 May 2023 18:32:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 272C11A00163
 for <ltp@lists.linux.it>; Wed,  3 May 2023 18:32:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 260CD22A42;
 Wed,  3 May 2023 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683131546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqWQbmpDQ7Kdq3TitS9eCIKzWUIIzk8rpLNgCNA+VxA=;
 b=OHmtBYL0GeBF1PrsAbL5p7xY/HLPzi+nHEuJzPh3NQXnsd0kTFzug4MIT/pZOK7kfGiwc2
 xLhjln+mCeKRIquzCwMNwaWCcR4dFTDlVm/auLVrqLlEVvKh3HGJkwf6nNhsNAWUMtCzYu
 DxAbMVOXVACaH+2VLYOhbywVnVS2zQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683131546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqWQbmpDQ7Kdq3TitS9eCIKzWUIIzk8rpLNgCNA+VxA=;
 b=7Ab/Y+r48PGPebE+VgC53V/iNhjeHDHW2o/VAa6LzzOGlQC81CtWnVAxDEh6Fj7B6ebALT
 l84B7Ga4JkiFO7Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04BD61331F;
 Wed,  3 May 2023 16:32:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rpv7OpmMUmQ3CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 May 2023 16:32:25 +0000
Date: Wed, 3 May 2023 18:32:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230503163239.GA3762958@pevik>
References: <ZEjsKC6ESB1+mM0H@rei> <20230502143711.GA3665733@pevik>
 <20230502151457.GA3677937@pevik> <ZFIq0CnSCS0jp8dE@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFIq0CnSCS0jp8dE@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > * nfs08.sh: Skip on vfat
> > https://patchwork.ozlabs.org/project/ltp/patch/20230502151348.3677809-1-pvorel@suse.cz/

> This is workaround for bugs found by the "run nfs on all fs" patch,
> right?

Well, this is the problem which was found by this patchset. If you use TMPDIR
with vfat or exfat (unlikely, I know) on current master, it will fail.
I tested it on both loop device (demonstrated below) and on separate disc in VM.

dd if=/dev/zero of=/tmp/dev bs=1M count=500
losetup /dev/loop0 /tmp/dev
mkfs.exfat /dev/loop0
mkdir -p /export
mount /dev/loop0 /export
df -hT /export/
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/loop0     vfat  500M     0  500M   0% /export

PATH="/opt/ltp/testcases/bin:$PATH" TMPDIR=/export nfs08.sh -v 4 -t tcp
...
nfs08 1 TINFO: timeout per run is 0h 5m 0s
nfs08 1 TINFO: mount.nfs: (linux nfs-utils 2.6.3)
nfs08 1 TINFO: setup NFSv4, socket type tcp
nfs08 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4 10.0.0.2:/export/LTP_nfs08.R9JOL8zozk/4/tcp /export/LTP_nfs08.R9JOL8zozk/4/0
nfs08 1 TINFO: testing NFS cache invalidation for directories
1
nfs08 1 TPASS: ls | grep 1 passed as expected
nfs08 1 TFAIL: ls | grep 2 failed unexpectedly

Actually, nfs08.sh not working on vfat and exfat
=> therefore nfs_lib.sh should be without TST_SKIP_FILESYSTEMS (currently all tests whitelists exfat)
and nfs08.sh should have: TST_SKIP_FILESYSTEMS="exfat,vfat"

umount /export
umount: /export: target is busy.

fuser -vm /dev/loop0
                     USER        PID ACCESS COMMAND
/dev/loop0:          root     kernel mount /export
                     root     kernel knfsd /export

=> Forced me to umount with -l or reboot, regardless used filesystem on
/dev/loop0.  This is fixed in this patchset which uses TST_ALL_FILESYSTEMS,
but I'd prefer to merge it instead of fixing master.

This is reproducible even if I just add new device (i.e. not a loop device) to VM.

> I suppose that it may be better not to enable nfs on all filesystems for
> this release so that we have time to figure out what is wrong before
> next release.

> I really do not like applying "temporary" workarounds for real bugs in
> the LTP codebase. There is always danger of "temporary" being forgotten
> and we end up masking the real bug for eternity.

We're masking the problems, because by default we test on what's on /tmp
(often tmpfs, which is unlikely to be used for NFS or ext4 or btrfs).

I need to test more old distros, I suspect that nfs-utils 1.3.3 has problems
with vfat, exfat, tmpfs and fuse, which is in Debian 11 (bullseye).

=> Maybe, as a start we could decide to run nfs_lib.sh only on modern linux
filesystems: i.e. btrfs, ext4, xfs
We could have:
TST_SKIP_FILESYSTEMS="btrfs,exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
That would shorten the runtime and have more test coverage.
WDYT? I'm about to send v5 and run tests in the loop. Shell I include this
change?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
