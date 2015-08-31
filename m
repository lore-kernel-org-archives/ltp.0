Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWMFK-0001Pw-0a
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 10:23:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWMFH-0004aq-UR
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2015 10:23:25 +0000
Date: Mon, 31 Aug 2015 12:22:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150831102243.GA17387@rei.suse.cz>
References: <20150829232628.GA14374@fifo99.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150829232628.GA14374@fifo99.com>
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
> I read your January 2015 article where someone asked if TAP test output would be supported. It sounded like
> you were going to look into it. Did you make any progress?

Unfortunately not yet.

> The reason I asked if because I was wanting the same feature and I was going to review the LTP code to see
> how hard it would be to add it, but I wouldn't want to start if someone else has already done it. I did
> see anything in the git history tho.

Well, have a look at lib/tst_res.c, that is the place where test results
are stored/printed. Unfortunately this code hasn't been cleaned up yet.

I've started to work on this just recently. Just now I'm experimenting
with rewriting it from scratch keeping most of the API unchanged (since
we cannot change easily the API for > ~1000 testcases).

Then there is another problem, so far LTP testcases are executed using
the ltp-pan test driver, which executes testcases, catches segfaults,
etc. We would have to consider how that would interact with the output
generated from testcases.

One option would be to get rid of most of the pan functionality by
moving the test driver code into the test library, so that each testcase
would fork first, then run the real test in it's own virtual terminal,
etc.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
