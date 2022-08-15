Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E39CC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:31:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6843C95F9
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:31:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EDC33C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:31:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2095600723
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:31:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3B4B20134;
 Mon, 15 Aug 2022 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660555900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5h+6dMJXLvTUhDdgYsCYGE7DqfaiThyuBXafm3lVxnk=;
 b=psJt9Ek0Mz6wTogTcV2x4KyVeR5jUkh7Ddsmp80L0+m8lbvb8m26j4Rh91pYtO7oV5dw6C
 NPKyHtrJAJ990nI1PifeWLtdJyyw4As6NZa1O4Ktyl7lejv1s06CnrUIQlA4OGNrllFEIW
 pUAuIR5uZz+rsWcqb5ynh/chHvomIkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660555900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5h+6dMJXLvTUhDdgYsCYGE7DqfaiThyuBXafm3lVxnk=;
 b=gSY3g1TpOIVFTT+Sp3UoBhTUnI33ePw+tJXSno2WTdLB9uVK6dqh0zM6WC+XSKFYp38QEX
 cSZkSX5WlB1KZOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90D8D13A93;
 Mon, 15 Aug 2022 09:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id i8EqIXsS+mKCWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 09:31:39 +0000
Date: Mon, 15 Aug 2022 11:31:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <YvoSeTmLoQVxq7p9@pevik>
References: <YvZc+jvRdTLn8rus@pevik> <YvZUfq+3HYwXEncw@pevik>
 <YvZTpQFinpkB06p9@pevik>
 <20220814224440.GR3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220814224440.GR3600936@dread.disaster.area>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP test df01.sh detected different size of loop device
 in v5.19
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dave,

> On Fri, Aug 12, 2022 at 03:20:37PM +0200, Petr Vorel wrote:
> > Hi all,

> > LTP test df01.sh found different size of loop device in v5.19.
> > Test uses loop device formatted on various file systems, only XFS fails.
> > It randomly fails during verifying that loop size usage changes:

> > grep ${TST_DEVICE} output | grep -q "${total}.*${used}" [1]

> > How to reproduce:
> > # PATH="/opt/ltp/testcases/bin:$PATH" df01.sh -f xfs # it needs several tries to hit

> > df saved output:
> > Filesystem     1024-blocks    Used Available Capacity Mounted on
> > ...
> > /dev/loop0          256672   16208    240464       7% /tmp/LTP_df01.1kRwoUCCR7/mntpoint
> > df output:
> > Filesystem     1024-blocks    Used Available Capacity Mounted on
> > ...
> > tmpfs               201780       0    201780       0% /run/user/0
> > /dev/loop0          256672   15160    241512       6% /tmp/LTP_df01.1kRwoUCCR7/mntpoint
> > => different size
> > df01 4 TFAIL: 'df -k -P' failed, not expected.

> Yup, most likely because we changed something in XFS related to
> internal block reservation spaces. That is, the test is making
> fundamentally flawed assumptions about filesystem used space
> accounting.

> It is wrong to assuming that the available capacity of a given empty
> filesystem will never change.  Assumptions like this have been
> invalid for decades because the available space can change based on
> the underlying configuration or the filesystem. e.g. different
> versions of mkfs.xfs set different default parameters and so simply
> changing the version of xfsprogs you use between the two comparision
> tests will make it fail....

> And, well, XFS also has XFS_IOC_{GS}ET_RESBLKS ioctls that allow
> userspace to change the amount of reserved blocks. They were
> introduced in 1997, and since then we've changed the default
> reservation the filesystem takes at least a dozen times.

Thanks a lot for valuable info.

> > > It might be a false positive / bug in the test, but it's at least a changed behavior.

> Yup, any test that assumes "available space" does not change from
> kernel version to kernel version is flawed. There is no guarantee
> that this ever stays the same, nor that it needs to stay the same.
I'm sorry I was not clear. Test [1] does not measure "available space" between
kernel releases. It just run df command with parameters, saves it's output
and compares "1024-blocks" and "Used" columns of df output with stat output:

		local total=$(stat -f mntpoint --printf=%b)
		local free=$(stat -f mntpoint --printf=%f)
		local used=$((total-free))

		local bsize=$(stat -f mntpoint --printf=%s)
		total=$((($total * $bsize + 512)/ 1024))
		used=$((($used * $bsize + 512) / 1024))

And comparison with "$used" is what sometimes fails.

BTW this happens on both distros when loop device is on tmpfs. I'm trying to
trigger it on ext4 and btrfs, not successful so far. Looks like it's tmpfs
related.

If that's really expected, we might remove this check for used for XFS
(not sure if check only for total makes sense).

> > > I was able to reproduce it on v5.19 distro kernels (openSUSE, Debian).
> > > I haven't bisected (yet), nor checked Jens' git tree (maybe it has been fixed).

> > Forget to note dmesg "operation not supported error" warning on *each* run (even
> > successful) on affected v5.19:
> > [ 5097.594021] loop0: detected capacity change from 0 to 524288
> > [ 5097.658201] operation not supported error, dev loop0, sector 262192 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> > [ 5097.675670] XFS (loop0): Mounting V5 Filesystem
> > [ 5097.681668] XFS (loop0): Ending clean mount
> > [ 5097.956445] XFS (loop0): Unmounting Filesystem

> That warning is from mkfs attempting to use fallocate(ZERO_RANGE) to
> offload the zeroing of the journal to the block device. It would
> seem that the loop device image file is being hosted on a filesystem
> that does not support the fallocate() ZERO_RANGE (or maybe
> PUNCH_HOLE) operation. That warning should simply be removed - it
> serves no useful purpose to a user...
Interesting. Which one of these two is not supported on tmpfs?

Kind regards,
Petr

> CHeers,

> Dave.

[1] https://github.com/linux-test-project/ltp/blob/f42f6f3b4671f447b743afe8612917ba4362b8a6/testcases/commands/df/df01.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
