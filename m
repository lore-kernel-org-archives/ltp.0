Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoL9-0001Xj-NA
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:37:19 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoL5-0004g2-JZ
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:37:19 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHZNKf020820
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:35:23 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHb9Sh146026
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:37:09 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHb9Kt018083
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 11:37:09 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101457.12177.8327.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
	<20090828101457.12177.8327.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:06:42 +0530
Message-Id: <1251653804.12120.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 3/8] Patch to integrate ILB testcase to LTP
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

On Fri, 2009-08-28 at 15:44 +0530, Poornima Nayak wrote: 
> Patch to integrate ILB testcase to LTP
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/Makefile ltp/testcases/kernel/power_management/Makefile
> --- ltp_orig/testcases/kernel/power_management/Makefile	2009-08-28 10:54:59.000000000 +0530
> +++ ltp/testcases/kernel/power_management/Makefile	2009-08-28 12:28:50.000000000 +0530
> @@ -49,6 +49,7 @@ install:
>  	ln -f  check_cpuidle_sysfs_files.sh ../../bin/check_cpuidle_sysfs_files.sh;
>  	ln -f  cpu_consolidation.py ../../bin/cpu_consolidation.py
>  	ln -f  sched_domain.py ../../bin/sched_domain.py
> +	ln -f  ilb_test.py ../../bin/ilb_test.py
>  	chmod ugo+x *.sh
>  clean:
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
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
