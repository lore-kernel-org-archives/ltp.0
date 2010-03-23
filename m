Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <schamart@linux.vnet.ibm.com>) id 1Nu3SX-00046R-0n
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 12:43:49 +0000
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nu3SU-00085r-Bc
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 12:43:48 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2NCLh1T007013
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 23:21:43 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2NCPTfk1814544
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 23:25:29 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2NCPT0c006685
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 23:25:29 +1100
Received: from localhost ([9.124.218.7])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2NCPRNh006652
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Mar 2010 23:25:28 +1100
Date: Tue, 23 Mar 2010 17:55:27 +0530
From: Srinivasa R Chamarthy <schamart@linux.vnet.ibm.com>
Message-ID: <20100323122527.GA6017@chamarthy>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [BUG] cgroup_fj tests fail to run due to missing
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
To: ltp-list@lists.sourceforge.net

Hi LTP,

cgroup_fj tests of controllers is currently failing due to missing file
cgroup_fj_testcases after compilation. I see that the file cgroup_fj_testcases
is existing in the source but it is not available in /opt/ltp after
compilation.

FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2010_Mar_23-13h_22m_15s.failed
Running tests.......
<<<test_start>>>
tag=cgroup_fj stime=1269346936
cmdline="      run_cgroup_test_fj.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
Now, we start the test for cgroup...
cat: cgroup_fj_testcases: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=6 cstime=2
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100228

Eventhough the tests did not run, the results say all tests PASS. :)

-- 
Srinivasa R Chamarthy (schamart@linux.vnet.ibm.com)
Linux on System z (RedHat & Novell SuSE) CSVT,
IBM India Systems & Technology Group/LTC - ISL,
Bangalore - 560071, KA, INDIA. Off: +91-80-41776451 
[ http://www.ibm.com/in/isl | http://www.ibm.com/linux/ltc ]

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
