Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1N0BLL-0005zq-4F
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 09:49:27 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N0BLF-0006eV-58
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 09:49:27 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9K9f9Ft010021
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 05:41:09 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9K9n4gj2322500
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 05:49:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9K9mvK8018768
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 05:48:57 -0400
From: poornima nayak <mpnayak@linux.vnet.ibm.com>
Date: Mon, 21 Sep 2009 12:08:16 +0530
Message-Id: <1253515096.6109.21.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [LTP] [Patch 0/6] New test scenarios & fixes for Power Management
 testcases
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
Cc: Arun <arun@linux.vnet.ibm.com>, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

Hi 

Did demo of Power management testcases to the Linux Kernel developers in
IBM. Outcome of the demo is 
- Inclusion of another test scenario for CPU consolidation testing for
existing testcases in LTP.
- 'workload' as a test variable for CPU consolidation testing can be
dropped. After dropping Workload as test variable test execution time of
Power Management testing has reduced significantly.
- Only the Timer migration interface testing testcase will be included
in LTP.

So this patchset will have 
-Additional 5 new testcases
-Fixes in master script and library functions as workload is no more
test variable.
-Fixes in reusable functions for issues observed during development of
testcases.

Above fix has been tested on Hyper threaded system and did not observe
any failures so far. Some more testing has to be done, will continue
testing on other architectures and provide fixs before this month end
release.
 
Regards
Poornima


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
