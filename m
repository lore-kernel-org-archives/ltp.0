Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MzaOR-000074-Fo
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 18:22:11 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MzaOJ-0006Q7-9m
	for ltp-list@lists.sourceforge.net; Sun, 18 Oct 2009 18:22:11 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9IIB21x019490
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 12:11:02 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9IILtnR165326
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 12:21:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9IILtds020096
	for <ltp-list@lists.sourceforge.net>; Sun, 18 Oct 2009 12:21:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A0780153D6ED@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780153D6ED@svexch01.mvista.com>
Date: Sun, 18 Oct 2009 23:51:36 +0530
Message-Id: <1255890097.5359.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][mq_* clock_nanosleep01] change use of signal
	to	sigaction for more reliability, fix time issue
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
To: Henry Yei <hyei@mvista.com>, Jiri Palecek <jpalecek@web.de>, Randy Vinson <rvinson@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Thu, 2009-10-15 at 19:48 -0700, Henry Yei wrote: 
> All,
> 
> Here are three patches the help with the issue where these tests miss a signal and hang. The original patches were created before the latest check-ins by jpalecek@web.de , but I believe they still help. I've regenerated the patches against CVS source and tested on a multi-core machine running MVL6 (x86 2.6.28) 
> 
> The clock_nanosleep01 patch changes signal to the more reliable sigaction().
> 
> mq_timedsend01 patch changes from signal() to sigaction() and corrects the time-specs
> used by the test. Timespec's passed to mq_timedsend are abs time, not relative
> time. The patch adds the current time to convert relative time to abs time but
> only if the change won't invalidate the test objective. For example, if the
> test would have passed -1 for tv_sec to cause an invalid time error, adding the
> current time would prevent the expected error.
> 
> mq_timedrecieve01.patch changes from signal() to sigaction() and corrects the time-specs
> used by the test. Timespec's passed to mq_timedreceive are abs time, not
> relative
> time. The patch adds the current time to convert relative time to abs time but
> only if the change won't invalidate the test objective. For example, if the
> test would have passed -1 for tv_sec to cause an invalid time error, adding the
> current time would prevent the expected error. The timeout for SIGINT test is
> extended to allow time for the signal to arrive.
> 
> Original patches provided by Randy Vinson <rvinson@mvista.com>
> 
> Signed-off by: Henry Yei <hyei@mvista.com>

Thanks.

Regards--
Subrata

> 
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
