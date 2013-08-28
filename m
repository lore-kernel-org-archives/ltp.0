Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEcVs-0006Ao-RO
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 09:58:08 +0000
Date: Wed, 28 Aug 2013 11:58:14 +0200
From: chrubis@suse.cz
Message-ID: <20130828095814.GC22849@rei.Home>
References: <521C4688.9020305@cn.fujitsu.com> <521C46FB.7020308@cn.fujitsu.com>
	<20130827125144.GI10995@rei.Home> <521D710C.8030609@cn.fujitsu.com>
	<20130828093810.GA22849@rei.Home> <521DC969.3090103@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521DC969.3090103@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2 v2] quotactl/quotactl02.c: create a case to
 test basic flags of quotactl(2)
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > You can define as many structures as you want, one for this particular
> > test and one for the rest of the testcases for example, does the syscall
> > modify the structure?
> 
> Yeah, calling quotactl() with "Q_XGETQUOTA" will modify this structure.

Ok. I did not know this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
