Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYLT2-0005Vz-3k
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 16:35:08 +0000
Date: Thu, 30 Dec 2010 17:50:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230165032.GA26724@saboteur.suse.cz>
References: <4CCA33F8.6020104@cn.fujitsu.com> <4CD777DE.7040302@cn.fujitsu.com>
	<AANLkTikkEAuO5jPXExneKC7OHbOViTErs_Fu_XasYma4@mail.gmail.com>
	<20101118202910.GF19296@saboteur.suse.cz>
	<AANLkTimz2WBPfwCBHajqzA7Uk_72MZeTJdWB0Zbkch8B@mail.gmail.com>
	<AANLkTi=YvMBmUQLSmtq8aM0+s2-X3BmRM13fSUa6a1-1@mail.gmail.com>
	<4CF4CCD7.3060009@cn.fujitsu.com>
	<20101202121334.GA20268@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101202121334.GA20268@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Don't use clock_settime()
 to reset a CPU-time Clock
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Yes this assumption seems to be incorrect as I couldn't find in a place
> in POSIX documentation which explicitly states that two obtained
> clock_id that points to the same clock must be the same. On linux
> calling clock_getcpuclockid() with 0 and value from getpid() returns two
> different id which both points to the same clock.

Garrett ping.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
