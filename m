Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nu5HQ-0003GP-KP
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 14:40:28 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nu5HP-0005zV-20
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 14:40:28 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2NEZnSa015748
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 10:35:49 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2NEeHct058528
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 10:40:17 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2N7eGE9025085
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 01:40:16 -0600
Date: Tue, 23 Mar 2010 20:10:13 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100323144012.GC16182@linux.vnet.ibm.com>
References: <20100323122527.GA6017@chamarthy>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100323122527.GA6017@chamarthy>
Subject: Re: [LTP] [BUG] cgroup_fj tests fail to run due to missing
 cgroup_fj_testcases
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
To: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 23, 2010 at 05:55:27PM +0530, Srinivasa R Chamarthy wrote:
> Hi LTP,
> 
> cgroup_fj tests of controllers is currently failing due to missing file
> cgroup_fj_testcases after compilation. I see that the file cgroup_fj_testcases
> is existing in the source but it is not available in /opt/ltp after
> compilation.
> 
> FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2010_Mar_23-13h_22m_15s.failed
> Running tests.......
> <<<test_start>>>
> tag=cgroup_fj stime=1269346936
> cmdline="      run_cgroup_test_fj.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> Now, we start the test for cgroup...
> cat: cgroup_fj_testcases: No such file or directory
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=6 cstime=2
> <<<test_end>>>
> INFO: ltp-pan reported all tests PASS
> LTP Version: LTP-20100228
> 
> Eventhough the tests did not run, the results say all tests PASS. :)

For the above report here is the quick fix i can think.

commit 391e757d43b3ac33a4a435e319ee77b1daa6da76
Author: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Date:   Tue Mar 23 20:07:34 2010 +0530

    Fix the proper return for testcase.
    
    Reported By: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
    Signed-off By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

diff --git a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
index 7445725..672f37c 100755
--- a/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
+++ b/testcases/kernel/controllers/cgroup_fj/run_cgroup_test_fj.sh
@@ -129,4 +129,4 @@ do
        fi
 done
 
-exit 0;
+exit $ret;

> 
> -- 
> Srinivasa R Chamarthy (schamart@linux.vnet.ibm.com)
> Linux on System z (RedHat & Novell SuSE) CSVT,
> IBM India Systems & Technology Group/LTC - ISL,
> Bangalore - 560071, KA, INDIA. Off: +91-80-41776451 
> [ http://www.ibm.com/in/isl | http://www.ibm.com/linux/ltc ]
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

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
