From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Sun, 21 Feb 2021 21:32:14 -0500
Subject: [LTP] [PATCH] memcg_stat_test.sh: Add missing dot in cd command
Message-ID: <1613961134-31207-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 3a62391..f531f87 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -109,7 +109,7 @@ test8()
 	cd subgroup
 	check_mem_stat "hierarchical_memsw_limit" $((PAGESIZE*2))
 
-	cd .
+	cd ..
 	rmdir subgroup
 }
 
-- 
1.8.3.1



