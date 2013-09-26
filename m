Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VP8qp-0006id-Fc
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:15 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VP8ql-00055w-AK
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:15 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Sep 2013 14:30:35 +0400
Message-Id: <1380191440-18171-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/7] cpuset/cpuset_base_ops_test: fix expected error
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

At least since kernel 3.0.0 writing '0-' to
$CPUSET/N/{cpus, mems} files doesn't raise an error.
Reading content of these files after writing gives '0'.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_base_ops_testset.sh                     |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 8b21210..126eec5 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -117,7 +117,6 @@ test_cpus()
 		0-$((nr_cpus-1))			0-$((nr_cpus-1))
 		-1					WRITE_ERROR
 		0-$nr_cpus				WRITE_ERROR
-		0-					WRITE_ERROR
 		0--$((nr_cpus-1))			WRITE_ERROR
 		0,1-$((nr_cpus-2)),$((nr_cpus-1))	0-$((nr_cpus-1))
 		0,1-$((nr_cpus-2)),			0-$((nr_cpus-2))
@@ -125,6 +124,13 @@ test_cpus()
 		AAA					WRITE_ERROR
 	EOF
 	# while read cpus result
+
+	tst_kvercmp 3 0 0
+	if [ $? -eq 0 ]; then
+		base_op_test "$CPUSET/1/cpus" "0-" "WRITE_ERROR"
+	else
+		base_op_test "$CPUSET/1/cpus" "0-" "0"
+	fi
 }
 
 test_mems()
@@ -144,7 +150,6 @@ test_mems()
 		0-$((nr_mems-1))			0-$((nr_mems-1))
 		-1					WRITE_ERROR
 		0-$nr_mems				WRITE_ERROR
-		0-					WRITE_ERROR
 		0--$((nr_mems-1))			WRITE_ERROR
 		0,1-$((nr_mems-2)),$((nr_mems-1))	0-$((nr_mems-1))
 		0,1-$((nr_mems-2)),			0-$((nr_mems-2))
@@ -152,6 +157,13 @@ test_mems()
 		AAA					WRITE_ERROR
 	EOF
 	# while read mems result
+
+	tst_kvercmp 3 0 0
+	if [ $? -eq 0 ]; then
+		base_op_test "$CPUSET/1/mems" "0-" "WRITE_ERROR"
+	else
+		base_op_test "$CPUSET/1/mems" "0-" "0"
+	fi
 }
 
 test_flags()
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
