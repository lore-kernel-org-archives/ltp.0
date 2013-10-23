Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYxfc-0003lM-Ca
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 12:36:16 +0000
Date: Wed, 23 Oct 2013 14:35:58 +0200
From: chrubis@suse.cz
Message-ID: <20131023123557.GA24275@rei.Home>
References: <010c01cecf9e$f1e915d0$d5bb4170$@gyu.kim@lge.com>
	<20131023105447.GA23369@rei.Home>
	<015c01cecfe8$20e2cd60$62a86820$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <015c01cecfe8$20e2cd60$62a86820$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH v2] getcontext01: fix to check libc version for ARM
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
To: Honggyu Kim <hong.gyu.kim@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> You're right.
> Current getcontext returns -1 after setting errno as ENOSYS.
> The solution has become easier and simpler. I just tested and verified it.
> 
> I will submit a new patch soon after changing the title and commit messages.
> If you think that we need a feature for libc version comparison for the
> future usage, I will submit it too as an extra patch.

I tend not to add functiontality that is not used (as that only adds
unneded complexity and code that will break sooner or later). So let's
go just with the errno == ENOSYS patch fow now.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
