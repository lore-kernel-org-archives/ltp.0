Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N8FcE-0006Ux-93
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 16:00:14 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N8Fc9-00083U-69
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 16:00:14 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nABFmJKR029479
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 08:48:19 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nABFxqjk106376
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 08:59:53 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nABG1TPx009270
	for <ltp-list@lists.sourceforge.net>; Wed, 11 Nov 2009 09:01:30 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091111001059.GA30122@us.ibm.com>
References: <4948C6E4.8080801@linux.vnet.ibm.com>
	<49491512.9000905@linux.vnet.ibm.com>
	<1229578051.5149.11.camel@subratamodak.linux.ibm.com>
	<20090214203139.GA10969@us.ibm.com>
	<1234762145.7791.13.camel@subratamodak.linux.ibm.com>
	<1245768501.4860.56.camel@subratamodak.linux.ibm.com>
	<4AF8F73E.10506@linux.vnet.ibm.com> <20091111001059.GA30122@us.ibm.com>
Date: Wed, 11 Nov 2009 21:29:42 +0530
Message-Id: <1257955182.27679.14.camel@subratamodak.linux.ibm.com>
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, gowrishankar.muthukrishna@gmail.com, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Nadia Derbey <Nadia.Derbey@bull.net>

On Tue, 2009-11-10 at 18:10 -0600, Serge E. Hallyn wrote: 
> Quoting Rishikesh (risrajak@linux.vnet.ibm.com):
> > Subrata Modak wrote:
> > > On Mon, 2009-02-16 at 10:59 +0530, Subrata Modak wrote: 
> > >   
> > >> Thanks Suka,
> > >>
> > >> On Sat, 2009-02-14 at 12:31 -0800, Sukadev Bhattiprolu wrote:
> > >>     
> > >>> Subrata Modak [subrata@linux.vnet.ibm.com] wrote:
> > >>> | 
> > >>> | > > pidns21:
> > >>> | > >    The pidns21.c testcase verifies that container-init is terminated
> > >>> | > >    by SIGUSR1 when:
> > >>> | > >       - a handler is specified for SIGUSR1,
> > >>> | > >       - container-init blocks SIGUSR1,
> > >>> | > >       - parent queues SIGUSR1 and
> > >>> | > >       - handler for SIGUSR1 is set to system default before SIGUSR1 is 
> > >>> | > > unblocked.
> > >>>
> > >>> I know I had acked this test before, but back then the actual implementation
> > >>> of the signal semantics in the kernel were not complete.
> > >>>
> > >>> To simplify the implementation of the semantics, it was decided that
> > >>> SIGKILL/SIGSTOP would be the only reliable signals from a parent
> > >>> container. IOW, container-init would ignore SIGUSR1 or SIGINT, SIGQUIT
> > >>> etc even if sent from a parent container.
> > >>>
> > >>> See patchset/discussion:
> > >>>
> > >>> 	http://lkml.org/lkml/2009/1/17/131
> > >>>
> > >>> (which is not yet merged, but appears to be close to consensus)
> > >>>
> > >>> The  rationale for this simplification is that any serious
> > >>> 'container-init' would explicitly SIG_IGN all signals that it is
> > >>> not interested in. So the only signals that would be in SIG_DFL
> > >>> state would be SIGKILL/SIGSTOP.
> > >>>
> > >>> Effectively, testcase pidns21 will fail if/when the above patchset
> > >>> (specifically, patch 5/6) is merged.
> > >>>       
> > >> Gowri,
> > >>
> > >> Kindly update this test when the patch makes into next stable kernel
> > >> release.
> > >>     
> > >
> > > Suka/Gowri,
> > >
> > > Are we still looking into these tests ?
> > >   
> > 
> > 
> > Anyone still looking into it ? Still i am getting failure for pidns21 
> > with latest ltp release.
> 
> The patch in question is upstream, so pidns21.c will always
> fail and should be removed from ltp.

Ok. I did that just now.

Regards--
Subrata

> 
> It's worth testing that the container init survives SIGUSR1
> from a child, but whether it survives or dies from a parent
> we don't particularly care.
> 
> -serge


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
