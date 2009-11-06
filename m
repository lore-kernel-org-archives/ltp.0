Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1N6XpY-000710-3l
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:02:56 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6XpS-00057j-LC
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:02:55 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA6MpGku027305
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 15:51:16 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA6N2Xfn078292
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 16:02:37 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nA6N48sw026368
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Nov 2009 16:04:08 -0700
Date: Fri, 6 Nov 2009 15:02:31 -0800
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20091106230231.GC26614@count0.beaverton.ibm.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<200911061409.03835.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911061409.03835.vapier@gentoo.org>
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
> On Friday 06 November 2009 13:04:51 Garrett Cooper wrote:
> > As I just wrote in the INSTALL file after the release (I apologize for
> > not catching this beforehand, but all of the systems I use -- Fedora,
> > Gentoo, RHEL 4 update 6, Ubuntu -- have make 3.81):
> 
> hrm, it sucks to not support make 3.80.  while make 3.81 has been out for 
> three years now, make 3.80 support would increase the coverage to 8 years.  
> but if you've looked at the situation and found 3.80 support to be non 
> trivial, i wont whine too loud.
> 
> > In order to compile and use pan, you must have bison/yacc, flex, and make
> > 3.81+ installed.
> 
> if we're forcing make-3.81+, then make it explicit:
> ifneq ($(findstring x3.7,x$(MAKE_VERSION)),)

This snippet might work better than findstring. If the make version is
greater than or equal to 3.81 then NEED_NEWER_MAKE is n:

NEED_NEWER_MAKE := n
MAX_VERSION := $(shell echo 3.81 $(MAKE_VERSION) | xargs -r -n 1 | sort -V -r | head -n 1)
ifneq(x$(MAKE_VERSION),x$(MAX_VERSION))
NEED_NEWER_MAKE := y
endif

(I tried to make this a into neat sortv Make "function" but couldn't
get arg passing to work :P)

> NEED_NEWER_MAKE := y
> endif
> ifeq ($(MAKE_VERSION),3.80)
> NEED_NEWER_MAKE := y
> endif
> ifeq ($(NEED_NEWER_MAKE),y)
> $(error ..)
> endif
> 
> also, i thought we were going to rename the top level Makefile to GNUmakefile 
> and add a dummy Makefile that just spat out "sorry, ltp requires GNU make".

Bleh. Can't we just check the output of $(MAKE) --version rather than
assume other makes use "Makefile"?

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
