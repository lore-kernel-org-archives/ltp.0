Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6Wo7-00033Y-P6
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:57:23 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Wnz-0004XE-V3
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 21:57:23 +0000
Date: Fri, 6 Nov 2009 22:57:09 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106215709.GK819@basil.fritz.box>
References: <200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
	<20091106194335.GB32249@refried.org>
	<20091106195940.GH819@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
	<364299f40911061347h24237df0x23aea3be3dc78b7e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40911061347h24237df0x23aea3be3dc78b7e@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Mike Frysinger <vapier@gentoo.org>, Nate Straz <nate@refried.org>

On Fri, Nov 06, 2009 at 01:47:26PM -0800, Garrett Cooper wrote:
> > I'm pretty sure that not supporting older distributions is very
> > necessarily a bad thing.
> 
> I agree. There are some feature gaps between 3.80 and 3.81 I'll need
> to address, which means I need to first off download SLES 10 and

Sorry, it's suse 10.0, not sles10. 

But it's enough to just install make 3.80 somewhere and
call it explicitely on a newer distro (I just tested that).
Shows the same problem.

> install it on another VM, and toy around with it (if you can provide
> me with those details, I'll give it a shot).

what details do you need?

> >> Then it comes back to tools -- I'm basically going to have to write
> >> checks in autoconf to make sure that readlink does as planned (isn't
> >> broken), and it's going to be more painful for you performance wise to
> >> have this hack in place, as opposed to just having an upgraded version
> >> of make, which also has resolved several bugs between 3.80 and 3.81.
> >
> > I don't understand: the key is not to test for commands used
> > by makefiles, but simply only use features which are generally available.
> >
> > I'm also highly surprised that this doesn't work with autoconf -- I thought
> > the whole point of autoconf was to generate portable makefiles, but
> > in this case it seems to especially generate a non portable Makefile.
> >
> > I suspect it's actually not a autoconf problem by itself, but
> > something that's in the LTP templates.
> 
> Agreed. The problem that everyone with <3.80 is running into is that I

<=3.80

> was stupid and was under the assumption that many distros wouldn't
> still use make 3.81 because it's been out for the past 4 years. My
> apologies -- I stand corrected.

Thanks for addressing the problem.
I apologize also for being somewhat too grumpy on the issue.
If you have any patches to test feel free to send them.

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
