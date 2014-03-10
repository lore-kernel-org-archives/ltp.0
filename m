Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WN0oq-00048j-Dr
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 14:04:40 +0000
Date: Mon, 10 Mar 2014 15:04:22 +0100
From: chrubis@suse.cz
Message-ID: <20140310140422.GC10346@rei>
References: <531DC318.7060504@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <531DC318.7060504@gmail.com>
Subject: Re: [LTP] Testing absence of ticks with nohz_full
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
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> My company (Enea) wants to create test case(s) that verifies that you 
> can run an application without having ticks going on the CPU that the 
> application runs on. This would utilize the new nohz_full feature 
> available from kernel version 3.10.
> 
> I cannot find any existing test case in LTP in this area, so I assume I 
> have to create the test case myself.

I'm not aware of such tests in LTP.

> One catch is that the current nohz_full implementation actually 
> generates 1Hz. So part of the test could be to verify that we actually 
> get 1Hz rather than full tick speed. It would also be possible to 
> support the experimental patch from Kevin Hilman to actually turn ticks 
> off for real. The test code code check whether the patch is applied and 
> based on it expect 0Hz or 1Hz ticks.
> 
> Would LTP be a good place for such tests?

Certainly.

I've wrote (about two months ago) a short guide on writing LTP testcases
and contributing the code have look at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

And if you have any questions don't hesitate to ask on LTP mailing list.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
