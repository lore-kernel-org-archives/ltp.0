Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEc08-0005Fj-Nw
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 11:34:24 +0000
Date: Mon, 13 Jul 2015 13:32:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713113253.GE2900@rei.suse.de>
References: <BLU436-SMTP2533A9350B9BD99FA2EE294CF9C0@phx.gbl>
	<20150713104302.GB2900@rei.suse.de>
	<BLU436-SMTP133C07D3DBE5E6ACC4B3BDFCF9C0@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP133C07D3DBE5E6ACC4B3BDFCF9C0@phx.gbl>
Subject: Re: [LTP] Purpose of fsync02
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
To: Rock Lee <rocklee_104@outlook.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 	If this testcase is only to test whether fsync() finishes in a 
> reasonable time, just calls fsync() is enough. Why there needs a sparse 
> file? And why this reasonable time is 120 seconds?

No idea for the sparse file, it may be regression test for some problem
they had in 2001, unfortunately there is no more documentation for the
test. Googling revealed that the test has catched deadlocks in Linux
2.5.1. The 120 seconds is IMHO arbitrary large constant, something like
50 times more than the test usually takes.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
