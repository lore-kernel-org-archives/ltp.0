Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <schamart@linux.vnet.ibm.com>) id 1Ntdhb-0007mQ-KR
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 09:13:39 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ntdha-0006An-CB
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 09:13:39 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2M95wlE010895
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 20:05:58 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2M95wDF762020
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 20:05:58 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2M95vo2017789
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 20:05:57 +1100
Received: from localhost (chamarthy.in.ibm.com [9.124.33.99])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2M95vhl017745
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 20:05:57 +1100
Date: Mon, 22 Mar 2010 14:35:55 +0530
From: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Message-ID: <20100322090555.GA6154@chamarthy>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Subject: [LTP] memcg_function tests failing on s390
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


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi LTP,

The memcg_function tests were failing in s390 as the condition for checking
support for memory controller is not getting satisfied. Eventhough the cgroup
memory is enabled, the script comes out saying that the memory support is not
available in the kernel.

This patch changes the condition checking for memory cgroup support in kernel
in the script memcg_function_test.sh.

-- 
Srinivasa R Chamarthy (schamart@linux.vnet.ibm.com)
Linux on System z (RedHat & Novell SuSE) CSVT,
IBM India Systems & Technology Group/LTC - ISL,
Bangalore - 560071, KA, INDIA. Off: +91-80-41776451 
[ http://www.ibm.com/in/isl | http://www.ibm.com/linux/ltc ]

--17pEHd4RhPHOinZp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="memcg_function_patch.patch"

diff -Naurp memcg_function_test_old.sh memcg_function_test.sh
--- memcg_function_test_old.sh  2010-03-22 09:50:56.000000000 +0100
+++ memcg_function_test.sh      2010-03-22 09:52:52.000000000 +0100
@@ -30,7 +30,7 @@ export TCID="memcg_function_test"
 export TST_TOTAL=38
 export TST_COUNT=0
 
-if [ ! "grep -w memory /proc/cgroups | cut -f4" == "1" ]
+if [ "$(grep -w memory /proc/cgroups | cut -f4)" != "1" ]
 then
         echo "WARNING:";
         echo "Either Kernel does not support for memory resource controller or feature not enabled";
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--17pEHd4RhPHOinZp--

