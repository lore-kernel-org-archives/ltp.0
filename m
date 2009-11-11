Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1N80ns-0004Ji-FW
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 00:11:16 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N80nm-00064l-5L
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 00:11:16 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAB0628M014694
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 19:06:02 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAB0B0Fo1310890
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 19:11:00 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAAE8ZsL004310
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 09:08:36 -0500
Date: Tue, 10 Nov 2009 18:10:59 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20091111001059.GA30122@us.ibm.com>
References: <4948C6E4.8080801@linux.vnet.ibm.com>
	<49491512.9000905@linux.vnet.ibm.com>
	<1229578051.5149.11.camel@subratamodak.linux.ibm.com>
	<20090214203139.GA10969@us.ibm.com>
	<1234762145.7791.13.camel@subratamodak.linux.ibm.com>
	<1245768501.4860.56.camel@subratamodak.linux.ibm.com>
	<4AF8F73E.10506@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AF8F73E.10506@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] testcase pidns20, pidns21 on pid namespace
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, gowrishankar.muthukrishna@gmail.com, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Nadia Derbey <Nadia.Derbey@bull.net>

Quoting Rishikesh (risrajak@linux.vnet.ibm.com):
> Subrata Modak wrote:
> > On Mon, 2009-02-16 at 10:59 +0530, Subrata Modak wrote: 
> >   
> >> Thanks Suka,
> >>
> >> On Sat, 2009-02-14 at 12:31 -0800, Sukadev Bhattiprolu wrote:
> >>     
> >>> Subrata Modak [subrata@linux.vnet.ibm.com] wrote:
> >>> | 
> >>> | > > pidns21:
> >>> | > >    The pidns21.c testcase verifies that container-init is terminated
> >>> | > >    by SIGUSR1 when:
> >>> | > >       - a handler is specified for SIGUSR1,
> >>> | > >       - container-init blocks SIGUSR1,
> >>> | > >       - parent queues SIGUSR1 and
> >>> | > >       - handler for SIGUSR1 is set to system default before SIGUSR1 is 
> >>> | > > unblocked.
> >>>
> >>> I know I had acked this test before, but back then the actual implementation
> >>> of the signal semantics in the kernel were not complete.
> >>>
> >>> To simplify the implementation of the semantics, it was decided that
> >>> SIGKILL/SIGSTOP would be the only reliable signals from a parent
> >>> container. IOW, container-init would ignore SIGUSR1 or SIGINT, SIGQUIT
> >>> etc even if sent from a parent container.
> >>>
> >>> See patchset/discussion:
> >>>
> >>> 	http://lkml.org/lkml/2009/1/17/131
> >>>
> >>> (which is not yet merged, but appears to be close to consensus)
> >>>
> >>> The  rationale for this simplification is that any serious
> >>> 'container-init' would explicitly SIG_IGN all signals that it is
> >>> not interested in. So the only signals that would be in SIG_DFL
> >>> state would be SIGKILL/SIGSTOP.
> >>>
> >>> Effectively, testcase pidns21 will fail if/when the above patchset
> >>> (specifically, patch 5/6) is merged.
> >>>       
> >> Gowri,
> >>
> >> Kindly update this test when the patch makes into next stable kernel
> >> release.
> >>     
> >
> > Suka/Gowri,
> >
> > Are we still looking into these tests ?
> >   
> 
> 
> Anyone still looking into it ? Still i am getting failure for pidns21 
> with latest ltp release.

The patch in question is upstream, so pidns21.c will always
fail and should be removed from ltp.

It's worth testing that the container init survives SIGUSR1
from a child, but whether it survives or dies from a parent
we don't particularly care.

-serge

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
