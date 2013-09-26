Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VP8qt-0005r0-Cy
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:19 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VP8qr-0002cz-C0
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:19 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Sep 2013 14:30:39 +0400
Message-Id: <1380191440-18171-7-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 6/7] cpuset_memory_spread_test: number of nodes and
	sleep timeout
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

I've not found a better way to guarantee dropping of caches than
just increasing sleep timeout twice (to 20 seconds).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset_memory_spread_testset.sh                |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index a357e22..4d7bbeb 100755
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
@@ -231,7 +231,7 @@ general_memory_spread_test()
 	fi
 
 	# wait for droping the cache
-	sleep 10
+	sleep 20
 
 	get_memsinfo
 	/bin/kill -s SIGUSR1 $test_pid
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
