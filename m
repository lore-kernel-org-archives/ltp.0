Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1Ggx-0007QO-VG
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 14:34:40 +0000
Date: Thu, 9 Jan 2014 15:34:17 +0100
From: chrubis@suse.cz
Message-ID: <20140109143417.GA28639@rei>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<201401090803.39606.vapier@gentoo.org>
	<20140109130919.GF5125@rei.Home>
	<201401090900.59568.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401090900.59568.vapier@gentoo.org>
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
> > > you aren't really testing for "clone takes 7 args", you're testing for
> > > "clone has varargs support".  rename the define (and use _ in its name),
> > > and drop the ia64 check as it isn't needed.
> > 
> > I wouldn't call it varargs because there are only three more pointers to
> > pass to clone() and the only reason it's defined as varargs is to be
> > compatible with the previous clone definition...
> 
> fair enough.  the define still needs renaming like CLONE_ACCEPTS_7_ARGS.

OK.

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
