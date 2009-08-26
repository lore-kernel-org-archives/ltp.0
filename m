Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MgCfZ-0002Hh-Bd
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 07:11:45 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgCfQ-0002RX-LA
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 07:11:45 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7Q79TD9031992
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 01:09:29 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7Q7BToq247340
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 01:11:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7Q7BSOY016093
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Aug 2009 01:11:28 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908251909m7ed3e630r475500b21b16a54f@mail.gmail.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
	<4A928BD0.4000508@canonical.com>
	<1251195139.5534.32.camel@subratamodak.linux.ibm.com>
	<4A945616.7000805@canonical.com>
	<364299f40908251909m7ed3e630r475500b21b16a54f@mail.gmail.com>
Date: Wed, 26 Aug 2009 12:41:19 +0530
Message-Id: <1251270680.19240.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 00/02] Integrate Valgrind Memory Check Tool to LTP
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, 2009-08-25 at 19:09 -0700, Garrett Cooper wrote: 
> On Tue, Aug 25, 2009 at 2:22 PM, Paul Larson<paul.larson@canonical.com> wrote:
> > Subrata Modak wrote:
> >
> >>> really just to "test the tests", would it make sense to put it under
> >>> /scratch or /testscripts as a separate script, rather than just include
> >>> it as yet-another-option for runltp?
> >>
> >> But, creating another script say under testscripts will be to duplicate
> >> again runltp code, as the same script should be able to parse all the
> >> options what we use with runltp. So, keeping it in runltp will just a
> >> little overhead. And, may be we can introduce some longoptions or
> >> manpage for ltp as suggested by people earlier !!
> >
> > It doesn't need to have anywhere near the same options available as
> > under runltp.  Other than being able to specify a set of tests to run, I
> > can't really think of a need for many of the others.
> 
> Rather than make runltp into a huge long-options setup, why not
> separate out the common functionality in runltp into a library, make

Hmmm. I do not know how to do this. Can you show me. I can then try.

> it source-able from runltp, runltp-lite, and whatever script is used
> to call valgrind?

Till then, lets have this extended options in runltp.

Regards--
Subrata

> Thanks,
> -Garrett


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
