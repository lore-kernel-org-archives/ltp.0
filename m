Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7X2-0002ov-1E
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:28 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Wt-0002DD-Rp
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:27 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7QWPT032595
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:26:32 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7UEM7257944
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:30:14 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7UDKg012784
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:30:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090820160723.30926.96672.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160723.30926.96672.sendpatchset@localhost.localdomain>
Date: Sun, 23 Aug 2009 12:59:39 +0530
Message-Id: <1251012580.16822.42.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to get max sched mc & smt values based on
	kernel	version
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
> Replaces shell function with C functions to get max sched_mc & sched_smt value.
> Since this uses LTP libraray function to analyze kernel version maintenence of the 
> code will be easier.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

> 
> 
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/get_sched_values.c ltp-full-20090731/testcases/kernel/power_management/get_sched_values.c
> --- ltp-full-20090731_orig/testcases/kernel/power_management/get_sched_values.c	1970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/get_sched_values.c	2009-08-20 20:38:13.000000000 +0530
> @@ -0,0 +1,53 @@
> +/************************************************************************
> +* Copyright (c) International Business Machines Corp., 2008
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License as published by
> +* the Free Software Foundation; either version 2 of the License, or
> +* (at your option) any later version.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> +* the GNU General Public License for more details.
> +* You should have received a copy of the GNU General Public License
> +* along with this program; if not, write to the Free Software
> +* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +*
> +***************************************************************************/
> +#include <stdio.h>
> +#include <test.h>
> +
> +int get_supp_sched_mc(void) {
> +	if (tst_kvercmp(2,6,29) < 0 )
> +		return 1;
> +	else
> +		return 2;
> +}
> +
> +int get_supp_sched_smt(void) {
> +	if (tst_kvercmp(2,6,29) < 0 )
> +		return 1;
> +	else
> +		return 2;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	char *param;
> +	if (argc == 0)
> +		return 1;
> +	else
> +	{
> +		param = argv[1];
> +		if (strcmp(param, "sched_mc")==0)
> +			if (get_supp_sched_mc() == 0)
> +				return 0;
> +			else
> +				return 1;
> +		if (strcmp(param, "sched_smt")==0)
> +                        if (get_supp_sched_smt() == 0)
> +                                return 0;
> +                        else
> +                                return 1;
> +	}
> +}
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
