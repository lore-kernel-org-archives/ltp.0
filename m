Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XoC8q-0005Qs-1D
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 14:09:56 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1D537AB07
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Nov 2014 14:09:48 +0000 (UTC)
Date: Tue, 11 Nov 2014 15:09:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111140917.GB32196@rei>
References: <1415639518-4906-1-git-send-email-jack@suse.cz>
	<20141111121345.GA29189@rei> <20141111135224.GE10456@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141111135224.GE10456@quack.suse.cz>
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify: Verify that inode ignore
 masks are properly reflected
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > Verify that when inode has an ignore mask set, it is properly reflected
> > > when notifying a mountpoint. The test verifies fix "fanotify: Fix notification
> > > of groups with inode & mount marks" in the Linux kernel.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > Pushed with small change to get rid of another signed vs unsigned
> > comparsion warning.
>   Yeah. BTW those warnings are pretty annoying and the number of false
> positives is IHMO too large for the warning to be useful...

Well they come with the gcc -W flag (nowadays called -Wextra). We may be
able to disable these with -Wno-sign-compare but don't want to play
whack a mole trying to figure out which warnings are useful. I doubt
that this is worth the effort and since we do not use -Werror these are
just mildly annoying. Or do you have a better idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
