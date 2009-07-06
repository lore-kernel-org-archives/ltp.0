Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MNqT0-0000dn-W2
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:50:54 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNqSp-000883-7Q
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:50:44 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n66FdgSX002242
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:39:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n66FoXvq252756
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:50:33 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n66Fm4DV019178
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Jul 2009 11:48:04 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078BC18DD@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078BC18DD@svexch01.mvista.com>
Date: Mon, 06 Jul 2009 21:20:27 +0530
Message-Id: <1246895427.4887.44.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][syscalls] change io_* testcases to run directly
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-07-01 at 16:34 -0700, Henry Yei wrote: 
> Again, I forgot the subject..
> 
> It looks like the io_*.sh files are now not needed since the test source has been modified to check for an autoconf definition.
> This patch modifies the syscalls runtest file to call those test directly. (io_cancel, io_destroy01, io_getevents01, io_setup01, io_submit01)
> 
> As the scripts are not needed any more, can we remove the following?
> 
> ltp/testcases/kernel/syscalls/io_cancel01.sh
> ltp/testcases/kernel/syscalls/io_destroy01.sh
> ltp/testcases/kernel/syscalls/io_getevents0101.sh
> ltp/testcases/kernel/syscalls/io_setup01.sh
> ltp/testcases/kernel/syscalls/io_submit01.sh

Removing reference from runtest/syscalls is ok. But, how about removing
the actual scritps ? Send me a patch for that :-)

Regards--
Subrata

> 
> These scripts were not being copied into testcases/bin anyway and so AFAIK, were not being run correctly by pan anyway.
> 
> Henry Yei
> MontaVista Software, Inc.
> hyei@mvista.com
> 
> 
>  
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
