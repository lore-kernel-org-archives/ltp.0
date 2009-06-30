Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <svaidy@linux.vnet.ibm.com>) id 1MLgyL-0001KS-QZ
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 17:18:21 +0000
Received: from e28smtp07.in.ibm.com ([59.145.155.7])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLgyH-0003ft-Jq
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 17:18:20 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5UHIEeO030078
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 22:48:14 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UHIEsi2277622
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 22:48:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5UHIEkl030515
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 22:48:14 +0530
Date: Tue, 30 Jun 2009 22:47:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Message-ID: <20090630171744.GE8147@dirshya.in.ibm.com>
References: <1246362283.15408.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1246362283.15408.8.camel@localhost.localdomain>
Subject: Re: [LTP] [Patch 0/4]Addtional test scenarios & fixes for
	power	management testcases
Reply-To: svaidy@linux.vnet.ibm.com
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
Cc: ltp-list@lists.sourceforge.net

* Poornima Nayak <mpnayak@linux.vnet.ibm.com> [2009-06-30 17:14:43]:

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

Hi Poornima,

Can you CC me on the rest of the patch stack?  I got only 0/4!

--Vaidy

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
