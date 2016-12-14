From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Dec 2016 18:09:11 +0800
Subject: [LTP] [PATCH v2 4/4] ltp/numa: add new test11
Message-ID: <1481710151-18453-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/README         |  2 ++
 testcases/kernel/numa/numa01.sh      | 46 ++++++++++++++++++++++++++++++--
 testcases/kernel/numa/support_numa.c | 51 +++++++++++++++++++++++++++++++++---
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
index 57b12f7..a5c3f1b 100644
--- a/testcases/kernel/numa/README
+++ b/testcases/kernel/numa/README
@@ -54,6 +54,8 @@ Verifies the numa_node_size api with hardware checking.
 TestCase10:
 Verifieds the NUMA migratepages policy.
 
+TestCase11:
+Verifies the hugepage memory allocated from the node we specify.
 
 Pre-requisites
 ====================================================================================================================
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 39f3af5..4eabedf 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -31,11 +31,12 @@
 #               Test #8: Verifies memhog                                     #
 #               Test #9: Verifies numa_node_size api                         #
 #               Test #10:Verifies Migratepages                               #
+#               Test #11:Verifies hugepage alloacted on specified node       #
 #                                                                            #
 ##############################################################################
 
 TST_ID="numa01"
-TST_CNT=10
+TST_CNT=11
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
@@ -67,11 +68,13 @@ setup()
 {
 	export MB=$((1024*1024))
 	export PAGE_SIZE=$(getconf PAGE_SIZE)
+	export HPAGE_SIZE=$(cat /proc/meminfo  |grep "Hugepagesize:" |awk '{print $2}')
 
 	# arguments to memory exercise program support_numa.c
 	ALLOC_1MB=1
 	SHARE_1MB=2
-	PAUSE=3
+	HUGE_PAGE=3
+	PAUSE=4
 
 	total_nodes=0       # total no. of numa nodes
 	# all availiable nodes id list
@@ -203,6 +206,7 @@ test4()
 	tst_sleep 100ms
 
 	for node in $nodes_list; do
+
 		Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB" |bc)
 
 		if [ $(echo "$Mem_curr < $Exp_incr" |bc ) -eq 1 ]; then
@@ -409,4 +413,42 @@ test10()
 	tst_res TPASS "NUMA MIGRATEPAGES policy -TEST10 PASSED !!"
 }
 
+# Function:     test11
+#
+# Description:  - Verification of hugepage memory allocated on a node
+#
+test11()
+{
+	Mem_huge=0
+
+	if [ ! -d "/sys/kernel/mm/hugepages/" ]; then
+		tst_brk TCONF "hugepage is not supported"
+	fi
+
+	for node in $nodes_list; do
+		Ori_hpgs=$(cat /sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages)
+		echo 1 >/sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
+
+		numactl --cpunodebind=$node --membind=$node support_numa $HUGE_PAGE &
+		pid=$!
+
+		# Wait a little msec for memory allocating in background
+		tst_sleep 100ms
+
+		Mem_huge=$(echo $(numastat -p $pid |grep '^Huge' |awk '{print $'$((node+2))'}'))
+		Mem_huge=$(echo "$Mem_huge * 1024" |bc)
+
+		if [ $(echo "$Mem_huge < $HPAGE_SIZE" | bc) -eq 1 ]; then
+			tst_res TFAIL \
+				"NUMA memory allocated in node$node is less than expected"
+			return
+		fi
+
+		kill -18 $pid 2>&1 >/dev/null
+		echo $Ori_hpgs >/sys/devices/system/node/node${node}/hugepages/hugepages-${HPAGE_SIZE}kB/nr_hugepages
+	done
+
+	tst_res TPASS "NUMA local node hugepage memory allocated -TEST11 PASSED !!"
+}
+
 tst_run
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 82c9353..1c80ae2 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -22,7 +22,7 @@
 /*                                                                            */
 /* File:        support_numa.c                                                */
 /*                                                                            */
-/* Description: Allocates 1MB of memory and touches it to verify numa         */
+/* Description: Allocates memory and touches it to verify numa                */
 /*                                                                            */
 /* Author:      Sivakumar Chinnaiah  Sivakumar.C@in.ibm.com                   */
 /*                                                                            */
@@ -56,16 +56,43 @@ void help(void)
 	printf("Input:	Describe input arguments to this program\n");
 	printf("	argv[1] == 1 then allocate 1MB of memory\n");
 	printf("	argv[1] == 2 then allocate 1MB of share memory\n");
-	printf("	argv[1] == 3 then pause the program to catch sigint\n");
+	printf("	argv[1] == 3 then allocate 1HUGE PAGE SIZE of memory\n");
+	printf("	argv[1] == 4 then pause the program to catch sigint\n");
 	printf("Exit:	On failure - Exits with non-zero value\n");
 	printf("	On success - exits with 0 exit value\n");
 
 	exit(1);
 }
 
+int read_hugepagesize(void)
+{
+	FILE *fp;
+	char line[BUFSIZ], buf[BUFSIZ];
+	int val;
+
+	fp = fopen("/proc/meminfo", "r");
+	if (fp == NULL) {
+		fprintf(stderr, "Failed to open /proc/meminfo");
+		return 1;
+	}
+
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		if (sscanf(line, "%64s %d", buf, &val) == 2)
+			if (strcmp(buf, "Hugepagesize:") == 0) {
+				fclose(fp);
+				return 1024 * val;
+			}
+	}
+
+	fclose(fp);
+	fprintf(stderr, "can't find \"%s\" in %s", "Hugepagesize:", "/proc/meminfo");
+
+	return 1;
+}
+
 int main(int argc, char *argv[])
 {
-	int i, fd, rc;
+	int i, fd, rc, hpsz;
 	char *buf = NULL;
 	struct stat sb;
 	struct sigaction sa;
@@ -119,6 +146,24 @@ int main(int argc, char *argv[])
 		remove(TEST_SFILE);
 		break;
 	case 3:
+		hpsz = read_hugepagesize();
+
+		buf = mmap(NULL, hpsz, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+				-1, 0);
+
+		if (buf == MAP_FAILED){
+			fprintf(stderr, "mmap failed\n");
+			exit(1);
+		}
+
+		memset(buf, 'a', hpsz);
+
+		raise(SIGSTOP);
+
+		munmap(buf, hpsz);
+		break;
+	case 4:
 		/* Trap SIGINT */
 		sa.sa_handler = sigfunc;
 		sa.sa_flags = SA_RESTART;
-- 
1.8.3.1

