Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mh3uD-0001yT-07
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 16:02:25 +0000
Date: Fri, 28 Aug 2009 18:02:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090828160210.GA7218@schrodinger.suse.cz>
References: <20090828152415.GB4567@schrodinger.suse.cz>
	<200908281144.24993.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200908281144.24993.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Add autoconf tests for taskstats members
	not	present?on older kernels
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
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>

Hi!
> > > this patch adds autoconf checks for some build failures reported by Cyril
> > > Hrubis. Please note I have not tested this on an old kernel.
> > >
> > > Also, it corrects the names of the preprocessor macros defined by
> > > autoconf
> > >
> > > The remaining issue (the cgroupstats.h file) should be solved using the
> > > autoconf test that was committed recently.
> >
> > The autoconf part is okay, but getdelays.c needs some more #ifdef
> > HAVE_LINUX_CGROUPSTAT_H to build correctly on all I have here.
> >
> > Patch attached, however it may need minor cleanups.
> 
> preprocessor macros should never be intended

I allways forgot this one...

> can the test case pass at all if the linux headers are missing ?  if they 
> cant, there's no point in sprinkling #ifdef's throughout the code.  stub the 
> whole thing out.

As far as I see the cgroupstat code is activated only by -C switch, so it does
make sence spread #ifdefs around.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
