From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri, 15 Jan 2021 13:25:43 +0100
Subject: [LTP] [PATCH 1/1] swapping01: fix parameter truncation in abs
Message-ID: <20210115122543.288948-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Parameters passed to abs(int) are of type long. Use labs(long) instead
to avoid value truncation.

Fixes the following warning:

swapping01.c: In function ?check_swapping?:
swapping01.c:133:7: warning: absolute value function ?abs? given an argument of type ?long int? but has parameter of type ?int? which may cause truncation of value [-Wabsolute-value]
  133 |   if (abs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 512)
      |       ^~~

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index ff40c85c0..24b8313f3 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -130,7 +130,7 @@ static void check_swapping(void)
 	while (i < 10) {
 		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
-		if (abs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 512)
+		if (labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 512)
 			break;
 
 		i++;
-- 
2.26.2

