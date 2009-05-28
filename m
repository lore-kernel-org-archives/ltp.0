Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1M9j1a-00032Y-Uf
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 17:04:14 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9j1Y-0008Cl-J1
	for ltp-list@lists.sourceforge.net; Thu, 28 May 2009 17:04:14 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4SH0Swo011502
	for <ltp-list@lists.sourceforge.net>; Thu, 28 May 2009 11:00:28 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4SH2iU4133324
	for <ltp-list@lists.sourceforge.net>; Thu, 28 May 2009 11:02:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4SH2hka013586
	for <ltp-list@lists.sourceforge.net>; Thu, 28 May 2009 11:02:44 -0600
Message-ID: <4A1EC3AC.2080901@in.ibm.com>
Date: Thu, 28 May 2009 22:32:36 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080205000001040201080301"
Subject: [LTP] [RFC] Patch getcpu01 testcase
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
To: ltp-list@lists.sourceforge.net, Subrata Modak <subrata@linux.vnet.ibm.com>, sharyath@in.ibm.com

This is a multi-part message in MIME format.
--------------080205000001040201080301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The getcpu01 always exits with a non-zero exit code (indicating a 
Failure as per UNIX semantics) on non-NUMA machines.

This is due to the following code :

            tst_resm(TWARN,
                    "/sys not mounted or not a numa system. Assuming one 
node: %s",
                         strerror(errno));


Being a non-NUMA machine is not a failure, but an info. So it should not 
cause the test to have a non zero exit status.

I have attached a patch which could do the same and provide a more 
friendly o/p.


Please apply.

Thanks
Suzuki

--------------080205000001040201080301
Content-Type: text/plain;
 name="fix-warning-getcpu01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-warning-getcpu01.diff"

Index: ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c
===================================================================
--- ltp-20081031.orig/testcases/kernel/syscalls/getcpu/getcpu01.c	2008-10-23 02:23:19.000000000 -0500
+++ ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c	2009-05-28 11:52:54.000000000 -0500
@@ -47,6 +47,8 @@
  * HISTORY
  *	06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
  *
+ *	05/2009 	Suzuki K P <suzuki@in.ibm.com>
+ *			Friendly messages for non-NUMA machines.
  * RESTRICTIONS
  *	none
  */
@@ -234,8 +236,10 @@
 
         directory_parent = opendir("/sys/devices/system/node");
         if (!directory_parent)  {
-                tst_resm(TWARN,
-                   "/sys not mounted or not a numa system. Assuming one node: %s",
+                tst_resm(TINFO,
+                        "/sys not mounted or not a numa system. Assuming one node");
+		tst_resm(TINFO,
+			"Reason /sys/devices/system/node :%s",
                         strerror(errno));
                	return 0; //By Default assume it to belong to node Zero 
         } else {

--------------080205000001040201080301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--------------080205000001040201080301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080205000001040201080301--

