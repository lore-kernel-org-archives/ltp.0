Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1Glz-0006g4-6c
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 14:39:51 +0000
Date: Thu, 9 Jan 2014 15:39:28 +0100
From: chrubis@suse.cz
Message-ID: <20140109143928.GH5125@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<201401090851.42915.vapier@gentoo.org>
	<256751357.13345901.1389276652247.JavaMail.root@redhat.com>
	<201401090930.13714.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401090930.13714.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7
 arguments
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > exactly.  why does a clone() test have any bearing at all on ia64
> > > behavior ? the code that checks the define won't get used in the
> > > __ia64__ case, so having
> > > a define here is pointless.
> > 
> > I thought the check applies to whole ltp_clone, since that is what is
> > called by testcases checking this define.
> 
> there's debate as to whether that's how we want to take things :).  we'll sort 
> it out there.

I would go with the __clone2() in the #else branch because the same
ifdef is used in the clone08 testcase and not having positive result in
__ia64__ case would wrongly disable the testcase.

It's shame that ia64 has different clone syscall interface but that is
price for the way how our system is evolving...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
