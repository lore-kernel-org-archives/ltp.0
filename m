Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mfso1-000380-4j
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:59:09 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mfsnw-0007SE-Jy
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:59:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9nhNW009025
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:49:43 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9wu9b203906
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:56 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9wukN002160
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:56 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908241626v22effcd2p5ab84bc4f81e9352@mail.gmail.com>
References: <364299f40908221131h75bad0bdm85d5831cf8bddeda@mail.gmail.com>
	<1251012586.16822.44.camel@subratamodak.linux.ibm.com>
	<364299f40908241626v22effcd2p5ab84bc4f81e9352@mail.gmail.com>
Date: Tue, 25 Aug 2009 15:28:30 +0530
Message-Id: <1251194311.5534.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Schedule for makefile-infra-rework to hit HEAD
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, 2009-08-24 at 16:26 -0700, Garrett Cooper wrote: 
> On Sun, Aug 23, 2009 at 12:29 AM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> > On Sat, 2009-08-22 at 11:31 -0700, Garrett Cooper wrote:
> >> Hi all,
> >>     Given the fact that the intermediate date has already passed for
> >> the August snapshot, the earliest date that I can have this hit the
> >> tree is right after the August release. I want a full cycle of testing
> >> to be done for any and all nits to be worked out with my changes, so
> >> committing now would be foolish.
> >>     I'm working on out-of-buildtree support, as I found a few nits
> >> during this process so I'll commit the critical items as soon as
> >> possible. Would anyone oppose me committing after the August snapshot
> >> given that it works at the same level of functionality as the current
> >> version (and improves upon it in a number of other areas)?
> >
> > Let me try the basic sanity checking. I would update you Garret.
> 
> Ok. I'm really close to finishing off out-of-buildtree support (~1.5
> weeks with my other work), so I hope to add that seemingly `minor'
> functionality before committing next month. It required some changes
> to master_rules.mk because I wasn't approaching the problem correctly
> 100% in some areas, and some of the code wasn't as portable as it
> should have been, and plus I wasn't following auto[conf|make]
> convention 100%.
> 
> I'll recommit to the branch and generate another standard diff and an
> rdiff so folks can run patch directly.

Would be great.

Regards--
Subrata

> 
> Thanks!
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
