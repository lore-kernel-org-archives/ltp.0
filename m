Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1MLbn2-0005J6-Ue
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 11:46:20 +0000
Received: from [32.97.182.138] (helo=e8.ny.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLbn1-0002xD-8n
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 11:46:20 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5UBYfct019402
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:34:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5UBjSDA176642
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:45:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5UBh3pA007933
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 07:43:03 -0400
From: poornima nayak <mpnayak@linux.vnet.ibm.com>
Date: Tue, 30 Jun 2009 17:14:43 +0530
Message-Id: <1246362283.15408.8.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [LTP] [Patch 0/4]Addtional test scenarios & fixes for power
 management testcases
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
To: ltp-list@lists.sourceforge.net
Cc: vaidy <svaidy@linux.vnet.ibm.com>

Hi,

On doing demo of LTP testcases to developers we realized some more test
scenarios has to be added to LTP testcases for better test coverage.
Also some bug fixes has to be done for existing test cases to run on
future versions on Linux Kernel.
We also want to integrate kernbench in LTP for sched_mc_power_savings=2.
Hence this list of patches include patches to integrate kernbench into
LTP. The test also covers consolidation at core level for hyper threaded
system.

Regards
Poornima


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
