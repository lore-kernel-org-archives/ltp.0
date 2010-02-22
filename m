Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NjbTm-0006w5-AS
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 16:49:54 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjbTi-00021b-HS
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 16:49:53 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1MGmDOW032653
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 09:48:13 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1MGnSvM046976
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 09:49:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1MGnRnO031402
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 09:49:27 -0700
Date: Mon, 22 Feb 2010 22:19:21 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100222164921.GC2992@linux.vnet.ibm.com>
References: <4B823681.7010300@linux.vnet.ibm.com>
	<OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
Subject: Re: [LTP] [ANNOUNCEMENT]: Intermediate release for FEB'10
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
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Vishukumar S Shetty <svishuku@in.ibm.com>

Hi Iranna,


Thanks for reporting this build failure and helping, as it will
really help to make ltp more stable.

Here is the quick patch i am attaching which solves the problem.

Signed-off By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
Tested By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>
---
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
b/testcases/kernel/syscalls/mbind/mbind01.c
index 5d7eb69..847186a 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -74,6 +74,7 @@ int  TST_TOTAL = 2;           /* total number of tests
in this file.   */
 #include <unistd.h>
 #include "include_j_h.h"
 #include "numa_helpers.h"
+#include <linux/mempolicy.h>
 
 #if ! defined(LIBNUMA_API_VERSION) || LIBNUMA_API_VERSION < 2
 

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
