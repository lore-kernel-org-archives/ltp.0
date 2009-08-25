Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsnL-0002Qg-N8
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:27 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfsnH-00034U-T5
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:27 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7PA2RJg028556
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 06:02:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9wItj253912
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:58:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9tLqx028851
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:55:21 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A92DCAE.5060102@redhat.com>
References: <4A92DCAE.5060102@redhat.com>
Date: Tue, 25 Aug 2009 15:28:13 +0530
Message-Id: <1251194293.5534.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Bug in memory controller test - memctl test #4
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
To: Mike Gahagan <mgahagan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-08-24 at 14:32 -0400, Mike Gahagan wrote: 
> When running the Memory Controller test # 4, I'm seeing this behavior below.
> 
> TEST 4: MEMORY CONTROLLER TESTING
> RUNNING SETUP.....
> TEST STARTED: Please avoid using system while this test executes
> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh: 
> line 327: [: 62955520: unary operator expected
> TINFO   Memory Resource Controller: stat check test fails in first run
> /mnt/tests/kernel/distribution/ltp/20090731/ltp-full-20090731/testcases/bin/run_memctl_test.sh: 
> line 364: [: 78704640: unary operator expected
> TFAIL   Memory Resource Controller: stat check test FAILED
> *** infinite loop here, script exists memctl_test01 remains running ***
> ^Cincrementing stop
> 
> The bash error is due to the 'grep -w "active"' not matching anything so 
> one of the variables isn't getting set like it is supposed to. I believe 
> the test was written with an old version of the memory controller what 
> put a field called memory.stat.active in the file memory.stat. The 

Correct. Somebody needs to revisit these tests, as the ABIs has changed.
Thanks for pointing that out. However, your patch has the following
problem:

1) Missing Signed-off-by:
2) missing header for unified diff at line 3 of patch
patching file testcases/kernel/controllers/memctl/run_memctl_test.sh

Please look into them when you send a patch next time ;-)

Regards--
Subrata

> current memory controller I am testing appears to have replaced this 
> field with "rss". There are fields showing anonymous and file backed 
> pages in memory.stat, but I don't think they are ever going to match the 
> memory.usage.in.bytes the test is looking for. Rss always matches and I 
> believe that is what we should update the check in the test to look for. 
> The attached patch fixes test #4 to compare memory.usage.in.bytes with rss.
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
