From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Mar 2019 13:12:42 +0100
Subject: [LTP] [PATCH] kernel/numa01.sh: Remove file based tests
Message-ID: <20190313121242.5257-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is follow up on:

commit 55ee8a5adcf32d46372b32c0e470e42a82165c67
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Wed Mar 6 17:16:33 2019 +0100

    syscalls: Add set_mempolicy numa tests.

Tests 3 and 5 were using a single file mmaped into test memory to check
NUMA allocation policy. Using a single small file for this kind of tests
is wrong for several reasons, among other things filesystems tends to
allocate pages in batches (to have better performance), which means that
interleave policy has to sample several slightly larger files to check
for fairness of the memory placements.

The testcase 5 was failing often on Btrfs and testcase 3 was failing
rarely so this commit removes these two.

The test 3 is now reimplemented as subset of set_mempolicy03 the only
difference is that test 3 tries to fiddle with cpu affinity to keep the
test running on different node than is the one we requested allocation
on but given that we try to allocate memory on all memory nodes it's
unlikely that we will actually always run on the same node we want to
allocate the memory on and if we ever wanted we can add another variant
for the set_mempolicy03 test easily as well.

The test 5 is reimplemented as set_mempolicy04 with the difference that
set_mempolicy04 runs on all supported filesystems and samples several
files as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/numa/numa01.sh      | 100 +++++----------------------
 testcases/kernel/numa/support_numa.c |  30 +-------
 2 files changed, 18 insertions(+), 112 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 327fa2f1f..9b302ca0f 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -23,20 +23,18 @@
 # Description:  Test Basic functionality of numactl command.                 #
 #               Test #1: Verifies cpunodebind and membind                    #
 #               Test #2: Verifies preferred node bind for memory allocation  #
-#               Test #3: Verifies share memory allocation on preferred node  #
-#               Test #4: Verifies memory interleave on all nodes             #
-#               Test #5: Verifies share memory interleave on all nodes       #
-#               Test #6: Verifies physcpubind                                #
-#               Test #7: Verifies localalloc                                 #
-#               Test #8: Verifies memhog                                     #
-#               Test #9: Verifies numa_node_size api                         #
-#               Test #10:Verifies Migratepages                               #
-#               Test #11:Verifies hugepage alloacted on specified node       #
-#               Test #12:Verifies THP memory allocated on preferred node     #
+#               Test #3: Verifies memory interleave on all nodes             #
+#               Test #4: Verifies physcpubind                                #
+#               Test #5: Verifies localalloc                                 #
+#               Test #6: Verifies memhog                                     #
+#               Test #7: Verifies numa_node_size api                         #
+#               Test #8:Verifies Migratepages                                #
+#               Test #9:Verifies hugepage alloacted on specified node        #
+#               Test #10:Verifies THP memory allocated on preferred node     #
 #                                                                            #
 ##############################################################################
 
-TST_CNT=12
+TST_CNT=10
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
@@ -152,44 +150,8 @@ test2()
 	tst_res TPASS "NUMA preferred node policy"
 }
 
-# Verification of share memory allocated on preferred node
-test3()
-{
-	Mem_curr=0
-	COUNTER=1
-
-	for node in $nodes_list; do
-
-		if [ $COUNTER -eq $total_nodes ]   #wrap up for last node
-		then
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
-		else
-			# always next node is preferred node
-			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
-		fi
-
-		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB_shared &
-		pid=$!
-
-		TST_RETRY_FUNC "check_for_support_numa $pid" 0
-
-		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
-		if [ $(echo "$Mem_curr < $MB" |bc ) -eq 1 ]; then
-			tst_res TFAIL \
-				"NUMA share memory allocated in node$Preferred_node is less than expected"
-			kill -CONT $pid >/dev/null 2>&1
-			return
-		fi
-
-		COUNTER=$((COUNTER+1))
-		kill -CONT $pid >/dev/null 2>&1
-	done
-
-	tst_res TPASS "NUMA share memory allocated in preferred node"
-}
-
 # Verification of memory interleaved on all nodes
-test4()
+test3()
 {
 	Mem_curr=0
 	# Memory will be allocated using round robin on nodes.
@@ -215,36 +177,8 @@ test4()
 	tst_res TPASS "NUMA interleave policy"
 }
 
