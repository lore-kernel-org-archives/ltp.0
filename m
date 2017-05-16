From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 May 2017 11:30:39 +0200
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <1977457874.10364325.1494507049706.JavaMail.zimbra@redhat.com>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
 <20170510130125.GE29838@rei.suse.de>
 <1251960161.9665123.1494425698679.JavaMail.zimbra@redhat.com>
 <20170510150807.GF29838@rei.suse.de>
 <57874670.10114549.1494484804573.JavaMail.zimbra@redhat.com>
 <20170511122636.GA27575@rei.lan>
 <1977457874.10364325.1494507049706.JavaMail.zimbra@redhat.com>
Message-ID: <20170516093039.GA2897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> per node limit 8 and allocate 4 hugepages on each? What worries
> me are architectures, where default huge page is very large
> (e.g. 512M on aarch64).

I finally got access to my testing machines and:

The kernel tries to distribute the huge page pools evenly between nodes
hence for a machine with a two nodes reserving 8 instead of 4 huge pages
fixes the problem completely, i.e. following patch:


diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index de0034626..0305055a9 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -149,7 +149,7 @@ static void setup(void)
        hpsz *= 1024;
 
        SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-       SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
+       SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
 
        ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
        if (ret < 0)

Since reserving eight more huge pages in the global poll reserves 4 more on each node. The /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages is adjusted by 4 by the kernel and everything works fine (reserving just two is prone to some kind of race which is what we discussed before).

Now this wouldn't possibly work on a machine with more than two nodes, hence we may as well try to update the per-node pools.

So follwoing patch does:

1. Tries to setup per node hugepage pool to 4 huge pages
2. If 1. fails we try to setup the global pool to 8 and
   allocate 4 huge pages on each node

Which seems to be best approach to me to make sure that there is enough huge
pages available for the test.

From 995787fa48c24ed4507d6aa605162ff16c81f4b6 Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 May 2017 15:43:47 +0200
Subject: [PATCH] move_pages12: Make sure hugepages are available

This commit makes sure that enough huge pages are available on each node prior
to the test.

One problem we had is that there has to be at least four huge pages available
in the per-node pools even though we only allocate two. One of the
possibilities is that when we are moving pages back and forth between the nodes
there may be some overlap when huge page is allocated on a node but the two
huge pages there, that are about to be moved, are still there or at least
accounted for. Hence we have to make sure that at least four huge pages are
available prior to the test.

The second problem is that huge page pools are limited by several files in the
virtual filesystem. There is global knob for controlling the huge page pool
size in /proc, then there are per-node knobs in /sys. The value written to the
global knob is distributed evenly between the per-node knobs, hence on two node
machine writing 8 to the global knob is sufficient to make sure there is enough
huge pages for the test. But that does not work if the machine has three or
more nodes. Hence this patch tries to adjust per-node pools on the nodes
selected for the test and only if that is not possible we adjust the global
knob and then make sure that expected number of huge pages could be allocated
on each node.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/move_pages/move_pages12.c      | 101 +++++++++++++++++++--
 1 file changed, 94 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index de00346..6a1a186 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -35,6 +35,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
@@ -52,7 +53,11 @@
 #define TEST_NODES	2
 
 static int pgsz, hpsz;
-static long orig_hugepages;
+static long orig_hugepages = -1;
+static char path_hugepages_node1[PATH_MAX];
+static char path_hugepages_node2[PATH_MAX];
+static long orig_hugepages_node1 = -1;
+static long orig_hugepages_node2 = -1;
 static unsigned int node1, node2;
 static void *addr;
 
@@ -128,6 +133,45 @@ static void do_test(void)
 	}
 }
 
+static void alloc_free_huge_on_node(unsigned int node, size_t size)
+{
+	char *mem;
+	long ret;
+	struct bitmask *bm;
+
+	tst_res(TINFO, "Allocating and freeing %zu hugepages on node %u",
+		size / hpsz, node);
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (mem == MAP_FAILED) {
+		if (errno == ENOMEM)
+			tst_brk(TCONF, "Cannot allocate huge pages");
+
+		tst_brk(TBROK | TERRNO, "mmap(..., MAP_HUGETLB, ...) failed");
+	}
+
+	bm = numa_bitmask_alloc(numa_max_possible_node() + 1);
+	if (!bm)
+		tst_brk(TBROK | TERRNO, "numa_bitmask_alloc() failed");
+
+	numa_bitmask_setbit(bm, node);
+
+	ret = mbind(mem, size, MPOL_BIND, bm->maskp, bm->size + 1, 0);
+	if (ret) {
+		if (errno == ENOMEM)
+			tst_brk(TCONF, "Cannot mbind huge pages");
+
+		tst_brk(TBROK | TERRNO, "mbind() failed");
+	}
+
+	numa_bitmask_free(bm);
+
+	memset(mem, 0, size);
+
+	SAFE_MUNMAP(mem, size);
+}
+
 static void setup(void)
 {
 	int memfree, ret;
@@ -137,6 +181,10 @@ static void setup(void)
 	if (access(PATH_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "Huge page not supported");
 
+	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
+
 	pgsz = (int)get_page_size();
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
 
@@ -148,17 +196,56 @@ static void setup(void)
 
 	hpsz *= 1024;
 
-	SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
-	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 4);
+	snprintf(path_hugepages_node1, sizeof(path_hugepages_node1),
+		 "/sys/devices/system/node/node%u/hugepages/hugepages-2048kB/nr_hugepages",
+		 node1);
+
+	snprintf(path_hugepages_node2, sizeof(path_hugepages_node2),
+		 "/sys/devices/system/node/node%u/hugepages/hugepages-2048kB/nr_hugepages",
+		 node2);
+
+	if (!access(path_hugepages_node1, F_OK)) {
+		SAFE_FILE_SCANF(path_hugepages_node1,
+				"%ld", &orig_hugepages_node1);
+		tst_res(TINFO, "Increasing hugepages pool on node %u to %ld",
+			node1, orig_hugepages_node1 + 4);
+		SAFE_FILE_PRINTF(path_hugepages_node1,
+				 "%ld", orig_hugepages_node1 + 4);
+	}
 
-	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
-	if (ret < 0)
-		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
+	if (!access(path_hugepages_node2, F_OK)) {
+		SAFE_FILE_SCANF(path_hugepages_node2,
+				"%ld", &orig_hugepages_node2);
+		tst_res(TINFO, "Increasing hugepages pool on node %u to %ld",
+			node2, orig_hugepages_node2 + 4);
+		SAFE_FILE_PRINTF(path_hugepages_node2,
+				 "%ld", orig_hugepages_node2 + 4);
+	}
+
+	if (orig_hugepages_node1 == -1 || orig_hugepages_node2 == -1) {
+		SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+		tst_res(TINFO, "Increasing global hugepages pool to %ld",
+			orig_hugepages + 8);
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
+		alloc_free_huge_on_node(node1, 4 * hpsz);
+		alloc_free_huge_on_node(node2, 4 * hpsz);
+	}
 }
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+	if (orig_hugepages != -1)
+		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+
+	if (orig_hugepages_node1 != -1) {
+		SAFE_FILE_PRINTF(path_hugepages_node1,
+				 "%ld", orig_hugepages_node1);
+	}
+
+	if (orig_hugepages_node2 != -1) {
+		SAFE_FILE_PRINTF(path_hugepages_node2,
+				 "%ld", orig_hugepages_node2);
+	}
 }
 
 static struct tst_test test = {
-- 
2.7.3

-- 
Cyril Hrubis
chrubis@suse.cz
