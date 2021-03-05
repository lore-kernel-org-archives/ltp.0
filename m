From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Fri,  5 Mar 2021 17:27:14 -0500
Subject: [LTP] [PATCH] memcg: memcg_subgroup_charge.sh: Fix the parent
 memory limit
Message-ID: <20210305222714.257839-1-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

memcg_subgroup_charge.sh fails on v5.9 and later kernel.
That's because memory.limit_in_bytes isn't set the suitable value
so mem_process is killed by OOM accidentally.

The memory.limit_in_bytes is now wrong value because commit
3e38e0aaca9e ("mm: memcg: charge memcg percpu memory to the parent cgroup")
changed the charging memory usage. The percpu memory, which is
needed to create the subgroup, is charged to the parent's usage.

Since we can get the amount of the percpu memory as memory.usage_in_bytes
after the subgroup is created, extend the limit to limit_in_bytes + usage_in_bytes.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 .../memcg/functional/memcg_subgroup_charge.sh            | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 9b23177a4..512a4e3dd 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -20,9 +20,16 @@ TST_CNT=3
 test_subgroup()
 {
 	mkdir subgroup
-	echo $1 > memory.limit_in_bytes
 	echo $2 > subgroup/memory.limit_in_bytes
 
+	# v5.9 and later kernel, percpu memory which is needed to create
+	# the subgroup is charged to the parent's usage.
+	# Extend the parent limit so that we can observe the rss of
+	# memcg_process correctly.
+	pre_used=$(cat memory.usage_in_bytes)
+	newlimit=$(( $1 + pre_used ))
+	echo $newlimit > memory.limit_in_bytes
+
 	start_memcg_process --mmap-anon -s $PAGESIZES
 
 	warmup
-- 
2.27.0