-# Verification of shared memory interleaved on all nodes
-test5()
-{
-	Mem_curr=0
-	# Memory will be allocated using round robin on nodes.
-	Exp_incr=$(echo "$MB / $total_nodes" |bc)
-
-	numactl --interleave=all support_numa alloc_1MB_shared &
-	pid=$!
-
-	TST_RETRY_FUNC "check_for_support_numa $pid" 0
-
-	for node in $nodes_list; do
-		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
-
-		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
-			tst_res TFAIL \
-				"NUMA interleave share memory allocated in node$node is less than expected"
-			kill -CONT $pid >/dev/null 2>&1
-			return
-		fi
-	done
-
-	kill -CONT $pid >/dev/null 2>&1
-
-	tst_res TPASS "NUMA interleave policy on shared memory"
-}
-
 # Verification of physical cpu bind
-test6()
+test4()
 {
 	no_of_cpus=0	#no. of cpu's exist
 	run_on_cpu=0
@@ -276,7 +210,7 @@ test6()
 }
 
 # Verification of local node allocation
-test7()
+test5()
 {
 	Mem_curr=0
 
@@ -306,7 +240,7 @@ check_ltp_numa_test8_log()
 }
 
 # Verification of memhog with interleave policy
-test8()
+test6()
 {
 	Mem_curr=0
 	# Memory will be allocated using round robin on nodes.
@@ -348,7 +282,7 @@ test8()
 #                 0:  10  20
 #                 1:  20  10
 #
-test9()
+test7()
 {
 	RC=0
 
@@ -368,7 +302,7 @@ test9()
 }
 
 # Verification of migratepages
-test10()
+test8()
 {
 	Mem_curr=0
 	COUNTER=1
@@ -404,7 +338,7 @@ test10()
 }
 
 # Verification of hugepage memory allocated on a node
-test11()
+test9()
 {
 	Mem_huge=0
 	Sys_node=/sys/devices/system/node
@@ -448,7 +382,7 @@ test11()
 }
 
 # Verification of THP memory allocated on preferred node
-test12()
+test10()
 {
 	Mem_curr=0
 
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 4e8be4c75..a0afee554 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -52,7 +52,6 @@ static void help(void)
 {
 	printf("Input:	Describe input arguments to this program\n");
 	printf("	argv[1] == \"alloc_1MB\" then allocate 1MB of memory\n");
-	printf("	argv[1] == \"alloc_1MB_shared\" then allocate 1MB of share memory\n");
 	printf("	argv[1] == \"alloc_2HPSZ_THP\" then allocate 2HUGE PAGE SIZE of THP memory\n");
 	printf("        argv[1] == \"alloc_1huge_page\" then allocate 1HUGE PAGE SIZE of memory\n");
 	printf("        argv[1] == \"pause\" then pause the program to catch sigint\n");
@@ -90,9 +89,8 @@ static int read_hugepagesize(void)
 
 int main(int argc, char *argv[])
 {
-	int i, fd, rc, hpsz;
+	int i, hpsz;
 	char *buf = NULL;
-	struct stat sb;
 
 	if (argc != 2) {
 		fprintf(stderr, "Here expect only one number(i.e. 2) as the parameter\n");
@@ -113,32 +111,6 @@ int main(int argc, char *argv[])
 		raise(SIGSTOP);
 
 		free(buf);
-	} else if (!strcmp(argv[1], "alloc_1MB_shared")) {
-		fd = open(TEST_SFILE, O_RDWR | O_CREAT, 0666);
-		/* Writing 1MB of random data into this file [32 * 32768 = 1024 * 1024] */
-		for (i = 0; i < 32768; i++){
-			rc = write(fd, STR, strlen(STR));
-			if (rc == -1 || ((size_t)rc != strlen(STR)))
-				fprintf(stderr, "write failed\n");
-		}
-
-		if ((fstat(fd, &sb)) == -1)
-			fprintf(stderr, "fstat failed\n");
-
-		buf = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-		if (buf == MAP_FAILED){
-			fprintf(stderr, "mmap failed\n");
-			close(fd);
-			exit(1);
-		}
-
-		memset(buf, 'a', sb.st_size);
-
-		raise(SIGSTOP);
-
-		munmap(buf, sb.st_size);
-		close(fd);
-		remove(TEST_SFILE);
 	} else if (!strcmp(argv[1], "alloc_2HPSZ_THP")) {
 		ssize_t size = 2 * read_hugepagesize();
 		if (size == 0)
-- 
2.19.2

