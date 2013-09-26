Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VP8qr-0006j4-VZ
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:18 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VP8qn-0008MT-S0
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 10:31:17 +0000
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Sep 2013 14:30:38 +0400
Message-Id: <1380191440-18171-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1380191440-18171-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 5/7] cpuset/cpuset_memory_test: fixes
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

cpuset_memory_test.c:
 * lack of "config.h"
 * incorrect use of HAVE_LINUX_MEMPOLICY macro
 * some cleanup

cpuset_memory_testset.sh:
 * number of cpu and memory nodes are set based on environment
 * we send second SIGUSR1 signal to make the child free its resources
 * setting nr_hugepages to a value of 2 is not sufficient. Because there
   is no guarantee that these hugepages will be allocated on the specified
   node
 * cleanup and several typos are fixed

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../cpuset/cpuset_memory_test/cpuset_memory_test.c |   31 ++++++++++---------
 .../cpuset_memory_test/cpuset_memory_testset.sh    |   18 ++++++-----
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
index ddf5935..17b3ed7 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
@@ -20,6 +20,7 @@
 /*                                                                            */
 /******************************************************************************/
 
+#include "config.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -36,27 +37,27 @@
 #include <syscall.h>
 #include <pthread.h>
 
-#include "../cpuset_lib/cpuset.h"
-
 char *TCID = "cpuset_memory_test";
 int TST_TOTAL = 1;
 
-#if HAVE_LINUX_MEMPOLICY_TEST
+#if HAVE_LINUX_MEMPOLICY_H
+
+#include "../cpuset_lib/cpuset.h"
 
-int fd;
-int flag_exit;
+static int fd;
+static int flag_exit;
 
-int opt_mmap_anon;
-int opt_mmap_file;
-int opt_mmap_lock1;
-int opt_mmap_lock2;
-int opt_shm;
-int opt_hugepage;
-int opt_check;			/* check node when munmap memory (only for mmap_anon()) */
-int opt_thread;
+static int opt_mmap_anon;
+static int opt_mmap_file;
+static int opt_mmap_lock1;
+static int opt_mmap_lock2;
+static int opt_shm;
+static int opt_hugepage;
+static int opt_check; /* check node when munmap memory (only for mmap_anon()) */
+static int opt_thread;
 
-int key_id;			/* used with opt_shm */
-unsigned long memsize;
+static int key_id;			/* used with opt_shm */
+static unsigned long memsize;
 
 #define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
 
diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 85f1863..2a9f7e3 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -33,8 +33,8 @@ export TST_COUNT=1
 exit_status=0
 
 # must >= 3 for: 1-$((nr_mems-2))
-nr_cpus=4
-nr_mems=3
+nr_cpus=$NR_CPUS
+nr_mems=$N_NODES
 
 cpus_all="$(seq -s, 0 $((nr_cpus-1)))"
 mems_all="$(seq -s, 0 $((nr_mems-1)))"
@@ -55,6 +55,8 @@ simple_getresult()
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
 	sleep 1
+	/bin/kill -s SIGUSR1 $1
+	sleep 1
 	/bin/kill -s SIGINT $1
 	wait $1
 	read node < "$MEMORY_RESULT"
@@ -150,7 +152,7 @@ test5()
 #        1 - support hugetlbfs
 check_hugetlbfs()
 {
-	local fssupport="grep -w hugetlbfs /proc/filesystems 2>/dev/null | cut -f2"
+	local fssupport=$(grep -w hugetlbfs /proc/filesystems 2>/dev/null | cut -f2)
 
 	if [ "$fssupport" = "hugetlbfs" ]; then
 		return 1
@@ -178,7 +180,7 @@ test6()
 	mount -t hugetlbfs none /hugetlb
 
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo 2 > /proc/sys/vm/nr_hugepages
+	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
 	./cpuset_memory_test --mmap-file --hugepage -s $HUGEPAGESIZE >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
@@ -187,7 +189,7 @@ test6()
 	rmdir /hugetlb
 
 	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $! -ne 0 ]; then
+	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
 		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
 		return 1
 	fi
@@ -217,7 +219,7 @@ test7()
 	mount -t hugetlbfs none /hugetlb
 
 	save_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	echo 2 > /proc/sys/vm/nr_hugepages
+	echo $((2*$nr_mems)) > /proc/sys/vm/nr_hugepages
 
 	./cpuset_memory_test --shm --hugepage -s $HUGEPAGESIZE --key=7 >"$MEMORY_RESULT" &
 	simple_getresult $! "$CPUSET/0"
@@ -226,7 +228,7 @@ test7()
 	rmdir /hugetlb
 
 	echo $save_nr_hugepages > /proc/sys/vm/nr_hugepages
-	if [ $! -ne 0 ]; then
+	if [ $(cat /proc/sys/vm/nr_hugepages) -ne $save_nr_hugepages ]; then
 		tst_resm TFAIL "can't restore nr_hugepages(nr_hugepages = $save_nr_hugepages)."
 		return 1
 	fi
@@ -821,7 +823,7 @@ do
 			if [ $? -ne 0 ]; then
 				exit_status=1
 			else
-				tst_resm TPASS "Cpuset memory alloaction test succeeded."
+				tst_resm TPASS "Cpuset memory allocation test succeeded."
 			fi
 		fi
 	fi
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
