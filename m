Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YDz-0005JW-Dt
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:19 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YDv-0002rq-4a
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:19 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200911031130.05930.vapier@gentoo.org>
References: <1257220567.10382.3.camel@munipradeep-laptop>
	<200911031050.38755.vapier@gentoo.org>
	<364299f40911030805m5e40d9c8w74a69d7f452200f8@mail.gmail.com>
	<200911031130.05930.vapier@gentoo.org>
Date: Mon, 09 Nov 2009 23:09:21 +0530
Message-Id: <1257788361.7677.70.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Got warning message on ltp-full-20091031 while
	running	./configure
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2009-11-03 at 12:30 -0400, Mike Frysinger wrote: 
> On Tuesday 03 November 2009 11:05:10 Garrett Cooper wrote:
> > On Tue, Nov 3, 2009 at 7:50 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > > On Tuesday 03 November 2009 08:01:08 Garrett Cooper wrote:
> > >> >> On Tue, 2009-11-03 at 09:26 +0530, Munipradeep Beerakam wrote:
> > >> >> > I got the following warning messages while running "./configure" on
> > >> >> > the ltp-full-20091031. However, make and make install worked fine.
> > >> >> >
> > >> >> > configure: WARNING: linux/genetlink.h: present but cannot be
> > >> >> > compiled configure: WARNING: linux/genetlink.h:     check for
> > >> >> > missing prerequisite headers?
> > >> >> > configure: WARNING: linux/genetlink.h: see the Autoconf
> > >> >> > documentation configure: WARNING: linux/genetlink.h:     section
> > >> >> > "Present But Cannot Be Compiled"
> > >> >> > configure: WARNING: linux/genetlink.h: proceeding with the
> > >> >> > preprocessor's result
> > >> >> > configure: WARNING: linux/genetlink.h: in the future, the compiler
> > >> >> > will take precedence
> > >> >> > configure: WARNING:     ##
> > >> >> > ------------------------------------------------ ##
> > >> >> > configure: WARNING:     ## Report this to
> > >> >> > ltp-results@lists.sourceforge.net ##
> > >> >> > configure: WARNING:     ##
> > >> >> > ------------------------------------------------ ##
> > >>
> > >>     Yeah -- I need to find the header that defines u32 (instead of
> > >> uint32 or uint32_t). Does anyone know which one was that again? I
> > >> thought it was a kernel specific datatype (and in that event it
> > >> shouldn't be exported).
> > >
> > > correct -- nothing in userspace should be using u32.  if the kernel
> > > headers are, they're broken and need fixing, so complain to lkml/your
> > > distro.
> > 
> >     That's what I figured -- ok. The test and the app should also be
> > converted to straight linux/genetlink.h, because linux/genetlink.h is
> > a superset of linux/netlink.h.
> 
> we should get Subrata to generate the release with newer versions of autotools 
> (like autoconf-2.64) so that these warnings dont show up.  if the header cant 

I upgraded my system to 2.64 just now.

$ /usr/bin/autoconf --version
autoconf (GNU Autoconf) 2.64
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv2+: GNU GPL version 2 or later
<http://gnu.org/licenses/old-licenses/gpl-2.0.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Written by David J. MacKenzie and Akim Demaille.

Hope this would solve all such problems.

Regards--
Subrata

> be compiled, then we want it marked as not usable and so the related tests get 
> skipped.
> -mike


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
