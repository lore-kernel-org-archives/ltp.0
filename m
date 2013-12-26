Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6us-0002Lw-Js
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6ur-0000gb-LP
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:42 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97ZXo011178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:36 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97ZhP002120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:35 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97YIx002107
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:34 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:20 +0400
Message-Id: <1388048842-28373-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/5] rpc-tirpc-full-test-suite: fixed the cmdline in
	runtest
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
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

To make debugging easier we don't use run_rpc_test.sh but
use its own test case name for each test case.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/rpc                                        |    8 +++++++-
 runtest/stress.part3                               |    8 +++++++-
 .../rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh    |   12 +++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/runtest/rpc b/runtest/rpc
index c9e5f0d..7c18eda 100644
--- a/runtest/rpc
+++ b/runtest/rpc
@@ -2,7 +2,13 @@
 #
 # PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
 #
-run_rpc_tests.sh run_rpc_tests.sh
+rpc_addrmanagmt_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_addrmanagmt_basic_lib.sh
+rpc_auth_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_auth_basic_lib.sh
+rpc_broadc_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_broadc_basic_lib.sh
+rpc_createdestroy_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_createdestroy_basic_lib.sh
+rpc_err_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_err_basic_lib.sh
+rpc_regunreg_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_regunreg_basic_lib.sh
+rpc_stdcall_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_stdcall_basic_lib.sh
 rpc01 rpc01
 rpcinfo rpcinfo01
 rup rup01
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index bb4807c..57a5106 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -886,6 +886,12 @@ hangup01 hangup01
 mc_cmds mc_cmds
 mc_opts export TCsrc=$LTPROOT/testcases/network/multicast/mc_opts; mc_opts
 rpc01 export TCbin=$LTPROOT/testcases/network/rpc/basic_tests/rpc01; rpc01
-run_rpc_tests.sh export TCbin=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; run_rpc_tests.sh
+rpc_addrmanagmt_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_addrmanagmt_basic_lib.sh
+rpc_auth_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_auth_basic_lib.sh
+rpc_broadc_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_broadc_basic_lib.sh
+rpc_createdestroy_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_createdestroy_basic_lib.sh
+rpc_err_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_err_basic_lib.sh
+rpc_regunreg_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_regunreg_basic_lib.sh
+rpc_stdcall_basic_lib	cd $LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite; ./rpc_ts_run.sh -l rpc_stdcall_basic_lib.sh
 perf_lan perf_lan
 
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
index e3fca59..66be9b8 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
@@ -24,15 +24,17 @@
 # *** INITIALISATION ***
 # **********************
 
+LTPROOT=${LTPROOT:=$(readlink -f ../../../..)}
+
 # Indicates in which directory tests binaries are installed
-SERVERTSTPACKDIR=/home/lerouzic/benchs/ltp-full-20080930/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
-CLIENTTSTPACKDIR=/home/lerouzic/benchs/ltp-full-20080930/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
+SERVERTSTPACKDIR=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
+CLIENTTSTPACKDIR=$LTPROOT/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack
 # LOCALIP variable is computer IP/name used to run tests scripts
 # if LOCALIP = SERVERIP = CLIENTIP, that means all tests are in local mode
 # (run on the same machine)
-LOCALIP=localhost
-SERVERIP=localhost
-CLIENTIP=localhost
+LOCALIP=`hostname`
+SERVERIP=`hostname`
+CLIENTIP=`hostname`
 SERVERUSER=root
 CLIENTUSER=root
 # number of threads for thread tests
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
