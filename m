Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYzHt-0001Vr-0d
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 14:19:53 +0000
Date: Wed, 23 Oct 2013 16:19:37 +0200
From: chrubis@suse.cz
Message-ID: <20131023141936.GA25456@rei.Home>
References: <000001cecffa$34dbd980$9e938c80$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000001cecffa$34dbd980$9e938c80$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH v4] getcontext01: check getcontext function in libc
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
> getcontext function is implemented depends on libc version and arch.
> Some libc version for specific arch does not implement getcontext yet.
> In that case, getcontext just sets errno to ENOSYS and returns -1.
> For example, getcontext is not implemented before libc-2.17 in ARM.
> Current test goes to TFAIL when lower version of libc is used in ARM.
> 
> This patch sets the test as TCONF if libc does not implement getcontext.
> If ENOSYS is not set and -1 is returned, it goes to TFAIL as it was.
> 

I've pushed this patch, with unwrapped line and minus the Change-Id in
the commit message. And added my patch that cleans up the source a bit
on the top of it. Thanks.

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
