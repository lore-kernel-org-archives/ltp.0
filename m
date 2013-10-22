Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1VYYBF-0007Ya-8m
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 09:23:13 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VYYBB-0003Nk-Ip
	for ltp-list@lists.sourceforge.net; Tue, 22 Oct 2013 09:23:13 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9M9N2bh020121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 09:23:03 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9M9N1P4004520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 09:23:01 GMT
Received: from abhmt108.oracle.com (abhmt108.oracle.com [141.146.116.60])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9M9N1pN004514
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Oct 2013 09:23:01 GMT
From: shuang.qiu@oracle.com
Date: Tue, 22 Oct 2013 17:22:34 +0800
Message-Id: <1382433754-25025-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] Fix cgroup_regression_test.sh script issue
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

From: Shuang Qiu <shuang.qiu@oracle.com>

Testcase cgroup sometimes fail although there is no bug found.
Initialize the exit status to fix it.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 .../controllers/cgroup/cgroup_regression_test.sh   |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index f5e0b4b..356c000 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -28,6 +28,8 @@ export TCID="cgroup_regression_test"
 export TST_TOTAL=10
 export TST_COUNT=1
 
+failed=0
+
 tst_kvercmp 2 6 29
 if [ $? -eq 0 ]; then
 	tst_brkm TCONF ignored "test must be run with kernel 2.6.29 or newer"
@@ -523,7 +525,7 @@ for ((cur = 1; cur <= $TST_TOTAL; cur++))
 	test_$cur
 }
 
-rmdir cgroup/
+rmdir -p cgroup/*
 
 exit $failed
 
-- 
1.7.7


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
