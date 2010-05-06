Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v2J-0007d7-M8
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:19 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v2I-0001IZ-Bc
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:58:19 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466mKEo010124
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:48:20 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466wCDc145904
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466wBR3001778
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:11 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:28:02 +0530
Message-Id: <20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [08/12 FAILURE] LTPX clock gettime03 fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5219310779845186545=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============5219310779845186545==

Subject: LTP�� clock_gettime03 fails

Issue Description below:
=======================================
# ./runltp -s clock_gettime03
<<<test_output>>>
clock_gettime03    1  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14):
Bad address
clock_gettime03    2  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14):
Bad address
clock_gettime03    3  TFAIL  :  failed to produce expected error [expected
errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
clock_gettime03    4  TFAIL  :  failed to produce expected error [expected
errno = 22 (Invalid argument), TEST_RETURN = 0]: TEST_ERRNO=???(0): Success
clock_gettime03    5  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14):
Bad address
clock_gettime03    6  TPASS  :  got expected failure: TEST_ERRNO=EFAULT(14):
Bad address
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

SUZUKI K. POULOSE gave the following patch already. Not sure if it is
discussed in the mailing list:
--- include/common_timers.h.orig        2010-04-30 12:39:08.000000000 +0000
+++ include/common_timers.h     2010-04-30 12:39:46.000000000 +0000
@@ -35,7 +35,8 @@ clock_t clock_list[] = {
        CLOCK_THREAD_CPUTIME_ID,
        CLOCK_MONOTONIC_RAW,
 };
-#define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
+// #define MAX_CLOCKS (sizeof(clock_list) / sizeof(*clock_list))
+#define MAX_CLOCKS 16

 const char *get_clock_str(const int clock_id)
 {


The above patch fixes the problem. For more info, see linux/time.h for the
MAX_CLOCKS value.

Regards--
Subrata



--===============5219310779845186545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5219310779845186545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5219310779845186545==--
