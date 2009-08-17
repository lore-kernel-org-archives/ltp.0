Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Md13b-0003KE-Av
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:11:23 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Md13V-0001n3-DL
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 12:11:23 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HC7TaU016812
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:07:29 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HCB7CJ163580
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:11:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HCB6lp008359
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Aug 2009 06:11:07 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2009 17:40:50 +0530
Message-Id: <20090817121048.8902.12251.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
References: <20090817120835.8902.4597.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [RESULTS v2] Results of test run for "Fault Injection
	Framework"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

Again comes the actual test output the framework will generate. Below are the test
results with and without this Infrastructure on my following machine:

# uname -a
Linux 2.6.29-gcov #1 SMP Fri Jun 19 12:14:27 IST 2009 i686 i686 i386 GNU/Linux

================================================================================
# ./runltp -f math -o ltp_without_fault_injection.out
================================================================================
<<<test_start>>>
tag=abs01 stime=1250492520
cmdline="abs01"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01 stime=1250492520
cmdline="atof01"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01 stime=1250492520
cmdline="fptest01"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02 stime=1250492520
cmdline="fptest02"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01 stime=1250492520
cmdline="nextafter01"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
================================================================================


================================================================================
# ./runltp -f math -F 6,15 -o ltp_with_fault_injection.out
================================================================================
<<<test_start>>>
tag=abs01 stime=1250492531
cmdline="abs01"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_1under_fault_kernel stime=1250492531
cmdline="$LTPROOT/tools/insert_kernel_faults.sh 15; abs01"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_2under_fault_kernel stime=1250492531
cmdline=" abs01 "
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_3under_fault_kernel stime=1250492531
cmdline=" abs01 "
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_4under_fault_kernel stime=1250492531
cmdline=" abs01 "
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_5under_fault_kernel stime=1250492531
cmdline=" abs01 "
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=abs01_loop_6under_fault_kernel stime=1250492531
cmdline=" abs01 ; $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; while [ $RC -ne 0 ]; do $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; done"
contacts=""
analysis=exit
<<<test_output>>>
abs01       1  TPASS  :  Test passed
abs01       2  TPASS  :  Test passed
abs01       3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=atof01 stime=1250492531
cmdline="atof01"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_1under_fault_kernel stime=1250492531
cmdline="$LTPROOT/tools/insert_kernel_faults.sh 15; atof01"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_2under_fault_kernel stime=1250492531
cmdline=" atof01 "
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_3under_fault_kernel stime=1250492531
cmdline=" atof01 "
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_4under_fault_kernel stime=1250492531
cmdline=" atof01 "
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_5under_fault_kernel stime=1250492531
cmdline=" atof01 "
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=atof01_loop_6under_fault_kernel stime=1250492531
cmdline=" atof01 ; $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; while [ $RC -ne 0 ]; do $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; done"
contacts=""
analysis=exit
<<<test_output>>>
atof01      1  TPASS  :  Test passed
atof01      2  TPASS  :  Test passed
atof01      3  TPASS  :  Test passed
atof01      4  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest01 stime=1250492531
cmdline="fptest01"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_1under_fault_kernel stime=1250492531
cmdline="$LTPROOT/tools/insert_kernel_faults.sh 15; fptest01"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_2under_fault_kernel stime=1250492531
cmdline=" fptest01 "
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_3under_fault_kernel stime=1250492531
cmdline=" fptest01 "
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_4under_fault_kernel stime=1250492531
cmdline=" fptest01 "
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_5under_fault_kernel stime=1250492531
cmdline=" fptest01 "
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest01_loop_6under_fault_kernel stime=1250492531
cmdline=" fptest01 ; $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; while [ $RC -ne 0 ]; do $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; done"
contacts=""
analysis=exit
<<<test_output>>>
fptest01    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest02 stime=1250492531
cmdline="fptest02"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_1under_fault_kernel stime=1250492531
cmdline="$LTPROOT/tools/insert_kernel_faults.sh 15; fptest02"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_2under_fault_kernel stime=1250492531
cmdline=" fptest02 "
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_3under_fault_kernel stime=1250492531
cmdline=" fptest02 "
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_4under_fault_kernel stime=1250492531
cmdline=" fptest02 "
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_5under_fault_kernel stime=1250492531
cmdline=" fptest02 "
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=fptest02_loop_6under_fault_kernel stime=1250492531
cmdline=" fptest02 ; $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; while [ $RC -ne 0 ]; do $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; done"
contacts=""
analysis=exit
<<<test_output>>>
fptest02    1  TPASS  :  PASS
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=nextafter01 stime=1250492531
cmdline="nextafter01"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_1under_fault_kernel stime=1250492531
cmdline="$LTPROOT/tools/insert_kernel_faults.sh 15; nextafter01"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_2under_fault_kernel stime=1250492531
cmdline=" nextafter01 "
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_3under_fault_kernel stime=1250492531
cmdline=" nextafter01 "
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_4under_fault_kernel stime=1250492531
cmdline=" nextafter01 "
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_5under_fault_kernel stime=1250492531
cmdline=" nextafter01 "
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=nextafter01_loop_6under_fault_kernel stime=1250492531
cmdline=" nextafter01 ; $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; while [ $RC -ne 0 ]; do $LTPROOT/tools/restore_kernel_faults_default.sh; RC=$?; done"
contacts=""
analysis=exit
<<<test_output>>>
nextafter01    1  TPASS  :  Test passed
nextafter01    2  TPASS  :  Test passed
nextafter01    3  TPASS  :  Test passed
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=1 cstime=2
<<<test_end>>>
================================================================================

Regards--
Subrata


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
