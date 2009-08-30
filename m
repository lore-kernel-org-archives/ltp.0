Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoMJ-0004Ke-80
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:31 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoMC-00043D-5s
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:38:31 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHViT3009040
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:31:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHcIG1258072
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:38:18 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHcIOA028657
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:38:18 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101539.12177.96172.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
	<20090828101539.12177.96172.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:07:05 +0530
Message-Id: <1251653828.12120.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 8/8]Patch to modify Readme file as
	new	functionality testcase is integrated
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
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Fri, 2009-08-28 at 15:45 +0530, Poornima Nayak wrote: 
> Updated Readme w.r.t new testcases
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Last one also through.

Regards--
Subrata

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/README ltp/testcases/kernel/power_management/README
> --- ltp_orig/testcases/kernel/power_management/README	2009-08-28 10:54:59.000000000 +0530
> +++ ltp/testcases/kernel/power_management/README	2009-08-28 12:31:08.000000000 +0530
> @@ -82,3 +82,6 @@ To run cpu consolidation test user has t
>  Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for details of ebizzy.
> 
>  To test CPU consolidation for sched_mc 2 kernbench has to run. Kernbench needs linux kernel source as input in /root directory . For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2. If Linux kernel source not found kernbench wiil  not execute.
> +CPU consolidation testcases will not execute if number of CPU's in package is less then 2. If system is hyper threaded but number of CPU is 1 only sched_smt testcases will be excuted. For better coverage of testcases select a system which is atleast quad core and then hyper threaded so that you will observe 8 CPU's in each package.
> +
> +Timer migration interface test will execute on kernel versions 2.6.31 and above. Timer migration functionality verification testcases will be executed only on suitable architecture like quad core or the number of CPU's in each package should be atleast 4 and above
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
