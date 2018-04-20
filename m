From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 20 Apr 2018 11:18:52 +0800
Subject: [LTP] [PATCH ltp 3/6] numa/numa01.sh: Fix shellcheck issue SC2069
In-Reply-To: <20180420031855.22657-1-yixin.zhang@intel.com>
References: <20180420031855.22657-1-yixin.zhang@intel.com>
Message-ID: <20180420031855.22657-3-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

error: The order of the 2>&1 and the redirect matters. The 2>&1 has to
be last. [SC2069]

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 testcases/kernel/numa/numa01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index fd3b4be64..27a2f2f7c 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -315,7 +315,7 @@ test8()
 	# Memory will be allocated using round robin on nodes.
 	Exp_incr=$(echo "$MB / $total_nodes" |bc)
 
-	numactl --interleave=all memhog -r1000000 1MB 2>&1 >ltp_numa_test8.log &
+	numactl --interleave=all memhog -r1000000 1MB >ltp_numa_test8.log 2>&1 &
 	pid=$!
 
 	local retries=20
-- 
2.14.1

