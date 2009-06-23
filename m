Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7nV-00066u-Vh
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:20:33 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7nS-0007TW-B5
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:20:33 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NFGDrZ031930
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:16:13 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NFGOaK199302
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:20:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NFDme1007205
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:13:48 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090621111911.GB11977@webber.adilger.int>
References: <20090522213639.GC13578@webber.adilger.int>
	<bb33bcf20905230403n2e959d8fg1f463539b7cdb445@mail.gmail.com>
	<20090621111911.GB11977@webber.adilger.int>
Date: Tue, 23 Jun 2009 20:20:45 +0530
Message-Id: <1245768646.4860.93.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Lustre basic tests script
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
To: Andreas Dilger <adilger@sun.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>

On Sun, 2009-06-21 at 13:19 +0200, Andreas Dilger wrote: 
> On May 23, 2009  16:33 +0530, Subrata Modak wrote:
> > On Sat, May 23, 2009 at 3:06 AM, Andreas Dilger <adilger@sun.com> wrote:
> > 
> > > Below are included some of the tests from the Lustre "sanity.sh" script,
> > > which tests filesystem behaviour in a variety of ways.  Some of them are
> > > very simple and might concievably be removed, but are not necessarily bad.
> > > I've removed the tests that depend on Lustre-specific behaviour.
> > >
> > > It probably isn't useful to use this test script directly, since it
> > > depends on a number of helper functions, but it is definitely useful
> > > as a starting point for adding new tests to xfstests.
> > >
> > > Unfortunately, a bunch of tests had to be removed since they depend on
> > > Lustre's fault-injection code, but they would be useful for testing
> > > generic filesystem behaviour (e.g. ENOMEM or ENOSPC handling).  There
> > > is also a helper program we use "multiop" which is a toolbox program
> > > that I could supply separately, if you want.
> > 
> > 
> > How about understanding these and find out if they can be made part of LTP
> > as well  ? Any objection(s) ?
> 
> Sorry for the late response.  No objection to using these tests in LTP.

Thanks Andreas. When ready we will send you the integration patch for
your review.

Regards--
Subrata

> I've separatel posted the "multiop" program to this list so that you
> can better understand what the tests are doing.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Sr. Staff Engineer, Lustre Group
> Sun Microsystems of Canada, Inc.
> 
> 
> ------------------------------------------------------------------------------
> Are you an open source citizen? Join us for the Open Source Bridge conference!
> Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
> Need another reason to go? 24-hour hacker lounge. Register today!
> http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
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
