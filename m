Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vr53M-0001DK-9H
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 12:07:40 +0000
Date: Thu, 12 Dec 2013 13:07:04 +0100
From: chrubis@suse.cz
Message-ID: <20131212120704.GC10634@rei.Home>
References: <20131211151928.GA30754@rei.Home>
 <52A957EF.7040003@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52A957EF.7040003@oracle.com>
Subject: Re: [LTP] [RFC] LTP Test Writing Guidelines
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Good news everyone!
> >
> > As number of contributors grows I've finally started to address our lack
> > of documentation. I've written down a short introduction on how to write
> > a LTP test. It's intended to cover just enough so that you can write a
> > reasonable LTP testcase without any prior knowledge as well as to codify
> > some of the rules we formed but were not written down till now.
> >
> > The text is attached as an asciidoc formatted plaintext and can be
> > viewed in html form at [1].
> >
> > The attached text is a draft and it's likely that there are mistakes or
> > important things missing. For example, as far as I know, we do not have
> > a uniform coding style for shell scripts nor clear documentation for the
> > shell LTP library functions, this should be ideally addressed as well.
> >
> > As usuall comments and patches are welcome ;).
> 
> Fantastic work! :)
> 
> Thank you.
> 
> Maybe add here a notice about performing a cleanup (in a separate patch) 
> before doing any "serious" modifications of the old test cases?
> 
> Since there are many such "old-style" test cases in LTP, these 
> situations may happen regularly.

Right, I will add a paragraph about dealing with legacy messed up code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
