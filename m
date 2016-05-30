From: Dong ZHu <bluezhudong@gmail.com>
Date: Mon, 30 May 2016 17:56:19 +0800
Subject: [LTP] [PATCH] kernel/numa: sleep 2s in test01 for waiting numastat
	updating
Message-ID: <CAAUgArBQ_D+wY+48YO6VYPWYM70hxr98YshcRRkXDYSoz2VZQg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From 98db5da4ec362e4f8e64b119a8d32245ca06bf36 Mon Sep 17 00:00:00 2001
        From: Dong Zhu <bluezhudong@gmail.com>
Date: Mon, 30 May 2016 17:40:05 +0800
Subject: [PATCH] kernel/numa: sleep 2s in test01 for waiting numastat updating

Without this patch always get the below error with kernel 4.6.0:
"ltpapicmd.c:193: Test #1: NUMA hit and localnode increase in node0 is
less than expected"

numastat's "local_node" might take some to update even though we malloc
the local memory for each node.

So this patch in targets to sleep for 2 seconds until "local_node" get
updated.

Signed-off-by: Dong Zhu <bluezhudong@gmail.com>
---
 testcases/kernel/numa/numa01.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 9c5f49a..d3c7606 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -247,6 +247,7 @@ test01()
         extract_numastat local_node $local_node $col || return 1
         Prev_value=$RC
         numactl --cpunodebind=$node --membind=$node support_numa $ALLOC_1MB
+       sleep 2s
         numastat > $LTPTMP/numalog
         extract_numastat local_node $local_node $col || return 1
         Curr_value=$RC
-- 
2.1.0


-- 
Best Regards,
Dong Zhu

My Site: http://bluezd.info
