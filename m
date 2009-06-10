Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MEI18-0002No-Fe
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2009 07:14:38 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEI0n-0005RP-74
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2009 07:14:38 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n5A7EAX4023864
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 12:44:10 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A7E9P52023608
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 12:44:09 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n5A7E9uT011531
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2009 12:44:09 +0530
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-QOPrrCn/uXIs9yD8RNW+"
Date: Wed, 10 Jun 2009 12:44:35 +0530
Message-Id: <1244618075.10778.4.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: [LTP] [PATCH]get_mempolicy01: fix for changing failure due
	to	configuration error
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
To: ltp-list@lists.sourceforge.net


--=-QOPrrCn/uXIs9yD8RNW+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is the attachment to fix the configuration error in
get_mempolicy01.c
Actually it should not fail due to configuration error. So changed the
necessary.

Thanks
Muni

--=-QOPrrCn/uXIs9yD8RNW+
Content-Disposition: attachment; filename=get_mempolicy01.patch
Content-Type: text/x-patch; name=get_mempolicy01.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c	2009-06-10 07:08:08.000000000 -0400
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c	2009-06-10 07:12:16.000000000 -0400
@@ -296,7 +296,7 @@
                         TEST(rc = syscall(__NR_set_mempolicy, tc->policy,&nodemask, maxnode));
 
 		if (TEST_RETURN < 0) {
-			tst_resm(TFAIL, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TCONF, "set_mempolicy() failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         result = 1;
 			cleanup();
                         tst_exit();
@@ -307,7 +307,7 @@
                 // mmap memory
                 p = mmap(NULL, len, PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
                 if (p == (void*)-1) {
-			tst_resm(TFAIL, "malloc failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
+			tst_resm(TCONF, "malloc failed - errno = %d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         result = 1;
 			cleanup();
                         tst_exit();

--=-QOPrrCn/uXIs9yD8RNW+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--=-QOPrrCn/uXIs9yD8RNW+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-QOPrrCn/uXIs9yD8RNW+--


