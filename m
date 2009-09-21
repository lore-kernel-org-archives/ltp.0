Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mpldu-0004Gt-BF
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:34 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mpldn-00039x-PF
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:34 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LGHL48028038
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:17:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LGLIsi087698
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:21:18 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LGLHAv021390
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 10:21:17 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090921072502.7307.58886.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
	<20090921072502.7307.58886.sendpatchset@localhost.localdomain>
Date: Mon, 21 Sep 2009 21:50:24 +0530
Message-Id: <1253550026.6736.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 3/6] To incorporate changes in reusable function
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

On Mon, 2009-09-21 at 12:55 +0530, Poornima Nayak wrote: 
> ILB testcase uses trigger workload to pin a task to CPU. This patch is to incorporate the changes in
> the prototype of function testcase invokes to trigger workload.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090831/testcases/kernel/power_management/ilb_test.py ltp-full-20090831_patched/testcases/kernel/power_management/ilb_test.py
> --- ltp-full-20090831/testcases/kernel/power_management/ilb_test.py	2009-08-31 10:45:45.000000000 +0530
> +++ ltp-full-20090831_patched/testcases/kernel/power_management/ilb_test.py	2009-09-21 12:13:26.205934090 +0530
> @@ -42,13 +42,15 @@ def main(argv=None):
>          background="no"
>          duration=60
>          pinned="yes"
> -        trigger_workld(options.work_ld, "single_job", duration, background, pinned)
> +
> +        trigger_workld(options.smt_level,options.work_ld, "single_job", duration, background, pinned)
>          generate_loc_intr_report()
>          status = validate_ilb(options.mc_level, options.smt_level)
>          reset_schedmc()
>          if is_hyper_threaded():
>              reset_schedsmt()
> -        return(status)        
> +        return(status)     
> +   
>      except Exception, details:
>          print "INFO: Idle Load Balancer test failed", details
>          return(1)
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
