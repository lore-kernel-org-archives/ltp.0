Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VS2KD-0004uy-3W
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:33 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VS2KB-00023f-Ao
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:33 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  4 Oct 2013 14:09:02 +0400
Message-Id: <1380881342-13025-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 5/5] cpuset_base_ops_test: using tst_kvercmp2
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
Cc: vasily.isaenko@oracle.com, miaox@cn.fujitsu.com

RHEL6 kernel backported a fix to not produce
an error in case of writing '0-' to cpuset/N/{cpus,mems} file.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_base_ops_testset.sh                     |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 3fa905c..63a9dc5 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -128,7 +128,7 @@ test_cpus()
 		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
 	fi
 
-	tst_kvercmp 3 0 0
+	tst_kvercmp2 3 0 0 "RHEL6:2.6.32"
 	if [ $? -eq 0 ]; then
 		base_op_test "$CPUSET/1/cpus" "0-" "WRITE_ERROR"
 	else
@@ -164,7 +164,7 @@ test_mems()
 		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
 	fi
 
-	tst_kvercmp 3 0 0
+	tst_kvercmp2 3 0 0 "RHEL6:2.6.32"
 	if [ $? -eq 0 ]; then
 		base_op_test "$CPUSET/1/mems" "0-" "WRITE_ERROR"
 	else
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
