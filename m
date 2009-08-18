Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <robbie@ubuntu.com>) id 1MdQB3-0005XM-Gq
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 15:00:45 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdQAy-0001R5-KK
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 15:00:45 +0000
Message-ID: <4A8AB639.8030000@ubuntu.com>
Date: Tue, 18 Aug 2009 09:10:01 -0500
From: Robbie Williamson <robbie@ubuntu.com>
MIME-Version: 1.0
References: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] Dead End with LTP Options
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Cai Qian <qcai@redhat.com>, Nate Straz <nate@refried.org>, "manoj.iyer" <manoj.iyer@canonical.com>

On 08/18/2009 04:07 AM, Subrata Modak wrote:
> Hi,
> 
> We are about to hit the dead end for LTP options with increasing no. of
> options being added to 'runltp' with each passing day. And even with
> line items i have for ltp in 2009 alone, it will easily add up to 3-4
> options.
> 
> Now, this will become a mess in future:
> 
>      1. "./runltp -h" will scroll up and will not show on a single
>         screen,
I really don't see this as a problem, as I'd expect someone running the ltp to
know how to |more....or |less. ;)

>      2. It will be difficult for users to remember all options and their
>         usage as no. of options increase manifold, which is already too
>         much.
Perhaps it's time to create a manpage?

> 
> While there is no doubt that we will keep adding more punch to ltp and
> the way it provisions tests in future, so, the time has come for us to
> adhere to a simpler process which can be easily:
> 
>      1. Used &
>      2. Maintained
> 
> I have no reservations of how it should be implemented, so, would like
> to hear from you on how it can be done best. I would like to see just
> the following command execute LTP as desired by the user:
> 
> ./runltp
> 
> And the remaining choice of providing more options to 'runltp' hidden
> somewhere.
> 
> Regards--
> Subrata
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
