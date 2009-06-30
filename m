Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLfv5-00029O-GT
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:55 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLfur-0002NY-5P
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:10:42 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UFvuSw010571
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 11:57:56 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UGAeLq240328
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 12:10:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UGAddT015740
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 12:10:40 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090630145833.11163.78843.sendpatchset@localhost.localdomain>
References: <20090630145706.11163.54040.sendpatchset@localhost.localdomain>
	<20090630145833.11163.78843.sendpatchset@localhost.localdomain>
Date: Tue, 30 Jun 2009 21:40:31 +0530
Message-Id: <1246378232.6978.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 10/10]Patch to add another command file in runtest
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


On Tue, 2009-06-30 at 20:28 +0530, Poornima Nayak wrote:
> [Patch 10/10]Patch to add another command file in runtest
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

The last one also done.

Regards--
Subrata

> 
> diff -uprN ltp_orig/runtest/power_management_tests_exclusive ltp_patched/runtest/power_management_tests_exclusive
> --- ltp_orig/runtest/power_management_tests_exclusive	1970-01-01 05:30:00.000000000 +0530
> +++ ltp_patched/runtest/power_management_tests_exclusive	2009-06-30 16:25:28.000000000 +0530
> @@ -0,0 +1 @@
> +POWER_MANAGEMENT runpwtests.sh -exclusive
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
