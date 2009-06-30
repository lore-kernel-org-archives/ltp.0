Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLftz-0007lA-DH
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:09:47 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLftx-00028c-Us
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 16:09:47 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UG8weK017969
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:08:58 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UG9bsw180544
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:09:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UG9br2001489
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 10:09:37 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1246362283.15408.8.camel@localhost.localdomain>
References: <1246362283.15408.8.camel@localhost.localdomain>
Date: Tue, 30 Jun 2009 21:39:33 +0530
Message-Id: <1246378174.6978.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 0/4]Addtional test scenarios & fixes for
	power	management testcases
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
To: poornima nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vaidy <svaidy@linux.vnet.ibm.com>

Thanks that you considered for this release. May be you would like to
send them a little early next time.

Regards--
Subrata

On Tue, 2009-06-30 at 17:14 +0530, poornima nayak wrote: 
> Hi,
> 
> On doing demo of LTP testcases to developers we realized some more test
> scenarios has to be added to LTP testcases for better test coverage.
> Also some bug fixes has to be done for existing test cases to run on
> future versions on Linux Kernel.
> We also want to integrate kernbench in LTP for sched_mc_power_savings=2.
> Hence this list of patches include patches to integrate kernbench into
> LTP. The test also covers consolidation at core level for hyper threaded
> system.
> 
> Regards
> Poornima
> 
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
