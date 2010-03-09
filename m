Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NotPT-00054H-0t
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 06:59:19 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NotPS-0004ps-2o
	for ltp-list@lists.sourceforge.net; Tue, 09 Mar 2010 06:59:18 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o296pPFC021308
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 23:51:25 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o296x24p113384
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 23:59:02 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o296x1ao009833
	for <ltp-list@lists.sourceforge.net>; Mon, 8 Mar 2010 23:59:01 -0700
Date: Tue, 9 Mar 2010 12:28:52 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100309065852.GA5875@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Fix for running freezer testcases
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
To: LTP <ltp-list@lists.sourceforge.net>
Cc: Matt Helsley <matthltc@linux.vnet.ibm.com>

commit 58854395050b8a3bb2fa4e5e4401546925f6aad8
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Tue Mar 9 12:24:47 2010 +0530

    Commenting "make all" in run_freezer.sh file as it is stopping to
run the freezer testcase
    

    Signed-off By: Rishikesh K Rajak<risrajak@linux.vnet.ibm.com>

diff --git a/testcases/kernel/controllers/freezer/run_freezer.sh
b/testcases/kernel/controllers/freezer/run_freezer.sh
index 3baf968..f66e321 100755
--- a/testcases/kernel/controllers/freezer/run_freezer.sh
+++ b/testcases/kernel/controllers/freezer/run_freezer.sh
@@ -69,7 +69,8 @@ function test_setup()
        export LTPBIN PATH TCID TST_COUNT TST_TOTAL CGROUPS_TESTROOT
        tst_resm TINFO "Preparing to run: ${P} $@"
 
-       make all
+       # this is not require here
+       #make all
 }
 
 function test_prereqs()

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
