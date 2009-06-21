Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <adilger@sun.com>) id 1MIL8l-0005h5-3x
	for ltp-list@lists.sourceforge.net; Sun, 21 Jun 2009 11:23:15 +0000
Received: from sca-es-mail-2.sun.com ([192.18.43.133])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.69) id 1MIL6A-0007YB-Tc
	for ltp-list@lists.sourceforge.net; Sun, 21 Jun 2009 11:23:15 +0000
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id
	n5LBJZ9L028152 for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Jun 2009 04:19:35 -0700 (PDT)
MIME-version: 1.0
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16
	2009)) id <0KLL0020062E9Y00@fe-sfbay-09.sun.com> for
	ltp-list@lists.sourceforge.net; 
	Sun, 21 Jun 2009 04:19:35 -0700 (PDT)
Date: Sun, 21 Jun 2009 13:19:11 +0200
From: Andreas Dilger <adilger@sun.com>
In-reply-to: <bb33bcf20905230403n2e959d8fg1f463539b7cdb445@mail.gmail.com>
Message-id: <20090621111911.GB11977@webber.adilger.int>
References: <20090522213639.GC13578@webber.adilger.int>
	<bb33bcf20905230403n2e959d8fg1f463539b7cdb445@mail.gmail.com>
Subject: Re: [LTP] Lustre basic tests script
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
To: Subrata Modak <tosubrata@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>

On May 23, 2009  16:33 +0530, Subrata Modak wrote:
> On Sat, May 23, 2009 at 3:06 AM, Andreas Dilger <adilger@sun.com> wrote:
> 
> > Below are included some of the tests from the Lustre "sanity.sh" script,
> > which tests filesystem behaviour in a variety of ways.  Some of them are
> > very simple and might concievably be removed, but are not necessarily bad.
> > I've removed the tests that depend on Lustre-specific behaviour.
> >
> > It probably isn't useful to use this test script directly, since it
> > depends on a number of helper functions, but it is definitely useful
> > as a starting point for adding new tests to xfstests.
> >
> > Unfortunately, a bunch of tests had to be removed since they depend on
> > Lustre's fault-injection code, but they would be useful for testing
> > generic filesystem behaviour (e.g. ENOMEM or ENOSPC handling).  There
> > is also a helper program we use "multiop" which is a toolbox program
> > that I could supply separately, if you want.
> 
> 
> How about understanding these and find out if they can be made part of LTP
> as well  ? Any objection(s) ?

Sorry for the late response.  No objection to using these tests in LTP.
I've separatel posted the "multiop" program to this list so that you
can better understand what the tests are doing.

Cheers, Andreas
--
Andreas Dilger
Sr. Staff Engineer, Lustre Group
Sun Microsystems of Canada, Inc.


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
