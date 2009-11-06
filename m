Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6XbE-0006Jr-Gm
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:48:08 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Xb6-0003Ms-6X
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:48:08 +0000
Date: Fri, 6 Nov 2009 23:47:53 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106224752.GL819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
	<200911061612.11199.vapier@gentoo.org>
	<20091106214558.GJ819@basil.fritz.box>
	<364299f40911061359v1e59fb0ct7b990da3edf655ea@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40911061359v1e59fb0ct7b990da3edf655ea@mail.gmail.com>
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

> $(abspath $(FOO)) only exists in 3.81+, along with some of the other
> built-in functions IIRC. Replacing $(abspath ) with $(shell readlink
> -f "$(FOO)" 2>/dev/null) is possible, but there are some associated
> issues with that solution:
> 
> 1. They must have readlink
> 1. It may fail if their shell is toast (in this case, they're kind of SoL).
> 2. It may fail if their's a bug (that's my job to fix).
> 
> It's bad practice to use $(shell ) because it also consumes a lot more
> resources allocating a separate shell, and all that badness associated
> with it.

With := it's probably not too bad to call the shell.
> 
> If $(patsubst ) is toast, then I'll have to replace it with $(shell )
> call to awk or perl.

As a datapoint the kernel uses patsubst and afaik it builds with 3.80

> I really do appreciate the feedback. As I stated before though, 3.80
> is where we need to draw the line in the sand, because 3.79 is a
> buggy, ancient PoS, so RHEL 4 users and other users of distros around
> that era will _need_ to compile 3.80, or 3.81 and install it on their
> target systems.

At least for me that works, but I don't speak for RHEL4 users.

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
