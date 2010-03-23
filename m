Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nu3wb-0007fh-L7
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 13:14:53 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nu3wZ-0004ym-To
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 13:14:53 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2ND3BdA001132
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 09:03:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2NDEjK9159038
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 09:14:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2NDEiLm003442
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 10:14:44 -0300
Date: Tue, 23 Mar 2010 18:44:38 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100323131438.GA16182@linux.vnet.ibm.com>
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


Hi Srini,

Thanks for reporting failure.

Yes, looks like this commit is doing the changes from cgroup_fj_testcases to
cgroup_fj_testcases.sh .

commit 223e12ee3f7fdb525746462747954552f0e07538
Author: Garrett Cooper <yanegomi@gmail.com>
Date:   Mon Mar 8 07:46:02 2010 -0800

    Fix install for cgroup_fj_testcases.
    
    Turns out this script wasn't being installed properly, and thus its
testcases were failing; fix by suffixing with .sh
    
    Signed-off-by: Garrett Cooper <yanegomi@gmail.com>



Let me have a look tomorrow where went wrong.
-Rishi
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
