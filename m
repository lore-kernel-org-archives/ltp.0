Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqTo-0005DB-F9
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:44 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqTn-0002oI-Uk
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:51:44 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n66Fo5bT018733
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:50:05 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n66FpUrF233918
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:51:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n66FpKJV024557
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 09:51:20 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200907060426.57132.vapier@gentoo.org>
References: <1246864076.2865.35.camel@localhost.localdomain>
	<200907060426.57132.vapier@gentoo.org>
Date: Mon, 06 Jul 2009 21:21:04 +0530
Message-Id: <1246895464.4887.55.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP Build - Would it be possible to handle testcase	build
	failures without failing all the build process?
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
To: Lucas Meneghel Rodrigues <lmr@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Mon, 2009-07-06 at 04:26 -0400, Mike Frysinger wrote: 
> On Monday 06 July 2009 03:07:56 Lucas Meneghel Rodrigues wrote:
> > LTP does have a large amount of testcases, and most of the testcases are
> > independent from each other, thus IMHO, a single compilation failure
> > should not fail the whole build process, instead, the tests that could
> > not be compiled should be marked as BROKEN, and should not be executed
> > during LTP execution.

Yes, that would be great. And for that an m4 rule file has to be written
for each and every LTP test, checking:
1) Header dependency,
2) Library dependency, etc
before compiling.

Regards--
Subrata

> >
> > Do we have any plans to handle individual build failures in a way that
> > doesn't fail the whole build process?
> 
> use the -k option with make
> -mike
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
