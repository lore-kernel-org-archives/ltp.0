Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYgD0-0005qg-IJ
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 17:57:34 +0000
Date: Tue, 22 Oct 2013 19:57:16 +0200
From: chrubis@suse.cz
Message-ID: <20131022175716.GC7753@rei>
References: <CA+rVjkCwd4O6sEg7426VohDqrm1yTdyQd9L0Bg=_Xi5dNiZU_w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+rVjkCwd4O6sEg7426VohDqrm1yTdyQd9L0Bg=_Xi5dNiZU_w@mail.gmail.com>
Subject: Re: [LTP] Test suite for the t-core kernel patch
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
To: C N <linuxsnail@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Is there any plan for removal of t-core test case?
> 
> Please ref:
> http://sourceforge.net/p/ltp/mailman/message/31006567/

Thanks for reminding. I've just pushed a patch that removes the testcase
to git.

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
