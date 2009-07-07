Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCeO-0006EX-Dj
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:08 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCeN-0002lE-NE
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:08 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FPL9I012483
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:25:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FW70q130444
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FW6Re012049
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 11:32:06 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078D0105B@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078BC18DD@svexch01.mvista.com>
	<1246895427.4887.44.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078D0105B@svexch01.mvista.com>
Date: Tue, 07 Jul 2009 21:02:01 +0530
Message-Id: <1246980721.5539.41.camel@subratamodak.linux.ibm.com>
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

On Mon, 2009-07-06 at 16:31 -0700, Henry Yei wrote: 
> Here is the patch to remove the unneeded scripts for the io_* tests, which should be used in conjunction with the previous patch for the syscalls patch. 
> 

Thanks.

Regards--
Subrata

> Thanks,
> 
> -----Original Message-----
> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com] 
> Sent: Monday, July 06, 2009 8:50 AM
> To: Henry Yei
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH][syscalls] change io_* testcases to run directly
> 
> On Wed, 2009-07-01 at 16:34 -0700, Henry Yei wrote: 
> > Again, I forgot the subject..
> > 
> > It looks like the io_*.sh files are now not needed since the test source has been modified to check for an autoconf definition.
> > This patch modifies the syscalls runtest file to call those test 
> > directly. (io_cancel, io_destroy01, io_getevents01, io_setup01, 
> > io_submit01)
> > 
> > As the scripts are not needed any more, can we remove the following?
> > 
> Edited, my paths and file names were way incorrect.
> > ltp/testcases/kernel/syscalls/io_cancel/run-io_cancel.sh
> > ltp/testcases/kernel/syscalls/io_destroy/run-io_destroy.sh
> > ltp/testcases/kernel/syscalls/io_getevents/run-io_getevents.sh
> > ltp/testcases/kernel/syscalls/io_setup/run-io_setup.sh
> > ltp/testcases/kernel/syscalls/io_submit/run-io_submit.sh
> 
> Removing reference from runtest/syscalls is ok. But, how about removing the actual scritps ? Send me a patch for that :-)
> 
> Regards--
> Subrata
> 
> > 
> > These scripts were not being copied into testcases/bin anyway and so AFAIK, were not being run correctly by pan anyway.
> > 
> > Henry Yei
> > MontaVista Software, Inc.
> > hyei@mvista.com
> > 
> > 
> >  
> > ----------------------------------------------------------------------
> > -------- _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
