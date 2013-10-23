Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYw5j-0005dI-39
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 10:55:07 +0000
Date: Wed, 23 Oct 2013 12:54:47 +0200
From: chrubis@suse.cz
Message-ID: <20131023105447.GA23369@rei.Home>
References: <010c01cecf9e$f1e915d0$d5bb4170$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <010c01cecf9e$f1e915d0$d5bb4170$@gyu.kim@lge.com>
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
> getcontext function is implemented from libc-2.17 in ARM.
> Currently, getcontext01 goes to TFAIL because getcontext just 
> returns -1 in the previous libc for ARM.
> This patch makes getcontext01 as TCONF when libc version is less 
> than 2.17.

Does the setcontext() set errno to ENOSYS after the failure? If so it
would be much easier (and more general solution) to just add a test for
errno == ENOSYS and return TCONF if so.

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
