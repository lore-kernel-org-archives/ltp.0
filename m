Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <veeren@linux.vnet.ibm.com>) id 1NSmev-0000fp-3V
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 07:19:53 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSmer-0004bB-6K
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 07:19:53 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o077AaAD031374
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 02:10:36 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o077Jheh036346
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 02:19:43 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o077JgWp011517
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 05:19:42 -0200
Received: from [127.0.0.1] ([9.124.33.55])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o077JdAb011480
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 05:19:41 -0200
Message-ID: <4B458B0A.9040304@linux.vnet.ibm.com>
Date: Thu, 07 Jan 2010 12:49:38 +0530
From: Veerendra C <veeren@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070804050306050509020005"
Subject: [LTP] capset01 patch
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070804050306050509020005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
 Here is a patch/attachment to fix the  error number and error message , 
when the capset() syscall fails.


*After applying patch:*
capset01    1    TBROK    capget() failed: errno=???(38): Function not 
implemented

*Before applying patch:*
capset01    1    TBROK    capget() failed: TEST_ERRNO=???(0): Success


Note: This is in the custom built linux kernel where the capset/capget 
syscall is not implemented. In normal linux kernel this testcase would 
just work fine without any errors.
*
Normal kernel:*
capset01    1  TPASS  :  capset() returned 0


Regards
Veerendra C


--------------070804050306050509020005
Content-Type: text/plain;
 name="capset01.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="capset01.patch"

--- testcases/kernel/syscalls/capset.orig/capset01.c	2010-01-06 13:29:07.000000000 +0530
+++ testcases/kernel/syscalls/capset/capset01.c	2010-01-06 13:50:12.000000000 +0530
@@ -89,6 +89,7 @@ static void cleanup();
 char *TCID = "capset01";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 extern int Tst_count;		/* Test Case counter for tst_* routines */
+static int exp_enos[] = { EFAULT, EINVAL, EPERM, 0 };
 
 static struct __user_cap_header_struct header;	/* cap_user_header_t is a pointer
 						   to __user_cap_header_struct */
@@ -143,6 +144,9 @@ void setup()
 	/* capture signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
+        /* Set up the expected error numbers for -e option */
+        TEST_EXP_ENOS(exp_enos);
+
 	/* Pause if that option was specified */
 	TEST_PAUSE;
 


--------------070804050306050509020005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--------------070804050306050509020005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070804050306050509020005--


