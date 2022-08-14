Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B9AC25B06
	for <ltp@archiver.kernel.org>; Sun, 14 Aug 2022 22:45:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F03993C9641
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 00:44:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09353C0780
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 00:44:48 +0200 (CEST)
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au
 [211.29.132.249])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 5C241680E37
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 00:44:46 +0200 (CEST)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au
 [49.181.193.158])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 23B8610E874E;
 Mon, 15 Aug 2022 08:44:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1oNMLY-00DAwR-OG; Mon, 15 Aug 2022 08:44:40 +1000
Date: Mon, 15 Aug 2022 08:44:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20220814224440.GR3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvZc+jvRdTLn8rus@pevik> <YvZUfq+3HYwXEncw@pevik>
 <YvZTpQFinpkB06p9@pevik>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62f97adc
 a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
 a=RqjhzPdQHaDuyD3YeBEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 12, 2022 at 03:20:37PM +0200, Petr Vorel wrote:
> Hi all,
> 
> LTP test df01.sh found different size of loop device in v5.19.
> Test uses loop device formatted on various file systems, only XFS fails.
> It randomly fails during verifying that loop size usage changes:
> 
> grep ${TST_DEVICE} output | grep -q "${total}.*${used}" [1]
> 
> How to reproduce:
> # PATH="/opt/ltp/testcases/bin:$PATH" df01.sh -f xfs # it needs several tries to hit
> 
> df saved output:
> Filesystem     1024-blocks    Used Available Capacity Mounted on
> ...
> /dev/loop0          256672   16208    240464       7% /tmp/LTP_df01.1kRwoUCCR7/mntpoint
> df output:
> Filesystem     1024-blocks    Used Available Capacity Mounted on
> ...
> tmpfs               201780       0    201780       0% /run/user/0
> /dev/loop0          256672   15160    241512       6% /tmp/LTP_df01.1kRwoUCCR7/mntpoint
> => different size
> df01 4 TFAIL: 'df -k -P' failed, not expected.

Yup, most likely because we changed something in XFS related to
internal block reservation spaces. That is, the test is making
fundamentally flawed assumptions about filesystem used space
accounting.

It is wrong to assuming that the available capacity of a given empty
filesystem will never change.  Assumptions like this have been
invalid for decades because the available space can change based on
the underlying configuration or the filesystem. e.g. different
versions of mkfs.xfs set different default parameters and so simply
changing the version of xfsprogs you use between the two comparision
tests will make it fail....

And, well, XFS also has XFS_IOC_{GS}ET_RESBLKS ioctls that allow
userspace to change the amount of reserved blocks. They were
introduced in 1997, and since then we've changed the default
reservation the filesystem takes at least a dozen times.

> > It might be a false positive / bug in the test, but it's at least a changed behavior.

Yup, any test that assumes "available space" does not change from
kernel version to kernel version is flawed. There is no guarantee
that this ever stays the same, nor that it needs to stay the same.

> > I was able to reproduce it on v5.19 distro kernels (openSUSE, Debian).
> > I haven't bisected (yet), nor checked Jens' git tree (maybe it has been fixed).
> 
> Forget to note dmesg "operation not supported error" warning on *each* run (even
> successful) on affected v5.19:
> [ 5097.594021] loop0: detected capacity change from 0 to 524288
> [ 5097.658201] operation not supported error, dev loop0, sector 262192 op 0x9:(WRITE_ZEROES) flags 0x8000800 phys_seg 0 prio class 0
> [ 5097.675670] XFS (loop0): Mounting V5 Filesystem
> [ 5097.681668] XFS (loop0): Ending clean mount
> [ 5097.956445] XFS (loop0): Unmounting Filesystem

That warning is from mkfs attempting to use fallocate(ZERO_RANGE) to
offload the zeroing of the journal to the block device. It would
seem that the loop device image file is being hosted on a filesystem
that does not support the fallocate() ZERO_RANGE (or maybe
PUNCH_HOLE) operation. That warning should simply be removed - it
serves no useful purpose to a user...

CHeers,

Dave.

-- 
Dave Chinner
david@fromorbit.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
