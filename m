Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWVVP-0006R0-JD
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 18:07:35 +0000
Date: Wed, 16 Oct 2013 20:07:21 +0200
From: chrubis@suse.cz
Message-ID: <20131016180721.GB21437@rei.suse.cz>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131015133036.GB25867@rei> <525E61D0.7030704@oracle.com>
	<20131016104712.GA24451@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131016104712.GA24451@rei.Home>
Subject: Re: [LTP] controllers/cpuset: promised patches
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> > I suppose cleanup() function doesn't perform normally. Since it has many 
> > '> /dev/null 2>&1' you didn't see any errors on the screen.
> 
> That is likely.
> 
> And after I've rebooted the machine, the tests seems to run fine (the setup is
> no longer commented).
> 
> I think that the problem is that the cleanup() is not able to cope with the
> /dev/cpuset directory left out after killed cpuset01 test. I will look into
> this.

The problem was caused by a cpuset01 child that was still there in
cpuset named '1', which couldn't be deleted because the proces was still
running... And that interfered with the testing.

The reason why the cleanup fails is that cpuset is not included in the
output from mount (not present in /etc/mtab at all). This is easy to
fix, we just need to use /proc/mounts instead. But even after that the
loop that kills the processes does not work right, there is a race
between the processes to be killed and the umount after the loop, but
kill -9 fixes that...

Otherwise than that I've managed to run the tests several times and
apart from a few failures in memory, memory_presure and hotplug that
needs to be taken care of, it seems to run fine.

I will push your patches tomorrow and add my fixes as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
