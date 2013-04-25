Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <takahash@us.ibm.com>) id 1UVAkM-00007j-So
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 01:13:14 +0000
Received: from [32.97.110.56] (helo=drano2.localdomain)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1UVAkI-0000Iy-Nj
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 01:13:14 +0000
Date: Wed, 24 Apr 2013 18:13:04 -0700
From: James Takahashi <takahash@us.ibm.com>
Message-ID: <20130425011303.GB30114@us.ibm.com>
References: <5177684F.7060204@cn.fujitsu.com> <20130424093255.GA5674@rei>
	<201304241207.31644.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201304241207.31644.vapier@gentoo.org>
Subject: Re: [LTP] question about a license
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
Cc: ltp-list@lists.sourceforge.net, wboyer@us.ibm.com

On Wed, 24 Apr 2013 12:07, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 24 April 2013 05:32:56 chrubis@suse.cz wrote:
> > > When trying to cleanup syscalls/getitimer03.c, i meet a strange license.
> > > It says:
> > > 
> > > *********************************************************************
> > > 
> > > /*
> > >  * $Copyright: $
> > >  * Copyright (c) 1984-2000
> > >  * Sequent Computer Systems, Inc.   All rights reserved.
> > >  *$
> > >  * This software is furnished under a license and may be used
> > >  * only in accordance with the terms of that license and with the
> > >  * inclusion of the above copyright notice.   This software may not
> > >  * be provided or otherwise made available to, or used by, any
> > >  * other person.  No title to or ownership of the software is
> > >  * hereby transferred.
> > >  */
> > > 
> > > *********************************************************************
> > > 
> > > Here is my question,
> > > 1. Can i change this license to GPL2? or
> > > 2. Can i modify code of the case under this license?
> > > 
> > > Could you please provide me any pointer/suggstion. :)
> > 
> > Given that the testcases is a few lines that calls getitimer() with
> > invalid value, I would play safe and rewrite it from scratch.
> > 
> > Anybody has different opinion?
> 
> there are four such files:
> 	testcases/kernel/syscalls/getitimer/getitimer03.c
> 	testcases/kernel/syscalls/getresgid/getresgid01.c
> 	testcases/kernel/syscalls/nftw/Makefile
> 	testcases/kernel/syscalls/nftw/nftw64.h
> 
> the Makefile has at least be rewritten enough that i think we can change things 
> as the code has largely been written by Garrett Cooper now
> 
> if we can't locate someone (Wayne Boyer?) for the tests, i suggest looking at 
> what they test (just read the comment block), then delete the file and write a 
> new test from scratch.
> 
> the header file i think might be accidental as none of the nftw files look that 
> way.  instead, they have the ibm copyright.  so i'd just change it to that.
> -mike

Wayne is still at IBM (Sequent was acquired by IBM).  I have CC'd him
on this thread.

If you'd elaborate on what sort of permission/assistance you need for
this copyright issue, I'm sure Wayne would be happy to cooperate.

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
