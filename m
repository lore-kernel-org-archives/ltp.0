Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MdKfb-0003EZ-As
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 09:07:55 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MdKfX-0006E7-4k
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 09:07:55 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 18 Aug 2009 14:37:11 +0530
Message-Id: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] Dead End with LTP Options
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
To: Mike Frysinger <vapier@gentoo.org>, Garrett Cooper <yanegomi@gmail.com>, Masatake YAMATO <yamato@redhat.com>, Cai Qian <qcai@redhat.com>, Paul Larson <paul.larson@canonical.com>, Robbie Williamson <robbie@ubuntu.com>, Nate Straz <nate@refried.org>, "manoj.iyer" <manoj.iyer@canonical.com>, Michael Reed <mreed10@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi,

We are about to hit the dead end for LTP options with increasing no. of
options being added to 'runltp' with each passing day. And even with
line items i have for ltp in 2009 alone, it will easily add up to 3-4
options.

Now, this will become a mess in future:

     1. "./runltp -h" will scroll up and will not show on a single
        screen,
     2. It will be difficult for users to remember all options and their
        usage as no. of options increase manifold, which is already too
        much.

While there is no doubt that we will keep adding more punch to ltp and
the way it provisions tests in future, so, the time has come for us to
adhere to a simpler process which can be easily:

     1. Used &
     2. Maintained

I have no reservations of how it should be implemented, so, would like
to hear from you on how it can be done best. I would like to see just
the following command execute LTP as desired by the user:

./runltp

And the remaining choice of providing more options to 'runltp' hidden
somewhere.

Regards--
Subrata



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
