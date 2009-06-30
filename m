Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLfud-0001GL-Qb
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:27 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLfuY-0001QJ-9r
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:26 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UG736i019757
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:07:03 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UGA6U3105330
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:10:08 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UGA5xH010380
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:10:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090630145716.11163.65234.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
	<20090630145716.11163.65234.sendpatchset@localhost.localdomain>
Date: Tue, 30 Jun 2009 21:40:02 +0530
Message-Id: <1246378202.6978.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 2/10]Makefile patch to integrate to LTP
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
> [Patch 2/10]Makefile patch to integrate to LTP
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Checked in.

> 
> diff -uprN ltp_orig/utils/benchmark/Makefile ltp_patched/utils/benchmark/Makefile
> --- ltp_orig/utils/benchmark/Makefile	2009-06-30 15:04:20.000000000 +0530
> +++ ltp_patched/utils/benchmark/Makefile	2009-06-30 15:12:52.000000000 +0530
> @@ -18,7 +18,7 @@
>  ####
>  ################################################################################
> 
> -SUBDIRS := ebizzy-0.3
> +SUBDIRS := ebizzy-0.3 kernbench-0.42
> 
>  configure:
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
> @@ -27,6 +27,6 @@ all: configure
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
> 
>  install:
> -
> +	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
>  clean:
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
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
