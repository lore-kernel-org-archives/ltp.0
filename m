Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7X5-0005XH-Jt
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:31 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Wy-0004XU-72
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:31 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7L80D003299
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:21:08 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7UIYM223992
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:30:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7UIt0022637
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:30:18 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090820160714.30926.24455.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160714.30926.24455.sendpatchset@localhost.localdomain>
Date: Sun, 23 Aug 2009 12:59:43 +0530
Message-Id: <1251012583.16822.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to include workload for consolidation verification
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, 2009-08-20 at 21:37 +0530, Poornima Nayak wrote: 
> Modified to pass workload as a parameter for cpu cosolidation verifcation function.
> This is required to verify cpu consolidation on Hypre threaded system for kernbench workload.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/cpu_consolidation.py ltp-full-20090731/testcases/kernel/power_management/cpu_consolidation.py
> --- ltp-full-20090731_orig/testcases/kernel/power_management/cpu_consolidation.py	2009-08-20 19:59:11.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/cpu_consolidation.py	2009-08-20 20:39:25.000000000 +0530
> @@ -45,7 +45,7 @@ def main(argv=None):
>          duration=60
>          trigger_workld(options.work_ld, options.stress, duration, background)
>          generate_report()
> -        status = validate_cpu_consolidation(options.mc_level, options.smt_level)
> +        status = validate_cpu_consolidation(options.work_ld,options.mc_level, options.smt_level)
>          reset_schedmc()
>          if is_hyper_threaded():
>              reset_schedsmt()
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
