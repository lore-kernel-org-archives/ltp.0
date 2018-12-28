From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 28 Dec 2018 18:32:13 +0000
Subject: [LTP] [PATCH 2/2]  memcg_stress_test.sh: fix memory usage
In-Reply-To: <20181228183213.36339-1-cristian.marussi@arm.com>
References: <20181228183213.36339-1-cristian.marussi@arm.com>
Message-ID: <20181228183213.36339-3-cristian.marussi@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When this test was run on a 'swap-less' system, the max quantity of
memory to allocate for the test runners was wrongly set as the whole
amount of free memory.
This caused the test to fail badly without even properly cleanup all
the memcg related configurations, so impacting also a lot of following
memcg related test-cases. With this fix, when the available swap space
is zero, the test limit itself to use only half of all the available
free memory.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 2c5c13e3e..507d17a3d 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -33,7 +33,8 @@ do_setup()
 	local mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
 	local swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
 
-	MEM=$(( $mem_free + $swap_free / 2 ))
+	# Limit the maximum amount of memory to use depending on swap space
+	[ $swap_free -gt 0 ] && MEM=$(( $mem_free + $swap_free / 2 )) || MEM=$(( $mem_free / 2 ))
 	MEM=$(( MEM / 1024 ))
 	RUN_TIME=$(( 15 * 60 ))
 
-- 
2.17.1

