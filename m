From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Feb 2019 15:11:09 +0800
Subject: [LTP] [PATCH] mem/lib: remove NH_CPUS flag from
	get_allowed_nodes_arr
Message-ID: <20190222071109.10970-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A new BROK was occurred on a special numa system which node 1 just has
memory but no cpu. This special configuration makes numa system detection
is_numa(NULL, NH_MEMS, 2) get pass in setup() but test failed in the mem.c
library funcion test_ksm_merge_across_nodes becuase the NH_CPUS is to requre
testing node should have cpu.

However, I have gone though all of our LTP ksm tests and confirmed that there
is no necessary to do cpu check for it, actully only ksm06 invoke that funcion.
In this patch I just remove the NH_CPUS flag to get ksm06 test pass.

  # numactl -H
  available: 2 nodes (0-1)
  node 0 cpus: 0 1 2 3 4 5 6 7
  node 0 size: 31431 MB
  node 0 free: 26355 MB
  node 1 cpus:
  node 1 size: 255 MB
  node 1 free: 213 MB
  node distances:
  node   0   1
    0:  10  40
    1:  40  10

  # ./ksm06
  tst_test.c:1085: INFO: Timeout per run is 0h 10m 00s
  mem.c:539: INFO: need NUMA system support
  tst_test.c:920: BROK: Test haven't reported results!

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index ec1792004..a0c1b9b00 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -532,7 +532,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
 #endif
 
-	ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
 	if (ret != 0)
 		tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
 	if (num_nodes < 2) {
-- 
2.20.1

