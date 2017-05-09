From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  9 May 2017 16:04:58 +0200
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages prior
	the test
Message-ID: <20170509140458.26343-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit adds code into the test setup to mmap(), mbind() and fault
hugepages on both testing nodes prior to the test run in order to make sure
that there is enough continous space for the move_pages() syscall to move huge
pages back and forth.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/move_pages/move_pages12.c      | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index de00346..765ea7e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -128,6 +128,45 @@ static void do_test(void)
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
@@ -154,6 +193,9 @@ static void setup(void)
 	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
 	if (ret < 0)
 		tst_brk(TBROK | TERRNO, "get_allowed_nodes: %d", ret);
+
+	alloc_free_huge_on_node(node1, TEST_PAGES * hpsz);
+	alloc_free_huge_on_node(node2, TEST_PAGES * hpsz);
 }
 
 static void cleanup(void)
-- 
2.7.3

