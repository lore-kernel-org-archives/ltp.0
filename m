From: Li Wang <liwang@redhat.com>
Date: Fri, 19 May 2017 16:27:24 +0800
Subject: [LTP] [PATCH v3 3/3] ltp/numa: use string to describe operation
Message-ID: <20170519082724.10232-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/numa01.sh      | 24 +++++++++---------------
 testcases/kernel/numa/support_numa.c | 23 +++++++++--------------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 93d74cc..4eda3f1 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -86,12 +86,6 @@ setup()
 	export PAGE_SIZE=$(getconf PAGE_SIZE)
 	export HPAGE_SIZE=$(awk '/Hugepagesize:/ {print $2}' /proc/meminfo)
 
-	# arguments to memory exercise program support_numa.c
-	ALLOC_1MB=1
-	SHARE_1MB=2
-	HUGE_PAGE=3
-	PAUSE=4
-
 	total_nodes=0
 
 	nodes_list=$(numactl --show | grep nodebind | cut -d ':' -f 2)
@@ -112,7 +106,7 @@ test1()
 	Mem_curr=0
 
 	for node in $nodes_list; do
-		numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB &
+		numactl --cpunodebind=$node --membind=$node support_numa alloc_1MB &
 		pid=$!
 
 		wait_for_support_numa $pid
@@ -146,7 +140,7 @@ test2()
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
 		fi
 
-		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $ALLOC_1MB &
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB &
 		pid=$!
 
 		wait_for_support_numa $pid
@@ -182,7 +176,7 @@ test3()
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
 		fi
 
-		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa $SHARE_1MB &
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1MB_shared &
 		pid=$!
 
 		wait_for_support_numa $pid
@@ -209,7 +203,7 @@ test4()
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
-	numactl --interleave=all support_numa $ALLOC_1MB &
+	numactl --interleave=all support_numa alloc_1MB &
 	pid=$!
 
 	wait_for_support_numa $pid
@@ -236,7 +230,7 @@ test5()
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
-	numactl --interleave=all support_numa $SHARE_1MB &
+	numactl --interleave=all support_numa alloc_1MB_shared &
 	pid=$!
 
 	wait_for_support_numa $pid
@@ -267,7 +261,7 @@ test6()
 	no_of_cpus=$(tst_ncpus)
 	# not sure whether cpu's can't be in odd number
 	run_on_cpu=$(($((no_of_cpus+1))/2))
-	numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for sigint
+	numactl --physcpubind=$run_on_cpu support_numa pause & #just waits for sigint
 	pid=$!
 	var=`awk '{ print $2 }' /proc/$pid/stat`
 	while [ $var = '(numactl)' ]; do
@@ -295,7 +289,7 @@ test7()
 	Mem_curr=0
 
 	for node in $nodes_list; do
-		numactl --cpunodebind=$node --localalloc support_numa $ALLOC_1MB &
+		numactl --cpunodebind=$node --localalloc support_numa alloc_1MB &
 		pid=$!
 
 		wait_for_support_numa $pid
@@ -388,7 +382,7 @@ test10()
 			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
 		fi
 
-		numactl --preferred=$node support_numa $ALLOC_1MB &
+		numactl --preferred=$node support_numa alloc_1MB &
 		pid=$!
 
 		wait_for_support_numa $pid
@@ -432,7 +426,7 @@ test11()
 			return
 		fi
 
-		numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
+		numactl --cpunodebind=$node --membind=$node support_numa alloc_1huge_page &
 		pid=$!
 		wait_for_support_numa $pid
 
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 97f3008..b6aa8bd 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -50,10 +50,10 @@
 static void help(void)
 {
 	printf("Input:	Describe input arguments to this program\n");
-	printf("	argv[1] == 1 then allocate 1MB of memory\n");
-	printf("	argv[1] == 2 then allocate 1MB of share memory\n");
-	printf("        argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
-	printf("        argv[1] == 4 then pause the program to catch sigint\n");
+	printf("	argv[1] == \"alloc_1MB\" then allocate 1MB of memory\n");
+	printf("	argv[1] == \"alloc_1MB_shared\" then allocate 1MB of share memory\n");
+	printf("        argv[1] == \"alloc_1huge_page\" then allocate 1HUGE PAGE SIZE of memory\n");
+	printf("        argv[1] == \"pause\" then pause the program to catch sigint\n");
 	printf("Exit:	On failure - Exits with non-zero value\n");
 	printf("	On success - exits with 0 exit value\n");
 
@@ -97,8 +97,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	switch (atoi(argv[1])) {
-	case 1:
+	if (!strcmp(argv[1], "alloc_1MB")) {
 		buf = malloc(MB);
 		if (!buf) {
 			fprintf(stderr, "Memory is not available\n");
@@ -112,8 +111,7 @@ int main(int argc, char *argv[])
 		raise(SIGSTOP);
 
 		free(buf);
-		break;
-	case 2:
+	} else if (!strcmp(argv[1], "alloc_1MB_shared")) {
 		fd = open(TEST_SFILE, O_RDWR | O_CREAT, 0666);
 		/* Writing 1MB of random data into this file [32 * 32768 = 1024 * 1024] */
 		for (i = 0; i < 32768; i++){
@@ -139,8 +137,7 @@ int main(int argc, char *argv[])
 		munmap(buf, sb.st_size);
 		close(fd);
 		remove(TEST_SFILE);
-		break;
-	case 3:
+	} else if (!strcmp(argv[1], "alloc_1huge_page")) {
 		hpsz = read_hugepagesize();
 		if (hpsz == 0)
 			exit(1);
@@ -159,11 +156,9 @@ int main(int argc, char *argv[])
 		raise(SIGSTOP);
 
 		munmap(buf, hpsz);
-		break;
-	case 4:
+	} else if (!strcmp(argv[1], "pause")) {
 		raise(SIGSTOP);
-		break;
-	default:
+	} else {
 		help();
 	}
 
-- 
2.9.3

