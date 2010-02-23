Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NjmzN-0000GG-MW
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 05:07:17 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjmzM-0005bN-Dq
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 05:07:17 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1N4xVgJ010281
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 21:59:31 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1N575AB121034
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 22:07:05 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1N574bZ017702
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 22:07:04 -0700
Date: Tue, 23 Feb 2010 10:37:01 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100223050701.GB11102@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Container Test should not run on older distro kernel
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

Hi All,

I ran feb'10 intermediate release on RHEL5.4. And found that it is
running pidns testcase which is not at all require.

Garret is it require to disable check_pidns_enabled.c which has been
masked for now ? I think we will need this file as it does more than
kernel version comparison.

can someone look into it please ?

Here are the failures which i am getting:

=====================================================================
...
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 31429     -n 31429  -p  -f
/tmp/ltp-wcBkk31437/alltests -l
/opt/ltp/results/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.log  -C
/opt/ltp/output/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.failed
LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.log
FAILED COMMAND File:
/opt/ltp/output/LTP_RUN_ON-2010_Feb_23-04h_51m_27s.failed
Running tests.......
<<<test_start>>>
tag=Containers stime=1266918687
cmdline="container_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
/opt/ltp/testcases/bin/container_test.sh: line 13: check_for_unshare:
command not found
Uts namespaces not enabled in kernel.  Not running utsns tests.
ipc namespaces not enabled in kernel.  Not running ipcns tests.
Running pidns tests.
pid_namespace1    0  TINFO  :  PIDNS test is running inside container

pid_namespace1    1  TFAIL  :  FAIL: Got unexpected result of cpid=31542
ppid=31541

pid_namespace2    0  TINFO  :  Checking session id & group id inside
container

pid_namespace2    1  TFAIL  :  Got unexpected result ofGroup ID = 31544
& Session ID = 31544

pid_namespace3    0  TINFO  :   Checking pid for parent ns and
container-init
		Parent namespace pid = 31545,container parent pid =
31545,and container pid = 31546
pid_namespace3    1  TFAIL  :  mount failed : 

pid_namespace3    2  TPASS  :  Got the proc file directory created by
parent ns 31545
pid_namespace4    1  TFAIL  :  got unexpected result of cpid=31548
ppid=31547
pid_namespace4    1  TFAIL  :  Container init is killed by SIGKILL !!!
pidns05     1  TFAIL  :  FAIL: Got unexpected result of cpid=31551
ppid=31550

pidns05     1  TFAIL  :  Unable to create 5 containers

pidns06     0  TINFO  :  Parent: Passing the pid of the process 31552
pidns06     1  TFAIL  :  Unexpected result for Container:  init
pid=31553 parent pid=31552

pidns30     1  TBROK  :  parent: mq_open() failed (Permission denied)
pidns31     1  TBROK  :  parent: mq_open() failed (Permission denied)
pidns10     1  TBROK  :  cinit: pidns is not created.
pidns10     1  TBROK  :  parent: container was terminated by Unknown
signal 0
pidns12     0  TINFO  :  parent: PID is 31558
pidns12     1  TBROK  :  cinit: pidns is not created.
pidns12     1  TBROK  :  parent: container did not respond!
pidns13     1  TBROK  :  cinit1: pidns is not created.
pidns13     1  TBROK  :  cinit2: pidns is not created.
pidns16     1  TBROK  :  pidns is not created.
pidns16     0  TINFO  :  sig_handler is signalled from pid  31563
pidns16     0  TINFO  :  Container: Resumed after receiving SIGUSR1 from
parentNS 
pidns16     2  TBROK  :  Unexpected value for Sending-ProcessID when
signal handler called 31564

pidns16     0  TINFO  :  Container: Resumed after sending SIGUSR1 from
container itself
pidns16     1  TPASS  :  container init continued successfuly, after
handling signal -USR1

pidns17     1  TBROK  :  cinit: pidns is not created.

<----- stuck here, i never get the shell back here :(.
============================================================

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
