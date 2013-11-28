Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vm2OJ-0008PL-MF
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 14:16:27 +0000
Date: Thu, 28 Nov 2013 15:15:49 +0100
From: chrubis@suse.cz
Message-ID: <20131128141548.GB20294@rei.Home>
References: <1384395907-13886-1-git-send-email-penght@cn.fujitsu.com>
	<20131114122922.GA13348@rei>
	<187658148.31700134.1384433325925.JavaMail.root@redhat.com>
	<20131114125524.GD13348@rei> <5285EB6C.9000107@cn.fujitsu.com>
	<5296D114.4070507@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5296D114.4070507@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] sigaction:16-1: leave it untested on the Linux
 kernel less than 2.6.22
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>> I don't have strong preference. I'd be OK also with a text file, which would
> >>> list which ones fail, why, relevant kernel/glibc versions, etc.
> >>
> >> Or a wiki page. I would love to see more LTP documentation...
> >>
> > 
> > As a known bug, I think it is OK to skip the case.
> > Although a text file or a wiki page is existent, the new users of ltp may
> > not catch it and investigate the bug again and again.
> > 
> 
> What is decision about the discuss?

I wote for adding 'test_linux' make target which will skipp testcases
that are expected to fail on the tested system.

Anybody has different idea?

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
