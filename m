Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvaO-0003qs-P4
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:12 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvaI-0002VO-4m
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:12 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BFElO003872
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:15:14 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BK0u3190998
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:00 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BJxhe017621
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:00 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A717D05.2070603@petalogix.com>
References: <20090730075802.GE3058@console-pimps.org>
	<4A717D05.2070603@petalogix.com>
Date: Mon, 03 Aug 2009 16:49:55 +0530
Message-Id: <1249298395.7460.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] fcntl24,25,26 fail when run on tmpfs
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
To: michal.simek@petalogix.com, Matt Fleming <matt@console-pimps.org>
Cc: ltp-list@lists.sourceforge.net

On Thu, 2009-07-30 at 12:59 +0200, Michal Simek wrote: 
> Hi Matt,
> > Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
> > the host is running on tmpfs. The reason being that, as documented here
> > http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
> > cannot work on tmpfs.

Thanks for this patch, except that it does not have a Signed-off-by:
Matt Fleming <matt@console-pimps.org>, though i have added the same in
CVS log message:
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl24.c?view=log,
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl25.c?view=log,
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl26.c?view=log,

> >   
> I tested it and works. The same issue is for RAMFS. But for this fs in
> necessary to create
> tst_is_cwd_ramfs function. Maybe worth to add together
> tst_is_cwd_tmpfs.c and tst_cwd_has_free.c too.

Thanks Michal for testing this.

Regards--
Subrata

> 
> Regards,
> Michal
> 
> >   
> > ------------------------------------------------------------------------
> >
> > ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> > trial. Simplify your report design, integration and deployment - and focus on 
> > what you do best, core application coding. Discover what's new with 
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
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
