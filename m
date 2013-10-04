Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VS2KH-0007J5-PR
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:37 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VS2K9-00023U-Pq
	for ltp-list@lists.sourceforge.net; Fri, 04 Oct 2013 10:09:37 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri,  4 Oct 2013 14:09:01 +0400
Message-Id: <1380881342-13025-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/5] controllers/cpuset: required number of nodes
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

Initially these testcases required a host with 4 CPUs
and 3 memory nodes minumum. This prevented to run the
testcases on widely used 2-memory-nodes configuration.

And in fact the testcases only need 2 memory nodes, and
a few needs 4 CPUs.

Modified the checks accordingly. Now "ideal" minumum
configuration of a host is 4 CPUs and 2 memory nodes.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_base_ops_testset.sh                     |   14 ++++++++++----
 .../kernel/controllers/cpuset/cpuset_funcs.sh      |   15 +++++++++------
 .../cpuset_load_balance_test.sh                    |    3 +--
 .../cpuset_sched_domains_test.sh                   |    3 +--
 .../cpuset_memory_spread_testset.sh                |    1 -
 .../cpuset_memory_test/cpuset_memory_testset.sh    |    1 -
 .../cpuset_syscall_test/cpuset_syscall_testset.sh  |   14 ++++++++++++--
 7 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index be28c4b..3fa905c 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -118,13 +118,16 @@ test_cpus()
 		-1					WRITE_ERROR
 		0-$nr_cpus				WRITE_ERROR
 		0--$((nr_cpus-1))			WRITE_ERROR
-		0,1-$((nr_cpus-2)),$((nr_cpus-1))	0-$((nr_cpus-1))
-		0,1-$((nr_cpus-2)),			0-$((nr_cpus-2))
 		0AAA					WRITE_ERROR
 		AAA					WRITE_ERROR
 	EOF
 	# while read cpus result
 
+	if [ $nr_cpus -ge 3 ]; then
+		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2)),$((nr_cpus-1))" "0-$((nr_cpus-1))"
+		base_op_test "$CPUSET/1/cpus" "0,1-$((nr_cpus-2))," "0-$((nr_cpus-2))"
+	fi
+
 	tst_kvercmp 3 0 0
 	if [ $? -eq 0 ]; then
 		base_op_test "$CPUSET/1/cpus" "0-" "WRITE_ERROR"
@@ -151,13 +154,16 @@ test_mems()
 		-1					WRITE_ERROR
 		0-$nr_mems				WRITE_ERROR
 		0--$((nr_mems-1))			WRITE_ERROR
-		0,1-$((nr_mems-2)),$((nr_mems-1))	0-$((nr_mems-1))
-		0,1-$((nr_mems-2)),			0-$((nr_mems-2))
 		0AAA					WRITE_ERROR
 		AAA					WRITE_ERROR
 	EOF
 	# while read mems result
 
+	if [ $nr_mems -ge 3 ]; then
+		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2)),$((nr_mems-1))" "0-$((nr_mems-1))"
+		base_op_test "$CPUSET/1/mems" "0,1-$((nr_mems-2))," "0-$((nr_mems-2))"
+	fi
+
 	tst_kvercmp 3 0 0
 	if [ $? -eq 0 ]; then
 		base_op_test "$CPUSET/1/mems" "0-" "WRITE_ERROR"
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index edca7b4..3419a11 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -65,16 +65,16 @@ version_check()
 
 ncpus_check()
 {
-	if [ $NR_CPUS -lt 4 ]; then
-		tst_brkm TCONF ignored "The total of CPUs is less than 4"
+	if [ $NR_CPUS -lt $1 ]; then
+		tst_brkm TCONF ignored "The total of CPUs is less than $1"
 		return 1
 	fi
 }
 
 nnodes_check()
 {
-	if [ $N_NODES -lt 3 ]; then
-		tst_brkm TCONF ignored "The total of nodes is less than 3"
+	if [ $N_NODES -lt $1 ]; then
+		tst_brkm TCONF ignored "The total of nodes is less than $1"
 		return 1
 	fi
 }
@@ -103,6 +103,9 @@ cpuset_check()
 	return 1
 }
 
+# optional parameters (pass both or none of them):
+# $1 - required number of cpus (default 2)
+# $2 - required number of memory nodes (default 2)
 check()
 {
 	user_check
@@ -120,12 +123,12 @@ check()
 		exit 0
 	fi
 
-	ncpus_check
+	ncpus_check ${1:-2}
 	if [ $? -ne 0 ]; then
 		exit 0
 	fi
 
-	nnodes_check
+	nnodes_check ${2:-2}
 	if [ $? -ne 0 ]; then
 		exit 0
 	fi
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
index 8ba7222..7123019 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_load_balance_test.sh
@@ -28,11 +28,10 @@ export TST_COUNT=1
 
 . cpuset_funcs.sh
 
-check
+check 4 2
 
 exit_status=0
 
-# must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
index 53675ec..014bc74 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_sched_domains_test.sh
@@ -28,11 +28,10 @@ export TST_COUNT=1
 
 . cpuset_funcs.sh
 
-check
+check 4 2
 
 exit_status=0
 
-# must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index ae1bc09..ad989f3 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -31,7 +31,6 @@ export TST_COUNT=1
 check
 
 exit_status=0
-# must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 315f759..e8ef6bf 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -32,7 +32,6 @@ check
 
 exit_status=0
 
-# must >= 3 for: 1-$((nr_mems-2))
 nr_cpus=$NR_CPUS
 nr_mems=$N_NODES
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
index 587e912..561c3b9 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_testset.sh
@@ -32,6 +32,8 @@ check
 
 exit_status=0
 
+nr_mems=$N_NODES
+
 TEST_CPUSET="$CPUSET/0"
 TEST_OUTPUT="$CPUSET_TMP/result"
 TEST_PROCSTATUS="$CPUSET_TMP/status"
@@ -276,14 +278,22 @@ test12()
 
 test13()
 {
-	do_syscall_test 0 0-1 --set_mempolicy=6 0 || return 1
+	if [ $nr_mems -ge 3 ]; then
+		do_syscall_test 0 0-1 --set_mempolicy=6 0 || return 1
+	else
+		do_syscall_test 0 0-1 --set_mempolicy=2 0 || return 1
+	fi
 	check_result "1"
 	return $?
 }
 
 test14()
 {
-	do_syscall_test 0 0 --set_mempolicy=6 1 || return 1
+	if [ $nr_mems -ge 3 ]; then
+		do_syscall_test 0 0 --set_mempolicy=6 1 || return 1
+	else
+		do_syscall_test 0 0 --set_mempolicy=2 1 || return 1
+	fi
 	return 0
 }
 
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
