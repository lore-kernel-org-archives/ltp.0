Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nate@refried.org>) id 1N6XqC-0007P8-Oq
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:03:36 +0000
Received: from smtp1.av-mx.com ([137.118.16.57])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6Xq4-0000XT-Ko
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:03:36 +0000
Date: Fri, 6 Nov 2009 18:03:19 -0500
From: Nate Straz <nate@refried.org>
Message-ID: <20091106230319.GD32249@refried.org>
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061225k2e359ae0w4466a571261e96e@mail.gmail.com>
	<20091106210225.GI819@basil.fritz.box>
	<200911061612.11199.vapier@gentoo.org>
	<20091106214558.GJ819@basil.fritz.box>
	<364299f40911061359v1e59fb0ct7b990da3edf655ea@mail.gmail.com>
	<20091106224752.GL819@basil.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091106224752.GL819@basil.fritz.box>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Nov  6 23:47, Andi Kleen wrote:
> > I really do appreciate the feedback. As I stated before though, 3.80
> > is where we need to draw the line in the sand, because 3.79 is a
> > buggy, ancient PoS, so RHEL 4 users and other users of distros around
> > that era will _need_ to compile 3.80, or 3.81 and install it on their
> > target systems.
> 
> At least for me that works, but I don't speak for RHEL4 users.

RHEL4 users have make-3.80.

Nate

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
