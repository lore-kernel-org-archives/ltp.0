Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v13-0005j8-T1
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:01 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v11-00024A-LN
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:57:01 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466kkAn016414
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:46:46 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466urHY118006
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 02:56:53 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o466urb5017577
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 03:56:53 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:26:42 +0530
Message-Id: <20100506065641.23879.24212.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [03/12 FAILURE] LTPX Memory Conroller test fails and hangs system for more than 12 hours
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6344221361730184854=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============6344221361730184854==

Subject: LTP�� Memory Conroller test fails and hangs system for more than 12 hours

Issue Description below:
==============================
# ./runltp -f test_controllers
TEST 1: MEMORY CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
Before task migration to group2
group2 memory usage: 0 Bytes
After task migration to group2
group2 memory usage: 0 Bytes
TPASS   Memory Resource Controller: Task Migration test 1 PASSED
Memory Resource Controller test executed successfully.
Cleanup called
/opt/ltp/testcases/bin/run_memctl_test.sh: line 87: [: -lt: unary operator
expected
TEST 2: MEMORY CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
Before task migration to group2
group2 memory usage: 0 Bytes
After task migration to group2 and doing malloc
group2 memory usage: 63045632 Bytes
TPASS   Memory Resource Controller: Task Migration test 2 PASSED
Memory Resource Controller test executed successfully.
Cleanup called
/opt/ltp/testcases/bin/run_memctl_test.sh: line 87: [: -lt: unary operator
expected
TEST 3: MEMORY CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
failcnt = 4498
TPASS   Memory Resource Controller: failcnt check test PASSED
Memory Resource Controller test executed successfully.
Cleanup called
/opt/ltp/testcases/bin/run_memctl_test.sh: line 87: [: -lt: unary operator
expected
TEST 4: MEMORY CONTROLLER TESTING
RUNNING SETUP.....
TEST STARTED: Please avoid using system while this test executes
TINFO   Memory Resource Controller: stat check test fails in first run
TFAIL   Memory Resource Controller: stat check test FAILED

Process infos are:
[root@mjs22lp1 ltp]# ps axjf
    1  1608  1608  1458 ?           -1 S        0   0:00 /bin/sh ./runltp -g
fc13_p6_kernel-2.6.33.1-19.fc13.ppc64_host-mjs22lp1_20100423_23:16:16.html
 1608  1724  1608  1458 ?           -1 S        0   0:00  \_
/opt/ltp/bin/ltp-pan -e -S -a 1608 -n 1608 -p -f /tmp/ltp-71wskF3epE/alltests
-l /opt/ltp/results/LTP_RUN_ON-20
 1724  1784  1784  1458 ?           -1 S        0   0:00      \_ /bin/bash
/opt/ltp/testcases/bin/test_controllers.sh
 1784 14666  1784  1458 ?           -1 S        0   0:00          \_ /bin/bash
/opt/ltp/testcases/bin/run_memctl_test.sh 4
14666 14682  1784  1458 ?           -1 R        0 733:20              \_
./memctl_task_1

Both strace and ltrace info does not wield any result:
[root@mjs22lp1 ltp]# strace -p 14682
Process 14682 attached - interrupt to quit
[root@mjs22lp1 ltp]# ltrace -p 14682

Regards--
Subrata



--===============6344221361730184854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6344221361730184854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6344221361730184854==--
