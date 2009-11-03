Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1N5FWh-0006kM-T7
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 09:18:07 +0000
Received: from e28smtp09.in.ibm.com ([59.145.155.9])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5FWb-0002lO-4S
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 09:18:07 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id nA392xS7014582
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Nov 2009 14:32:59 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA39Hpxc2838590
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Nov 2009 14:47:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA39Hp2J000487
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Nov 2009 14:47:51 +0530
Message-ID: <4AEFF53D.1010908@in.ibm.com>
Date: Tue, 03 Nov 2009 14:47:49 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090506060005050801030808"
Subject: [LTP] [PATCH][RFC]Testcases mbind01.c and get_mempolicy01 fails
	with EINVAL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: "Rishikesh K. Rajak" <risrajak@in.ibm.com>

This is a multi-part message in MIME format.
--------------090506060005050801030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
	We observed that LTP test cases are failing when run on some of the distros

Problem Statement:

	I observed that test cases mbind01.c and get_mempolicy01.c are failing during call to 
get_mempolicy() with error -EINVAL.
	In the kernel code the error comes from
----------------------------------------------------------------

SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
                 unsigned long __user *, nmask, unsigned long, maxnode,
                 unsigned long, addr, unsigned long, flags)
{
         int err;
         int uninitialized_var(pval);
         nodemask_t nodes;

         if (nmask != NULL && maxnode < MAX_NUMNODES)
                 return -EINVAL;
                                                  <== in the kernel code,
MAX_NUMNODES comes to 512
----------------------------------------------------------------
Analysis:
	
	When kernel config option 'configure maximum number of SMP processors and NUMA node'  is 
set MAX_NUMNODES will be initialized to 512 and any call to get_mempolicy() with maxnode 
value  less than that cause the test to fail.
----------------------------------------------------------------
Fix:
	increase the default maxnode value in the test case to reflect this value. maxnode value 
comes from numaif.h and this patch increase the value to 512 from earlier 128.

Note:
	I will submit it in the format, once the patch is accepted

Thanks
Yeehaw


--------------090506060005050801030808
Content-Type: text/x-patch; name="increase_maxnode_to_sync_with_kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="increase_maxnode_to_sync_with_kernel.patch"

This patch fixes the issues noticed while running test case mbind01.c. The test case failed while making call to get_mempolicy system call. The system call fails with kernel returning -EINVAL. This issues is observed due to compatibiliy issue between kernel and ltp code. When kernel configure option 'configure maximum number of SMP processors and NUMA node' is enabled kernel will  initialize MAX_NUMNODES variable to 512. In the user space while calling get_mempolicy if user pass any value lesser than 512 for maxnode, the system calls fails with EINVAL. This patch addresses the issue by increasing the maxnode value to 512

Signed-off-by: Sharyathi Nagesh <sharyath@in.ibm.com>

Index: ltp/testcases/kernel/syscalls/utils/numaif.h
===================================================================
--- ltp.orig/testcases/kernel/syscalls/utils/numaif.h	2009-06-23 19:51:32.000000000 +0530
+++ ltp/testcases/kernel/syscalls/utils/numaif.h	2009-10-20 09:16:00.000000000 +0530
@@ -29,7 +29,7 @@
 #include "./include_j_h.h"
 #include "linux_syscall_numbers.h"
 
-#define NUMA_NUM_NODES 	128
+#define NUMA_NUM_NODES 	512	
 typedef struct { 
 	unsigned long n[NUMA_NUM_NODES/(sizeof(unsigned long)*8)];
 } nodemask_t;

--------------090506060005050801030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--------------090506060005050801030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090506060005050801030808--

