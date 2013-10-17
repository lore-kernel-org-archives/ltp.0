Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWmwv-0007Jl-3K
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 12:45:09 +0000
Date: Thu, 17 Oct 2013 14:44:55 +0200
From: chrubis@suse.cz
Message-ID: <20131017124455.GB24992@rei>
References: <003c01cec987$79eb1320$6dc13960$@cn.fujitsu.com>
	<20131015115452.GA25867@rei> <525F5E68.7030108@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <525F5E68.7030108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] access/access06.c: add ELOOP, ENOTDIR,
 EROFS error number test for access(2)
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Also looking at the access testcases, there is allready access05 to test
> > access failures, I wonder if it would be better to move the ENOTDIR and
> > ELOOP tests there (after it's cleaned up a bit). But I'm not sure about
> > this myself...
> 
> Since access03 and access05 both contain error number tests for access, 
> I think a new access06 would be better to make the three error number 
> tests clearer.
> If you perfer to add these test to existing tests, I will make a new version
> patch.

Actually after looking at your v2 patch the code is cleaner than the
access05.c, what about moving the testcases from access05 to the test
you written and calling the result access05? Are you OK with that?

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
