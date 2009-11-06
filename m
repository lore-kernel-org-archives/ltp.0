Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6WdJ-000315-C3
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:46:13 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6WdC-000050-Qa
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:46:13 +0000
Date: Fri, 6 Nov 2009 22:45:58 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106214558.GJ819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
	<200911061612.11199.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061612.11199.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Nate Straz <nate@refried.org>

On Fri, Nov 06, 2009 at 04:12:10PM -0500, Mike Frysinger wrote:
> On Friday 06 November 2009 16:02:25 Andi Kleen wrote:
> > I'm also highly surprised that this doesn't work with autoconf -- I thought
> > the whole point of autoconf was to generate portable makefiles, but
> > in this case it seems to especially generate a non portable Makefile.
> 
> that is not the point of autoconf at all; it has nothing to do with makefiles.  
> that is the point of automake -- which we specifically are not using.  there 
> are way too many Makefiles that would need to be generated.

True. So you guys just managed to write a very non portable Makefile on your
own.  Congratulations.

I tried to debug the problem, but it's such a maze that I gave up.

It seems to be related to abs_top_builddir not getting expanded correctly.

I suspect simply expanding some of the filter magic rules manually
might fix it.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
