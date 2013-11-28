Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vm1ZB-00062G-L5
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 13:23:37 +0000
Date: Thu, 28 Nov 2013 14:23:08 +0100
From: chrubis@suse.cz
Message-ID: <20131128132307.GE19263@rei.Home>
References: <20131119214612.GA2120@p100.box>
	<236728861.37114527.1384935019282.JavaMail.root@redhat.com>
	<528D135D.5060204@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528D135D.5060204@gmx.de>
Subject: Re: [LTP] [PATCH] fix readv01 testcase for parisc architecture
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Ok, so if you could just apply this second hunk it would be great!

I've cleaned up the testcase and fixed the number of vectors as well.

> Thanks for maintaining LTP!
> It helped me a lot to find bugs in the parisc arch code of the kernel.

:)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
