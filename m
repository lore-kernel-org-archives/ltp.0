Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWniI-0003d0-2v
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 15:43:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWniH-0008C3-3g
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 15:43:10 +0000
Date: Tue, 1 Sep 2015 17:42:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150901154229.GB17536@rei.suse.cz>
References: <20150829232628.GA14374@fifo99.com>
	<20150831102243.GA17387@rei.suse.cz>
	<20150831170112.GA18725@fifo99.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150831170112.GA18725@fifo99.com>
Subject: Re: [LTP] Test Anything Protocal output
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
To: dwalker@fifo99.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> It looks like it could be changes in lib/tst_res.c line 404 in function tst_print().
> There's other components to TAP but the change above it the biggest I think.

Getting 90% working would be easy enough, the real problem is making it
work for all corner cases, which is the reason I would rather want to do
this for a cleaner code.

> > I've started to work on this just recently. Just now I'm experimenting
> > with rewriting it from scratch keeping most of the API unchanged (since
> > we cannot change easily the API for > ~1000 testcases).
> > 
> > Then there is another problem, so far LTP testcases are executed using
> > the ltp-pan test driver, which executes testcases, catches segfaults,
> > etc. We would have to consider how that would interact with the output
> > generated from testcases.
> > 
> > One option would be to get rid of most of the pan functionality by
> > moving the test driver code into the test library, so that each testcase
> > would fork first, then run the real test in it's own virtual terminal,
> > etc.
> 
> Well, if your re-writing it, than TAP could be added after that. Is this re-write
> a long term thing, or something your planning to complete in the next couple months?

The tst_res.c is one of the last files under the lib/ that hasn't been
cleaned up yet and I certainly want to do that before next release,
which would be in aprox. three months.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
