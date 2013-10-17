Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VWjhm-0005it-CN
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 09:17:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VWjhk-0003Ww-BY
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 09:17:18 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9H9H9LI032161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 09:17:10 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9H9H8G1000843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 09:17:09 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9H9H82B000826
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Oct 2013 09:17:08 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 17 Oct 2013 13:17:03 +0400
Message-Id: <1382001423-19290-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] memcg_control: revert memory.use_hierarchy value to 0
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

Documentation/cgroups/memory.txt states that "Enabling/disabling will
fail if either the cgroup already has other cgroups created below it,
or if the parent cgroup has use_hierarchy enabled."

memcg_control_test.sh sets global memory.use_hierarchy value to 1 before
the execution of its own tests but doesn't revert it back to 0 after
they complete.

It causes failures of memcg_stat_test.sh and memcg_use_hierarchy_test.sh
testcases if runtest/controllers is run twice on the same host.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../memcg/control/memcg_control_test.sh            |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index dfc1302..fa50516 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -146,6 +146,8 @@ while [ $TST_NUM -le $TST_TOTAL ]; do
 	: $((TST_NUM += 1))
 done
 
+echo 0 > mnt/memory.use_hierarchy 2> /dev/null
+
 cleanup
 
 if [ "$FAILED_CNT" -ne 0 ]; then
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
