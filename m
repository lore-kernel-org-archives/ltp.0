Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLfud-0007rE-2U
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:27 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLfuZ-0004bH-6O
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:27 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UG73q6019758
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:07:03 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UGAIGv137920
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:10:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UGAHEZ028307
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:10:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090630145725.11163.50654.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
	<20090630145725.11163.50654.sendpatchset@localhost.localdomain>
Date: Tue, 30 Jun 2009 21:40:14 +0530
Message-Id: <1246378214.6978.10.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 3/10]Readme modified with pre-requisite
	for	sched_mc=2 test
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
Cc: ltp-list@lists.sourceforge.net


On Tue, 2009-06-30 at 20:27 +0530, Poornima Nayak wrote:
> [Patch 3/10]Readme modified with pre-requisite for sched_mc=2 test
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/README ltp_patched/testcases/kernel/power_management/README
> --- ltp_orig/testcases/kernel/power_management/README	2009-06-30 15:04:19.000000000 +0530
> +++ ltp_patched/testcases/kernel/power_management/README	2009-06-30 16:31:17.000000000 +0530
> @@ -80,3 +80,5 @@ Then either configuration is not set or 
>  For CPU consolidation verification ebizzy is included in utils directory of LTP.
>  To run cpu consolidation test user has to provide -w <workload> -l <sched_mc_level>.
>  Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for details of ebizzy.
> +
> +To test CPU consolidation for sched_mc 2 kernbench has to run. Kernbench needs linux kernel source as input in /root directory . For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2. If Linux kernel source not found kernbench wiil  not execute.
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
