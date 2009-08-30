Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoM7-0001dr-Mf
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:19 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoM1-00025J-M7
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:19 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHairf029514
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:36:44 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHc7gN247006
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:38:07 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHc7gA023049
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:38:07 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101531.12177.80803.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
	<20090828101531.12177.80803.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:06:59 +0530
Message-Id: <1251653822.12120.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 7/8] Patch for cpu_consolidation
	to	incorporate	changes in reusable function
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Fri, 2009-08-28 at 15:45 +0530, Poornima Nayak wrote: 
> Patch for cpu_consolidation to incorporate changes in reusable function
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Fine.

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/cpu_consolidation.py ltp/testcases/kernel/power_management/cpu_consolidation.py
> --- ltp_orig/testcases/kernel/power_management/cpu_consolidation.py	2009-08-28 10:54:59.000000000 +0530
> +++ ltp/testcases/kernel/power_management/cpu_consolidation.py	2009-08-28 12:17:34.000000000 +0530
> @@ -43,7 +43,8 @@ def main(argv=None):
>          print "INFO: Created table mapping cpu to package"
>          background="no"
>          duration=60
> -        trigger_workld(options.work_ld, options.stress, duration, background)
> +        pinned ="no"
> +        trigger_workld(options.work_ld, options.stress, duration, background, pinned)
>          generate_report()
>          status = validate_cpu_consolidation(options.work_ld,options.mc_level, options.smt_level)
>          reset_schedmc()
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
