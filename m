Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VYDSx-0003CZ-80
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 11:16:07 +0000
Date: Mon, 21 Oct 2013 13:15:48 +0200
From: chrubis@suse.cz
Message-ID: <20131021111548.GC1274@rei>
References: <9C261B4871671149A8D67C0E65957391507046@039-SN1MPN1-003.039d.mgd.msft.net>
	<20131016112213.GB24451@rei.Home>
	<9C261B4871671149A8D67C0E659573915077DF@039-SN1MPN1-003.039d.mgd.msft.net>
	<20131017125233.GC24992@rei>
	<9C261B4871671149A8D67C0E65957391507F9C@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9C261B4871671149A8D67C0E65957391507F9C@039-SN1MPN1-003.039d.mgd.msft.net>
Subject: Re: [LTP] "cpu_hotplug/functional/cpuhotplug05.sh" failed
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
To: Liao Guoqi-B25230 <B25230@freescale.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I have no idea that when it was changed. But I think we could update the matching program to compatibility old and new.

Hmm, what about modifying the test to accept either nan or 0.00? That
way we don't have to find you when it was changed.

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
