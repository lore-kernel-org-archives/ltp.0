Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wayneb@linux.vnet.ibm.com>) id 1UVDHo-0005Qv-RL
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 03:55:56 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVDHn-0006v6-OK
	for ltp-list@lists.sourceforge.net; Thu, 25 Apr 2013 03:55:56 +0000
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <wayneb@linux.vnet.ibm.com>; 
	Wed, 24 Apr 2013 23:55:50 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DF753C9001D
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Apr 2013 23:55:46 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r3P3tkNh301268
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Apr 2013 23:55:47 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r3P3wc8N021576
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Apr 2013 21:58:38 -0600
Message-ID: <5178A940.7070807@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 20:55:44 -0700
From: Wayne Boyer <wayneb@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <OF9DB4E12A.D5B7A192-ON88257B58.0013E63A-88257B58.0013F584@us.ibm.com>
In-Reply-To: <OF9DB4E12A.D5B7A192-ON88257B58.0013E63A-88257B58.0013F584@us.ibm.com>
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
Cc: ltp-list@lists.sourceforge.net, takahash@linux.vnet.ibm.com


Mike Frysinger <vapier@gentoo.org> wrote on 04/24/2013 07:01:29 PM:

> From: Mike Frysinger <vapier@gentoo.org>
> To: takahash@linux.vnet.ibm.com,
> Cc: ltp-list@lists.sourceforge.net, Wayne Boyer/Beaverton/IBM@IBMUS
> Date: 04/24/2013 07:01 PM
> Subject: Re: [LTP] question about a license
>
> On Wednesday 24 April 2013 21:13:04 James Takahashi wrote:
> > On Wed, 24 Apr 2013 12:07, Mike Frysinger <vapier@gentoo.org> wrote:
> > > On Wednesday 24 April 2013 05:32:56 chrubis@suse.cz wrote:
> > > > > When trying to cleanup syscalls/getitimer03.c, i meet a strange
> > > > > license. It says:
> > > > >
> > > > > *********************************************************************
> > > > >
> > > > > /*
> > > > >
> > > > >  * $Copyright: $
> > > > >  * Copyright (c) 1984-2000
> > > > >  * Sequent Computer Systems, Inc.   All rights reserved.
> > > > >  *$
> > > > >  * This software is furnished under a license and may be used
> > > > >  * only in accordance with the terms of that license and with the
> > > > >  * inclusion of the above copyright notice.   This software may not
> > > > >  * be provided or otherwise made available to, or used by, any
> > > > >  * other person.  No title to or ownership of the software is
> > > > >  * hereby transferred.
> > > > >  */
> > > > >
> > > > > *********************************************************************
> > > > >
> > > > > Here is my question,
> > > > > 1. Can i change this license to GPL2? or
> > > > > 2. Can i modify code of the case under this license?
> > > > >
> > > > > Could you please provide me any pointer/suggstion. :)
> > > >
> > > > Given that the testcases is a few lines that calls getitimer() with
> > > > invalid value, I would play safe and rewrite it from scratch.
> > > >
> > > > Anybody has different opinion?
> > >
> > > there are four such files:
> > >    testcases/kernel/syscalls/getitimer/getitimer03.c
> > >    testcases/kernel/syscalls/getresgid/getresgid01.c
> > >    testcases/kernel/syscalls/nftw/Makefile
> > >    testcases/kernel/syscalls/nftw/nftw64.h
> > >
> > > the Makefile has at least be rewritten enough that i think we can change
> > > things as the code has largely been written by Garrett Cooper now
> > >
> > > if we can't locate someone (Wayne Boyer?) for the tests, i suggest
> > > looking at what they test (just read the comment block), then delete the
> > > file and write a new test from scratch.
> > >
> > > the header file i think might be accidental as none of the nftw files
> > > look that way.  instead, they have the ibm copyright.  so i'd just
> > > change it to that. -mike
> >
> > Wayne is still at IBM (Sequent was acquired by IBM).  I have CC'd him
> > on this thread.
> >
> > If you'd elaborate on what sort of permission/assistance you need for
> > this copyright issue, I'm sure Wayne would be happy to cooperate.
>
> the code says Wayne wrote it.  if Wayne can confirm that, and if he
> can confirm
> that we want to change the copyright to the standard ibm ones (found in many
> other files) and license it similarly.
> -mike

Hi Mike,

I looked at the four files in question.  I did write getitimer03.c and I
believe using the standard IBM copyright is correct.

I ported the getresgid01.c code to run under Linux.  As I recall it was 
originally a Sequent test case for the Dynix/ptx OS.  Again I believe
using the standard IBM copyright is correct.

I did not work with the last two files, but they follow the same pattern
as the getresgid01.c code.  There were originally part of the Dynix/ptx
test cases.


-- 
Wayne Boyer
LTC Embedded Linux - Customer Tech Lead
IBM - Hillsboro, Oregon


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
