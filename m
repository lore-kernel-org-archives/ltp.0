From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Aug 2017 17:12:57 +0800
Subject: [LTP] [PATCH] numa: Add new regression test for MPOL_PREFERRED poliy
Message-ID: <20170816091257.5097-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kernel bug description:
  Allocating memory on node1 with MPOL_PREFERRED policy doesn't work
  with THP enabled, it always fallbacks to local node (ex. node0).
  This impacts workload performance for multi node systems.

It has been fixed by:
  commit 0867a57c (mm, thp: respect MPOL_PREFERRED policy with non-local node)

Test on kernel without this patch:
  12 TFAIL: NUMA memory allocated in node1 is less than expected
Test on kernel with this fix:
  12 TPASS: NUMA preferred node policy verified with THP enabled

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/numa/README         |  3 +++
 testcases/kernel/numa/numa01.sh      | 39 +++++++++++++++++++++++++++++++++++-
 testcases/kernel/numa/support_numa.c | 17 ++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/README b/testcases/kernel/numa/README
index a5c3f1b..846d36d 100644
--- a/testcases/kernel/numa/README
+++ b/testcases/kernel/numa/README
@@ -57,6 +57,9 @@ Verifieds the NUMA migratepages policy.
 TestCase11:
 Verifies the hugepage memory allocated from the node we specify.
 
+TestCase12:
+Verifies the preferred node policy with THP memory allocating from the node we specify.
+
 Pre-requisites
 ====================================================================================================================
  * libnuma should be installed on the NUMA machine before executing theses testcases
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index b831ada..59879f4 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -32,10 +32,11 @@
 #               Test #9: Verifies numa_node_size api                         #
 #               Test #10:Verifies Migratepages                               #
 #               Test #11:Verifies hugepage alloacted on specified node       #
+#               Test #12:Verifies THP memory allocated on preferred node     #
 #                                                                            #
 ##############################################################################
 
-TST_CNT=11
+TST_CNT=12
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
@@ -82,6 +83,7 @@ wait_for_support_numa()
 setup()
 {
 	export MB=$((1024*1024))
+	export GB=$((1024*1024*1024))
 	export PAGE_SIZE=$(getconf PAGE_SIZE)
 	export HPAGE_SIZE=$(awk '/Hugepagesize:/ {print $2}' /proc/meminfo)
 
@@ -458,4 +460,39 @@ test11()
 	tst_res TPASS "NUMA local node hugepage memory allocated"
 }
 
+# Verification of THP memory allocated on preferred node
+test12()
+{
+	Mem_curr=0
+
+	COUNTER=1
+	for node in $nodes_list; do
+
+		if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
+		else
+			# always next node is preferred node
+			Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
+		fi
+
+		numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1GB_THP &
+		pid=$!
+
+		wait_for_support_numa $pid
+
+		Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
+		if [ $(echo "$Mem_curr < $GB" |bc ) -eq 1 ]; then
+			tst_res TFAIL \
+				"NUMA memory allocated in node$Preferred_node is less than expected"
+			kill -CONT $pid >/dev/null 2>&1
+			return
+		fi
+
+		COUNTER=$((COUNTER+1))
+		kill -CONT $pid >/dev/null 2>&1
+	done
+
+	tst_res TPASS "NUMA preferred node policy verified with THP enabled"
+}
+
 tst_run
diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
index 4904cc5..37790e7 100644
--- a/testcases/kernel/numa/support_numa.c
+++ b/testcases/kernel/numa/support_numa.c
@@ -53,6 +53,7 @@ static void help(void)
 	printf("Input:	Describe input arguments to this program\n");
 	printf("	argv[1] == \"alloc_1MB\" then allocate 1MB of memory\n");
 	printf("	argv[1] == \"alloc_1MB_shared\" then allocate 1MB of share memory\n");
+	printf("	argv[1] == \"alloc_1GB_THP\" then allocate 1GB of THP memory\n");
 	printf("        argv[1] == \"alloc_1huge_page\" then allocate 1HUGE PAGE SIZE of memory\n");
 	printf("        argv[1] == \"pause\" then pause the program to catch sigint\n");
 	printf("Exit:	On failure - Exits with non-zero value\n");
@@ -138,6 +139,22 @@ int main(int argc, char *argv[])
 		munmap(buf, sb.st_size);
 		close(fd);
 		remove(TEST_SFILE);
+	} else if (!strcmp(argv[1], "alloc_1GB_THP")) {
+		size_t size = 1024 * MB;
+
+		buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS,
+				-1, 0);
+		if (buf == MAP_FAILED) {
+			perror("mmap failed");
+			exit(1);
+		}
+
+		memset(buf, 'a', size);
+
+		raise(SIGSTOP);
+
+		munmap(buf, size);
 	} else if (!strcmp(argv[1], "alloc_1huge_page")) {
 		hpsz = read_hugepagesize();
 		if (hpsz == 0)
-- 
2.9.3

