Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7Mo-0002U0-Ax
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:52:58 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7Mn-0001uL-0H
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:52:58 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEnjHs022376
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:49:45 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NEqtgJ229566
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:52:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NEqsVn022202
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 08:52:54 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1234762145.7791.13.camel@subratamodak.linux.ibm.com>
References: <4948C6E4.8080801@linux.vnet.ibm.com>
	<49491512.9000905@linux.vnet.ibm.com>
	<1229578051.5149.11.camel@subratamodak.linux.ibm.com>
	<20090214203139.GA10969@us.ibm.com>
	<1234762145.7791.13.camel@subratamodak.linux.ibm.com>
Date: Tue, 23 Jun 2009 20:18:21 +0530
Message-Id: <1245768501.4860.56.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] testcase pidns20, pidns21 on pid namespace
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Nadia Derbey <Nadia.Derbey@bull.net>, gowrishankar.muthukrishna@gmail.com

On Mon, 2009-02-16 at 10:59 +0530, Subrata Modak wrote: 
> Thanks Suka,
> 
> On Sat, 2009-02-14 at 12:31 -0800, Sukadev Bhattiprolu wrote:
> > Subrata Modak [subrata@linux.vnet.ibm.com] wrote:
> > | 
> > | > > pidns21:
> > | > >    The pidns21.c testcase verifies that container-init is terminated
> > | > >    by SIGUSR1 when:
> > | > >       - a handler is specified for SIGUSR1,
> > | > >       - container-init blocks SIGUSR1,
> > | > >       - parent queues SIGUSR1 and
> > | > >       - handler for SIGUSR1 is set to system default before SIGUSR1 is 
> > | > > unblocked.
> > 
> > I know I had acked this test before, but back then the actual implementation
> > of the signal semantics in the kernel were not complete.
> > 
> > To simplify the implementation of the semantics, it was decided that
> > SIGKILL/SIGSTOP would be the only reliable signals from a parent
> > container. IOW, container-init would ignore SIGUSR1 or SIGINT, SIGQUIT
> > etc even if sent from a parent container.
> > 
> > See patchset/discussion:
> > 
> > 	http://lkml.org/lkml/2009/1/17/131
> > 
> > (which is not yet merged, but appears to be close to consensus)
> > 
> > The  rationale for this simplification is that any serious
> > 'container-init' would explicitly SIG_IGN all signals that it is
> > not interested in. So the only signals that would be in SIG_DFL
> > state would be SIGKILL/SIGSTOP.
> > 
> > Effectively, testcase pidns21 will fail if/when the above patchset
> > (specifically, patch 5/6) is merged.
> 
> Gowri,
> 
> Kindly update this test when the patch makes into next stable kernel
> release.

Suka/Gowri,

Are we still looking into these tests ?

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> 
> 
> ------------------------------------------------------------------------------
> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
> -Strategies to boost innovation and cut costs with open source participation
> -Receive a $600 discount off the registration fee with the source code: SFAD
> http://p.sf.net/sfu/XcvMzF8H
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
