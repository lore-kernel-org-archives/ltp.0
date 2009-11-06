Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1N6Yhu-0001Rl-QM
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:59:06 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Yht-00014R-Q9
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:59:06 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA6NuQpl020794
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 16:56:26 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA6NwxG0142952
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 16:58:59 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA6NwwCY010211
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 16:58:59 -0700
Date: Fri, 6 Nov 2009 15:34:22 -0800
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20091106233422.GB6619@count0.beaverton.ibm.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061409.03835.vapier@gentoo.org>
	<20091106230231.GC26614@count0.beaverton.ibm.com>
	<200911061809.05115.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061809.05115.vapier@gentoo.org>
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
Cc: ltp-list@lists.sourceforge.net

On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
> On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
> > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
> > > On Friday 06 November 2009 13:04:51 Garrett Cooper wrote:

<snip>

> > This snippet might work better than findstring. If the make version is
> > greater than or equal to 3.81 then NEED_NEWER_MAKE is n:
> > 
> > NEED_NEWER_MAKE := n
> > MAX_VERSION := $(shell echo 3.81 $(MAKE_VERSION) | xargs -r -n 1 | sort -V
> >  -r | head -n 1)
> 
> this involves executing a shell and a lot of external utilities.  my version 
> requires an internal make string search.  anything that involves $(shell) here 
> is going to be worse.

OK -- I don't know whether old versions of xargs and sort take those
arguments and you seem to know those kinds of details better than I.

> > > also, i thought we were going to rename the top level Makefile to
> > > GNUmakefile and add a dummy Makefile that just spat out "sorry, ltp
> > > requires GNU make".
> > 
> > Bleh. Can't we just check the output of $(MAKE) --version rather than
> > assume other makes use "Makefile"?
> 
> the assumption is that only GNU make parses "GNUmakefile".  i think that's a 
> pretty safe assumption.

Right, but GNU Make also parses Makefile. If some poor bastard runs:

make -f Makefile

where GNU Make is "make" they may be further confused. Seems like it's
better to check what's actually running ($(MAKE)) or will run
(like `which make` in configure) than rely on a filename hack like this.

Cheers,
	-Matt Helsley

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
