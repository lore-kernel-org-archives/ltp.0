Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1DjA-0005SB-1y
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 11:24:44 +0000
Date: Thu, 9 Jan 2014 12:24:24 +0100
From: chrubis@suse.cz
Message-ID: <20140109112423.GA5125@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389191490.2879.27.camel@G08JYZSD130126>
	<201401081447.46449.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401081447.46449.vapier@gentoo.org>
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
> > Create m4/ltp-clone7args.m4 to check whether clone support 7 arguments.
> > When HAVE_CLONE7ARGS is not defined, make clone08 return TCONF
> 
> this patch lacks any sort of detail.  what system are you on where this 
> doesn't work ?

That was in one of the emails but I guess that this should be part of
the commit message as well. These are either old systems SLES10, RHER4
or exotic architectures s390, s390x. The really old systems are not that
much important but build failures on reasonably recent systems on exotic
hardware should be fixed.

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
