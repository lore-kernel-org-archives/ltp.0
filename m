Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VR0GR-0007rc-53
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:23 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VR0GN-0006xa-TB
	for ltp-list@lists.sourceforge.net; Tue, 01 Oct 2013 13:45:23 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  1 Oct 2013 17:44:53 +0400
Message-Id: <1380635095-21403-7-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380635095-21403-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 6/8] cpuset_memory_spread_test: number of nodes and
	sync
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

For unification number of nodes is set based on environment.

OS caches were not reliably dropped after execution of 'dd'
on DATAFILE. And since 'dd' was executed in root cpuset the
caches were spread among all available memory nodes. Because on
consecutive reading of DATAFILE in cpuset_mem_hog didn't increase
memory consumption. This situation caused random failures of
the testcase.

In accordance to Documentation/sysctl/vm.txt to reliably drop caches
we should invoke 'sync' before 'echo N > /proc/sys/vm/drop_caches'.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_memory_spread_testset.sh                |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index a357e22..ffce419 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -32,8 +32,8 @@ export TST_COUNT=1
 
 exit_status=0
 # must >= 3 for: 1-$((nr_mems-2))
-nr_cpus=4
-nr_mems=3
+nr_cpus=$NR_CPUS
+nr_mems=$N_NODES
 
 # In general, the cache hog will use more than 10000 kb slab space on the nodes
 # on which it is running. The other nodes' slab space has littler change.(less
@@ -223,6 +223,7 @@ general_memory_spread_test()
 	fi
 
 	# we'd better drop the caches before we test page cache.
+	sync
 	/bin/echo 3 > /proc/sys/vm/drop_caches 2> $CPUSET_TMP/stderr
 	if [ $? -ne 0 ]; then
 		cpuset_log_error $CPUSET_TMP/stderr
@@ -230,9 +231,6 @@ general_memory_spread_test()
 		return 1
 	fi
 
-	# wait for droping the cache
-	sleep 10
-
 	get_memsinfo
 	/bin/kill -s SIGUSR1 $test_pid
 	read exit_num < $FIFO
@@ -344,12 +342,6 @@ if [ $? -ne 0 ]; then
 	exit 1
 fi
 
-# drop page caches
-/bin/echo 1 > /proc/sys/vm/drop_caches
-
-# wait for droping caches
-sleep 10
-
 mkfifo $FIFO
 if [ $? -ne 0 ]; then
 	rm -f DATAFILE
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
