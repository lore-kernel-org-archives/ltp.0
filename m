Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YDZTQ-0007JO-7m
	for ltp-list@lists.sourceforge.net; Tue, 20 Jan 2015 14:08:04 +0000
Date: Tue, 20 Jan 2015 15:07:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150120140704.GA15452@rei>
References: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8593d893c637eadbac85711428be570e2636ef38.1421761305.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] runltp: export initialized LTP_DEV
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, liwan@redhat.com

> commit 5c7c3fb219957484db92111d423e4e2553fb580b removed initialization
> of empty LTP_DEV from setup(), but it also caused that LTP_DEV
> is no longer exported when it's initialized in set_block_device().
> 
> This causes every test to attempt to get loop device on its own,
> which is not necessary and it also makes tests sporadically fail with EBUSY:
>   creat06     9  TBROK  :  tst_device.c:156: ioctl(/dev/loop1, LOOP_CLR_FD, 0) failed: EBUSY
>   creat06    10  TBROK  :  tst_device.c:156: Remaining cases broken
> 
> The cause of EBUSY is unknown. Cyril suggested it might be gvfsd-trash,
> however I don't have such process and still get the failures sporadically.

The EBUSY I've seen was from umount() rather that from ioctl() and was
caused by stat() from gvfsd-trash. I'm sure of it.

In that case one of the testcases fails to umount the device as:

acct01      0  TWARN  :  acct01.c:225: umount device:/dev/loop1 failed: errno=EBUSY(16): Device or resource busy

I've never seen EBUSY from the ioctl() that removes the loop device,
that looks like a kernel bug to me.

> This patch restores behavior from ltp-20140828, where LTP_DEV is exported
> and tst_acquire_device() will use that instead of trying to acquire/release
> loopdev on its own.

That wouldn't do because that breaks the exectuion when device was not
passed to runltp. What about exporting it but only when it's non-empty?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
