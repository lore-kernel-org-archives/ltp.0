From: Sun Lianwen <sun_lianwen@163.com>
Date: Sun, 14 Oct 2018 17:27:15 +0800
Subject: [LTP] [PATCH] stress/route: fix spelling mistake "delte" -> "delete"
Message-ID: <20181014092715.6877-1-sun_lianwen@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The word "delte" spell mistake.

Signed-off-by: Sun Lianwen <sun_lianwen@163.com>
---
 testcases/network/stress/route/route4-change-dst | 2 +-
 testcases/network/stress/route/route6-change-dst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/route/route4-change-dst b/testcases/network/stress/route/route4-change-dst
index 86327fad4..8ec606152 100644
--- a/testcases/network/stress/route/route4-change-dst
+++ b/testcases/network/stress/route/route4-change-dst
@@ -246,7 +246,7 @@ test_body()
 	    ;;
 	esac
 	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
+	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
 	    return 1
 	fi
 
diff --git a/testcases/network/stress/route/route6-change-dst b/testcases/network/stress/route/route6-change-dst
index dfaa2137b..2aa953396 100644
--- a/testcases/network/stress/route/route6-change-dst
+++ b/testcases/network/stress/route/route6-change-dst
@@ -242,7 +242,7 @@ test_body()
 	    ;;
 	esac
 	if [ $? -ne 0 ]; then
-	    tst_resm TFAIL "Cannot delte the route to ${ADDDEL_ROUTE}"
+	    tst_resm TFAIL "Cannot delete the route to ${ADDDEL_ROUTE}"
 	    return 1
 	fi
 
-- 
2.19.0


